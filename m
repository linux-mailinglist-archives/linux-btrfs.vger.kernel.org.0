Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1383BAE6C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfIJJYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 05:24:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44842 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfIJJYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 05:24:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A9NWKc054075;
        Tue, 10 Sep 2019 09:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hUHHppBR/CYeZsEa6qm0uZ0XCQDIMgs4+nnqhhQdhnY=;
 b=UBh8beIiqd0230yf5p7ZqY3AvN/Y1lYCSUs8/OnQ9+eEh0E2brM7ghv48tResTAmaYZv
 i8KLMhI7fsCkM+4PpWTw6rOlrXYv7YzdLBi7w0/xo6/JTU7qujfL8jHRzOnPqopn22a0
 cHmMQBdglpT15I/ucSjU/6IAeVy2SBsBNfivJHpu1WVU0YJJGEUKlnZyeyuDl0kvoSId
 P72SpSM2g7WSEDRLbtEcxtLay2fH+s9WCyko54AqIaajClLRYyWn9i/83bJMkYH8UDcC
 056sDaEACq/WuCUJWB6PAnCUCKcqvo2Q5vOcdDyN/taumMaeEzzN9ZaiKzf7qeKovb2j nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jy2295-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 09:23:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A9Mb4X078324;
        Tue, 10 Sep 2019 09:23:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2uwqktgdj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 09:23:35 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8A9NYtR021923;
        Tue, 10 Sep 2019 09:23:34 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 02:23:34 -0700
Subject: Re: [PATCH v3 2/2] btrfs: tree-checker: Fix wrong check on max devid
To:     WenRuo Qu <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190828023313.22417-1-wqu@suse.com>
 <20190828023313.22417-2-wqu@suse.com>
 <325a8560-b172-0826-95b7-c0922f8e2c50@oracle.com>
 <cf1c250d-b981-b26c-48f0-f3a58255c217@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e6420408-3519-0e60-dc11-869e0db6c657@oracle.com>
Date:   Tue, 10 Sep 2019 17:23:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cf1c250d-b981-b26c-48f0-f3a58255c217@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/9/19 5:12 PM, WenRuo Qu wrote:
> 
> 
> On 2019/9/10 下午5:07, Anand Jain wrote:
>>
>>
>>
>>
>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>> index ccd5706199d7..15d1aa7cef1f 100644
>>> --- a/fs/btrfs/tree-checker.c
>>> +++ b/fs/btrfs/tree-checker.c
>>> @@ -686,9 +686,7 @@ static void dev_item_err(const struct
>>> extent_buffer *eb, int slot,
>>>    static int check_dev_item(struct extent_buffer *leaf,
>>>                  struct btrfs_key *key, int slot)
>>>    {
>>> -    struct btrfs_fs_info *fs_info = leaf->fs_info;
>>>        struct btrfs_dev_item *ditem;
>>> -    u64 max_devid = max(BTRFS_MAX_DEVS(fs_info),
>>> BTRFS_MAX_DEVS_SYS_CHUNK);
>>
>> As I commented in v2.
>> I see that BTRFS_MAX_DEVS_SYS_CHUNK is not being used anywhere
>> else after this being removed. So good to delete the define.
>> I am bit surprised as well if I am missing?
> 
> Please check the first patch.
> 
> It adds back the reference to it as an early exit for btrfs_alloc_chunk().

  Oh. Right here in the same thread. Ok. Thanks.

> Thanks,
> Qu
>>
>> Thanks, Anand
>>

