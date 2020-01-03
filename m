Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3012F6B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgACK2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 05:28:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgACK2m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 05:28:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 003AOoO5194578;
        Fri, 3 Jan 2020 10:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=zAMUah4TVyJRwXvmSzvt7LB1THe6cqx2WU8489vIe9o=;
 b=gFTYFnmb0ZyiPhNLDDsD/5pOzopDA0gvPLoTAcD1UVBlSA/ib7YD8i6sS38Nu6B7oNwI
 R9UehFrcRSgrjPlEgZaBnIEOkFVe+y6LwSYZXDULaaFBLd+XwZD2gLmWyCNnImvTl1l9
 aIaw8FqhDCXJvl0lCNkOECpqPtO0FRsolWKnCRs/FG/n0+m48rQMXTHp8A+1QsaZXP6p
 X0XS782S2pz2BVZxj4klJOnSwteBGx4Zs5QEEWNd7ph8P0UQJAl3koJ3+5cdtls/BKsm
 on24lI9mGWP8hrmQSjRNPa7xB5G6EEFLoji7CKgUGSeJePWYCMYVA2FjWq7RF/GyVP5F ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2x5y0pupnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 10:28:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 003ASWLm051165;
        Fri, 3 Jan 2020 10:28:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2x8gjbr9v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 10:28:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 003ASS1I016107;
        Fri, 3 Jan 2020 10:28:28 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jan 2020 02:28:27 -0800
Subject: Re: [PATCH v2 1/3] btrfs: add readmirror type framework
To:     Steven Davies <btrfs-list@steev.me.uk>,
        David Sterba <dsterba@suse.com>
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
 <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
 <4f4a1dab-fd9b-a5b6-2109-d82fc222d208@steev.me.uk>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <e652f476-eef8-62d1-4a3d-b01dbce2677a@oracle.com>
Date:   Fri, 3 Jan 2020 18:28:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4f4a1dab-fd9b-a5b6-2109-d82fc222d208@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030099
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/1/20 3:32 AM, Steven Davies wrote:
> On 02/01/2020 10:12, Anand Jain wrote:
>> As of now we use %pid method to read stripped mirrored data. So
>> application's process id determines the stripe id to be read. This type
>> of read IO routing typically helps in a system with many small
>> independent applications tying to read random data. On the other hand
>> the %pid based read IO distribution policy is inefficient if there is a
>> single application trying to read large data and the overall disk
>> bandwidth remains under utilized.
>>
>> So this patch introduces a framework where we could add more readmirror
>> policies, such as routing the IO based on device's wait-queue or manual
>> when we have a read-preferred device or a policy based on the target
>> storage caching.
> 
> I think the idea is good but that it would be cleaner if the tunable was 
> named read_policy rather than readmirror as it's more obvious that it 
> contains a policy tunable.

  Um. 'read_policy' sounds good, but I hope it is clear enough to
  indicate that we are talking about read for only mirrored-chunks.
  Will rename to read_policy.

> Do you envisage allowing more than one policy to be active for a 
> filesystem? If not, what about using the same structure as the CPU 
> frequency and block IO schedulers with the format
> 
> #cat /sys/block/sda/queue/scheduler
> noop [deadline] cfq
> 
> Such that btrfs would (eventually) have something like
> 
> #cat /sys/fs/btrfs/UUID/read_policy
> by_pid [user_defined_device] by_shortest_queue
> 

  And in case of user_defined_device, the device for the read shall be
  specified in

   cat /sys/fs/btrfs/UUID/devinfo/<devid>/read_preferred

   0 = unset, 1 = set.

   (devinfo patches are in the ML [1] open for comment)
   [1]
   [PATCH v3 4/4] btrfs: sysfs, add devid/dev_state kobject and attribute

> And the policy would be changed by echo'ing the new policy name to the 
> read_policy kobject.

  I like this approach, will change it to use this format.

Thanks, Anand

> Steve

