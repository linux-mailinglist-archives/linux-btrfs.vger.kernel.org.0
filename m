Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B288214D0B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgA2SuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 13:50:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgA2SuL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 13:50:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76595AC22;
        Wed, 29 Jan 2020 18:50:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AAC94DA730; Wed, 29 Jan 2020 19:49:50 +0100 (CET)
Date:   Wed, 29 Jan 2020 19:49:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: sysfs, add read_policy attribute
Message-ID: <20200129184950.GM3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <b39e2e18-4116-f77b-df59-d39aa006ea93@applied-asynchrony.com>
 <20200108041647.2330-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108041647.2330-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 08, 2020 at 12:16:47PM +0800, Anand Jain wrote:
> Add
> 
>  /sys/fs/btrfs/UUID/read_policy
> 
> attribute so that the read policy for the raid1 and raid10 chunks can be
> tuned.
> 
> When this attribute is read, it shall show all available policies, and
> the active policy is with in [ ], read_policy attribute can be written
> using one of the items showed in the read.
> 
> For example:
> cat /sys/fs/btrfs/UUID/read_policy
> [by_pid]
> echo by_pid > /sys/fs/btrfs/UUID/read_policy
> echo -n by_pid > /sys/fs/btrfs/UUID/read_policy

Dropping "by_" is a good thing, but it should be removed everywhere.
Also '-n' to echo should not be necessary and the store handler of sysfs
should deal with that.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v3: rename [by_pid] to [pid]
> v2: v2: check input len before strip and kstrdup
> 
>  fs/btrfs/sysfs.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  1 +
>  2 files changed, 67 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 104a97586744..cc4a642878a1 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -809,6 +809,71 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
>  
>  BTRFS_ATTR(, checksum, btrfs_checksum_show);
>  
> +static const inline char *btrfs_read_policy_name(enum btrfs_read_policy_type type)
> +{
> +	switch (type) {
> +	case BTRFS_READ_BY_PID:
> +		return "pid";
> +	default:
> +		return "null";
> +	}
> +}

A simple table should do, similar what we have for the compression
number -> string mapping.

> +
> +static ssize_t btrfs_read_policy_show(struct kobject *kobj,
> +				      struct kobj_attribute *a, char *buf)
> +{
> +	int i;
> +	ssize_t len = 0;

As this is used as return value, plese rename it to 'ret'

> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
> +		if (len)
> +			len += snprintf(buf + len, PAGE_SIZE, " ");

You can use the same thning for the separator as is in
supported_checksums_show, ie. (i == 0 ? "" : " ") and add one more %s to
the format.

> +		if (fs_devices->read_policy == i)
> +			len += snprintf(buf + len, PAGE_SIZE, "[%s]",
> +					btrfs_read_policy_name(i));
> +		else
> +			len += snprintf(buf + len, PAGE_SIZE, "%s",
> +					btrfs_read_policy_name(i));

Keeping the default and the rest as separte calls to snprintf is
probably better so with the separator it would be

		if (fs_devices->read_policy == i)
			len += snprintf(buf + len, PAGE_SIZE, "%s[%s]",
					(i == 0 ? "" : " "),
					btrfs_read_policy_name(i));
		else
			len += snprintf(buf + len, PAGE_SIZE, "%s%s",
					(i == 0 ? "" : " "),
					btrfs_read_policy_name(i));

> +	}
> +
> +	len += snprintf(buf + len, PAGE_SIZE, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
> +				       struct kobj_attribute *a,
> +				       const char *buf, size_t len)
> +{
> +	int i;
> +	char *stripped;
> +	char *policy_name;
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	if (len > BTRFS_READ_POLICY_NAME_MAX)
> +		return -EINVAL;
> +
> +	policy_name = kstrdup(buf, GFP_KERNEL);

Can you avoid the allocation? None of the sysfs handlers should need it.

> +	if (!policy_name)
> +		return -ENOMEM;
> +
> +	stripped = strstrip(policy_name);

So the allocation is to make a copy of a string to get rid of leading
and trailing whitespace. There shouldn't be any leading space that we
should care about, but anyway skip_spaces() can be used on a read-only
string just fine.

The trailing whitespace is for the potential '\n' that we want to
handle. But doing an allocation here is an overkill, you can add a
helper that will verify that there's no garbage at the end of the
string, once the policy string matches one of ours.

> +
> +	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
> +		if (strncmp(stripped, btrfs_read_policy_name(i),
> +			    strlen(stripped)) == 0) {
> +			fs_devices->read_policy = i;
> +			kfree(policy_name);
> +			return len;
> +		}
> +	}
> +
> +	kfree(policy_name);
> +	return -EINVAL;
> +}
> +BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
> +
>  static const struct attribute *btrfs_attrs[] = {
>  	BTRFS_ATTR_PTR(, label),
>  	BTRFS_ATTR_PTR(, nodesize),
> @@ -817,6 +882,7 @@ static const struct attribute *btrfs_attrs[] = {
>  	BTRFS_ATTR_PTR(, quota_override),
>  	BTRFS_ATTR_PTR(, metadata_uuid),
>  	BTRFS_ATTR_PTR(, checksum),
> +	BTRFS_ATTR_PTR(, read_policy),
>  	NULL,
>  };
>  
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 46f4e2258203..fe1494d95893 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -209,6 +209,7 @@ BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>  BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>  
>  /* read_policy types */
> +#define BTRFS_READ_POLICY_NAME_MAX	12

And this can be dropped afterwards

>  #define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
>  enum btrfs_read_policy_type {
>  	BTRFS_READ_BY_PID,
> -- 
> 2.23.0
