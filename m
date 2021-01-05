Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463362EA3F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 04:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbhAEDeE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 22:34:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33816 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbhAEDeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 22:34:03 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1053FUq2174381;
        Tue, 5 Jan 2021 03:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ONyO0Pkpl7MMT+c26ipzPO0gCEMw8/vBrbjFFBW91K8=;
 b=AxZsJpVE0KJ/vkGa6gFHrpXgcEQz89U5ZKotmVQWh3urUGIB5oeZo9WEDJK4TYVaYBfo
 ftRg2bzl2gxXPpRGud7rQktuZ1WFAa1IwzoOlFpiUgsLl8+7L9CY9wYvG9RHYJYiCYBt
 Lt78bwNHFlQJ+FKkdOLlS1qQlPeMi8WFmDmcTDtetYZR7f1WKJ4KV9omqiiQUOs2NWes
 +5AHx0zbQ7rwdu2hrMvcBWJqfDDX8CJZCzDeno3fcAQWXVrGUJ3Rg386riaP5tUyRa/v
 zsQDW65TZ+Z2OeC9FnlKrGhXEr3rPq/n/YdZ71nCLAR/jAWC9Nr96+2nU5vGtGSufA4V fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35tebaq471-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 03:33:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1053VIkk175464;
        Tue, 5 Jan 2021 03:31:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35vct572x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 03:31:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1053VA8d009791;
        Tue, 5 Jan 2021 03:31:10 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 19:31:10 -0800
Subject: Re: [PATCH v2 2/2] btrfs: tree-checker: check if chunk item end
 oveflows
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
References: <20210103092804.756-1-l@damenly.su>
 <20210103092804.756-3-l@damenly.su>
 <1a8dbe6a-f2db-4e0d-3b5f-dcd2073d6e1d@oracle.com> <y2h9kqqx.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9be541dd-153a-dbb8-99ef-e890437c37fe@oracle.com>
Date:   Tue, 5 Jan 2021 11:31:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <y2h9kqqx.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050019
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>> The image has a chunk item which has a logical start 37748736 and length
>>> 18446744073701163008. The calculated end 29360127 is overflowed 
>>> obviously.
>>> -EEXIST was caught by insert_state() because of the duplicate end and
>>> extent_io_tree_panic() was called.
>>> Add overflow check of chunk item end in tree checker then the image will
>>> be rejected to be mounted.
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208929
>>> Signed-off-by: Su Yue <l@damenly.su>
>>> ---
>>>   fs/btrfs/tree-checker.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>> index 028e733e42f3..39c65c1cbe96 100644
>>> --- a/fs/btrfs/tree-checker.c
>>> +++ b/fs/btrfs/tree-checker.c
>>> @@ -760,6 +760,7 @@ int btrfs_check_chunk_valid(struct extent_buffer 
>>> *leaf,
>>>   {
>>>       struct btrfs_fs_info *fs_info = leaf->fs_info;
>>>       u64 length;
>>> +    u64 chunk_end;
>>>       u64 stripe_len;
>>>       u16 num_stripes;
>>>       u16 sub_stripes;
>>> @@ -814,6 +815,12 @@ int btrfs_check_chunk_valid(struct extent_buffer 
>>> *leaf,
>>>                 "invalid chunk length, have %llu", length);
>>>           return -EUCLEAN;
>>>       }
>>> +    if (unlikely(check_add_overflow(logical, length, &chunk_end))) {
>>> +        chunk_err(leaf, chunk, logical,
>>> +              "invalid chunk logical/length, have logical %llu 
>>> length %llu",
>>> +              logical, length);
>>> +        return -EUCLEAN;
>>> +    }
>>>       if (unlikely(!is_power_of_2(stripe_len) || stripe_len !=   
>>> BTRFS_STRIPE_LEN)) {
>>>           chunk_err(leaf, chunk, logical,
>>>                 "invalid chunk stripe length: %llu",
>>>
>>
>> So this is a system chunk? It is not so evident from the trace above.
>>
> It's a chunk item located in chunk tree leaf, not in system chunk array.
> Tree checker checks chunk items in both locations.


Ok. Thanks.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
