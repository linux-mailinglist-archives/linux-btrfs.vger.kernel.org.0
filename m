Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9E7B6682
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjJCKeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJCKeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 06:34:14 -0400
Received: from out28-66.mail.aliyun.com (out28-66.mail.aliyun.com [115.124.28.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EBAD
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 03:34:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436271|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.285689-0.00366355-0.710647;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Ut2BwYT_1696329246;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ut2BwYT_1696329246)
          by smtp.aliyun-inc.com;
          Tue, 03 Oct 2023 18:34:07 +0800
Date:   Tue, 03 Oct 2023 18:34:07 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Arsenii Skvortsov <ettavolt@gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: receive: cannot find clone source subvol when receiving in reverse direction
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <ce4f7788f24442cd6f4779baee1992bb1978b85c.camel@gmail.com>
References: <ce4f7788f24442cd6f4779baee1992bb1978b85c.camel@gmail.com>
Message-Id: <20231003183407.C63E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> process_clone only searches the received_uuid, but could exist in an earlier
> uuid that isn't the received_uuid.  Mirror what process_snapshot does and search
> both the received_uuid and if that fails look up by normal uuid.
> 
> Fixes: https://github.com/kdave/btrfs-progs/issues/606
> 
> Signed-off-by: Arsenii Skvortsov <ettavolt@gmail.com>

Is this patch yet not merged in btrfs-progs devel branch?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/10/03


> ---
>  cmds/receive.c                               | 28 +++---
>  tests/misc-tests/058-reverse-receive/test.sh | 98 ++++++++++++++++++++
>  2 files changed, 115 insertions(+), 11 deletions(-)
>  create mode 100755 tests/misc-tests/058-reverse-receive/test.sh
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index d16dc0a..763c2af 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -222,6 +222,19 @@ out:
>  	return ret;
>  }
>  
> +static struct subvol_info *search_source_subvol(struct subvol_uuid_search *s,
> +			const u8 *subvol_uuid, u64 transid)
> +{
> +	struct subvol_info *found;
> +	found = subvol_uuid_search(s, 0, subvol_uuid, transid, NULL,
> +			subvol_search_by_received_uuid);
> +	if (IS_ERR_OR_NULL(found)) {
> +		found = subvol_uuid_search(s, 0, subvol_uuid, transid, NULL,
> +				subvol_search_by_uuid);
> +	}
> +	return found;
> +}
> +
>  static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
>  			    const u8 *parent_uuid, u64 parent_ctransid,
>  			    void *user)
> @@ -284,14 +297,8 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
>  	memset(&args_v2, 0, sizeof(args_v2));
>  	strncpy_null(args_v2.name, path);
>  
> -	parent_subvol = subvol_uuid_search(rctx->mnt_fd, 0, parent_uuid,
> -					   parent_ctransid, NULL,
> -					   subvol_search_by_received_uuid);
> -	if (IS_ERR_OR_NULL(parent_subvol)) {
> -		parent_subvol = subvol_uuid_search(rctx->mnt_fd, 0, parent_uuid,
> -						   parent_ctransid, NULL,
> -						   subvol_search_by_uuid);
> -	}
> +	parent_subvol = search_source_subvol(rctx->mnt_fd, parent_uuid,
> +			parent_ctransid);
>  	if (IS_ERR_OR_NULL(parent_subvol)) {
>  		if (!parent_subvol)
>  			ret = -ENOENT;
> @@ -746,9 +753,8 @@ static int process_clone(const char *path, u64 offset, u64 len,
>  		   BTRFS_UUID_SIZE) == 0) {
>  		subvol_path = rctx->cur_subvol_path;
>  	} else {
> -		si = subvol_uuid_search(rctx->mnt_fd, 0, clone_uuid, clone_ctransid,
> -					NULL,
> -					subvol_search_by_received_uuid);
> +		si = search_source_subvol(rctx->mnt_fd, clone_uuid,
> +				clone_ctransid);
>  		if (IS_ERR_OR_NULL(si)) {
>  			char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
>  
> diff --git a/tests/misc-tests/058-reverse-receive/test.sh b/tests/misc-tests/058-reverse-receive/test.sh
> new file mode 100755
> index 0000000..6eff560
> --- /dev/null
> +++ b/tests/misc-tests/058-reverse-receive/test.sh
> @@ -0,0 +1,98 @@
> +#!/bin/bash
> +#
> +# Receive in reverse direction must not throw an error if it can find an earlier "sent" parent.
> +# In general, shows a backup+sync setup between two (or more) PCs with an external drive.
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +check_global_prereq dd
> +
> +declare -a roots
> +i_pc1=1
> +# An external drive used to backup and carry profile.
> +i_ext=2
> +i_pc2=3
> +roots[$i_pc1]="$TEST_MNT/pc1"
> +roots[$i_ext]="$TEST_MNT/external"
> +roots[$i_pc2]="$TEST_MNT/pc2"
> +
> +setup_root_helper
> +mkdir -p ${roots[@]}
> +setup_loopdevs 3
> +prepare_loopdevs
> +for i in `seq 3`; do
> +	TEST_DEV=${loopdevs[$i]}
> +    TEST_MNT="${roots[$i]}"
> +    run_check_mkfs_test_dev
> +    run_check_mount_test_dev
> +    run_check $SUDO_HELPER mkdir -p "$TEST_MNT/.snapshots"
> +done
> +
> +run_check_update_file()
> +{
> +    run_check $SUDO_HELPER cp --reflink ${roots[$1]}/profile/$2 ${roots[$1]}/profile/staging
> +    run_check $SUDO_HELPER dd if=/dev/urandom conv=notrunc bs=4K count=4 oseek=$3 "of=${roots[$1]}/profile/staging"
> +    run_check $SUDO_HELPER mv ${roots[$1]}/profile/staging ${roots[$1]}/profile/$2
> +}
> +run_check_copy_snapshot_with_diff()
> +{
> +    _mktemp_local send.data
> +    run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data -p "${roots[$1]}/.snapshots/$2" "${roots[$1]}/.snapshots/$3"
> +    run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "${roots[$4]}/.snapshots"
> +}
> +run_check_backup_profile()
> +{
> +    run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "${roots[$1]}/profile" "${roots[$1]}/.snapshots/$3"
> +    run_check_copy_snapshot_with_diff $1 $2 $3 $i_ext
> +    # Don't keep old snapshot in pc
> +    run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "${roots[$1]}/.snapshots/$2"
> +}
> +run_check_restore_profile()
> +{
> +    run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "${roots[$1]}/.snapshots/$2" "${roots[$1]}/profile"
> +}
> +run_check_copy_fresh_backup_and_replace_profile()
> +{
> +    run_check_copy_snapshot_with_diff $i_ext $2 $3 $1
> +    # IRL, it would be a nice idea to make a backup snapshot before deleting.
> +    run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "${roots[$1]}/profile"
> +    run_check_restore_profile $1 $3
> +    # Don't keep old snapshot in pc
> +    run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "${roots[$1]}/.snapshots/$2"
> +}
> +
> +
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "${roots[$i_pc1]}/profile"
> +run_check $SUDO_HELPER dd if=/dev/urandom bs=4K count=16 "of=${roots[$i_pc1]}/profile/day1"
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "${roots[$i_pc1]}/profile" "${roots[$i_pc1]}/.snapshots/day1"
> +_mktemp_local send.data
> +run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "${roots[$i_pc1]}/.snapshots/day1"
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "${roots[$i_ext]}/.snapshots"
> +
> +run_check_update_file $i_pc1 day1 2
> +run_check_backup_profile $i_pc1 day1 day2
> +
> +_mktemp_local send.data
> +run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "${roots[$i_ext]}/.snapshots/day2"
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "${roots[$i_pc2]}/.snapshots"
> +run_check_restore_profile $i_pc2 day2
> +run_check_update_file $i_pc2 day1 3
> +run_check_backup_profile $i_pc2 day2 day3
> +
> +run_check_update_file $i_pc2 day1 4
> +run_check_backup_profile $i_pc2 day3 day4
> +
> +run_check_copy_fresh_backup_and_replace_profile $i_pc1 day2 day4
> +run_check_update_file $i_pc1 day1 5
> +run_check_backup_profile $i_pc1 day4 day5
> +
> +run_check_copy_fresh_backup_and_replace_profile $i_pc2 day4 day5
> +run_check_update_file $i_pc2 day1 6
> +run_check_backup_profile $i_pc2 day5 day6
> +
> +run_check_umount_test_dev ${loopdevs[@]}
> +rmdir ${roots[@]}
> +rm -f send.data
> +cleanup_loopdevs
> -- 
> 2.41.0


