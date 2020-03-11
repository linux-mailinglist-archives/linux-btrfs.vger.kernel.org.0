Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB83918219E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgCKTKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 15:10:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbgCKTKv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 15:10:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 939F3AEE2;
        Wed, 11 Mar 2020 19:10:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9C57DA7A7; Wed, 11 Mar 2020 20:10:23 +0100 (CET)
Date:   Wed, 11 Mar 2020 20:10:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200311191023.GH12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Takashi Iwai <tiwai@suse.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200311093323.24955-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311093323.24955-1-tiwai@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 10:33:23AM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Is this a mechanical conversion or is there actually a potential
overflow in the code?

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  fs/btrfs/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 93cf76118a04..d3dc069789a5 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -310,12 +310,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
>  		 * This "trick" only works as long as 'enum btrfs_csum_type' has
>  		 * no holes in it
>  		 */
> -		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
>  				(i == 0 ? "" : " "), btrfs_super_csum_name(i));

Loop count is a constant, each iteration filling with two %s of constant
length, buffer size is PAGE_SIZE.

>  
>  	}
>  
> -	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
>  	return ret;
>  }
>  BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
> @@ -992,7 +992,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
>  			continue;
>  
>  		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
> -		len += snprintf(str + len, bufsize - len, "%s%s",
> +		len += scnprintf(str + len, bufsize - len, "%s%s",
>  				len ? "," : "", name);

Similar, compile-time constant for number of loops, filling with strings
of bounded length.

If the patch is a precaution, then ok, but I don't see what it's trying
to fix.
