Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8E11AE80
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 15:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfLKOzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 09:55:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35789 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfLKOzz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 09:55:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id s8so6510270qte.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6PFgLUQNRf4xg/tdXAUVCASsyl/WqwirZPNLIpxzzr4=;
        b=O/zE0N2UdEsO+A+d1wePXG7YoUqCg/+DImeTG4KyVU7bIhavbmDCNLkU9+yUVQ27W2
         wgKz/j90MVbSbWZGCwTDym1zAk61IeurfPKjgx3geUqzX5FrrqsOsyoFnPhTOTdrGuE2
         SbEmMse4cfPq7xicY4XAHMXhAQthZRX9P93F1/g2TL240KaG1DoEXP6J9Q08Fc2fQnU5
         TFIYLgIGLZ+k8rk/uoJIdrhDhdPvaOXI6aCz73pM3KKkmS2K00PsjAUFtWYyL8Mm+FsM
         6h8IG5uIo+zJc04YbbHgvqALPUqEjeWWvL5ldCjTJKVGuWGLyNbq91jWJKcf5f/Wgue1
         MYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6PFgLUQNRf4xg/tdXAUVCASsyl/WqwirZPNLIpxzzr4=;
        b=AG2mxh2EYjztwmfM4NC8mMRc7XuZwCNQ++9kpq3TH25mIKnVylNlVjYIrX8GTJPXKq
         1Mm98NAHbiKZUzfs1HWab1cfeTTdk5IfH4ijHYDtRNSV5xAFgNDJS0vUNiVCL73G2K8u
         RlGMkwsrZ+DHicSjfHmvtwEr/Wee4Gt2t+ByyRArp6q7sB3LMQIXDMIgwG2pbYSZwqp9
         7nDHF+lC7i4HQSBgwqhm7PXdejP/RZvDq+Bs+zsXhkwFrr3ywAX+kxayJn0p2jDyS0fY
         i3/8sBnBBAoYctvxUpg9sjjem+lyH/eSvtkVyR/ZkPDsqzNRdcYpjRQBIRnyt2SX38Ur
         3cCw==
X-Gm-Message-State: APjAAAU69qH4lNK2VYtwNjjgFTaVLc20f927755rYoEi6lCfGs9HPJU9
        nWw7AggTa/tGHQOWyIDmKEbyfw==
X-Google-Smtp-Source: APXvYqw6+kC9Lp7+xwNZw2AdJipcnZVj/pYjCq9QpQduI3jH+nNor1xgfoYAojR0ZDX1UvNTqWvsdg==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr2027087qtv.102.1576076154331;
        Wed, 11 Dec 2019 06:55:54 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4149])
        by smtp.gmail.com with ESMTPSA id k62sm725413qkc.95.2019.12.11.06.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:55:53 -0800 (PST)
Subject: Re: [PATCH 3/3] btrfs: relocation: Fix a KASAN report on
 btrfs_reloc_pre_snapshot() due to extended reloc root lifespan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211050004.18414-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e95ea11b-304a-92b7-b2ab-b244a17fa7ce@toxicpanda.com>
Date:   Wed, 11 Dec 2019 09:55:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211050004.18414-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/19 12:00 AM, Qu Wenruo wrote:
> [BUG]
> When running workload with balance start/cancel, snapshot
> creation/deletion and fsstress, we can hit the following KASAN report:
>    ==================================================================
>    BUG: KASAN: use-after-free in btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
>    Read of size 4 at addr ffff888157140100 by task btrfs/1822
> 
>    CPU: 2 PID: 1822 Comm: btrfs Tainted: G           O      5.5.0-rc1-custom+ #40
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>    Call Trace:
>     dump_stack+0xc2/0x11a
>     print_address_description.constprop.0+0x20/0x210
>     __kasan_report.cold+0x1b/0x41
>     kasan_report+0x12/0x20
>     check_memory_region+0x13c/0x1b0
>     __asan_loadN+0xf/0x20
>     btrfs_reloc_pre_snapshot+0x85/0xc0 [btrfs]
>     create_pending_snapshot+0x209/0x15f0 [btrfs]
>     create_pending_snapshots+0x111/0x140 [btrfs]
>     btrfs_commit_transaction+0x7a6/0x1360 [btrfs]
>     btrfs_mksubvol+0x915/0x960 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x1d5/0x1e0 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x1d3/0x270 [btrfs]
>     btrfs_ioctl+0x241b/0x3e60 [btrfs]
>     do_vfs_ioctl+0x831/0xb10
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x43/0x50
>     do_syscall_64+0x79/0xe0
>     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [CAUSE]
> Again, we try to access root->reloc_root without verify if that reloc
> root is already dead (being freed).
> 
> [FIX]
> Check if the root has dead reloc root before accessing it.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/relocation.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 619ccb183515..2d2cd1596ec9 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4721,7 +4721,8 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
>   	struct btrfs_root *root = pending->root;
>   	struct reloc_control *rc = root->fs_info->reloc_ctl;
>   
> -	if (!root->reloc_root || !rc)
> +	if (!root->reloc_root || !rc || test_bit(BTRFS_ROOT_DEAD_RELOC_TREE,
> +				&root->state))
>   		return;
>  

Same comment here as the other one, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Once it's fixed.  Thanks,

Josef
