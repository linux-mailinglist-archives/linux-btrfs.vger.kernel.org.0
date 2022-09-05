Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6762B5AC94C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 05:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiIED5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 23:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIED52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 23:57:28 -0400
Received: from out20-158.mail.aliyun.com (out20-158.mail.aliyun.com [115.124.20.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D4224F11
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Sep 2022 20:57:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04442586|-1;BR=01201311R191S27rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.365067-0.0122703-0.622663;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.P80ExQK_1662350243;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P80ExQK_1662350243)
          by smtp.aliyun-inc.com;
          Mon, 05 Sep 2022 11:57:24 +0800
Date:   Mon, 05 Sep 2022 11:57:26 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: slience the sparse warn of rcu_string
In-Reply-To: <20220824051208.19924-1-wangyugui@e16-tech.com>
References: <20220824051208.19924-1-wangyugui@e16-tech.com>
Message-Id: <20220905115726.6C63.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> slience the sparse warn of rcu_string reported by 'make C=1'
> 
> warning example:
> fs/btrfs/volumes.c:2300:41: warning: incorrect type in argument 3 (different address spaces)
> fs/btrfs/volumes.c:2300:41:    expected char const *device_path
> fs/btrfs/volumes.c:2300:41:    got char [noderef] __rcu *

I'm sorry that some new WARNING is triggered when 
lockdep(CONFIG_PROVE_LOCKING/...) check is enabled.

[  112.742722] =============================
[  112.746835] WARNING: suspicious RCU usage
[  112.750917] 6.0.0-4.0.el7.x86_64 #1 Not tainted
[  112.755540] -----------------------------
[  112.759624] fs/btrfs/volumes.c:918 suspicious rcu_dereference_check() usage!
[  112.766776] 
               other info that might help us debug this:

[  112.774921] 
               rcu_scheduler_active = 2, debug_locks = 1
[  112.781566] 2 locks held by mount/1725:
[  112.785471]  #0: ffffffffc50592a8 (uuid_mutex){+.+.}-{3:3}, at: btrfs_mount_root+0xfe/0x520 [btrfs]
[  112.794763]  #1: ffffa1147bf068e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: device_list_add+0x28d/0x830 [btrfs]


The fix is yet not clear,  we may need rcu_read_lock() just like
3181faa85bda3dc3f5e630a1846526c9caaa38e3 (cfq-iosched: fix a rcu warning)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/05

> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
> changes since v1:
>  add a warn example.
>  add 'Reviewed-by: Johannes Thumshirn'.
> 
>  fs/btrfs/dev-replace.c |  2 +-
>  fs/btrfs/volumes.c     | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 70d001d..b30930e 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -1006,7 +1006,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  	btrfs_sysfs_update_devid(tgt_device);
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
>  		btrfs_scratch_superblocks(fs_info, src_device->bdev,
> -					  src_device->name->str);
> +					  rcu_str_deref(src_device->name));
>  
>  	/* write back the superblocks */
>  	trans = btrfs_start_transaction(root, 0);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9481108..2cd261c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -390,7 +390,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
>  void btrfs_free_device(struct btrfs_device *device)
>  {
>  	WARN_ON(!list_empty(&device->post_commit_list));
> -	rcu_string_free(device->name);
> +	rcu_string_free(rcu_dereference(device->name));
>  	extent_io_tree_release(&device->alloc_state);
>  	btrfs_destroy_dev_zone_info(device);
>  	kfree(device);
> @@ -640,7 +640,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	if (!device->name)
>  		return -EINVAL;
>  
> -	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
> +	ret = btrfs_get_bdev_and_sb(rcu_str_deref(device->name), flags, holder, 1,
>  				    &bdev, &disk_super);
>  	if (ret)
>  		return ret;
> @@ -908,7 +908,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  				disk_super->fsid, devid, found_transid, path,
>  				current->comm, task_pid_nr(current));
>  
> -	} else if (!device->name || strcmp(device->name->str, path)) {
> +	} else if (!device->name || strcmp(rcu_str_deref(device->name), path)) {
>  		/*
>  		 * When FS is already mounted.
>  		 * 1. If you are here and if the device->name is NULL that
> @@ -978,7 +978,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			mutex_unlock(&fs_devices->device_list_mutex);
>  			return ERR_PTR(-ENOMEM);
>  		}
> -		rcu_string_free(device->name);
> +		rcu_string_free(rcu_dereference(device->name));
>  		rcu_assign_pointer(device->name, name);
>  		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
>  			fs_devices->missing_devices--;
> @@ -1035,7 +1035,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>  		 * uuid mutex so nothing we touch in here is going to disappear.
>  		 */
>  		if (orig_dev->name) {
> -			name = rcu_string_strdup(orig_dev->name->str,
> +			name = rcu_string_strdup(rcu_str_deref(orig_dev->name),
>  					GFP_KERNEL);
>  			if (!name) {
>  				btrfs_free_device(device);
> @@ -2217,7 +2217,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  	 */
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>  		btrfs_scratch_superblocks(fs_info, device->bdev,
> -					  device->name->str);
> +					  rcu_str_deref(device->name));
>  		if (device->bdev) {
>  			sync_blockdev(device->bdev);
>  			invalidate_bdev(device->bdev);
> @@ -2332,7 +2332,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
> -				  tgtdev->name->str);
> +				  rcu_str_deref(tgtdev->name));
>  
>  	btrfs_close_bdev(tgtdev);
>  	synchronize_rcu();
> -- 
> 2.36.2


