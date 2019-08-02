Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9D7EAF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 06:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfHBEHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 00:07:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfHBEHu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 00:07:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7243vkY180128;
        Fri, 2 Aug 2019 04:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/OSZ7pAdOCHG5jQnLEQxb7ziDYjUQLZ0/eSPVC6n4EA=;
 b=3fsRlQl4YJ8G0R6vzpmlTlXGFCwlcDgaHFzE/kCTkWKbpqui3DKblEoRD1Lrw6Y0kD3q
 lBjXJf35u2Qe3znFYxp8S7Ug81lGMf5P+bAR9Y8A9h+S9yeXbO23/XGMIoiRqn30ecdL
 oAOvS0A49teDHDnUgvEaaCa0P/rxh1egAW3s4y2lKSsUd4MnXWT8EPxY8mYot6rLiCvB
 ytLdCcRRLP+8jEJfI7Dwf62gIM0NegvTB4ny1e5t/sgZQ3V9RrOoh7BvU6O9l0Lpj21E
 qyYe8OI0GxKneiHHDISMXX3oP/OP57ysIqf6I9a0f2Qbgw6EdLgrDqlwxTZZMjUqvAXe dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u0e1u7nv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 04:07:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7247gSP182072;
        Fri, 2 Aug 2019 04:07:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u3mbv208d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 04:07:44 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7247gZR020869;
        Fri, 2 Aug 2019 04:07:43 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Aug 2019 21:07:42 -0700
Subject: Re: [RFC] BTRFS_DEV_REPLACE_ITEM_STATE_* doesn't match with on disk
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>, dsterba@suse.cz
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <e932064c-6182-a87c-3475-bf1765b165bc@oracle.com>
 <e19a1d1c-3d93-7b5c-01b1-83c0c53323c8@suse.com>
 <dd4eb64b-0841-1f81-04e1-309212bbbedd@oracle.com>
 <fad69f0c-a56e-0cbc-2ae0-85957b8f339e@oracle.com>
Message-ID: <90694419-f71a-cdec-14c6-bee0abc7c6c2@oracle.com>
Date:   Fri, 2 Aug 2019 12:07:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <fad69f0c-a56e-0cbc-2ae0-85957b8f339e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020041
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping.


On 11/21/18 3:31 PM, Anand Jain wrote:
> 
> David, any comments on this please.
> 
> Thanks, Anand
> 
> 
> On 11/13/2018 06:32 PM, Anand Jain wrote:
>>
>> David, Gentle ping.
>>
>> Thanks, Anand
>>
>> On 11/12/2018 03:50 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.11.18 г. 6:58 ч., Anand Jain wrote:
>>>>
>>>> The dev_replace_state defines are miss matched between the
>>>> BTRFS_IOCTL_DEV_REPLACE_STATE_* and BTRFS_DEV_REPLACE_ITEM_STATE_* [1].
>>>>
>>>> [1]
>>>> -----------------------------
>>>> btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED        2
>>>> btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED        3
>>>> btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED        4
>>>>
>>>> btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED    2
>>>> btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED    3
>>>> btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED    4
>>>> -----------------------------
>>>>
>>>> The BTRFS_DEV_REPLACE_ITEM_STATE_* series is unused in both btrfs.ko 
>>>> and
>>>> btrfs-progs, the on-disk also follows BTRFS_IOCTL_DEV_REPLACE_STATE_*
>>>> (we set dev_replace->replace_state using the
>>>> BTRFS_IOCTL_DEV_REPLACE_STATE_* defines and write to the on-disk).
>>>>
>>>>   359         btrfs_set_dev_replace_replace_state(eb, ptr,
>>>>   360                 dev_replace->replace_state);
>>>>
>>>> IMO it should be ok to delete the BTRFS_DEV_REPLACE_ITEM_STATE_*
>>>> altogether? But how about the userland progs other than btrfs-progs?
>>>> If not at least fix the miss match as in [2], any comments?
>>>
>>> Unfortunately you are right. This seems to stem from sloppy job back in
>>> the days of initial dev-replace support. BTRFS_DEV_REPLACE_ITEM_STATE_*
>>> were added in e922e087a35c ("Btrfs: enhance btrfs structures for device
>>> replace support"), yet they were never used. And the
>>> IOCTL_DEV_REPLACE_STATE* were added in e93c89c1aaaa ("Btrfs: add new
>>> sources for device replace code").
>>>
>>> It looks like the ITEM_STATE* definitions were stillborn so to speak and
>>> personally I'm in favor of removing them. They shouldn't have been
>>> merged in the first place and indeed the patch doesn't even have a
>>> Reviewed-by tag. So it originated from the, I'd say, spartan days of
>>> btrfs development...
>>>
>>> David,  any code which is using BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED
>>> is inherently broken, so how about we remove those definitions, then
>>> when it's compilation is broken in the future the author will actually
>>> have a chance to fix it, though it's highly unlikely anyone is relying
>>> on those definitions.
>>>
>>>
>>>>
>>>> [2]
>>>> --------------------------------------
>>>> diff --git a/include/uapi/linux/btrfs_tree.h
>>>> b/include/uapi/linux/btrfs_tree.h
>>>> index aff1356c2bb8..9ffa7534cadf 100644
>>>> --- a/include/uapi/linux/btrfs_tree.h
>>>> +++ b/include/uapi/linux/btrfs_tree.h
>>>> @@ -805,9 +805,9 @@ struct btrfs_dev_stats_item {
>>>>   #define 
>>>> BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID     1
>>>>   #define BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED     0
>>>>   #define BTRFS_DEV_REPLACE_ITEM_STATE_STARTED           1
>>>> -#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED         2
>>>> -#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED          3
>>>> -#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED          4
>>>> +#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED          2
>>>> +#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED          3
>>>> +#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED         4
>>>>
>>>>   struct btrfs_dev_replace_item {
>>>>          /*
>>>> --------------------------------------
>>>>
>>>>
>>>> Thanks, Anand
>>>>
> 

