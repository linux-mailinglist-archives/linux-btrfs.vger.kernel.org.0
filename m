Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD010361231
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhDOSgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOSgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 14:36:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E9C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:36:27 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s5so17501993qkj.5
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=82fNxRz5/qQxwCXbi9UEH58iG2sL5m2BoQ9nehVkC40=;
        b=DseGZxV/VVRwL7a4ni2BlER0x1Y4NGCD/8gfziaFPV1SHN4CHnPK8zSgQFB+fnDPIJ
         U4v2AtLkWr4TlYwaoBI4nysZ3jtulkAyJggmiHLYJCiIZSFnheoHSBOzOfB7Mog1l41F
         scI45jcQYtzzWuL34SFfzsnR7ygJivqK7H/ux+VsMJEvFq7nZL9i4IIewfzHDeOYS+ex
         zDA8QgVzwB5z32tONH611NlZW7/dYHdeFlS6iGp0Br8cT+NH0ava+A0M4h+8pslBw1KV
         hH+ROQp/4xbDekFOOxMXPWCIDPJx/SJSTfYbrbqQRr/jjSB3xfJOdz0kyng5HO4fDjA6
         tBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=82fNxRz5/qQxwCXbi9UEH58iG2sL5m2BoQ9nehVkC40=;
        b=H2xDcFz4rpNo2jVGRK5LCHbieJbfXnN5+WzSVp8KyigQbwlDFcOaj/qg66+Rcrrfu+
         47VM8lap8olDT57Sk3JkqAg/1Q07muOy5YuPa1eXQPGl/E4VT4+Eq2eKg7g+39NndIWQ
         b6jLfmPWOju6nu0xFpYF9N5b2E6PBldvFWhZ0n8fm1VVTMHSt6CLcwXJqUMtNdYS4lYF
         xQJGB6JPUS75OZadcSIp/lxGH5xZtXVGIk+WK6BInP9/HqJ94tM95WJXmQccispi1P81
         N94Uj+KoD4fnuEGnsrFlzaktdyJpclyuRn+41eoxwGNOUzP37evKqvk1N8catKEu7nYx
         C3/A==
X-Gm-Message-State: AOAM533MGXpd6OniAx4145NKvUi+wY3xV5unM2jDlzjIv1qlcMo/ALSE
        re3KFLzLQv5kPIRnO7iH6JGy2w==
X-Google-Smtp-Source: ABdhPJw+z1SXD32l8jZ4/l71TVJcdoPsYPP6nG3Gz3pJoS48IxcvMNZlC8MBm/BadhREYB+GvKh8bQ==
X-Received: by 2002:a37:614e:: with SMTP id v75mr4977129qkb.170.1618511786458;
        Thu, 15 Apr 2021 11:36:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id 8sm2561326qkb.32.2021.04.15.11.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:36:26 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <920701be19f36b4f7ed84efd53a3d0550700f047.1618494550.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <63c82817-751c-b200-abfc-b7e669affa93@toxicpanda.com>
Date:   Thu, 15 Apr 2021 14:36:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <920701be19f36b4f7ed84efd53a3d0550700f047.1618494550.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 9:58 AM, Johannes Thumshirn wrote:
> When a file gets deleted on a zoned file system, the space freed is not
> returned back into the block group's free space, but is migrated to
> zone_unusable.
> 
> As this zone_unusable space is behind the current write pointer it is not
> possible to use it for new allocations. In the current implementation a
> zone is reset once all of the block group's space is accounted as zone
> unusable.
> 
> This behaviour can lead to premature ENOSPC errors on a busy file system.
> 
> Instead of only reclaiming the zone once it is completely unusable,
> kick off a reclaim job once the amount of unusable bytes exceeds a user
> configurable threshold between 51% and 100%. It can be set per mounted
> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
> per default.
> 
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/block-group.c       | 96 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/block-group.h       |  3 ++
>   fs/btrfs/ctree.h             |  6 +++
>   fs/btrfs/disk-io.c           | 13 +++++
>   fs/btrfs/free-space-cache.c  |  9 +++-
>   fs/btrfs/sysfs.c             | 35 +++++++++++++
>   fs/btrfs/volumes.c           |  2 +-
>   fs/btrfs/volumes.h           |  1 +
>   include/trace/events/btrfs.h | 12 +++++
>   9 files changed, 175 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bbb5a6e170c7..3f06ea42c013 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1485,6 +1485,92 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>   	spin_unlock(&fs_info->unused_bgs_lock);
>   }
>   
> +void btrfs_reclaim_bgs_work(struct work_struct *work)
> +{
> +	struct btrfs_fs_info *fs_info =
> +		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
> +	struct btrfs_block_group *bg;
> +	struct btrfs_space_info *space_info;
> +	int ret = 0;
> +
> +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> +		return;
> +
> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> +		return;
> +
> +	mutex_lock(&fs_info->reclaim_bgs_lock);
> +	spin_lock(&fs_info->unused_bgs_lock);
> +	while (!list_empty(&fs_info->reclaim_bgs)) {
> +		bg = list_first_entry(&fs_info->reclaim_bgs,
> +				      struct btrfs_block_group,
> +				      bg_list);
> +		list_del_init(&bg->bg_list);
> +
> +		space_info = bg->space_info;
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +
> +		/* Don't want to race with allocators so take the groups_sem */
> +		down_write(&space_info->groups_sem);
> +
> +		spin_lock(&bg->lock);
> +		if (bg->reserved || bg->pinned || bg->ro) {
> +			/*
> +			 * We want to bail if we made new allocations or have
> +			 * outstanding allocations in this block group.  We do
> +			 * the ro check in case balance is currently acting on
> +			 * this block group.
> +			 */
> +			spin_unlock(&bg->lock);
> +			up_write(&space_info->groups_sem);
> +			goto next;
> +		}
> +		spin_unlock(&bg->lock);
> +

Here I think we want a

if (btrfs_fs_closing())
	goto next;

so we don't block out a umount for all eternity.  Thanks,

Josef
