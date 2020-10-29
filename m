Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611A229E041
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 02:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgJ2BOF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 21:14:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44170 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgJ2BMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 21:12:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T19Ldh043272;
        Thu, 29 Oct 2020 01:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VSUpzfNIPNF9rXToH4/MHLd8LfGZSGWrVsxfBxrSnRs=;
 b=s6Gnhm9F+UzGnbRBVYe6/ZpbMYN0hwWAKrDawO2Di99OXXmVEHTO0AvybHZ+j7icn97Y
 gBiBBxMyqX+TIXGK/FwDs192HOppfI7C6aB6ylolT6/I+fs5ZRPG4GNyC2IBjCReOIhX
 1SfrnG98Yzw7OogrQnPSPK+IPx2jEaoPZzoFVFwTWHEPvGq19b+Vlv2Wkr2clKuPj2sT
 0/OUH2ouZrU4fF4Mhum6z+C59VlcoNdo70SybL0LFcY4u43JmL3zGgy9If+31p637CQJ
 e+B0Q/S26xG77baAo9n+sZmqUV2pXJF3N67jqmb9yBeOyiPmleu2APtf5KvQYjaB9pm1 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7m2bqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 01:12:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T1ANhV069637;
        Thu, 29 Oct 2020 01:12:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34cx1sn7g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 01:12:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09T1CYv2003780;
        Thu, 29 Oct 2020 01:12:34 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 18:12:33 -0700
Subject: Re: [PATCH 2/4] btrfs: introduce new device-state read_preferred
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <b2cfd7bfb0ff90063196cb38b4689fb8d2ac9986.1603884539.git.anand.jain@oracle.com>
 <72a5f7b5-1412-f82d-a22a-5fddcaa47748@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b7305a68-322a-0f25-fc3e-081c7b6db501@oracle.com>
Date:   Thu, 29 Oct 2020 09:12:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <72a5f7b5-1412-f82d-a22a-5fddcaa47748@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290003
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/10/20 10:37 pm, Josef Bacik wrote:
> On 10/28/20 9:26 AM, Anand Jain wrote:
>> This is a preparatory patch and introduces a new device flag
>> 'read_preferred', RW-able using sysfs interface.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  1 +
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 88cbf7b2edf0..52b4c9bef673 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1413,11 +1413,66 @@ static ssize_t 
>> btrfs_devinfo_writeable_show(struct kobject *kobj,
>>   }
>>   BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>> +static ssize_t btrfs_devinfo_read_pref_show(struct kobject *kobj,
>> +                        struct kobj_attribute *a, char *buf)
>> +{
>> +    int val;
>> +    struct btrfs_device *device = container_of(kobj, struct 
>> btrfs_device,
>> +                           devid_kobj);
>> +
>> +    val = !!test_bit(BTRFS_DEV_STATE_READ_PREFERRED, 
>> &device->dev_state);
>> +
>> +    return snprintf(buf, PAGE_SIZE, "%d\n", val);
>> +}
>> +
>> +static ssize_t btrfs_devinfo_read_pref_store(struct kobject *kobj,
>> +                         struct kobj_attribute *a,
>> +                         const char *buf, size_t len)
>> +{
>> +    int ret;
>> +    unsigned long val;
>> +    struct btrfs_device *device;
>> +
>> +    ret = kstrtoul(skip_spaces(buf), 0, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (val != 0 && val != 1)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * lock is not required, the btrfs_device struct can't be freed 
>> while
>> +     * its kobject btrfs_device::devid_kobj is still open.
>> +     */
>> +    device = container_of(kobj, struct btrfs_device, devid_kobj);
>> +
>> +    if (val &&
>> +        ! test_bit(BTRFS_DEV_STATE_READ_PREFERRED, 
>> &device->dev_state)) {
>> +
> 
> No extra space between the ! test_bit, and you don't need these extra 
> newlines.
> 
  Will fix.

> I sort of wonder what happens if we have multiple SSD's with multiple 
> slow disks, we may want to load balance between the SSD's and set the 
> two SSD's to preferred.  But typing it out made me think its not really 
> related to this change, so don't worry too much about it, just thoughts 
> for the future.  Thanks,
> 

  That's true. I had the same challenges when I wrote this. Then later
  it lead to have device groups, which is for next developments.

Thanks, Anand

> Josef
