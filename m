Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576D929F6B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 22:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgJ2VOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 17:14:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35492 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJ2VOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 17:14:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TL9KBn085052;
        Thu, 29 Oct 2020 21:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BLNKAgiue99VRgmY15R6fTVaVwBCgX5GPf0o93Jq9O8=;
 b=eKuRftDA4DCN/NKh0rssoN5l2j6yT4mspkyV4Jv8JNWwl1KYTle1EDC+C5PqyWIsjrHr
 ntVlB+z8KmbApEUQe3ckpt4VklUKivPoHoTp+d3BWeLsDv5JEblcy5ws/+xYN6TwGC6f
 TlCTWt8Sly2IFyskdbxlAs29gpGWiEoPXsAZEZKiDbT5svk+xv1SzPq6EeaOYObhWFPY
 /rUwbtbFKUbslx9lzs0vwTVIo9wbr6twsgFSrTmh/blKYvo8JegDGq14OVURc5At5O3c
 cRCMTZi1aj29ONPOAUx7ZwziEA5O+CAQRYsSfsdZnsSqEWlPVJ2UO8YmXPlIV7wY5quD 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34c9sb78ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 21:14:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLAQeX021812;
        Thu, 29 Oct 2020 21:14:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1tpj85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:14:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09TLEAdi030912;
        Thu, 29 Oct 2020 21:14:10 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:14:09 -0700
Subject: Re: [PATCH RESEND 0/2] fix verify_one_dev_extent and
 btrfs_find_device
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <cover.1600940809.git.anand.jain@oracle.com>
 <20201029210242.GX6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <468a5f49-187a-71ad-b922-eaf091107d65@oracle.com>
Date:   Fri, 30 Oct 2020 05:14:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029210242.GX6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290148
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/10/20 5:02 am, David Sterba wrote:
> On Wed, Oct 21, 2020 at 12:16:07PM +0800, Anand Jain wrote:
>> btrfs_find_device()'s last arg %seed is unused, which the commit
>> 343694eee8d8 (btrfs: switch seed device to list api) ignored purposely
>> or missed.
>>
>> But there isn't any regression due to that. And this series makes
>> it official that btrfs_find_device() doesn't need the last arg.
>>
>> To achieve that patch 1/2 critically reviews the need for the check
>> disk_total_bytes == 0 in the function verify_one_dev_extent() and finds
>> that, the condition is never met and so deletes the same. Which also
>> drops one of the parents of btrfs_find_device() with the last arg false.
>>
>> So only device_list_add() is using btrfs_find_device() with the last arg as
>> false, which the patch 2/2 finds is not required as well. So
>> this patch drops the last arg in btrfs_find_device() altogether.
>>
>> Anand Jain (2):
>>    btrfs: drop never met condition of disk_total_bytes == 0
>>    btrfs: fix btrfs_find_device unused arg seed
> 
> I missed this update because you replied to the original mail and this
> threads under the replies and is so easy to miss that it will inevitably
> lead to delayed reviews. This is not supposed to be hard, if you have
> another iteration, send it as a new mail thread where the 0/N mail has
> other patches as replies. 

ok. For now I am using this option, as..

> You can also use the workflow scripts to
> create or update the issue so we'll notice that. 

I found workflow script can't handle the update? Instead it creates a 
new issue?

> Right now there's stale
> https://github.com/btrfs/linux/issues/65 that is labeled with comments
> so nobody will probably lookd at it again until the next iteration
> arrives.

Should I resend the latest update?

Thanks Anand
