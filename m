Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94B284C07
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgJFMxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 08:53:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51240 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgJFMxn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 08:53:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096CoDKM188824;
        Tue, 6 Oct 2020 12:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qUVsIp4C7j8qqVug2cEn0x45CMbiJX4wWSIRvLjhnAk=;
 b=SLDLrCFGaznYHxuU1Ewr1FRjG6/OdPkaS0NgY4As9zRKapUvTZTat3a7HfNWoqHLWxFG
 FmncLeVNHlIDwvz17aWIj9/rl0idzJx7X4vkKrpzwJGJH01BZApeLgyXhLcJsbocm3Go
 tDblJs7ldUgl8VQ/YChOJiJusbdJvOxJzhPwExcSAV+BqAxuheQl9iLkSoxSwglTy71S
 s5iJJe/Rh6Ld4iiYWnJpmCPpeey3dcQtnnJY7feYFO7GeTIzi5rToP5Vtfi3+qe8qe/P
 GkJRRUfknV1MRnIpYWAHaDpvGxnU022pH1vBLKdCosop0Y01NzqUpFSDGRPfSG7sy6m4 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33xetav01g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 12:53:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096CpG3O156726;
        Tue, 6 Oct 2020 12:53:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33y2vmx628-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 12:53:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 096CrZh7022724;
        Tue, 6 Oct 2020 12:53:35 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 05:53:35 -0700
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <2a768517-2ab4-8671-5d70-e80ed01e406d@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6db564ab-33e9-17cd-3ccd-9f3c2c6cf23c@oracle.com>
Date:   Tue, 6 Oct 2020 20:53:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2a768517-2ab4-8671-5d70-e80ed01e406d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060082
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/10/20 9:22 pm, Josef Bacik wrote:
> On 9/24/20 6:11 AM, Anand Jain wrote:
>> btrfs_device::disk_total_bytes is set even for a seed device (the
>> comment is wrong).
>>
>> The function fill_device_from_item() does the job of reading it from the
>> item and updating btrfs_device::disk_total_bytes. So both the missing
>> device and the seed devices do have their disk_total_bytes updated.
>>
>> So this patch removes the check dev->disk_total_bytes == 0 in the
>> function verify_one_dev_extent()
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Ok I understand that logically this check is incorrect, however we pull 
> this value from the device item, which could be corrupt.  I'm looking 
> around and I don't see a similar check in any of our other code, it 
> should probably go in check_dev_item() maybe?  I think that removing 
> this check is ok, but we need to make sure we catch the invalid case 
> where total_disk_bytes == 0 somewhere, so please add that in the 
> appropriate place.  Thanks,

We could check the upper limit based on the device size. But we can't
check for zero, because while removing the device if there is a power
loss, we could have a device with its total_bytes = 0, that's still
valid. I shall make this check in v2 in read_one_dev() as we need a
valid device->bdev.

But I have a question though- we have csum for everything to determine
offline corruption at the time of reading, so corruptions are taken care
of. An authenticated mount is a holistic fix for the crafted image
problems, and systems that aren't secured appropriately may be exposed
to crafted image problems. So do we have to handle each one of those
corruption/crafted-image cases independently, then?

Thanks, Anand

> 
> Josef
