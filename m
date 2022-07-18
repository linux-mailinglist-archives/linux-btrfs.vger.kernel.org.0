Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D91578CAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiGRVZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiGRVZg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 17:25:36 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5629818
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 14:25:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 8385B803E2;
        Mon, 18 Jul 2022 17:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658179535; bh=OeIp1zwaW7yZEhW9i1XBxP37a2SXTMLXV/czQM2mp3c=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=ODuWc+HWehrDD0JubVsvf6B5wkFDPH4cn+V0wTRlNg2UOFw/9FHMZzxyebBxwf60u
         mQoss/tpRYdxN8vaGliKOAX8FEpGUEs+FnUlPCF2gr5Fj4BYIc2Iekl+o8MPS8DnnG
         cSvZPk33MCwelZlhkEW0KqUD854Ko04b1+UG8511QHDzcsVEi9hPj1DkxpoYDXtZjz
         mvOPC8doCqsRx4e+iGbeKI6lVOyZ3PDVwqYxBCCIuPBpVHNjRuBhn86Jp8Hix+gklg
         ngjJUa5laaUVvB4HwI6UA/jsCnK3nyxTZAeI9VR9Uqt9Z7ttggoBaOli4YQH6gOfEf
         zyc0LQZR3o4nQ==
Message-ID: <98681a8f-c9c1-4480-a232-7c5e4589e0b3@dorminy.me>
Date:   Mon, 18 Jul 2022 17:25:31 -0400
MIME-Version: 1.0
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH RFC] btrfs: customizable log message id
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220607224337.11898-1-dsterba@suse.com>
Content-Language: en-US
In-Reply-To: <20220607224337.11898-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/7/22 18:43, David Sterba wrote:
> The btrfs messages are made of several parts, like prefix, the device
> for identification, and the message:
> 
>    BTRFS info (device loop0): using free space tree
> 
> Based on user feedback, something else than the device would be desired,
> like the uuid or label. As the messages are sort of a public interface,
> eg. for log scrapers or monitoring tools, changing current 'device' to
> a new default would potentially break that, and users have different
> preferences as the discussion showed.
> 
> Thus it's configurable. As implemented now it's per filesystem and can
> be set after mount. There's no global setting but can be implemented.
> 
> Configuration is done by sysfs by writing following strings to the file
> /sys/fs/btrfs/UUID/msgid:
> 
> - device (current default)
> - uuid - will print the filesystem uuid/fsid
> 
>    BTRFS info (uuid 7989fadb-469d-4969-ba6b-d1ead726a920): using free space tree
> 
> - uuid-short - print only first part of the uuid
> 
>    BTRFS info (uuid 7989fadb-469d): using free space tree
> 
> - label - print label
> 
>    BTRFS info (label TEST): using free space tree
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> This is RFC, questions to discuss:
> 
> - rename 'msgid' to something else
> - configurable at module load time as a parameter as the default
> - configurable after load gobally in sysfs (/sys/fs/btrfs/msgid)
> - both global and per-filesystem sysfs knob
> - change the default eventually but to what
> - other identification, suggestions were eg. devid, uuid+devid


I've certainly had the problem occasionally that I can't remember which 
device is associated with which FS, and it takes some effort to figure 
out what log message is associated with which filesystem. So thank you, 
I really like this idea and have been trying to mull it for a while to 
figure out what else would be nice. I haven't gotten anywhere much, so 
here are some random thoughts I've had:

Seems like there are a couple of different classes of message (with the 
disclaimer that I'm pretty new to btrfs and may not be using terminology 
correctly).

There are messages that are device-specific, and it's useful to know 
what device in particular caused the message. If, theoretically, a read 
from one device turned out to have a bad checksum, knowing that device 
ID in some form is important.

There are messages that effect the whole filesystem, and every subvolume 
on it. E.g. pushing out delayed items is filesystem-wide and unrelated 
to devices, as far as I know.

(I'm sure there are other classes too that I'm not thinking about)

As far as I know, a particular device only ever belongs to one 
filesystem, and a particular mountpoint/subvol only ever belongs to one 
filesystem. Thus, a user could enumerate (devices, global uuid, 
mountpoints, subvolume IDs) and go from any of those pieces of data to 
any other. It's just a matter of convenience and ability to do 
historical analysis (on log messages whose full filesystem knowledge is 
no longer known). And it would be nice to know mountpoints too -- as a 
filesystem user I usually think in terms of mount points, rather than 
uuids or labels or underlying devices -- but that gets complicated; I 
tried prototyping that when you first sent this and I didn't succeed, 
but maybe I missed something that would make it easier.

So in an ideal world I guess I'd propose:

a) log messages should be tagged with FS UUID, and either a subvol ID or 
a device ID or nothing, depending on how specific the message is. 
(Obviously a bunch of tedious work to go check and tweak all the print 
message origins, not to mention the impact on logscraping scripts)
b) the filesystem should log fs UUID/label, mounted subvol UUID/labels, 
and component devices (to easily associate all the information) anytime 
a new log message is going to be emitted and it's been at least X 
minutes since the last message of that form (X = 30, perhaps, in 
concrete terms? Or maybe 1 day, on the assumption everyone should have a 
day of logs saved?).

But that would probably be too large a change from the present format.

So to specifically address your question, subvolume UUID would be a nice 
additional option since the list of mounts might not list the filesystem 
UUID; and an option to print mount point(s) would match my instincts but 
I'm not sure it's doable. But I'm not sure.

Thanks for working on this, though: I definitely like the additional 
choices for logmessages and am excited for them.


> 
>   fs/btrfs/ctree.h   | 10 ++++++++++
>   fs/btrfs/disk-io.c |  3 +++
>   fs/btrfs/super.c   | 31 +++++++++++++++++++++++++++++--
>   fs/btrfs/sysfs.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f7afdfd0bae7..e448394451f1 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -646,6 +646,14 @@ enum {
>   #endif
>   };
>   
> +enum btrfs_msgid_type {
> +	BTRFS_MSGID_DEVICE,
> +	BTRFS_MSGID_UUID,
> +	BTRFS_MSGID_UUID_SHORT,
> +	BTRFS_MSGID_LABEL,
> +	BTRFS_MSGID_COUNT
> +};
> +
>   /*
>    * Exclusive operations (device replace, resize, device add/remove, balance)
>    */
> @@ -744,6 +752,8 @@ struct btrfs_fs_info {
>   	 */
>   	u64 max_inline;
>   
> +	enum btrfs_msgid_type msgid_type;
> +
>   	struct btrfs_transaction *running_transaction;
>   	wait_queue_head_t transaction_throttle;
>   	wait_queue_head_t transaction_wait;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..d1c6d372d5f7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3138,6 +3138,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   
>   	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
>   	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
> +
> +	/* Set default here */
> +	fs_info->msgid_type = BTRFS_MSGID_UUID;
>   }
>   
>   static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 719dda57dc7a..8227bcce9817 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -291,10 +291,37 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
>   	if (__ratelimit(ratelimit)) {
>   		if (fs_info) {
>   			char statestr[STATE_STRING_BUF_LEN];
> +			char *idtype;
> +			char id[64] = { 0 };
> +			bool short_fsid = false;
> +
> +			switch (READ_ONCE(fs_info->msgid_type)) {
> +			default:
> +			case BTRFS_MSGID_DEVICE:
> +				idtype = "device";
> +				scnprintf(id, sizeof(id), "%s", fs_info->sb->s_id);
> +				break;
> +			case BTRFS_MSGID_UUID_SHORT:
> +				short_fsid = true;
> +				fallthrough;
> +			case BTRFS_MSGID_UUID:
> +				idtype = "fsid";
> +				scnprintf(id, sizeof(id), "%pU",
> +					  fs_info->fs_devices->fsid);
> +				if (short_fsid)
> +					id[13] = 0;
> +				break;
> +			case BTRFS_MSGID_LABEL:
> +				idtype = "label";
> +				/* Fixme: first 64 from label */
> +				scnprintf(id, sizeof(id), "%s",
> +					  fs_info->super_copy->label);
> +				break;
> +			}
>   
>   			btrfs_state_to_string(fs_info, statestr);
> -			_printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
> -				fs_info->sb->s_id, statestr, &vaf);
> +			_printk("%sBTRFS %s (%s %s%s): %pV\n", lvl, type,
> +				idtype, id, statestr, &vaf);
>   		} else {
>   			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
>   		}
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 3554c7b4204f..94dd28112414 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -962,6 +962,8 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
>   	memcpy(fs_info->super_copy->label, buf, p_len);
>   	spin_unlock(&fs_info->super_lock);
>   
> +	/* Fixme: if label is empty, reset msgid_type to default */
> +
>   	/*
>   	 * We don't want to do full transaction commit from inside sysfs
>   	 */
> @@ -1214,6 +1216,43 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
>   BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
>   	      btrfs_bg_reclaim_threshold_store);
>   
> +static const char *msgid_strings[] = {
> +	[BTRFS_MSGID_DEVICE]	= "device",
> +	[BTRFS_MSGID_UUID]	= "uuid",
> +	[BTRFS_MSGID_UUID_SHORT] = "uuid-short",
> +	[BTRFS_MSGID_LABEL]	= "label",
> +};
> +
> +static ssize_t btrfs_msgid_show(struct kobject *kobj,
> +				struct kobj_attribute *a,
> +				char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +	return sysfs_emit(buf, "%s\n", msgid_strings[fs_info->msgid_type]);
> +}
> +
> +static ssize_t btrfs_msgid_store(struct kobject *kobj,
> +				 struct kobj_attribute *a,
> +				 const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	int i;
> +
> +	for (i = 0; i < BTRFS_MSGID_COUNT; i++) {
> +		/* Fixme: if label is empty do a fallback */
> +		if (strmatch(buf, msgid_strings[i])) {
> +			WRITE_ONCE(fs_info->msgid_type, i);
> +			break;
> +		}
> +	}
> +	if (i == BTRFS_MSGID_COUNT)
> +		return -EINVAL;
> +
> +	return len;
> +}
> +BTRFS_ATTR_RW(, msgid, btrfs_msgid_show, btrfs_msgid_store);
> +
>   /*
>    * Per-filesystem information and stats.
>    *
> @@ -1231,6 +1270,7 @@ static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, generation),
>   	BTRFS_ATTR_PTR(, read_policy),
>   	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
> +	BTRFS_ATTR_PTR(, msgid),
>   	NULL,
>   };
>   
