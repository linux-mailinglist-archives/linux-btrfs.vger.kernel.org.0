Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAD31F020
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 20:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhBRTlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 14:41:45 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:45883 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231234AbhBRTLv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 14:11:51 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-35.iol.local with ESMTPA
        id CohclVSyjpK9wCohclVMCz; Thu, 18 Feb 2021 20:11:05 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1613675465; bh=gCMjHwYfII2gUHX9EX+JZ8vveNB7dCulcOirCBKg5s4=;
        h=From;
        b=ROqbIJM64YoynTdhTVcXVwbtZXFFC4xgBeqmGTfd69yzqdveAF/IvKELov/kMH2lh
         V5cf7vheRCvk7GcD+tL1afFPym93TC7box6tT2pIrcWkxuR6+PFMsbVt4rx+A5hKGL
         c1jTjgLrNgalZHvTKiQCoQOrlO+6sXBT9kWe8tvvVkUGdgpX5gE1ZYB9qT3pMIWpmF
         HL6lSsKxLtDZUkFBlCeYjHpd10oY4MAHllMkAgLH0YB0LJdxKADvEM3ruQgRBa1f+A
         b8rXXJfCRDSWfel9kcEUG7p1yx6h/ohQKsmuxleaj9cZwXz5VFMqRUrCnKGO6HOi0+
         VoAMOcpwWKDRA==
X-CNFS-Analysis: v=2.4 cv=A9ipg4aG c=1 sm=1 tr=0 ts=602ebbc9 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=O4XOP55q0EOH1iYhKZ0A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH] btrfs: sysfs for chunk layout hint
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <0ed770d6d5e37fc942f3034d917d2b38477d7d20.1613668002.git.anand.jain@oracle.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <dade948e-7e66-4081-6ea1-f84a4dd6a11a@libero.it>
Date:   Thu, 18 Feb 2021 20:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0ed770d6d5e37fc942f3034d917d2b38477d7d20.1613668002.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDrieDsbKIVD2CqJHpSwUMWfKibEuA4jSN2UnvzjX3/J70NZ4W/W34UN8llW1l0Xx64OaN+vMNKo/yNj5xEQEqlc5TO2heV1pOM+S/meWVOQ4nbkoruM
 w0r7AM6IvlindmZ6PwHQOzRkNnKiajn/f46VzWNuRfWDMwAijDO2UZJi7HjnepDsVVqvlDtY8iAGoryJmTAyV8cJWKsx9TZW6THKxnbIMUiKwbURrqSDXBwf
 d9ei5S0lwYTkKUEeL+JEmnIVMpu5pOyVm2+tCtnfZn8Qh7fkOiEb4Tn8+vNoQTED
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/21 6:20 PM, Anand Jain wrote:
> btrfs_chunk_alloc() uses dev_alloc_list to allocate new chunks. The
> function's stack leading to btrfs_cmp_device_info() sorts the
> dev_alloc_list in the descending order of unallocated space. This
> sorting helps to maximize the filesystem space.
> 
> But, there might be other types of preferences when allocating the
> chunks. For example, allocation by device latency, with which the
> metadata could go to the device with the least latency.
> 
> This patch is a preparatory patch and makes the existing allocation
> layout a configurable parameter using sysfs, as shown below.
> 
> cd /sys/fs/btrfs/863c787e-fdbd-49ca-a0ea-22f36934ff1f
> cat chunk_layout_data
> [size]
> cat chunk_layout_metadata
> [size]
> 
> We could add more chunk allocation types by adding to the list in
> enum btrfs_chunk_layout{ }.


Hi Anand,

I like the idea. My patches set (allocation hint), provides a similar functionality.
However I used a "static" priority (each disks has an user-defined tag which give a priority for the allocation).

In any case the logic is always the same: until now btrfs_cmp_device_info() sorts the
devices on the basis of two criterion:
- the max_avail
- the total_vail

I added another criterion, that I called "alloc_hint" that decides the sorting.

I go even further, because Zygo asked me to add a flag which may exclude some disks.[*]

If we don't want to consider the idea to combine different criteria (like order by
speed AND latency AND space AND ... ) which increase the management complexity, the
main differences is that I used an "arbitrary user defined criterion", instead you may
suggest to use some specific performance index of the disks (like speed, latency...).

But in the end, because the latency or the speed are a "static" attribute (they should not change
during the life of the disks, or these change quite slowly) the results don't change.

So my concern is that my approach (which basically stores in the disk the priority) and your one (allow
to change the priority criterion) are quite overlapped but not completely and difficult
to combine.

BR
G.Baroncelli


[*] Zygo has an user case for this, however I fear the complexity that it adds from
a "free space report" point of view...

> 
> This is only a preparatory patch. The parameter is only an in-memory
> as of now. A persistent disk structure can be added on top of this
> when we have a consensus.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> This + sequential chunk layout hint (experimental) (patch not yet sent)
> helped me get consistent performance numbers for read_policy pid.
> As chunk layout hint is not set at mkfs, a balance after setting the
> desired chunk layout hint is needed.
> 
>   fs/btrfs/ctree.h   |  3 ++
>   fs/btrfs/disk-io.c |  3 ++
>   fs/btrfs/sysfs.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c |  4 +-
>   fs/btrfs/volumes.h | 10 +++++
>   5 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 3bc00aed13b2..c37bd2d7f5d4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -993,6 +993,9 @@ struct btrfs_fs_info {
>   	spinlock_t eb_leak_lock;
>   	struct list_head allocated_ebs;
>   #endif
> +
> +	int chunk_layout_data;
> +	int chunk_layout_metadata;
>   };
>   
>   static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c2576c5fe62e..c81f95339a35 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2890,6 +2890,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	fs_info->swapfile_pins = RB_ROOT;
>   
>   	fs_info->send_in_progress = 0;
> +
> +	fs_info->chunk_layout_data = BTRFS_CHUNK_LAYOUT_SIZE;
> +	fs_info->chunk_layout_metadata = BTRFS_CHUNK_LAYOUT_SIZE;
>   }
>   
>   static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 30e1cfcaa925..788784b1ed44 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -967,6 +967,102 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>   }
>   BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
>   
> +static const char * const btrfs_chunk_layout_name[] = { "size" };
> +
> +static ssize_t btrfs_chunk_layout_data_show(struct kobject *kobj,
> +					    struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	ssize_t ret = 0;
> +	int i;
> +
> +	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
> +		if (fs_info->chunk_layout_data == i)
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
> +					 (ret == 0 ? "" : " "),
> +					 btrfs_chunk_layout_name[i]);
> +		else
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> +					 (ret == 0 ? "" : " "),
> +					 btrfs_chunk_layout_name[i]);
> +	}
> +
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t btrfs_chunk_layout_data_store(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	int i;
> +
> +	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
> +		if (strmatch(buf, btrfs_chunk_layout_name[i])) {
> +			if (i != fs_info->chunk_layout_data) {
> +				fs_info->chunk_layout_data = i;
> +				btrfs_info(fs_info, "chunk_layout_data set to '%s'",
> +					   btrfs_chunk_layout_name[i]);
> +			}
> +			return len;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +BTRFS_ATTR_RW(, chunk_layout_data, btrfs_chunk_layout_data_show,
> +	      btrfs_chunk_layout_data_store);
> +
> +static ssize_t btrfs_chunk_layout_metadata_show(struct kobject *kobj,
> +						struct kobj_attribute *a,
> +						char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	ssize_t ret = 0;
> +	int i;
> +
> +	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
> +		if (fs_info->chunk_layout_metadata == i)
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
> +					 (ret == 0 ? "" : " "),
> +					 btrfs_chunk_layout_name[i]);
> +		else
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> +					 (ret == 0 ? "" : " "),
> +					 btrfs_chunk_layout_name[i]);
> +	}
> +
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t btrfs_chunk_layout_metadata_store(struct kobject *kobj,
> +						 struct kobj_attribute *a,
> +						 const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	int i;
> +
> +	for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
> +		if (strmatch(buf, btrfs_chunk_layout_name[i])) {
> +			if (i != fs_info->chunk_layout_metadata) {
> +				fs_info->chunk_layout_metadata = i;
> +				btrfs_info(fs_info,
> +					   "chunk_layout_metadata set to '%s'",
> +					   btrfs_chunk_layout_name[i]);
> +			}
> +			return len;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +BTRFS_ATTR_RW(, chunk_layout_metadata, btrfs_chunk_layout_metadata_show,
> +	      btrfs_chunk_layout_metadata_store);
> +
>   static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, label),
>   	BTRFS_ATTR_PTR(, nodesize),
> @@ -978,6 +1074,8 @@ static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, exclusive_operation),
>   	BTRFS_ATTR_PTR(, generation),
>   	BTRFS_ATTR_PTR(, read_policy),
> +	BTRFS_ATTR_PTR(, chunk_layout_data),
> +	BTRFS_ATTR_PTR(, chunk_layout_metadata),
>   	NULL,
>   };
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d1ba160ef73b..2223c4263d4a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5097,7 +5097,9 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   	ctl->ndevs = ndevs;
>   
>   	/*
> -	 * now sort the devices by hole size / available space
> +	 * Now sort the devices by hole size / available space.
> +	 * This sort helps to pick device(s) with larger space.
> +	 * That is BTRFS_CHUNK_LAYOUT_SIZE.
>   	 */
>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>   	     btrfs_cmp_device_info, NULL);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index d0a90dc7fc03..b514d09f4ba8 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -218,6 +218,16 @@ enum btrfs_chunk_allocation_policy {
>   	BTRFS_CHUNK_ALLOC_ZONED,
>   };
>   
> +/*
> + * If we have more than the required number of the devices for striping,
> + * chunk_layout let us know which device to use.
> + */
> +enum btrfs_chunk_layout {
> +	/* Use in the order of the size of the unallocated space on the device */
> +	BTRFS_CHUNK_LAYOUT_SIZE,
> +	BTRFS_NR_CHUNK_LAYOUT,
> +};
> +
>   /*
>    * Read policies for mirrored block group profiles, read picks the stripe based
>    * on these policies.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
