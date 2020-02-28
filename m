Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4998A1742B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Feb 2020 00:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1XOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 18:14:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33289 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgB1XOQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so4687027pjs.0
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 15:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEmhN44DkIJLX8nPp5Ub1dEDNAuQzGY/5HOEI/prRD0=;
        b=YMFWeYGiofiR8lWvoxZqr7+bKz55ToV60KAEErnabYZrUTIvNJMAnvQoScJlDwzJVm
         GVezQHw5ekxGvvn7A5QXQDNSMuRZkWpGESosGfDx5SEs3tTx9utfspgAlbxP+qex1/gK
         AASCZdojiyJjax/laSSVKNElv6jz8ucKFknEZeVhrKCN/uFtX2F1l95fZ76HYhAJ6TbD
         WK3Osvv484fZmD2ul2fSPhMIsJSS0qxfvliV9kTiW3eNOfBPgSdxBmPcAmUQFmsvwSRE
         9PRoKrZfUHtcgDBcUnhZHl5aGpDAu1elY+FdJ60IXZ5WJW0JfJOFwvKjij3zK7M2rc5Z
         aZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nEmhN44DkIJLX8nPp5Ub1dEDNAuQzGY/5HOEI/prRD0=;
        b=O5/C53BebNm1x1Rn+J3j8sUlHpPB9G88TzRqdZrPrW5M8z4PxehdVPYYoy/hRRfeuL
         tbK3KuOugiZ5q6/kf1Oqn2a2iJqRWQSpVJvKwpwJ++nEtEUPhUiveZoKqNnRbG7DdGyZ
         GAaHjuf4ZlPZip9HtqFOl98hN/rzk4eav4AX2YSHKJAAjzEj8q3GkpqrYuK0R87kOvmy
         DFdlzVqReImZtmLoS95oLxegJxGznosreDmeEMSGBYr4iv3AEfHoY84aiEI7hA70rrkD
         12F794wfXShp2ux3+puGcNEv4mVN+Zs89pG+hWT7hKjLiF3XFcVsCau+vWmS7r7uIKdz
         bqPA==
X-Gm-Message-State: APjAAAVvnPBIh2tvtludrivLHvLWggivm5oS19w81vksq8zEM3ktMdun
        B2V8d3hZFqqfXwnASxAoEzivoA==
X-Google-Smtp-Source: APXvYqz6iKiH5Ji74iko1a6ZI54D59Al0T51zswvjwUiaEcy54ZaK8HyoBmU4s3CJywGD4HUnXFiEQ==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr5640599ple.209.1582931652730;
        Fri, 28 Feb 2020 15:14:12 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::6:1714])
        by smtp.gmail.com with ESMTPSA id q7sm11421878pgk.62.2020.02.28.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:14:12 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 1/9] iov_iter: add copy_struct_from_iter()
Date:   Fri, 28 Feb 2020 15:13:53 -0800
Message-Id: <f924583dba1c9f26212a28348991e304871c7e11.1582930832.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1582930832.git.osandov@fb.com>
References: <cover.1582930832.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is essentially copy_struct_from_user() but for an iov_iter.

Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9576fd8158d7..9776b4be4833 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -122,6 +122,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf3af85..a2a6ab41767b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -942,6 +942,88 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
+/**
+ * copy_struct_from_iter - copy a struct from an iov_iter
+ * @dst: Destination buffer.
+ * @ksize: Size of @dst struct.
+ * @i: Source iterator.
+ * @usize: (Alleged) size of struct in @i.
+ *
+ * Copies a struct from an iov_iter in a way that guarantees
+ * backwards-compatibility for struct arguments in an iovec (as long as the
+ * rules for copy_struct_from_user() are followed).
+ *
+ * The recommended usage is that @usize be taken from the current segment:
+ *
+ *   int do_foo(struct iov_iter *i)
+ *   {
+ *     size_t usize = iov_iter_single_seg_count(i);
+ *     struct foo karg;
+ *     int err;
+ *
+ *     if (usize > PAGE_SIZE)
+ *       return -E2BIG;
+ *     if (usize < FOO_SIZE_VER0)
+ *       return -EINVAL;
+ *     err = copy_struct_from_iter(&karg, sizeof(karg), i, usize);
+ *     if (err)
+ *       return err;
+ *
+ *     // ...
+ *   }
+ *
+ * Return: 0 on success, -errno on error (see copy_struct_from_user()).
+ *
+ * On success, the iterator is advanced @usize bytes. On error, the iterator is
+ * not advanced.
+ */
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize)
+{
+	if (usize <= ksize) {
+		if (!copy_from_iter_full(dst, usize, i))
+			return -EFAULT;
+		memset(dst + usize, 0, ksize - usize);
+	} else {
+		size_t copied = 0, copy;
+		int ret;
+
+		if (WARN_ON(iov_iter_is_pipe(i)) || unlikely(i->count < usize))
+			return -EFAULT;
+		if (iter_is_iovec(i))
+			might_fault();
+		iterate_all_kinds(i, usize, v, ({
+			copy = min(ksize - copied, v.iov_len);
+			if (copy && copyin(dst + copied, v.iov_base, copy))
+				return -EFAULT;
+			copied += copy;
+			ret = check_zeroed_user(v.iov_base + copy,
+						v.iov_len - copy);
+			if (ret <= 0)
+				return ret ?: -E2BIG;
+			0;}), ({
+			char *addr = kmap_atomic(v.bv_page);
+			copy = min_t(size_t, ksize - copied, v.bv_len);
+			memcpy(dst + copied, addr + v.bv_offset, copy);
+			copied += copy;
+			ret = memchr_inv(addr + v.bv_offset + copy, 0,
+					 v.bv_len - copy) ? -E2BIG : 0;
+			kunmap_atomic(addr);
+			if (ret)
+				return ret;
+			}), ({
+			copy = min(ksize - copied, v.iov_len);
+			memcpy(dst + copied, v.iov_base, copy);
+			if (memchr_inv(v.iov_base, 0, v.iov_len))
+				return -E2BIG;
+			})
+		)
+		iov_iter_advance(i, usize);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_struct_from_iter);
+
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.25.1

