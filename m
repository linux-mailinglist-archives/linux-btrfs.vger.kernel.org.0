Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672E8A39D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfH3PDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 11:03:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:56256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbfH3PDl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 11:03:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCF2FAD3A;
        Fri, 30 Aug 2019 15:03:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCB2CDA809; Fri, 30 Aug 2019 17:04:00 +0200 (CEST)
Date:   Fri, 30 Aug 2019 17:03:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] btrfs: sysfs: export supported checksums
Message-ID: <20190830150359.GO2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190830113611.16865-1-jthumshirn@suse.de>
 <20190830113611.16865-5-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830113611.16865-5-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 30, 2019 at 01:36:11PM +0200, Johannes Thumshirn wrote:
> From: David Sterba <dsterba@suse.com>

I did not write the patch.

> Export supported checksum algorithms via sysfs.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

And 'git am' complains that there are two s-o-b lines.

> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> ---
> Changes to v2:
> - Prevent possible overflow of sysfs attribute
> Changes to v1:
> - Removed btrfs_checksums_store() function (Nik)
> - Renamed sysfs file to supported_checksums
> ---
>  fs/btrfs/sysfs.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index f6d3c80f2e28..cae9c99253c7 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -246,6 +246,24 @@ static umode_t btrfs_feature_visible(struct kobject *kobj,
>  	return mode;
>  }
>  
> +static ssize_t btrfs_supported_checksums_show(struct kobject *kobj,
> +					      struct kobj_attribute *a,
> +					      char *buf)
> +{
> +	ssize_t ret = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {

We'll need one more helper to return the number of csums, btrfs_csums is
not visible in sysfs.c anymore (aka it does not compile).

> +		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> +				(i == 0 ? "" : ", "),

I've checked some sysfs files what's commonly used for a value separator
and there are more examples of ' ', though ', ' is also there. I'd
prefer to use a single letter separator.

> +				btrfs_csums[i].name);
> +
> +	}
> +
> +	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +	return ret;
> +}
> +
>  BTRFS_FEAT_ATTR_INCOMPAT(mixed_backref, MIXED_BACKREF);
>  BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
>  BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
> @@ -259,6 +277,14 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>  BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  
> +static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
> +	.kobj_attr = __INIT_KOBJ_ATTR(supported_checksums, S_IRUGO,
> +				      btrfs_supported_checksums_show,
> +				      NULL),
> +	.feature_set	= FEAT_INCOMPAT,
> +	.feature_bit	= 0,
> +};
> +
>  static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(mixed_backref),
>  	BTRFS_FEAT_ATTR_PTR(default_subvol),
> @@ -272,6 +298,9 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(no_holes),
>  	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
>  	BTRFS_FEAT_ATTR_PTR(free_space_tree),
> +
> +	&btrfs_attr_features_checksums_name.kobj_attr.attr,

This belongs to the static features, ie. the same scheme as
rmdir_subvol. The two lists are merged together in sysfs directory, but
should be defined separately as they represent different type of
features.

> +
>  	NULL
>  };
>  
> -- 
> 2.16.4
