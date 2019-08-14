Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885268C568
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHNBEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfHNBER (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86F2BB0E6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:14 +0000 (UTC)
Received: from starscream.home.jeffm.io (starscream-1.home.jeffm.io [192.168.1.254])
        by mail.home.jeffm.io (Postfix) with ESMTPS id F2D1081AD3D8;
        Tue, 13 Aug 2019 22:05:07 -0400 (EDT)
Received: by starscream.home.jeffm.io (Postfix, from userid 1000)
        id 914C66093C9; Tue, 13 Aug 2019 21:04:11 -0400 (EDT)
From:   Jeff Mahoney <jeffm@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 2/5] btrfs-progs: btrfs_add_to_fsid: check if adding device would overflow
Date:   Tue, 13 Aug 2019 21:03:59 -0400
Message-Id: <20190814010402.22546-2-jeffm@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190814010402.22546-1-jeffm@suse.com>
References: <20190814010402.22546-1-jeffm@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's theoretically possible to add multiple devices with sizes that add up
to or exceed 16EiB.  A file system will be created successfully but will
have a superblock with incorrect values for total_bytes and other fields.

Kernels up to v5.0 will crash when they encounter this scenario.

We need to check for overflow and reject the device if it would overflow.
I've copied include/linux/overflow.h from the kernel to reuse that code.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1099147
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 common/device-scan.c                              |  15 +-
 kernel-lib/overflow.h                             | 270 ++++++++++++++++++++++
 tests/mkfs-tests/018-multidevice-overflow/test.sh |  22 ++
 3 files changed, 304 insertions(+), 3 deletions(-)
 create mode 100644 kernel-lib/overflow.h
 create mode 100755 tests/mkfs-tests/018-multidevice-overflow/test.sh

diff --git a/common/device-scan.c b/common/device-scan.c
index 2c5ae225..09d90add 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -26,6 +26,7 @@
 #include <linux/limits.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
+#include "kernel-lib/overflow.h"
 #include "common/path-utils.h"
 #include "common/device-scan.h"
 #include "common/messages.h"
@@ -118,7 +119,8 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	struct btrfs_device *device;
 	struct btrfs_dev_item *dev_item;
 	char *buf = NULL;
-	u64 fs_total_bytes;
+	u64 old_size = btrfs_super_total_bytes(super);
+	u64 new_size;
 	u64 num_devs;
 	int ret;
 
@@ -156,13 +158,20 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	if (check_add_overflow(old_size, device_total_bytes, &new_size)) {
+		error(
+"adding device of %llu bytes would exceed max file system size.",
+		      device->total_bytes);
+		ret = -EOVERFLOW;
+		goto out;
+	}
+
 	INIT_LIST_HEAD(&device->dev_list);
 	ret = btrfs_add_device(trans, fs_info, device);
 	if (ret)
 		goto out;
 
-	fs_total_bytes = btrfs_super_total_bytes(super) + device_total_bytes;
-	btrfs_set_super_total_bytes(super, fs_total_bytes);
+	btrfs_set_super_total_bytes(super, new_size);
 
 	num_devs = btrfs_super_num_devices(super) + 1;
 	btrfs_set_super_num_devices(super, num_devs);
diff --git a/kernel-lib/overflow.h b/kernel-lib/overflow.h
new file mode 100644
index 00000000..ab7f5d0e
--- /dev/null
+++ b/kernel-lib/overflow.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+#ifndef __LINUX_OVERFLOW_H
+#define __LINUX_OVERFLOW_H
+
+/*
+ * It would seem more obvious to do something like
+ *
+ * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
+ * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
+ *
+ * Unfortunately, the middle expressions, strictly speaking, have
+ * undefined behaviour, and at least some versions of gcc warn about
+ * the type_max expression (but not if -fsanitize=undefined is in
+ * effect; in that case, the warning is deferred to runtime...).
+ *
+ * The slightly excessive casting in type_min is to make sure the
+ * macros also produce sensible values for the exotic type _Bool. [The
+ * overflow checkers only almost work for _Bool, but that's
+ * a-feature-not-a-bug, since people shouldn't be doing arithmetic on
+ * _Bools. Besides, the gcc builtins don't allow _Bool* as third
+ * argument.]
+ *
+ * Idea stolen from
+ * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
+ * credit to Christian Biere.
+ */
+#define is_signed_type(type)       (((type)(-1)) < (type)1)
+#define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
+#define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
+#define type_min(T) ((T)((T)-type_max(T)-(T)1))
+
+/*
+ * Avoids triggering -Wtype-limits compilation warning,
+ * while using unsigned data types to check a < 0.
+ */
+#define is_non_negative(a) ((a) > 0 || (a) == 0)
+#define is_negative(a) (!(is_non_negative(a)))
+
+/* Checking for unsigned overflow is relatively easy without causing UB. */
+#define __unsigned_add_overflow(a, b, d) ({	\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	*__d = __a + __b;			\
+	*__d < __a;				\
+})
+#define __unsigned_sub_overflow(a, b, d) ({	\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	*__d = __a - __b;			\
+	__a < __b;				\
+})
+/*
+ * If one of a or b is a compile-time constant, this avoids a division.
+ */
+#define __unsigned_mul_overflow(a, b, d) ({		\
+	typeof(a) __a = (a);				\
+	typeof(b) __b = (b);				\
+	typeof(d) __d = (d);				\
+	(void) (&__a == &__b);				\
+	(void) (&__a == __d);				\
+	*__d = __a * __b;				\
+	__builtin_constant_p(__b) ?			\
+	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
+	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
+})
+
+/*
+ * For signed types, detecting overflow is much harder, especially if
+ * we want to avoid UB. But the interface of these macros is such that
+ * we must provide a result in *d, and in fact we must produce the
+ * result promised by gcc's builtins, which is simply the possibly
+ * wrapped-around value. Fortunately, we can just formally do the
+ * operations in the widest relevant unsigned type (u64) and then
+ * truncate the result - gcc is smart enough to generate the same code
+ * with and without the (u64) casts.
+ */
+
+/*
+ * Adding two signed integers can overflow only if they have the same
+ * sign, and overflow has happened iff the result has the opposite
+ * sign.
+ */
+#define __signed_add_overflow(a, b, d) ({	\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	*__d = (u64)__a + (u64)__b;		\
+	(((~(__a ^ __b)) & (*__d ^ __a))	\
+		& type_min(typeof(__a))) != 0;	\
+})
+
+/*
+ * Subtraction is similar, except that overflow can now happen only
+ * when the signs are opposite. In this case, overflow has happened if
+ * the result has the opposite sign of a.
+ */
+#define __signed_sub_overflow(a, b, d) ({	\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	*__d = (u64)__a - (u64)__b;		\
+	((((__a ^ __b)) & (*__d ^ __a))		\
+		& type_min(typeof(__a))) != 0;	\
+})
+
+/*
+ * Signed multiplication is rather hard. gcc always follows C99, so
+ * division is truncated towards 0. This means that we can write the
+ * overflow check like this:
+ *
+ * (a > 0 && (b > MAX/a || b < MIN/a)) ||
+ * (a < -1 && (b > MIN/a || b < MAX/a) ||
+ * (a == -1 && b == MIN)
+ *
+ * The redundant casts of -1 are to silence an annoying -Wtype-limits
+ * (included in -Wextra) warning: When the type is u8 or u16, the
+ * __b_c_e in check_mul_overflow obviously selects
+ * __unsigned_mul_overflow, but unfortunately gcc still parses this
+ * code and warns about the limited range of __b.
+ */
+
+#define __signed_mul_overflow(a, b, d) ({				\
+	typeof(a) __a = (a);						\
+	typeof(b) __b = (b);						\
+	typeof(d) __d = (d);						\
+	typeof(a) __tmax = type_max(typeof(a));				\
+	typeof(a) __tmin = type_min(typeof(a));				\
+	(void) (&__a == &__b);						\
+	(void) (&__a == __d);						\
+	*__d = (u64)__a * (u64)__b;					\
+	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
+	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
+	(__b == (typeof(__b))-1 && __a == __tmin);			\
+})
+
+
+#define check_add_overflow(a, b, d)					\
+	__builtin_choose_expr(is_signed_type(typeof(a)),		\
+			__signed_add_overflow(a, b, d),			\
+			__unsigned_add_overflow(a, b, d))
+
+#define check_sub_overflow(a, b, d)					\
+	__builtin_choose_expr(is_signed_type(typeof(a)),		\
+			__signed_sub_overflow(a, b, d),			\
+			__unsigned_sub_overflow(a, b, d))
+
+#define check_mul_overflow(a, b, d)					\
+	__builtin_choose_expr(is_signed_type(typeof(a)),		\
+			__signed_mul_overflow(a, b, d),			\
+			__unsigned_mul_overflow(a, b, d))
+
+/** check_shl_overflow() - Calculate a left-shifted value and check overflow
+ *
+ * @a: Value to be shifted
+ * @s: How many bits left to shift
+ * @d: Pointer to where to store the result
+ *
+ * Computes *@d = (@a << @s)
+ *
+ * Returns true if '*d' cannot hold the result or when 'a << s' doesn't
+ * make sense. Example conditions:
+ * - 'a << s' causes bits to be lost when stored in *d.
+ * - 's' is garbage (e.g. negative) or so large that the result of
+ *   'a << s' is guaranteed to be 0.
+ * - 'a' is negative.
+ * - 'a << s' sets the sign bit, if any, in '*d'.
+ *
+ * '*d' will hold the results of the attempted shift, but is not
+ * considered "safe for use" if false is returned.
+ */
+#define check_shl_overflow(a, s, d) ({					\
+	typeof(a) _a = a;						\
+	typeof(s) _s = s;						\
+	typeof(d) _d = d;						\
+	u64 _a_full = _a;						\
+	unsigned int _to_shift =					\
+		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
+	*_d = (_a_full << _to_shift);					\
+	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
+	(*_d >> _to_shift) != _a);					\
+})
+
+/**
+ * array_size() - Calculate size of 2-dimensional array.
+ *
+ * @a: dimension one
+ * @b: dimension two
+ *
+ * Calculates size of 2-dimensional array: @a * @b.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+static inline size_t array_size(size_t a, size_t b)
+{
+	size_t bytes;
+
+	if (check_mul_overflow(a, b, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+/**
+ * array3_size() - Calculate size of 3-dimensional array.
+ *
+ * @a: dimension one
+ * @b: dimension two
+ * @c: dimension three
+ *
+ * Calculates size of 3-dimensional array: @a * @b * @c.
+ *
+ * Returns: number of bytes needed to represent the array or SIZE_MAX on
+ * overflow.
+ */
+static inline size_t array3_size(size_t a, size_t b, size_t c)
+{
+	size_t bytes;
+
+	if (check_mul_overflow(a, b, &bytes))
+		return SIZE_MAX;
+	if (check_mul_overflow(bytes, c, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+/*
+ * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
+ * struct_size() below.
+ */
+static inline size_t __ab_c_size(size_t a, size_t b, size_t c)
+{
+	size_t bytes;
+
+	if (check_mul_overflow(a, b, &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(bytes, c, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
+/**
+ * struct_size() - Calculate size of structure with trailing array.
+ * @p: Pointer to the structure.
+ * @member: Name of the array member.
+ * @n: Number of elements in the array.
+ *
+ * Calculates size of memory needed for structure @p followed by an
+ * array of @n @member elements.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size(p, member, n)					\
+	__ab_c_size(n,							\
+		    sizeof(*(p)->member) + __must_be_array((p)->member),\
+		    sizeof(*(p)))
+
+#endif /* __LINUX_OVERFLOW_H */
diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
new file mode 100755
index 00000000..0b550685
--- /dev/null
+++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# test if mkfs.btrfs will create file systems that overflow total_bytes
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+mkdev()
+{
+	truncate -s 0 "$1"
+	truncate -s "$2" "$1"
+}
+
+mkdev "$TEST_TOP/test-dev1.img" 6E
+mkdev "$TEST_TOP/test-dev2.img" 6E
+mkdev "$TEST_TOP/test-dev3.img" 6E
+
+run_mustfail "mkfs.btrfs for too-large images" \
+	     "$TOP/mkfs.btrfs" -f "$TEST_TOP"/test-dev[123].img
+
+rm -f "$TEST_TOP"/test-dev[123].img
-- 
2.16.4

