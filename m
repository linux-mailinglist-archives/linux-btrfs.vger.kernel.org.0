Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762772994AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 18:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788957AbgJZR70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 13:59:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:57416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782044AbgJZR70 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 13:59:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EE6BAF80;
        Mon, 26 Oct 2020 17:59:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5D6ADA6E2; Mon, 26 Oct 2020 18:57:50 +0100 (CET)
Date:   Mon, 26 Oct 2020 18:57:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
Subject: Re: [PATCH v9 3/3] btrfs: create read policy sysfs attribute, pid
Message-ID: <20201026175750.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <abd366082eeb8b289cd420cb04528a687a250433.1603347462.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd366082eeb8b289cd420cb04528a687a250433.1603347462.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 22, 2020 at 03:43:37PM +0800, Anand Jain wrote:
> Add
> 
>  /sys/fs/btrfs/UUID/read_policy
> 
> attribute so that the read policy for the raid1, raid1c34 and raid10 can
> be tuned.
> 
> When this attribute is read, it shall show all available policies, with
> active policy being with in [ ]. The read_policy attribute can be written
> using one of the items listed in there.
> 
> For example:
>   $cat /sys/fs/btrfs/UUID/read_policy
>   [pid]
>   $echo pid > /sys/fs/btrfs/UUID/read_policy
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v9: fix C coding style, static const char*
> v5: 
>   Title rename: old: btrfs: sysfs, add read_policy attribute
>   Uses the btrfs_strmatch() helper (BTRFS_READ_POLICY_NAME_MAX dropped).
>   Use the table for the policy names.
>   Rename len to ret.
>   Use a simple logic to prefix space in btrfs_read_policy_show()
>   Reviewed-by: Josef Bacik <josef@toxicpanda.com> dropped.
> 
> v4:-
> v3: rename [by_pid] to [pid]
> v2: v2: check input len before strip and kstrdup
> 
>  fs/btrfs/sysfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 5ea262d289c6..e23ae3643527 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -883,6 +883,54 @@ static int btrfs_strmatch(const char *given, const char *golden)
>  	return -EINVAL;
>  }
>  
> +static const char * const btrfs_read_policy_name[] = { "pid" };
> +
> +static ssize_t btrfs_read_policy_show(struct kobject *kobj,
> +				      struct kobj_attribute *a, char *buf)
> +{
> +	int i;
> +	ssize_t ret = 0;
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
> +		if (fs_devices->read_policy == i)
> +			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",

All snprintf have been upgraded to scnprintf as it does have sane
behaviour when the buffer is not large enough.

> +					(ret == 0 ? "" : " "),
> +					btrfs_read_policy_name[i]);
> +		else
> +			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> +					(ret == 0 ? "" : " "),
> +					btrfs_read_policy_name[i]);
> +	}
> +
> +	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +
> +	return ret;
> +}
