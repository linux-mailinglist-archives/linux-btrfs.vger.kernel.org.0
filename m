Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD74442D49
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhKBL7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 07:59:19 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:57308 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBL7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 07:59:18 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 869FB6C00709;
        Tue,  2 Nov 2021 13:56:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1635854189; bh=TAvf0RujMgwWy4m94VDUs1ut9FAbEKcVc20lxgdKqJA=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=Sw4yO7h2z5rrMVBGAAwPGQBp535wk5QhYFsrww0rCEaJd2nF3VWVdU3DBSFQIxVrB
         zY4kmz7zBGc8+acxaHeHBON8QMNiu2T+3zWpsZqk6KxwXd2GiKqQw+6f/aLZmeIiwN
         0CWmVJW1C3oIdFeqaC5CbXZ76JyQZLpl9PG9X25Q=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 7A2D16C00708;
        Tue,  2 Nov 2021 13:56:29 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id o8ZXuKFt2PIP; Tue,  2 Nov 2021 13:56:29 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 329FC6C00697;
        Tue,  2 Nov 2021 13:56:29 +0200 (EET)
Received: from nas (unknown [117.62.175.1])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 766A71BE00BD;
        Tue,  2 Nov 2021 13:56:27 +0200 (EET)
References: <20211102104758.39871-1-wqu@suse.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Make "btrfs filesystem df" command to show
 upper case profile
Date:   Tue, 02 Nov 2021 19:52:44 +0800
In-reply-to: <20211102104758.39871-1-wqu@suse.com>
Message-ID: <8ry6hiu2.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m5/RSeE2piELSPXaeWkYrzV5EXevl+uWy0xxdmmeDUSOFf08TVhKpnGtzU32k
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 02 Nov 2021 at 18:47, Qu Wenruo <wqu@suse.com> wrote:

> [BUG]
> Since commit dad03fac3bb8 ("btrfs-progs: switch 
> btrfs_group_profile_str
> to use raid table"), fstests/btrfs/023 and btrfs/151 will always 
> fail.
>
> The failure of btrfs/151 explains the reason pretty well:
>
> btrfs/151 1s ... - output mismatch
>     --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 
>     +0800
>     +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 
>     17:13:43.879999994 +0800
>     @@ -1,2 +1,2 @@
>      QA output created by 151
>     -Data, RAID1
>     +Data, raid1
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out 
>     ~/xfstests-dev/results//btrfs/151.out.bad'  to see the 
>     entire diff)
>
> [CAUSE]
> Commit dad03fac3bb8 ("btrfs-progs: switch 
> btrfs_group_profile_str to use
> raid table") will use btrfs_raid_array[index].raid_name, which 
> is all
> lower case.
>
> [FIX]
> There is no need to bring such output format change.
>
> So here we adds a new helper function, 
> btrfs_group_profile_upper_str()
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
> @@ -72,6 +72,7 @@ static void print_df(int fd, struct 
> btrfs_ioctl_space_args *sargs, unsigned unit
>  {
>  	u64 i;
>  	struct btrfs_ioctl_space_info *sp = sargs->spaces;
> +	char profile_buf[BTRFS_PROFILE_STR_LEN];
>  	u64 unusable;
>  	bool ok;
>
> @@ -79,9 +80,10 @@ static void print_df(int fd, struct 
> btrfs_ioctl_space_args *sargs, unsigned unit
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
> @@ -1038,6 +1038,16 @@ const char* btrfs_group_profile_str(u64 
> flag)
>  	return btrfs_raid_array[index].raid_name;
>  }
>
> +void btrfs_group_profile_upper_str(u64 flags, char *ret)
> +{
> +	int i;
> +
> +	strncpy(ret, btrfs_group_profile_str(flags), 
> BTRFS_PROFILE_STR_LEN);
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
> @@ -75,6 +75,9 @@ int find_next_key(struct btrfs_path *path, 
> struct btrfs_key *key);
>  const char* btrfs_group_type_str(u64 flag);
>  const char* btrfs_group_profile_str(u64 flag);
>
> +#define BTRFS_PROFILE_STR_LEN	(64)
>
May it be 8?
struct btrfs_raid_attr {
...
       const char raid_name[8];
...
};

--
Su
> +void btrfs_group_profile_upper_str(u64 flag, char *ret);
> +
>  int count_digits(u64 num);
>  u64 div_factor(u64 num, int factor);
