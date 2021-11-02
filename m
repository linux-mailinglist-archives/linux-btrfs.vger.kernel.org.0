Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EED442BD3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 11:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBKuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 06:50:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36840 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBKuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 06:50:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78DFE2190B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635850096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rPAHtbS/4CNHyTO5ZFXKgWdCqtk+WQ6VBihKjGKJoyY=;
        b=lF7Cu0SIWoKiVAEqh0lY82Ji371rU8JTJQsBGiVnnR5wuevcaSW74rACeCNU2x66yHzyR7
        LriWMw20sa1fotGQqWfeB77Ocsn7QqAdeV0cx+VXLdoatmlr3+KwxlC7KLeIl6XfGEedBi
        jNpDwWSWflS8L1c8D2I0yoboHuiOgJg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA8D113C1F
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 10:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2RW9KW8XgWGWMAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 10:48:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Make "btrfs filesystem df" command to show upper case profile
Date:   Tue,  2 Nov 2021 18:47:58 +0800
Message-Id: <20211102104758.39871-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.

The failure of btrfs/151 explains the reason pretty well:

btrfs/151 1s ... - output mismatch
    --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 +0800
    +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 17:13:43.879999994 +0800
    @@ -1,2 +1,2 @@
     QA output created by 151
    -Data, RAID1
    +Data, raid1
    ...
    (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out ~/xfstests-dev/results//btrfs/151.out.bad'  to see the entire diff)

[CAUSE]
Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
raid table") will use btrfs_raid_array[index].raid_name, which is all
lower case.

[FIX]
There is no need to bring such output format change.

So here we adds a new helper function, btrfs_group_profile_upper_str()
to print the upper case profile name.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem.c |  4 +++-
 common/utils.c    | 10 ++++++++++
 common/utils.h    |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 6a9e46d2b7dc..9f49b7d0c9c5 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -72,6 +72,7 @@ static void print_df(int fd, struct btrfs_ioctl_space_args *sargs, unsigned unit
 {
 	u64 i;
 	struct btrfs_ioctl_space_info *sp = sargs->spaces;
+	char profile_buf[BTRFS_PROFILE_STR_LEN];
 	u64 unusable;
 	bool ok;
 
@@ -79,9 +80,10 @@ static void print_df(int fd, struct btrfs_ioctl_space_args *sargs, unsigned unit
 		unusable = device_get_zone_unusable(fd, sp->flags);
 		ok = (unusable != DEVICE_ZONE_UNUSABLE_UNKNOWN);
 
+		btrfs_group_profile_upper_str(sp->flags, profile_buf);
 		printf("%s, %s: total=%s, used=%s%s%s\n",
 			btrfs_group_type_str(sp->flags),
-			btrfs_group_profile_str(sp->flags),
+			profile_buf,
 			pretty_size_mode(sp->total_bytes, unit_mode),
 			pretty_size_mode(sp->used_bytes, unit_mode),
 			(ok ? ", zone_unusable=" : ""),
diff --git a/common/utils.c b/common/utils.c
index aee0eedc15fc..32ca6b2ef432 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1038,6 +1038,16 @@ const char* btrfs_group_profile_str(u64 flag)
 	return btrfs_raid_array[index].raid_name;
 }
 
+void btrfs_group_profile_upper_str(u64 flags, char *ret)
+{
+	int i;
+
+	strncpy(ret, btrfs_group_profile_str(flags), BTRFS_PROFILE_STR_LEN);
+
+	for (i = 0; i < BTRFS_PROFILE_STR_LEN && ret[i]; i++)
+		ret[i] = toupper(ret[i]);
+}
+
 u64 div_factor(u64 num, int factor)
 {
 	if (factor == 10)
diff --git a/common/utils.h b/common/utils.h
index 6f84e3cbc98f..0c1b6baa7ae3 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -75,6 +75,9 @@ int find_next_key(struct btrfs_path *path, struct btrfs_key *key);
 const char* btrfs_group_type_str(u64 flag);
 const char* btrfs_group_profile_str(u64 flag);
 
+#define BTRFS_PROFILE_STR_LEN	(64)
+void btrfs_group_profile_upper_str(u64 flag, char *ret);
+
 int count_digits(u64 num);
 u64 div_factor(u64 num, int factor);
 
-- 
2.33.1

