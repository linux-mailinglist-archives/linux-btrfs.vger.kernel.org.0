Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B037904CE
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 04:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351504AbjIBC5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 22:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBC5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 22:57:31 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296C10FF
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 19:57:26 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-565f2567422so1614943eaf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Sep 2023 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693623446; x=1694228246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hvpwoOReQe/f2+ShMCNKzSbvwPHEfis13EPIvWg6ifA=;
        b=OxNQOdRaYO7eDCvPj9z1mvRo+tebjYRs52Pn5ruSb+ZuXnPJLZeEAw5iiDTQ+7UqZ8
         NHKMGiFUJw8tmD1KGHCs1zYnxbXf+XLIgG3/RFHzB05mpVu79zg933Ao8UKg3819OtfI
         U419MpAJWP82igaTH6D2c5IyFcPBWwCPJYcKeFH9cfK+beZ5mn0CsY7wgEACqvNRcxjw
         Efteqxq66zd3N79j5NRyvTScV8/3+UC3HuFzps7+PO5cP5UDn7IfTjy96wFWgwTJ+GZa
         OTMCLUXBoPQUVZIQ1EsFf7mOjqxnvstCaOYo0YT5MJkvGWkufPyjB3GIyCFHjqdvckxI
         rk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693623446; x=1694228246;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvpwoOReQe/f2+ShMCNKzSbvwPHEfis13EPIvWg6ifA=;
        b=esJ8T9YuTjv9LMdGaevLQVC/Wv2ecVkvs3Da28e967GuXd3WGWezdb9n688wVygy+4
         0EhDjdPOXkFvk+RmZ3PzfpmGeMA/bhOF6F5w+/zIyCNroWnRakPQcTr5TPNodWHwsuxm
         qCiOe8XGrjXArMm3vkHyiM/x3cUx4hfrzHWzXluYLRzqXmXzcNT5JRhwgY8SluM+2QJm
         3ybfDCgqIKcDznwAt731vLoWMk8BB4+kxCHJb5mTKh4/hZJV75Cv/cQgUEGonNKtqG/1
         K/6jJKsMTMZmQUjxeSI1hJ2F8U3BY259QORxN66xeqwhkXjdD3ojKVePnYW0LY4bEm/N
         O+Hg==
X-Gm-Message-State: AOJu0YxlRx1/ASddwN8EpR0KfcFhb63+YVPvDqhg4Z/AkaU+ZOUy7PYh
        we+8Up+1gBUw+S7Hf7CH5CnlTsate6M=
X-Google-Smtp-Source: AGHT+IHsp/iYdEJWcWeCD34UvEuKVbT8KzoYTCDeRD1rdH17HLJkzcugxg925EryDlJpKTiGqeMeRw==
X-Received: by 2002:a05:6808:4e:b0:3a6:f622:70f1 with SMTP id v14-20020a056808004e00b003a6f62270f1mr3916959oic.57.1693623445717;
        Fri, 01 Sep 2023 19:57:25 -0700 (PDT)
Received: from [192.168.213.15] ([70.53.69.96])
        by smtp.gmail.com with ESMTPSA id j26-20020a05620a001a00b0076d6a08ac98sm1812174qki.76.2023.09.01.19.57.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 19:57:25 -0700 (PDT)
Message-ID: <ce4f7788f24442cd6f4779baee1992bb1978b85c.camel@gmail.com>
Subject: [PATCH v2] btrfs-progs: receive: cannot find clone source subvol
 when receiving in reverse direction
From:   Arsenii Skvortsov <ettavolt@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 01 Sep 2023 22:57:16 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

process_clone only searches the received_uuid, but could exist in an earlie=
r
uuid that isn't the received_uuid.  Mirror what process_snapshot does and s=
earch
both the received_uuid and if that fails look up by normal uuid.

Fixes: https://github.com/kdave/btrfs-progs/issues/606

Signed-off-by: Arsenii Skvortsov <ettavolt@gmail.com>
---
 cmds/receive.c                               | 28 +++---
 tests/misc-tests/058-reverse-receive/test.sh | 98 ++++++++++++++++++++
 2 files changed, 115 insertions(+), 11 deletions(-)
 create mode 100755 tests/misc-tests/058-reverse-receive/test.sh

diff --git a/cmds/receive.c b/cmds/receive.c
index d16dc0a..763c2af 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -222,6 +222,19 @@ out:
 	return ret;
 }
=20
+static struct subvol_info *search_source_subvol(struct subvol_uuid_search =
*s,
+			const u8 *subvol_uuid, u64 transid)
+{
+	struct subvol_info *found;
+	found =3D subvol_uuid_search(s, 0, subvol_uuid, transid, NULL,
+			subvol_search_by_received_uuid);
+	if (IS_ERR_OR_NULL(found)) {
+		found =3D subvol_uuid_search(s, 0, subvol_uuid, transid, NULL,
+				subvol_search_by_uuid);
+	}
+	return found;
+}
+
 static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid=
,
 			    const u8 *parent_uuid, u64 parent_ctransid,
 			    void *user)
@@ -284,14 +297,8 @@ static int process_snapshot(const char *path, const u8=
 *uuid, u64 ctransid,
 	memset(&args_v2, 0, sizeof(args_v2));
 	strncpy_null(args_v2.name, path);
=20
-	parent_subvol =3D subvol_uuid_search(rctx->mnt_fd, 0, parent_uuid,
-					   parent_ctransid, NULL,
-					   subvol_search_by_received_uuid);
-	if (IS_ERR_OR_NULL(parent_subvol)) {
-		parent_subvol =3D subvol_uuid_search(rctx->mnt_fd, 0, parent_uuid,
-						   parent_ctransid, NULL,
-						   subvol_search_by_uuid);
-	}
+	parent_subvol =3D search_source_subvol(rctx->mnt_fd, parent_uuid,
+			parent_ctransid);
 	if (IS_ERR_OR_NULL(parent_subvol)) {
 		if (!parent_subvol)
 			ret =3D -ENOENT;
@@ -746,9 +753,8 @@ static int process_clone(const char *path, u64 offset, =
u64 len,
 		   BTRFS_UUID_SIZE) =3D=3D 0) {
 		subvol_path =3D rctx->cur_subvol_path;
 	} else {
-		si =3D subvol_uuid_search(rctx->mnt_fd, 0, clone_uuid, clone_ctransid,
-					NULL,
-					subvol_search_by_received_uuid);
+		si =3D search_source_subvol(rctx->mnt_fd, clone_uuid,
+				clone_ctransid);
 		if (IS_ERR_OR_NULL(si)) {
 			char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
=20
diff --git a/tests/misc-tests/058-reverse-receive/test.sh b/tests/misc-test=
s/058-reverse-receive/test.sh
new file mode 100755
index 0000000..6eff560
--- /dev/null
+++ b/tests/misc-tests/058-reverse-receive/test.sh
@@ -0,0 +1,98 @@
+#!/bin/bash
+#
+# Receive in reverse direction must not throw an error if it can find an e=
arlier "sent" parent.
+# In general, shows a backup+sync setup between two (or more) PCs with an =
external drive.
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+check_global_prereq dd
+
+declare -a roots
+i_pc1=3D1
+# An external drive used to backup and carry profile.
+i_ext=3D2
+i_pc2=3D3
+roots[$i_pc1]=3D"$TEST_MNT/pc1"
+roots[$i_ext]=3D"$TEST_MNT/external"
+roots[$i_pc2]=3D"$TEST_MNT/pc2"
+
+setup_root_helper
+mkdir -p ${roots[@]}
+setup_loopdevs 3
+prepare_loopdevs
+for i in `seq 3`; do
+	TEST_DEV=3D${loopdevs[$i]}
+    TEST_MNT=3D"${roots[$i]}"
+    run_check_mkfs_test_dev
+    run_check_mount_test_dev
+    run_check $SUDO_HELPER mkdir -p "$TEST_MNT/.snapshots"
+done
+
+run_check_update_file()
+{
+    run_check $SUDO_HELPER cp --reflink ${roots[$1]}/profile/$2 ${roots[$1=
]}/profile/staging
+    run_check $SUDO_HELPER dd if=3D/dev/urandom conv=3Dnotrunc bs=3D4K cou=
nt=3D4 oseek=3D$3 "of=3D${roots[$1]}/profile/staging"
+    run_check $SUDO_HELPER mv ${roots[$1]}/profile/staging ${roots[$1]}/pr=
ofile/$2
+}
+run_check_copy_snapshot_with_diff()
+{
+    _mktemp_local send.data
+    run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data -p "${roots[$1]}=
/.snapshots/$2" "${roots[$1]}/.snapshots/$3"
+    run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "${roots[$4]}=
/.snapshots"
+}
+run_check_backup_profile()
+{
+    run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "${roots[$1]=
}/profile" "${roots[$1]}/.snapshots/$3"
+    run_check_copy_snapshot_with_diff $1 $2 $3 $i_ext
+    # Don't keep old snapshot in pc
+    run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "${roots[$1]}/.sn=
apshots/$2"
+}
+run_check_restore_profile()
+{
+    run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "${roots[$1]}/.=
snapshots/$2" "${roots[$1]}/profile"
+}
+run_check_copy_fresh_backup_and_replace_profile()
+{
+    run_check_copy_snapshot_with_diff $i_ext $2 $3 $1
+    # IRL, it would be a nice idea to make a backup snapshot before deleti=
ng.
+    run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "${roots[$1]}/pro=
file"
+    run_check_restore_profile $1 $3
+    # Don't keep old snapshot in pc
+    run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "${roots[$1]}/.sn=
apshots/$2"
+}
+
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "${roots[$i_pc1]}/pro=
file"
+run_check $SUDO_HELPER dd if=3D/dev/urandom bs=3D4K count=3D16 "of=3D${roo=
ts[$i_pc1]}/profile/day1"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "${roots[$i_pc1]=
}/profile" "${roots[$i_pc1]}/.snapshots/day1"
+_mktemp_local send.data
+run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "${roots[$i_pc1]}/.s=
napshots/day1"
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "${roots[$i_ext]}=
/.snapshots"
+
+run_check_update_file $i_pc1 day1 2
+run_check_backup_profile $i_pc1 day1 day2
+
+_mktemp_local send.data
+run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "${roots[$i_ext]}/.s=
napshots/day2"
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "${roots[$i_pc2]}=
/.snapshots"
+run_check_restore_profile $i_pc2 day2
+run_check_update_file $i_pc2 day1 3
+run_check_backup_profile $i_pc2 day2 day3
+
+run_check_update_file $i_pc2 day1 4
+run_check_backup_profile $i_pc2 day3 day4
+
+run_check_copy_fresh_backup_and_replace_profile $i_pc1 day2 day4
+run_check_update_file $i_pc1 day1 5
+run_check_backup_profile $i_pc1 day4 day5
+
+run_check_copy_fresh_backup_and_replace_profile $i_pc2 day4 day5
+run_check_update_file $i_pc2 day1 6
+run_check_backup_profile $i_pc2 day5 day6
+
+run_check_umount_test_dev ${loopdevs[@]}
+rmdir ${roots[@]}
+rm -f send.data
+cleanup_loopdevs
--=20
2.41.0
