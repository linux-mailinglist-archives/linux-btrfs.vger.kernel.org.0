Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EAB2FC8A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 04:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbhATDUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 22:20:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52986 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387599AbhATClU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 21:41:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K2e235086244;
        Wed, 20 Jan 2021 02:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PXytxwVzE5VR53HPMta1k/oaIyuKttBLtN1ccsE0Qp4=;
 b=s4AZug77Uuf1sknpBjVQxzEIlT+mjYZTytKD5p8SZFFMSKJbR8rURBRe5ILZKOPOQsog
 8sO+yrKjnFd2LiT6N7wKVTenjDs1qt30jnxBsOBYYLTVcBRKctQXuJQci1kA00nUG29F
 hOei1e9YXWdYV621nteQ6t20uxzQ15mqR0YYIvNiXwa11I/Psrsx+wQUSVQzc8DX3lxB
 Lp4dFQWbLRT2935ef1TwuG1s4xiS+mMYrt+iUSt9JCMNG5xtsXPKj8c87FcKM97cQg+9
 lGhTFd/5ZtQeja/xa42K4+1bQONcxdMfKtvgeDs18zjAj1mevpesAfDharDMxeaYsp1M jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3668qa8eeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 02:40:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K2dkJH073259;
        Wed, 20 Jan 2021 02:40:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3668rd77vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 02:40:22 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10K2eLUh031064;
        Wed, 20 Jan 2021 02:40:21 GMT
Received: from [192.168.10.137] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 18:40:21 -0800
Subject: Re: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <8e0afaa33f33d1a5efbf37fa4465954056ce3f59.1610324448.git.anand.jain@oracle.com>
 <b0cf6a1d-bd50-dbd5-ff8e-d24ab547e57a@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1337063c-1f3c-7d6f-8d0c-49b8a37beda3@oracle.com>
Date:   Wed, 20 Jan 2021 10:40:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b0cf6a1d-bd50-dbd5-ff8e-d24ab547e57a@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200014
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/1/21 3:41 am, Josef Bacik wrote:
> On 1/11/21 4:41 AM, Anand Jain wrote:
>> Add round-robin read policy to route the read IO to the next device in 
>> the
>> round-robin order. The chunk allocation and thus the stripe-index follows
>> the order of free space available on devices. So to make the round-robin
>> effective it shall follow the devid order instead of the stripe-index
>> order.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> -- 
>> RFC because: Provides terrible performance with the fio tests.
>> I am not yet sure if there is any io workload or a block layer
>> tuning that shall make this policy better. As of now just an
>> experimental patch.
>>
> 
> Just drop this one, if we can't find a reason to use it then don't 
> bother adding the code.  The other options have real world valuable 
> uses, so stick with those.  Thanks,
> 

  Yep. I will drop this patch in the next iteration.

  The low performance is attributed to the low number of read IO
  mergers in the block layer. The consecutive blocks in my test case
  (fio random read) were read from the other disk, so the block layer
  lost the opportunity to merge the IOs.

Thanks, Anand

> Josef
> 


