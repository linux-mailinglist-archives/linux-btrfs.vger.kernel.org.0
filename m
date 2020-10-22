Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF8295C1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509775AbgJVJkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 05:40:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509600AbgJVJkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 05:40:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9SjAJ103051;
        Thu, 22 Oct 2020 09:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Xdy+3ItlhStzn1CzBzxEWO/wJxwDwV+8Lpz9KfM000M=;
 b=eSj2VbJ7QAhmmSRJjqolYxvDy6VlyRTFXeT57uTXdWKDrLo2OUzgGs1DgekqugH1fRk/
 SceqfmMgfHxy+i21XkLsberiHXhXCnAJXIg0/OUrgCF2kGfIpYIZ28Hs1NXV4EdgNvSA
 K0sy8oXEkRP1YwtasKH0Ib8+mP+Jd6cjAMrgTm7YBUf54wj7l5O0U3Dr1s1AmOxu8sd1
 ISmmUkH3uSKfRWN6M4KQTT7fF1fFGKfySuF0WzPtJ6/LptEK2Ls8xbFAUZXI+O0Ch9cd
 xgiJFyexr639OcH7VXZYI13SpCKah07cQiWtMKm8Tg+Uulz1p6K06JxXnLtof9sgL8u3 ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrpw3y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 09:40:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9Thaw087103;
        Thu, 22 Oct 2020 09:40:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 348ah0mwwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 09:40:21 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09M9eKZT016170;
        Thu, 22 Oct 2020 09:40:20 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 02:40:20 -0700
Subject: Re: [PATCH RESEND v2 1/2] btrfs: drop never met condition of
 disk_total_bytes == 0
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1600940809.git.anand.jain@oracle.com>
 <2b54dd9a6634a833cff4e4ac8ff030a6b802652e.1601988260.git.anand.jain@oracle.com>
 <4c9e4f3a-493e-d8b1-ee26-ba78884a8743@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d15e5325-2d6f-89a7-9382-383595e26d6c@oracle.com>
Date:   Thu, 22 Oct 2020 17:40:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <4c9e4f3a-493e-d8b1-ee26-ba78884a8743@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220063
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/10/20 10:35 pm, Josef Bacik wrote:
> On 10/21/20 12:16 AM, Anand Jain wrote:
>> btrfs_device::disk_total_bytes is set even for a seed device (the
>> comment is wrong).
>>
>> The function fill_device_from_item() does the job of reading it from the
>> item and updating btrfs_device::disk_total_bytes. So both the missing
>> device and the seed devices do have their disk_total_bytes updated.
>>
>> Furthermore, while removing the device if there is a power loss, we could
>> have a device with its total_bytes = 0, that's still valid.
>>
>> So this patch removes the check dev->disk_total_bytes == 0 in the
>> function verify_one_dev_extent(), which it does nothing in it.
>>
>> And take this opportunity to introduce a check if the device::total_bytes
>> is more than the max device size in read_one_dev().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>> v2: add check if the total_bytes is more than the actual device size in
>>      read_one_dev().
>>      update change log.
>>
>>   fs/btrfs/volumes.c | 25 ++++++++++---------------
>>   1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 2a5397fb4175..0c6049f9ace3 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6847,6 +6847,16 @@ static int read_one_dev(struct extent_buffer 
>> *leaf,
>>       }
>>       fill_device_from_item(leaf, dev_item, device);
>> +    if (device->bdev) {
>> +        u64 max_total_bytes = i_size_read(device->bdev->bd_inode);
>> +
>> +        if (device->total_bytes > max_total_bytes) {
>> +            btrfs_err(fs_info,
>> +            "device total_bytes should be below %llu but found %llu",
> 
> "should be less than or equal to"
> 

Hm. Do you mean to say..

-               if (device->total_bytes > max_total_bytes) {
+               if (max_total_bytes <= device->total_bytes) {

OR

-               if (device->total_bytes > max_total_bytes) {
+               if (device->total_bytes <= max_total_bytes) {

The former is correct.
As device->total_bytes is the total_bytes as read from the dev_item.
And the max_total_bytes is the actual device size.



Thanks, Anand



> Thanks,
> 
> Josef
