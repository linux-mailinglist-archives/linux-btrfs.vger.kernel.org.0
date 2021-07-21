Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779AB3D15CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhGURVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 13:21:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhGURVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 13:21:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B12522257D;
        Wed, 21 Jul 2021 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626890539;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UURkxj0FzkddkNj25OCBmqPhNmUDQqkrhXQKcD008LU=;
        b=xcQSz636EWAiC85tX8hiA6MdN0EZiqEIXRlig788UnnDsmwAPzPBNq5J3lLcsUo83LT+9F
        PWY+l9YpdOPJ6SMR19CtQZDKqUAtXxhCzxHkySb4Z5Fz+k5lkuLdPKh0+Fr0OknVGundiW
        hVkzEVOGq0Yvh7CCchNWz2ZxJ+eNiJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626890539;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UURkxj0FzkddkNj25OCBmqPhNmUDQqkrhXQKcD008LU=;
        b=BKweevZE47LPO8lNVm//uvT+55czJ9isHbyeT/esC54dRYhnvB5WwwqU7lmw2B08F50XxW
        Zq7IF1jCXNLG68BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9A5B9A3B87;
        Wed, 21 Jul 2021 18:02:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D5D5DA704; Wed, 21 Jul 2021 19:59:38 +0200 (CEST)
Date:   Wed, 21 Jul 2021 19:59:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
Message-ID: <20210721175938.GP19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715103403.176695-1-desmondcheongzx@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 15, 2021 at 06:34:03PM +0800, Desmond Cheong Zhi Xi wrote:
> Syzbot reports a warning in close_fs_devices that happens because
> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
> on each device.
> 
> This happens when a writeable device is removed in
> __btrfs_free_extra_devids, but the rw device count is not decremented
> accordingly. So when close_fs_devices is called, the removed device is
> still counted and we get an off by 1 error.
> 
> Here is one call trace that was observed:
>   btrfs_mount_root():
>     btrfs_scan_one_device():
>       device_list_add();   <---------------- device added
>     btrfs_open_devices():
>       open_fs_devices():
>         btrfs_open_one_device();   <-------- rw device count ++
>     btrfs_fill_super():
>       open_ctree():
>         btrfs_free_extra_devids():
> 	  __btrfs_free_extra_devids();  <--- device removed
> 	  fail_tree_roots:
> 	    btrfs_close_devices():
> 	      close_fs_devices();   <------- rw device count off by 1
> 
> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")

What this patch did in the last hunk was the rw_devices decrement, but
conditional:

@@ -1080,9 +1071,6 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
                if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
                        list_del_init(&device->dev_alloc_list);
                        clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
-                       if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
-                                     &device->dev_state))
-                               fs_devices->rw_devices--;
                }
                list_del_init(&device->dev_list);
                fs_devices->num_devices--;
---


> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>  		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>  			list_del_init(&device->dev_alloc_list);
>  			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> +			fs_devices->rw_devices--;
>  		}
>  		list_del_init(&device->dev_list);
>  		fs_devices->num_devices--;

So should it be reinstated in the original form? The rest of
cf89af146b7e handles unexpected device replace item during mount.

Adding the decrement is correct, but right now I'm not sure about the
corner case when teh devcie has the BTRFS_DEV_STATE_REPLACE_TGT bit set.
The state machine of the device bits and counters is not trivial so
fixing it one way or the other could lead to further syzbot reports if
we don't understand the issue.
