Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF0647FF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 10:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLIJOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIJOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 04:14:39 -0500
Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979FB1DA
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Dec 2022 01:14:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670577273; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JHBwxqM83/58j77MHUDdbIJEAo8wAxXhGRCIZ6WbeMiEPhFvMQhmloiOi7xtoKCkkR5v8KVYUoBm21MGcXSSAFxl2RAYVf75Nj1C8L6xm37H6k1oUcvKrQ0UV/fTIPW/lUPuSPDTzGL9s1gMuN5Y0+Am6+wFGPbGte7kTW4u8js=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670577273; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BZxGM33kFfnCyxft4yF9YicUAS5tz5Ne/QN/h5u4o20=; 
        b=gTaK5g+h8pPhr5QYy9auRo4xm6QCLjzqy/F5Q31ICV5ip+Amk1jG2VinLNzjlTIbp8BLnSDKdzP7rxV7KrXgLCkWo8h8/1rw1kER2rSo8bbR+hrVdYwkkJjRMW4K71EjYzIxZnC33l9kkYUzvm7xhwQFsjxzHJvj/w4870c8FJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670577273;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=BZxGM33kFfnCyxft4yF9YicUAS5tz5Ne/QN/h5u4o20=;
        b=bsMSAq9DKsFWj0OX5vW77MEnXejmFsEEzw138QWoY4uZXMMrwthryWJZotQIlVJk
        nYXr+7GIKaZfq8csfEBB4y/IM5VlXBzYldxmFJXDWfRTDCVI8fL1lse6IzK31TGntLI
        SmFIYlik4sEfcqG4z4/F9LokT7QoUx8dKdNByFR4=
Received: from [192.168.0.103] (58.247.201.213 [58.247.201.213]) by mx.zohomail.com
        with SMTPS id 1670577271599723.0380548076341; Fri, 9 Dec 2022 01:14:31 -0800 (PST)
Message-ID: <304711fc-2204-177c-b2f0-161bed5178a1@zoho.com>
Date:   Fri, 9 Dec 2022 04:14:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] btrfs-progs: chunk tree search solution for btrfs249
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, anand.jain@oracle.com
References: <20220815024341.4677-1-hmsjwzb@zoho.com>
 <f8043322-7a70-80ac-4a19-3945df839d9b@gmx.com>
Content-Language: en-US
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <f8043322-7a70-80ac-4a19-3945df839d9b@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for the notification.
I have updated the commit message.

Thanks,
Flint

On 12/9/22 01:24, Qu Wenruo wrote:
> 
> 
> On 2022/8/15 10:43, Flint.Wang wrote:
>> Hi Qu,
>>
>> Thanks for your comment. I fix the issue you suggest.
>> It is much clean now.
>>
>> Btrfs249 failed due to btrfs_ioctl_fs_info() return RW devices for fi_args->num_devices.
>> This patch search chunk tree to find rw devices.
>>
>> v2 change:
>> 1. code style fix.
>> 2. noseed_dev => rw_devs, noseed_fsid => fsid.
>> 3. remove redundant structure devid_uuid.
>> 4. reuse the dev_info structure.
>> 5. remove redundant uuid argument.
>>
>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
> 
> Any update on this patch? IIRC btrfs/249 still fails without this patch.
> 
> Although Anand Jain has a similar patchset, but his solution requires a new kernel sysfs, which can still cause compatibility problems.
> 
> Thus your patch is still the better one, but your commit message still needs some update.
> 
> Thanks,
> Qu
>> ---
>>   cmds/filesystem-usage.c | 83 ++++++++++++++++++++++++++++++++---------
>>   1 file changed, 66 insertions(+), 17 deletions(-)
>>
>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>> index 01729e18..71f0e14c 100644
>> --- a/cmds/filesystem-usage.c
>> +++ b/cmds/filesystem-usage.c
>> @@ -25,6 +25,7 @@
>>   #include <getopt.h>
>>   #include <fcntl.h>
>>   #include <linux/limits.h>
>> +#include <uuid/uuid.h>
>>     #include "common/utils.h"
>>   #include "kerncompat.h"
>> @@ -689,6 +690,62 @@ out:
>>       return ret;
>>   }
>>   +static int load_devid(int fd, struct device_info *info,
>> +                int ndev, u8 *fsid)
>> +{
>> +    struct btrfs_ioctl_search_args_v2 *args2;
>> +    struct btrfs_ioctl_search_key *sk;
>> +    struct btrfs_ioctl_search_header *sh;
>> +    struct btrfs_dev_item *dev_item;
>> +    int args2_size = 1024;
>> +    char args2_buf[args2_size];
>> +    int ret = 0;
>> +    int i = 0;
>> +    int num = 0;
>> +    int rw_devs = 0;
>> +    int idx = 0;
>> +
>> +    args2 = (struct btrfs_ioctl_search_args_v2 *) args2_buf;
>> +    sk = &(args2->key);
>> +
>> +    sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
>> +    sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>> +    sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
>> +    sk->min_type = BTRFS_DEV_ITEM_KEY;
>> +    sk->max_type = BTRFS_DEV_ITEM_KEY;
>> +    sk->min_offset = 0;
>> +    sk->max_offset = (u64)-1;
>> +    sk->min_transid = 0;
>> +    sk->max_transid = (u64)-1;
>> +    sk->nr_items = -1;
>> +    args2->buf_size = args2_size - sizeof(struct btrfs_ioctl_search_args_v2);
>> +    ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH_V2, args2);
>> +    if (ret != 0)
>> +           return -1;
>> +
>> +    sh = (struct btrfs_ioctl_search_header *) args2->buf;
>> +    num = sk->nr_items;
>> +
>> +    dev_item = (struct btrfs_dev_item *) (sh + 1);
>> +    for (i = 0; i < num; i++) {
>> +        if (!uuid_compare(dev_item->fsid, fsid)) {
>> +            rw_devs += 1;
>> +            info[idx++].devid = dev_item->devid;
>> +        }
>> +        if (idx > ndev) {
>> +            error("unexpected number of devices: %d >= %d", idx, ndev);
>> +            return -1;
>> +        }
>> +        sh = (struct btrfs_ioctl_search_header *) dev_item + 1;
>> +        dev_item = (struct btrfs_dev_item *) sh + 1;
>> +    }
>> +
>> +    if (ndev != rw_devs)
>> +        error("unexpected number of devices: %d != %d", ndev, rw_devs);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    *  This function loads the device_info structure and put them in an array
>>    */
>> @@ -718,19 +775,17 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
>>           return 1;
>>       }
>>   -    for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
>> -        if (ndevs >= fi_args.num_devices) {
>> -            error("unexpected number of devices: %d >= %llu", ndevs,
>> -                (unsigned long long)fi_args.num_devices);
>> -            error(
>> -        "if seed device is used, try running this command as root");
>> -            goto out;
>> -        }
>> +    ret = load_devid(fd, info, fi_args.num_devices, fi_args.fsid);
>> +    if (ret == -1)
>> +        goto out;
>> +
>> +    for (i = 0, ndevs = 0 ; i < fi_args.num_devices ; i++) {
>>           memset(&dev_info, 0, sizeof(dev_info));
>> -        ret = get_device_info(fd, i, &dev_info);
>> +        ret = get_device_info(fd, info[i].devid, &dev_info);
>>   -        if (ret == -ENODEV)
>> -            continue;
>> +        if (ret == -ENODEV) {
>> +            error("device not found\n");
>> +        }
>>           if (ret) {
>>               error("cannot get info about device devid=%d", i);
>>               goto out;
>> @@ -759,12 +814,6 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
>>           ++ndevs;
>>       }
>>   -    if (ndevs != fi_args.num_devices) {
>> -        error("unexpected number of devices: %d != %llu", ndevs,
>> -                (unsigned long long)fi_args.num_devices);
>> -        goto out;
>> -    }
>> -
>>       qsort(info, fi_args.num_devices,
>>           sizeof(struct device_info), cmp_device_info);
>>   
