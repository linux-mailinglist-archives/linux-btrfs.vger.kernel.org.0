Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7C29E033
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgJ2BLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 21:11:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44220 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgJ2BLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 21:11:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T19S9R075414;
        Thu, 29 Oct 2020 01:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CngU99gycH8K2+mDJi05iHuJRBf+LTgcu366RDz/mgE=;
 b=FTw6Ro2dIjtgvFm8jmFkXqCkSGk1o1whba9/OxIAYcw1D0EpXtFRhVsYfxfxbhGiU6T7
 CHCI9+DENijG91t962wj9CEkxh6xOglFKEGzSRMVj605xZYyvFf+D+z46VHhxJjNkTN9
 aqxQAbdU2puSZXt1iAf4ceiKt2DE762OtlqurP276QoST8ThEtqC7eRgFPQnKTD2eB8k
 OhxzEHq8VBxDVqqx10JnrrRKBeofUbINye6acnrWBUQpEJk0bk1iLR1XLjOUPMDUf0As
 06baHh9sKkb/5FMBcPdK/c08lrF1TuwpJ9nkxxrpzVoloOtwEbY/TJUF7ytRwsVfMeDB og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9sb2gg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 01:10:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T15P3k091157;
        Thu, 29 Oct 2020 01:08:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34cx6xw32a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 01:08:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09T18tcO023665;
        Thu, 29 Oct 2020 01:08:55 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 18:08:54 -0700
Subject: Re: [PATCH v1 0/4] btrfs: read_policy types latency, device and
 round-robin
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <ac428935-c20c-d02d-6678-d88cc5eb4b63@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <da5c6fc8-95ef-6272-ea2a-4929fc32c69c@oracle.com>
Date:   Thu, 29 Oct 2020 09:08:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ac428935-c20c-d02d-6678-d88cc5eb4b63@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290003
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/10/20 10:32 pm, Josef Bacik wrote:
> On 10/28/20 9:25 AM, Anand Jain wrote:
>> Based on misc-next
>>
>> Depends on the following 3 patches in the mailing list.
>>    btrfs: add btrfs_strmatch helper
>>    btrfs: create read policy framework
>>    btrfs: create read policy sysfs attribute, pid
>>
>> v1:
>> Drop tracing patch
>> Drop factoring inflight command
>>    Here below is the performance differences, when inflight is used, 
>> it pushed
>>    few commands to the other device, so losing the potential merges.
>>
>>    with inflight:
>>     READ: bw=195MiB/s (204MB/s), 195MiB/s-195MiB/s (204MB/s-204MB/s), 
>> io=15.6GiB (16.8GB), run=82203-82203msec
>> sda 256054
>> sdc 20
>>
>>    without inflight:
>>     READ: bw=192MiB/s (202MB/s), 192MiB/s-192MiB/s (202MB/s-202MB/s), 
>> io=15.6GiB (16.8GB), run=83231-83231msec
>> sda 141006
>> sdc 0
>>
> 
> What's the baseline?  I think 3mib/s is not that big of a tradeoff for 
> complexity, but if baseline is like 190mib/s then maybe its worth it.  
> If baseline is 90mib/s then I say it's not worth the inflight.  Thanks,

  Oh no I have to rerun the test cases here. As far as I remember
  without inflight was better than with inflight. Because with
  inflight there were fewer merges leading to more read IOs.

  Will rerun and send the data.

Thanks, Anand

> 
> Josef
