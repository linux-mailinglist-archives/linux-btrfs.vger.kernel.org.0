Return-Path: <linux-btrfs+bounces-723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1338078EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AA91C20F41
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A16EB52;
	Wed,  6 Dec 2023 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="G/YGS07D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3755122
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:52:27 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id K7rM2B00T04l9eU017rNXC; Wed, 06 Dec 2023 19:51:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/4] new command: btrfs filesystem info [<path>...]
Date: Wed,  6 Dec 2023 20:32:43 +0100
Message-ID: <c86c826dcc398a49fc6d3afb68683b104763eceb.1701891165.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701891165.git.kreijack@inwind.it>
References: <cover.1701891165.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1701892282; bh=r1+jlvKdEoEeQcNpDbXawfZ20GX41C5akkAdBBVFRTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=G/YGS07D/fCLdWcUVkiJX7hWLaqQxb0PWAroKgwW+3dcL+lFOzT28totDLokRC0Fs
	 btNAK1FG9xw35Nd6MU3Ur7FYb9IA+bKGnDFhHQFVa8esKssCnhtny6l11XRCq/ujjl
	 Y1Ux6U9DNfMoq8q0wVfGOXdycGNfHmPoa2cbLLMM=

From: Goffredo Baroncelli <kreijack@inwind.it>

This command shows all the main info of a (or all) btrfs filesystem.
The argument may be in any of the following form:
- btrfs filesystem path
- btrfs device
- UUID=<uuid>
- UUID_sub=<uuid_sub>
- PARTUUID=<partuuid>

If no argument is passed, the informaton of all the filesystem are showed.

Typical output
---------------------------------------------------
$ btrfs fi info /mnt/btrfs-raid1
UUID:    b39b0b27-ff80-4cb4-bf48-0be939ff0788
LABEL:   raid1
devices:
        dev:      /dev/sda2
        UUID_SUB: 65a4f76b-abaa-4d98-a1d5-4c586ffdcbf0
        PARTUUID: fb9c0cc8-02
        major:    8
        minor:    2
        devid:    1

        dev:      /dev/sdb2
        UUID_SUB: 5f7f141f-0bdf-44fb-a910-fdc502a6fa7d
        PARTUUID:
        major:    8
        minor:    18
        devid:    2

mounts:
        dest:     /mnt/btrfs-raid1
        rootpath: /
        subvol:   /
        options:  rw,noatime,nodiratime,rw,space_cache,subvolid=5,subvol=/
        seq:      93
        over:     30

        dest:     /var/log
        rootpath: /@log
        subvol:   /@log
        options:  rw,noatime,nodiratime,rw,nossd,discard=async,space_cache,subvolid=447,subvol=/@log
        seq:      64
        over:     30

-----------------------------------------------------

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 1b444b8f..38a0787f 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -55,6 +55,7 @@
 #include "common/parse-utils.h"
 #include "common/filesystem-utils.h"
 #include "common/format-output.h"
+#include "common/btrfs-info.h"
 #include "cmds/commands.h"
 #include "cmds/filesystem-usage.h"
 
@@ -1503,6 +1504,48 @@ static int cmd_filesystem_label(const struct cmd_struct *cmd,
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_label, "label");
 
+static const char * const cmd_filesystem_info_usage[] = {
+	"btrfs filesystem info [UUID=<uuid>|UUID_SUB=<subuuid>|PARTUUID=<partuuid>|LABEL=<label>|<device>|<mount_point>] ...",
+	"Show the information of a btrfs filesystem.",
+	NULL
+};
+
+static int cmd_filesystem_info(const struct cmd_struct *cmd,
+				int argc, char **argv)
+{
+	clean_args_no_options(cmd, argc, argv);
+
+	if (argc - optind == 0) {
+		const struct btrfs_info *bi;
+		int r = btrfs_info_get(&bi);
+		if (r < 0) {
+			error("Cannot get info: %d - %s\n", -r, strerror(-r));
+			return 2;
+		}
+		btrfs_info_dump(bi, stdout);
+	} else {
+		for (int i = 1 ; i < argc ; i++) {
+			printf("Target: %s\n", argv[i]);
+
+			const struct btrfs_info *bi;
+			int r = btrfs_info_find(argv[i], &bi);
+			if (r < 0) {
+				error("Cannot get info for '%s': %d - %s\n",
+				      argv[i], -r, strerror(-r));
+				return 2;
+			}
+
+			btrfs_info_dump_single_entry(bi, stdout);
+
+			if (i < argc - 1)
+				printf("\n");
+		}
+	}
+
+	return 0;
+}
+static DEFINE_SIMPLE_COMMAND(filesystem_info, "info");
+
 static const char * const cmd_filesystem_balance_usage[] = {
 	"btrfs filesystem balance [args...] (alias of \"btrfs balance\")",
 	"Please see \"btrfs balance --help\" for more information.",
@@ -1707,6 +1750,7 @@ static const struct cmd_group filesystem_cmd_group = {
 		&cmd_struct_filesystem_balance,
 		&cmd_struct_filesystem_resize,
 		&cmd_struct_filesystem_label,
+		&cmd_struct_filesystem_info,
 		&cmd_struct_filesystem_usage,
 		&cmd_struct_filesystem_mkswapfile,
 		NULL
-- 
2.43.0


