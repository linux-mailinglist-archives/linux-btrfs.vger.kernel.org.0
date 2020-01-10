Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC65137A50
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 00:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgAJXmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 18:42:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgAJXmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 18:42:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00ANZxHC116523;
        Fri, 10 Jan 2020 23:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=SVNlU50412EUBWlM2QeNRfZxZPsQWynRTwXWEX0Q0Jg=;
 b=SC2DMYN8Pyn0hfip2ogo8eVi+BgtYvM7BZUyCujaRD5hQj5Cyr8Jcozj6yyDCDIEqKHu
 mE1QeSaLcSc7b1U3AJqtKNBeQ7x7629+Pm4aL+/VbKzcpD7MwP997yOKZJLGok5qJUGu
 SEAh5YrIky0wF2D175QTzVV6PYofWaYc9mF3jJwUsW66UdGCOMGwwb/7cpkaHCojZzJN
 iLOLpvUSNXPKiksNVgViUZ+amrbIIS7Cl77qAKDtFxPB/J7zzs0Zc3Q1ytcpzARKvpwB
 7gUS6YNcT4mcdj7PrOuAFQM9g1wiDkfLUNGArL08kiIR5fU+98NkFKPrbPMUmw4bZ8v4 aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbrd3tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 23:42:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00ANXcPN108003;
        Fri, 10 Jan 2020 23:42:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xevfe07nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 23:42:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00ANg06W010386;
        Fri, 10 Jan 2020 23:42:00 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jan 2020 15:42:00 -0800
Subject: Re: [PATCH 1/2] btrfs: open code log helpers in device_list_add()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200110090555.7049-1-anand.jain@oracle.com>
 <20200110164212.GQ3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ec1a6bed-ecea-c7f6-2567-9626590bc9c7@oracle.com>
Date:   Sat, 11 Jan 2020 07:41:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200110164212.GQ3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100193
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100193
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/1/20 12:42 AM, David Sterba wrote:
> On Fri, Jan 10, 2020 at 05:05:54PM +0800, Anand Jain wrote:
>> fs_info is born during mount, and operations before the mount such as
>> scanning and assembling of the device volume should happen without any
>> reference to fs_info.
>>
>> However the patch commit a9261d4125c9 (btrfs: harden agaist duplicate
>> fsid on scanned devices) used fs_info to call btrfs_warn_in_rcu() and
>> btrfs_info_in_rcu(), so if fs_info is NULL, the stacked functions leads
>> to btrfs_printk() which shall print "unknown" instead of sb->s_id. Or
>> even might UAF as reported in [1].
>>
>> So do the right thing, don't use btrfs_warn_in_rcu() and
>> btrfs_info_in_rcu() in device_list_add() instead just open code it.
>>
>> Link:
>> [1] https://www.spinics.net/lists/linux-btrfs/msg96524.html
>> Fixes: a9261d4125c9 (btrfs: harden agaist duplicate fsid on scanned devices)
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 6fd90270e2c7..1a419841fc99 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -889,17 +889,21 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   			if (device->bdev != path_bdev) {
>>   				bdput(path_bdev);
>>   				mutex_unlock(&fs_devices->device_list_mutex);
>> -				btrfs_warn_in_rcu(device->fs_info,
>> -			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
>> +				rcu_read_lock();
>> +				printk_ratelimited(
> 
> Avoiding fs_info here is correct but we don't want to use raw printk or
> printk_ratelimited anywhere.
> 

  I think I discussed this a long time back, that we should rather pass
  fs_devices in btrfs_warn_in_rcu().

  I am ok to make such a change, are you ok? Or I wonder if there is
  any other way?

Thanks, Anand
