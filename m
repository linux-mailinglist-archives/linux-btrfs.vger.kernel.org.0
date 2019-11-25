Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A31086CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 04:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKYDUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Nov 2019 22:20:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKYDUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Nov 2019 22:20:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP394bD053717;
        Mon, 25 Nov 2019 03:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hvIFPSnRwwxDei1y3+9fayFKOn5jNg2SWBLxHsxcRw4=;
 b=KQ18L6d9eRTkFPZf5hQERT3uAxc/r8LK6qr3SX7sho53evWY+fLBTm8zY1kEXZi9GuXf
 3UrF5kT6FDsKDHbUrlZZR3mSXZpY6Rges9uA0tEboeRAWiKjYR/dF98vnu9UsSkLycC4
 vjogywoyMLFcpUhwRl+UgECeyjR53sVPp5UTHekRY+m8ZF6/+uxC9TS5/18p6DuWuY1A
 n6rBwRv1ekn6KEqloutt96fHcH81Cz97ji6J97710IV5WbCbYTkqQhpdIByUnj1UkL9n
 TLMEnvGATc398wI5R28JJZTNLLnXW8KRT+28x1K7KRH9ifcNhk52k2iGQRswjsXM+dR9 yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wevqpvre3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 03:18:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAP38C7b189887;
        Mon, 25 Nov 2019 03:18:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wfe9cn9gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 03:18:44 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAP3IgMa020993;
        Mon, 25 Nov 2019 03:18:43 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Nov 2019 19:18:42 -0800
Subject: Re: [PATCH 05/15] btrfs: sysfs, move /sys/fs/btrfs/UUID related
 functions together
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
 <20191118084656.3089-6-anand.jain@oracle.com>
 <8972a47c-2fcc-f980-8e76-a7dc945ee939@suse.com>
 <20191119105856.GQ3001@twin.jikos.cz>
 <12c01ace-20c9-7cbd-d9c3-2b01d95c1f42@oracle.com>
 <20191122174837.GD3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <98f169e7-fb48-f376-bb1e-f584abc4a069@oracle.com>
Date:   Mon, 25 Nov 2019 11:18:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122174837.GD3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250028
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/23/19 1:48 AM, David Sterba wrote:
> On Wed, Nov 20, 2019 at 01:56:04PM +0800, Anand Jain wrote:
>> On 11/19/19 6:58 PM, David Sterba wrote:
>>> On Tue, Nov 19, 2019 at 11:24:37AM +0200, Nikolay Borisov wrote:
>>>> On 18.11.19 г. 10:46 ч., Anand Jain wrote:
>>>>> No functional changes. Move functions to bring btrfs_sysfs_remove_fsid()
>>>>> and btrfs_sysfs_add_fsid() and its related functions together.
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> This seems like pointless code motion.
>>>
>>> Yeah, unless there's some other reason to move the code, just plain
>>> moves are not desired.
>>
>>    The reason was - btrfs_sysfs_add_fsid() and btrfs_sysfs_remove_fsid()
>>    are related. Easy to read and verify to have placed them one below
>>    other.
> 
> I see that add and remove functions are grouped, so this would move
> someting else away:
> 
> btrfs_sysfs_remove_fsid + __btrfs_sysfs_remove_fsid
> 
> btrfs_sysfs_add_fsid + btrfs_sysfs_add_mounted

Ok.

> and device related functions are also grouped by the action type, so we
> can keep it like that.

Ok. Grouped by action type.

Thanks, Anand
