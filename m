Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0940929D39C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJ1VoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:44:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJ1VoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S8x4k2183763;
        Wed, 28 Oct 2020 08:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VQQJzp+B3kmYhE4iSorv2Lp1AFwSsWs0oQ0rNECA2K8=;
 b=tmfchUKN8BqwaezmWaC5qtXwGY26e7QJfFg4piAX0YCMnBoXYd5/77hvcTxh/MDDPVE9
 UdFrJSBNbPMocXe7F0ys9UA2lvjDADCznyoGD3ZhanekFm6f6f0wbstcNPDK0mmNGw7B
 JaLGVFm+REIFe3eiyJR07wNLUwS3/onqTSiCG3Fgty/Dmjrm+dn2w66rpr9FAz4g8xg9
 ebwzdU4/P8BM2KBqOK+f+/fwB33ZtvtNa0hKwXvd91T9qXcVJfcm7BHYNEKaP69EUITq
 JEGWDkmcMhV0Hlqyiy3d5OshBwERIZZi+VFK2t4SdGiodMofORiK8EocMv6Ae1HAJaq3 Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7kx6dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 08:59:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S8uKCQ154520;
        Wed, 28 Oct 2020 08:59:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1rr09e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 08:59:28 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09S8xRV2012755;
        Wed, 28 Oct 2020 08:59:27 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 01:59:27 -0700
Subject: Re: [PATCH RFC 4/7] btrfs: trace, add event btrfs_read_policy
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <e6e5c40113cd3e939441ab3ece823282049a596f.1603751876.git.anand.jain@oracle.com>
 <eaf39974-65db-4a38-4342-f7dbea4d06bc@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9e2c88d0-b13a-d175-38e9-7cd0e802acf8@oracle.com>
Date:   Wed, 28 Oct 2020 16:59:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <eaf39974-65db-4a38-4342-f7dbea4d06bc@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280061
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/10/20 2:22 am, Josef Bacik wrote:
> On 10/26/20 7:55 PM, Anand Jain wrote:
>> This patch adds trace event btrfs_read_policy, which is common to all the
>> read policies.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c           | 28 ++++++++++++++++++++++++++--
>>   include/trace/events/btrfs.h | 20 ++++++++++++++++++++
>>   2 files changed, 46 insertions(+), 2 deletions(-)
> 
> Noooooo this isn't the way we do this.  Simply make a trace class with 
> all the variations, and then add individual trace events that inherit 
> from the class that print out the appropriate values.  Thanks,
> 

I added this mainly to debug the inflight thing. I was kind of not so
successful in finding a relation between latency, queue depth, and
inflight. As it is gone now, I doubt if we still need tracing. I am ok
to drop this. Or we could add when we start digging anything around
this?

Thanks, Anand


> Josef

