Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D56654FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 08:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAKHGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 02:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjAKHFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 02:05:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069D4BB8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 23:05:52 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1pCSm63uDV-003cnP; Wed, 11
 Jan 2023 08:05:48 +0100
Message-ID: <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
Date:   Wed, 11 Jan 2023 15:05:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: keep sysfs features in tandem with runtime
 features change
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:a7OCplEnjEo0Ggh781azchhE2c20Q/uvekoX2R+/XQxZp2UojI8
 rhFusd595ZPcGUALtaNZW5f2iQqwBmkpXLxfkF6YR+D5SnCf/ZBMnmW9sNP8JC9SOQ9cj7C
 2YkJQqs1R4GGJDqzbW3ylabH1TM0Y3mOLVICt6pGhT3b9q2chAsVyc44bSgaVQ5wEfL6MRX
 z3EGpQjMWphlhjkQZTG0w==
UI-OutboundReport: notjunk:1;M01:P0:Q+9xen9sj/g=;UHhiaSedEFKIdJuBtevpK7EjSd9
 t6np1uhRlMTFyXWo7bSca1nBf4vViC1e/sfWxcvxn6s84hcpiFsaaFRE+io3/9in5W0tJuyj+
 6fwXFKHOcn7OcXHGgfsynWdrEHMZidfOEu0rITjRO17Tj5d/eycfnN6Y6ISmqqreXxu1vnKcU
 hW3sufLImvc5FS5xe3oBvon8kjAZQK9VYeWaUyCenitzD1mUbmbCD24RYMBswWEeTXVga4N2G
 KEipBQ/rfG8d0XMLekAXpLoihL0qPM96WMTk1hfSZjfpXwSY3nBRCg/N0XIkg0Imnqo1Zpw3y
 a+FtOGZAXKYF89ZiIQsvijiL3w5w0kvX4jJW0anbsLvnlDgppzibuI+j7kTdp6CJl19rUN/vG
 Gaj5/5zIwroXJ1vAsv6ncaNeyJeRT46o5Iemtszhbe/sRm14gfK7A+upqgfd3215Sov/GLl/t
 DaFBc0+e1Lkup889tEDjzJl8gAY9CwTEqg8ENmwi8mj3r/HxGd7U8KZ2D1pg7/Li2GaduEHgm
 erSZ4BxtGMPWMhMoQBUuccH6rEhqJbPdt3lYI2ZRCnmJr5RYIyTTQH6xrPmwsgUt7b0G+FlGx
 5KStvacG+p0XU76geEXrgrGzIitXac/tVZwzDEDZm9Nig6rwx11fhYVAxT0lXqUTFjkNY/btJ
 cHTiWg3XtdMGRYcL8gB8avP20B3tGqpPW8yMRf2L3iENbxKScAjbzZoDvzNQENqcmNOXTR9n4
 mtO6g/NCWjAYlr1uGsBxHs+e9KP5G3ETOo+f1GXqb9EgTl/VDhhrMRy5WG+HGnOjV4OOBepL+
 KiG2NnUaT6UjZUTefGQTqXPuHOF4H8eSBp/5subRgWPOhu+v7nrOH8poRiU/I81c2o1ae5FF1
 OmpSmBL/aIwGiRvJN2SOYORhOk5NYW7cuhSrjOm4ncHI4GBaZ4ax7dVc/I0lPm1emtpHUBhzz
 puzdA+0NqYNC+tIIduqvxWlQVjw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 13:40, Anand Jain wrote:
> When we change runtime features, the sysfs under
> 	/sys/fs/btrfs/<uuid>/features
> render stale.
> 
> For example: (before)
> 
>   $ btrfs filesystem df /btrfs
>   Data, single: total=8.00MiB, used=0.00B
>   System, DUP: total=8.00MiB, used=16.00KiB
>   Metadata, DUP: total=51.19MiB, used=128.00KiB
>   global reserve, single: total=3.50MiB, used=0.00B
> 
>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>   extended_iref free_space_tree no_holes skinny_metadata
> 
> Use balance to convert from single/dup to RAID5 profile.
> 
>   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
> 
> Still, sysfs is unaware of raid5.
> 
>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>   extended_iref free_space_tree no_holes skinny_metadata
> 
> Which doesn't match superblock
> 
>   $ btrfs in dump-super /dev/loop0
> 
>   incompat_flags 0x3e1
>   ( MIXED_BACKREF |
>   BIG_METADATA |
>   EXTENDED_IREF |
>   RAID56 |
>   SKINNY_METADATA |
>   NO_HOLES )
> 
> Require mount-recycle as a workaround.
> 
> Fix this by laying out all attributes on the sysfs at mount time. However,
> return 0 or 1 when read, for used or unused, respectively.
> 
> For example: (after)
> 
>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>   block_group_tree compress_zstd extended_iref free_space_tree mixed_groups raid1c34 skinny_metadata zoned
> compress_lzo default_subvol extent_tree_v2 metadata_uuid no_holes raid56 verity
> 
>   $ cat /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
>   0
> 
>   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
> 
>   $ cat /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
>   1

Oh, I found this very confusing.

Previously features/ directory just shows what we have (either in kernel 
support or the specified fs), which is very straightforward.

Changing it to 0/1 is way less easy to understand, and can be considered 
as big behavior change.

Is it really no way to change the fs' features?

Thanks,
Qu
> 
> A fstests test case will follow.
> 
> The source code changes involve removing the visible function pointer for
> the btrfs_feature_attr_group, as it is an optional feature. And the
> store/show part for the same is already implemented.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c | 23 -----------------------
>   1 file changed, 23 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..fa3354f8213f 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -256,28 +256,6 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
>   	return count;
>   }
>   
> -static umode_t btrfs_feature_visible(struct kobject *kobj,
> -				     struct attribute *attr, int unused)
> -{
> -	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> -	umode_t mode = attr->mode;
> -
> -	if (fs_info) {
> -		struct btrfs_feature_attr *fa;
> -		u64 features;
> -
> -		fa = attr_to_btrfs_feature_attr(attr);
> -		features = get_features(fs_info, fa->feature_set);
> -
> -		if (can_modify_feature(fa))
> -			mode |= S_IWUSR;
> -		else if (!(features & fa->feature_bit))
> -			mode = 0;
> -	}
> -
> -	return mode;
> -}
> -
>   BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
>   BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
>   BTRFS_FEAT_ATTR_INCOMPAT(compress_lzo, COMPRESS_LZO);
> @@ -335,7 +313,6 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>   
>   static const struct attribute_group btrfs_feature_attr_group = {
>   	.name = "features",
> -	.is_visible = btrfs_feature_visible,
>   	.attrs = btrfs_supported_feature_attrs,
>   };
>   
