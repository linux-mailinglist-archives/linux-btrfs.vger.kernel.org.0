Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E611AE72
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 15:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfLKOzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 09:55:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33454 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfLKOzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 09:55:06 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so5857913qvn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 06:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11zF8CeZYw7fujfDBWoUXQFxYiwUPZBvnHdi5wHX0KQ=;
        b=LSbT6wdPqIUFz2rydRZeJW2zdzFHPrbb/W58ZH7J8DuQFRmB7CA9cBclFMFkG+PePp
         /yq5Ca4tSPy6uPQGeA6r+P+hnk5VGVxsgg4THmReVX8ZBoAOzoKKKgTQTT83htuk0bSC
         38VwP89GKIhHwZR9M2dYLF5gkDxrTXz8PCvGECTn7BmUG8I/9wcy8y91y1ky+KCFi7dl
         7LPJvg+cvj2pmWxJGSWuMSFbb4M8zZzu+eIVEz7KLDwT0lba7EiwioOoX/9kcRcvKZbu
         bzQiKK1Gq3XPa5OwXvEprVqwyselmrkCxrtFbQmN6b0g5MTiW5Dv7Hzq4hclujz2R8IW
         1RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11zF8CeZYw7fujfDBWoUXQFxYiwUPZBvnHdi5wHX0KQ=;
        b=HgNBulK/fC+KkTsAM+BTHYfRdSW4s5ocWCM+n93hcsTOmiXJXGE2pb4A/6/v/VVaSY
         ZhwrjFIwRzemWnImSjy/eZn2QxASh0YHY0z7RWMKilQw98mIoEc1oG+vRfSO9lu8U+U+
         IjcWt2kQB7YngpjN+GCLdfDSlfaC2IB7fA9bfa7bCpCymLnau9EcWOFa2qIKm5oWW7/G
         lwzfJNJxMDBvKcTU6xSPgJZDaPOyylStXHzbzqrMiVLOf9ylrc4DJbOMOzVMrKbF8A/T
         1z+ZZFvmA+CUqNCjvaxDbo1OD6QrvfkLe9U5lZ4oC4e36MPTs5VoveY3qC03u5yZF7qe
         Ejxw==
X-Gm-Message-State: APjAAAWOHIaMP6L9qL5GO7bKIhdodiOygbrzUmazNfpVwFv4Dv757aI+
        GuS8m43EB/txNlX9GMZfwHpIAg==
X-Google-Smtp-Source: APXvYqw9SOQWhhIy7y7nBN5P/vofoBnmz2+zn4ofKA6hj2M8Q1wiXz07JpGcVJvjp1U5WIZUK528Cw==
X-Received: by 2002:ad4:46f1:: with SMTP id h17mr3447135qvw.178.1576076105616;
        Wed, 11 Dec 2019 06:55:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4149])
        by smtp.gmail.com with ESMTPSA id k73sm740375qke.36.2019.12.11.06.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:55:04 -0800 (PST)
Subject: Re: [PATCH 2/3] btrfs: relocation: Fix KASAN report on
 create_reloc_tree due to extended reloc tree lifepsan
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211050004.18414-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e429eb35-16d3-1231-b984-7210b1b6972b@toxicpanda.com>
Date:   Wed, 11 Dec 2019 09:55:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211050004.18414-3-wqu@suse.com>
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
> 
>    ==================================================================
>    BUG: KASAN: use-after-free in create_reloc_root+0x9f/0x460 [btrfs]
>    Read of size 8 at addr ffff8881571741f0 by task btrfs/3539
> 
>    CPU: 6 PID: 3539 Comm: btrfs Tainted: G           O      5.5.0-rc1-custom+ #40
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>    Call Trace:
>     dump_stack+0xc2/0x11a
>     print_address_description.constprop.0+0x20/0x210
>     __kasan_report.cold+0x1b/0x41
>     kasan_report+0x12/0x20
>     __asan_load8+0x54/0x90
>     create_reloc_root+0x9f/0x460 [btrfs]
>     btrfs_reloc_post_snapshot+0xff/0x6c0 [btrfs]
>     create_pending_snapshot+0xa9b/0x15f0 [btrfs]
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
> This is another case where root->reloc_root is accessed without checking
> if the reloc root is already dead.
> 
> [FIX]
> Also check DEAD_RELOC_TREE bit before accessing root->reloc_root.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/relocation.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index bb41b981e493..619ccb183515 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4755,7 +4755,14 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
>   	struct reloc_control *rc = root->fs_info->reloc_ctl;
>   	int ret;
>   
> -	if (!root->reloc_root || !rc)
> +	/*
> +	 * We don't need to use reloc tree if:
> +	 * - No reloc tree
> +	 * - Relocation not running
> +	 * - Reloc tree already merged
> +	 */
> +	if (!root->reloc_root || !rc || test_bit(BTRFS_ROOT_DEAD_RELOC_TREE,
> +				&root->state))

This is awkward formatting, can we move the test_bit() to the first thing we 
check so it's less weird?  Then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
