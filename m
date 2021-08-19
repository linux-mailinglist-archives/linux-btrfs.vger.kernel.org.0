Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B53F1660
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhHSJiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 05:38:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhHSJiN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 05:38:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56A6B200B6;
        Thu, 19 Aug 2021 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629365856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRs5AlltXFbkaU1rIg9USlvcBZrzBFXOkcf4ZR/7Zyw=;
        b=eyITXbSoBq+yb5htz0Ex2RT0B/aJCeUibDRMoKHQcvWMqlVgsEVjIYrQWclhgQtypJDI5u
        u/UTmEPFP5hatCHfV8mVNh2+Z+vYpp1S+8u2tBH9cpMGA9qa5sqFsxgok6In4AGarXw5qo
        wz/7+zPJuNIAEgfPRrjxRwNOKP8Cl/A=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0B90B1340C;
        Thu, 19 Aug 2021 09:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pgx/O18mHmFlLgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 09:37:35 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20210728165632.11813-1-dsterba@suse.com>
 <503a227c-3a73-7332-88b2-cba199fb71e5@suse.com>
 <DM6PR04MB7081BC46E02027125ECB20BEE7C09@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <74c98d51-8e3d-97e9-e989-1a6d3115fe6f@suse.com>
Date:   Thu, 19 Aug 2021 12:37:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081BC46E02027125ECB20BEE7C09@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.08.21 Ç. 12:31, Damien Le Moal wrote:
> On 2021/08/19 18:21, Nikolay Borisov wrote:
>>
>>
>> On 28.07.21 Ç. 19:56, David Sterba wrote:
>>> We've hidden the zoned support in sysfs under debug config for the first
>>> releases but now the stability is reasonable, though not all features
>>> have been implemented.
>>>
>>> As this depends on a config option, the per-filesystem feature won't
>>> exist as such filesystem can't be mounted. The static feature will print
>>> 1 when the support is built-in, 0 otherwise.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>
>>> The merge target is not set, depends if everybody thinks it's the time
>>> even though there are still known bugs. We're also waiting for
>>> util-linux support (blkid, wipefs), so that needs to be synced too.
>>>
>>>  fs/btrfs/sysfs.c | 12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>> index bfe5e27617b0..7ad8f802ab88 100644
>>> --- a/fs/btrfs/sysfs.c
>>> +++ b/fs/btrfs/sysfs.c
>>> @@ -263,8 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>>>  BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>>>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>>>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>>> -/* Remove once support for zoned allocation is feature complete */
>>> -#ifdef CONFIG_BTRFS_DEBUG
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>>>  #endif
>>>  #ifdef CONFIG_FS_VERITY
>>> @@ -285,7 +284,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>>>  	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
>>>  	BTRFS_FEAT_ATTR_PTR(free_space_tree),
>>>  	BTRFS_FEAT_ATTR_PTR(raid1c34),
>>> -#ifdef CONFIG_BTRFS_DEBUG
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>  	BTRFS_FEAT_ATTR_PTR(zoned),
>>>  #endif
>>>  #ifdef CONFIG_FS_VERITY
>>> @@ -384,12 +383,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>>>  BTRFS_ATTR(static_feature, supported_sectorsizes,
>>>  	   supported_sectorsizes_show);
>>>  
>>> +static ssize_t zoned_show(struct kobject *kobj, struct kobj_attribute *a, char *buf)
>>> +{
>>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", IS_ENABLED(CONFIG_BLK_DEV_ZONED));
>>> +}
>>> +BTRFS_ATTR(static_feature, zoned, zoned_show);
>>> +
>>>  static struct attribute *btrfs_supported_static_feature_attrs[] = {
>>>  	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>>>  	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>>>  	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>>>  	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>>>  	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
>>> +	BTRFS_ATTR_PTR(static_feature, zoned),
>>>  	NULL
>>>  };
>>
>> Why isn't the above hunk predicated on CONFIG_BLK_DEV_ZONED the same as
>> the ATTR_INCOMPAT zoneed bit, but as explained in my earlier email one
>> of these should go and whichever remains must be predicated on
>> CONFIG_BLK_DEV_ZONED.
> 
> zoned-btrfs can be used with regular devices too. In that case, zones are
> emulated, all of them being conventional. So btrfs zoned feature should
> definitely not be dependent on CONFIG_BLK_DEV_ZONED.
> 
> If CONFIG_BLK_DEV_ZONED is not defined, then zoned btrfs will be usable only on
> regular devices. But since in that case zoned devices will not show up, it is
> all consistent.

Then we should discuss what the semantics of the ZONED flag under
features should be? I.e do we need to explicitly distinguish between
"btrfs supports zoned AND the kernel is compiled with BLK_DEV_ZONED so
we say we support it" and "btrfs has support for zoned devices but you
have to figure on your own if BLK_DEV_ZONED is enabled" ? I.e by having
sys/fs/btrfs/zoned set to 1 what information do we want to convey to the
user?
