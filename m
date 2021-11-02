Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D6442DC7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 13:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKBM0U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Nov 2021 08:26:20 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:59695 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhKBM0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 08:26:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04461119|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00292336-0.00027284-0.996804;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.LmJQCjO_1635855822;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LmJQCjO_1635855822)
          by smtp.aliyun-inc.com(10.147.42.22);
          Tue, 02 Nov 2021 20:23:42 +0800
Date:   Tue, 02 Nov 2021 20:23:45 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Make "btrfs filesystem df" command to show upper case profile
In-Reply-To: <20211102104758.39871-1-wqu@suse.com>
References: <20211102104758.39871-1-wqu@suse.com>
Message-Id: <20211102202345.1D25.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

before Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
 raid table") , 'single' is lower case. others, such as RAID1 , are
upper case.

I don't know whether it is necessary to keep 'single' as lower case.

maybe we can change the array value directly?
./kernel-shared/volumes.c:62:   [BTRFS_RAID_RAID1C3] = {
./kernel-shared/volumes.c:71:           .raid_name      = "raid1c3",

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/11/02

> [BUG]
> Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
> to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.
> 
> The failure of btrfs/151 explains the reason pretty well:
> 
> btrfs/151 1s ... - output mismatch
>     --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 +0800
>     +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 17:13:43.879999994 +0800
>     @@ -1,2 +1,2 @@
>      QA output created by 151
>     -Data, RAID1
>     +Data, raid1
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out ~/xfstests-dev/results//btrfs/151.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
> raid table") will use btrfs_raid_array[index].raid_name, which is all
> lower case.
> 
> [FIX]
> There is no need to bring such output format change.
> 
> So here we adds a new helper function, btrfs_group_profile_upper_str()
> to print the upper case profile name.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/filesystem.c |  4 +++-
>  common/utils.c    | 10 ++++++++++
>  common/utils.h    |  3 +++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 6a9e46d2b7dc..9f49b7d0c9c5 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -72,6 +72,7 @@ static void print_df(int fd, struct btrfs_ioctl_space_args *sargs, unsigned unit
>  {
>  	u64 i;
>  	struct btrfs_ioctl_space_info *sp = sargs->spaces;
> +	char profile_buf[BTRFS_PROFILE_STR_LEN];
>  	u64 unusable;
>  	bool ok;
>  
> @@ -79,9 +80,10 @@ static void print_df(int fd, struct btrfs_ioctl_space_args *sargs, unsigned unit
>  		unusable = device_get_zone_unusable(fd, sp->flags);
>  		ok = (unusable != DEVICE_ZONE_UNUSABLE_UNKNOWN);
>  
> +		btrfs_group_profile_upper_str(sp->flags, profile_buf);
>  		printf("%s, %s: total=%s, used=%s%s%s\n",
>  			btrfs_group_type_str(sp->flags),
> -			btrfs_group_profile_str(sp->flags),
> +			profile_buf,
>  			pretty_size_mode(sp->total_bytes, unit_mode),
>  			pretty_size_mode(sp->used_bytes, unit_mode),
>  			(ok ? ", zone_unusable=" : ""),
> diff --git a/common/utils.c b/common/utils.c
> index aee0eedc15fc..32ca6b2ef432 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -1038,6 +1038,16 @@ const char* btrfs_group_profile_str(u64 flag)
>  	return btrfs_raid_array[index].raid_name;
>  }
>  
> +void btrfs_group_profile_upper_str(u64 flags, char *ret)
> +{
> +	int i;
> +
> +	strncpy(ret, btrfs_group_profile_str(flags), BTRFS_PROFILE_STR_LEN);
> +
> +	for (i = 0; i < BTRFS_PROFILE_STR_LEN && ret[i]; i++)
> +		ret[i] = toupper(ret[i]);
> +}
> +
>  u64 div_factor(u64 num, int factor)
>  {
>  	if (factor == 10)
> diff --git a/common/utils.h b/common/utils.h
> index 6f84e3cbc98f..0c1b6baa7ae3 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -75,6 +75,9 @@ int find_next_key(struct btrfs_path *path, struct btrfs_key *key);
>  const char* btrfs_group_type_str(u64 flag);
>  const char* btrfs_group_profile_str(u64 flag);
>  
> +#define BTRFS_PROFILE_STR_LEN	(64)
> +void btrfs_group_profile_upper_str(u64 flag, char *ret);
> +
>  int count_digits(u64 num);
>  u64 div_factor(u64 num, int factor);
>  
> -- 
> 2.33.1


