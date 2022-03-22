Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EA4E46F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 20:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiCVTyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCVTyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 15:54:21 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA3CDF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:52:52 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-32.iol.local with ESMTPA
        id WkYjnr8CQptnyWkYjnfwJx; Tue, 22 Mar 2022 20:52:50 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1647978770; bh=CbaMLgUUMo4TB9CihVdGEESQU8zjqcTbky7kfOySGJs=;
        h=From;
        b=ElegbnkfCJEc5vbfCukebDThwiXS5CLN0hpEY6XjBTuq3/hI/BDNKi2YNoN9R50o5
         2PRXklvAc3XT91cEZK3d8jggVYP9n6wF+UQhXTR1GmVL80brQ6Q8HGywpy7DV6+1YT
         Nn1etTpATqb9qcsrorIpZuacKGCqE+OKbB/NbuNK1btFAEUii34UPqVim+2TOwiwip
         5A9DFojd1rp1XRIAAtFTfbJEjwIeDbVTglABp3lHpmMr0ZqSYBsVCj7eF7tnDG0LhU
         FIKq6I1DbxMNvK70k7K7mJZ/AWATR7LLz1POZrbJ3TtVBtkpZG5yUrdA4gV9wGlTvZ
         +psO6RhKwl9BQ==
X-CNFS-Analysis: v=2.4 cv=fIX8YbWe c=1 sm=1 tr=0 ts=623a2912 cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=ABtUt3GdItX5J_LE5MQA:9 a=QEXdDO2ut3YA:10
Message-ID: <64537d09-628f-f619-4010-63a843ad46c8@libero.it>
Date:   Tue, 22 Mar 2022 20:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 3/5] btrfs: change the device allocation_hint property via
 sysfs
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
 <7c56077a080b9ab77d1a722cb3bdde50e83895c4.1646589622.git.kreijack@inwind.it>
 <YjohO4/ShmN9CVXd@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YjohO4/ShmN9CVXd@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKN2B7vHLoldzMkBapL0XRLm+1j6t/ZlpBJ8T5a48C6iphjzLnYoxTLSiyeLjoLzTSiLn33YVjagBic5I2LleZqBZvBpR0xwk0lhYhn/4zgUd0qMNAnD
 iwSuy6ufCaHogANqgi6tsslgUv3E/jYEaUu8iz1TEIsZCX0DUXYWBCj+s5jgjYPEKVLUZyMGI3xaoDqaQEP+yWF5VZkS9OhGPTrImD/ei46a+3Z0Hwp2yUcG
 Kd2hvIzbWFphdDlHnws+JUjos//RXpxfpVomDw6dt91Ma24nOaXSzx53vkkZ4XGHdkEY7TOjs6yx2FdMMAV2vuSF8f7B9IthSbkSZMDVN1TGqtv0KbAPo2gf
 l/8RaRQLJ5hqAmjp3aC/I39Xq+mVMeS7jKZDk8Y6mS8n//O9yQeEkJFSVG/gFUu0QY2tqIk1
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 20.19, Josef Bacik wrote:
> On Sun, Mar 06, 2022 at 07:14:41PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> This patch allow to change the allocation_hint property writing
>> a numerical value in the file.
>>
>> /sysfs/fs/btrfs/<UUID>/devinfo/<devid>/allocation_hint
>>
>> To update this field it is added the property "allocation_hint" in
>> btrfs-prog too.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/sysfs.c   | 76 +++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/volumes.c |  2 +-
>>   fs/btrfs/volumes.h |  2 ++
>>   3 files changed, 78 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 59d92a385a96..c6723456c0e1 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1606,7 +1606,81 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
>>   	}
>>   	return scnprintf(buf, PAGE_SIZE, "<UNKNOWN>\n");
>>   }
>> -BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
>> +
>> +static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
>> +				 struct kobj_attribute *a,
>> +				 const char *buf, size_t len)
> 
> If you're using vim, use
> 
> set cindent
> set cino=(0
> 
> This will give you the proper formatting we expect, this should be something
> like
> 
> statice ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
> 						    struct kobj_attribute *a,
> 						    const char *buf, size_t len)
> 
> 
>> +{
>> +	struct btrfs_fs_info *fs_info;
>> +	struct btrfs_root *root;
>> +	struct btrfs_device *device;
>> +	int ret;
>> +	struct btrfs_trans_handle *trans;
>> +	int i, l;
>> +	u64 type, prev_type;
>> +
>> +	if (len < 1)
>> +		return -EINVAL;
>> +
>> +	/* remove trailing newline */
>> +	l = len;
>> +	if (buf[len-1] == '\n')
>> +		l--;
>> +
> 
> This is unnecessary, because lower you can do...
> 
>> +	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
>> +		if (l != strlen(allocation_hint_name[i].name))
>> +			continue;
>> +
>> +		if (strncasecmp(allocation_hint_name[i].name, buf, l))
>> +			continue;
>> +
> 
> strmatch(buf, allocation_hint_name[i].name)
> 
> I would make a separate patch to change strmatch to do strncasecmp instead, but
> then you can just use that helper.

Looking at the code of strmatch()

   /*
    * Look for an exact string @string in @buffer with possible leading or
    * trailing whitespace
    */
   static bool strmatch(const char *buffer, const char *string)
   {
           const size_t len = strlen(string);
   
           /* Skip leading whitespace */
           buffer = skip_spaces(buffer);
   
           /* Match entire string, check if the rest is whitespace or empty */
           if (strncmp(string, buffer, len) == 0 &&
               strlen(skip_spaces(buffer + len)) == 0)
                   return true;
   
           return false;
   }

Is buf always zero terminated ?


> 
>> +		type = allocation_hint_name[i].value;
>> +		break;
>> +	}
>> +
>> +	if (i >= ARRAY_SIZE(allocation_hint_name))
>> +		return -EINVAL;
>> +
>> +	device = container_of(kobj, struct btrfs_device, devid_kobj);
>> +	fs_info = device->fs_info;
>> +	if (!fs_info)
>> +		return -EPERM;
>> +
>> +	root = fs_info->chunk_root;
>> +	if (sb_rdonly(fs_info->sb))
>> +		return -EROFS;
>> +
>> +	/* check if a change is really needed */
>> +	if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) == type)
>> +		return len;
>> +
>> +	trans = btrfs_start_transaction(root, 1);
>> +	if (IS_ERR(trans))
>> +		return PTR_ERR(trans);
>> +
>> +	prev_type = device->type;
>> +	device->type = (device->type & ~BTRFS_DEV_ALLOCATION_HINT_MASK) | type;
>> +
>> +	ret = btrfs_update_device(trans, device);
>> +
>> +	if (ret < 0) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		btrfs_end_transaction(trans);
>> +		goto abort;
>> +	}
>> +
>> +	ret = btrfs_commit_transaction(trans);
>> +	if (ret < 0)
>> +		goto abort;
>> +
>> +	return len;
>> +abort:
>> +	device->type = prev_type;
>> +	return  ret;
> 
> Extra whitespace here.
Ok
> 
>> +}
>> +BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
>> +				      btrfs_devinfo_allocation_hint_store);
>> +
>>   
>>   /*
>>    * Information about one device.
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 5e3e13d4940b..d4ac90f5c949 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2846,7 +2846,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	return ret;
>>   }
>>   
>> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
>> +noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
>>   					struct btrfs_device *device)
>>   {
>>   	int ret;
> 
> You can drop the noinline thing here as well, and make sure to fix the
> indentation.
Ok
> 
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index bd297f23d19e..93ac27d8097c 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -636,5 +636,7 @@ int btrfs_bg_type_to_factor(u64 flags);
>>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>>   bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
>> +int btrfs_update_device(struct btrfs_trans_handle *trans,
>> +			struct btrfs_device *device);
> 
> Make the indentation correct.  Thanks,

It is correct. Are the '+' and the tab that misaligned the patch.

> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
