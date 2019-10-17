Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3CDA3B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404287AbfJQC2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:28:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389173AbfJQC2G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94D21AE8D;
        Thu, 17 Oct 2019 02:28:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH v2] tools/lib/traceevent, perf tools: Handle %pU format correctly
Date:   Thu, 17 Oct 2019 10:28:00 +0800
Message-Id: <20191017022800.31866-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For btrfs related events, there is a field for fsid, but perf never
parse it correctly.

 # perf trace -e btrfs:qgroup_meta_convert xfs_io -f -c "pwrite 0 4k" \
   /mnt/btrfs/file1
     0.000 xfs_io/77915 btrfs:qgroup_meta_reserve:(nil)U: refroot=5(FS_TREE) type=0x0 diff=2
                                                  ^^^^^^ Not a correct UUID
     ...

[CAUSE]
The pretty_print() function doesn't handle the %pU format correctly.
In fact it doesn't handle %pU as uuid at all.

[FIX]
Add a new function, print_uuid_arg(), to handle %pU correctly.

Now perf trace can at least print fsid correctly:
     0.000 xfs_io/79619 btrfs:qgroup_meta_reserve:23ad1511-dd83-47d4-a79c-e96625a15a6e refroot=5(FS_TREE) type=0x0 diff=2

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use more comment explaining the finetunings we skipped for %pU*
- Use more elegant way to output uuid string
---
 tools/lib/traceevent/event-parse.c | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475585ce..3c9473f46efe 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <limits.h>
+#include <linux/uuid.h>
 #include <linux/time64.h>
 
 #include <netinet/in.h>
@@ -4508,6 +4509,45 @@ get_bprint_format(void *data, int size __maybe_unused,
 	return format;
 }
 
+static void print_uuid_arg(struct trace_seq *s, void *data, int size,
+			   struct tep_event *event, struct tep_print_arg *arg)
+{
+	unsigned char *buf;
+	int i;
+
+	if (arg->type != TEP_PRINT_FIELD) {
+		trace_seq_printf(s, "ARG TYPE NOT FIELID but %d", arg->type);
+		return;
+	}
+
+	if (!arg->field.field) {
+		arg->field.field = tep_find_any_field(event, arg->field.name);
+		if (!arg->field.field) {
+			do_warning("%s: field %s not found",
+				   __func__, arg->field.name);
+			return;
+		}
+	}
+	if (arg->field.field->size < 16) {
+		trace_seq_printf(s, "INVALID UUID: size have %u expect 16",
+				arg->field.field->size);
+		return;
+	}
+	buf = data + arg->field.field->offset;
+	/* first segment,  %02x *4 */
+	for (i = 0; i < 4; i++, buf++)
+		trace_seq_printf(s, "%02x", *buf);
+
+	/* 2nd, 3rd, 4th segment, each segment is "-%02x%02x" */
+	for (i = 0; i < 3; i++, buf += 2)
+		trace_seq_printf(s, "-%02x%02x", buf[i * 2], buf[i * 2 + 1]);
+
+	/* Final segment, '-' and '%02x' *6 */
+	trace_seq_putc(s, '-');
+	for (i = 0; i < 6; i++, buf++)
+		trace_seq_printf(s, "%02x", *buf);
+}
+
 static void print_mac_arg(struct trace_seq *s, int mac, void *data, int size,
 			  struct tep_event *event, struct tep_print_arg *arg)
 {
@@ -5074,6 +5114,22 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 						arg = arg->next;
 						break;
 					}
+				} else if (*ptr == 'U') {
+					/*
+					 * %pU has several finetunings variants
+					 * like %pUb and %pUL.
+					 * Here we ignore them, default to
+					 * byte-order no endian, lower case
+					 * letters.
+					 */
+					if (isalpha(ptr[1]))
+						ptr += 2;
+					else
+						ptr++;
+
+					print_uuid_arg(s, data, size, event, arg);
+					arg = arg->next;
+					break;
 				}
 
 				/* fall through */
-- 
2.23.0

