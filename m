Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF22EB842
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 03:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFC4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 21:56:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51276 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFC4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 21:56:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1062qf7G135912;
        Wed, 6 Jan 2021 02:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YiJ5QAyFojsQJUlBdNNbpKryDG/s7my5ALc5KaM+x14=;
 b=AudZGti5V+kOJ2uOsxuyb6nfSeBKvJ3MhWogZVszo0b77ztrqrShDeY953kbLg2ncLsB
 YS24sTcYNRryWr43EbSgy9hr9fGR/zztd5eyaMVymqJRVfBjf2kzpFPc0PvbOmdHNRcD
 5dAQOvy9YF2+KovnKMJ2f3FaDVCnnNfzYaagtmCvAFFDgOpOPlDrihGlm5MPSuprccy2
 BxewSPMsGX3QW4k3V44lbntZ5yEQ40OfXJ+GqQpiJ8eVnL5t23/dhRU5fKWSANzZvLcX
 +vlyItzT1KV4/A+9bc/yudYLppcS6avI8A4ULpuaG+qe5Qq5jhHBavoHBDFcSBWp+5Zm XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgskuhg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 02:55:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1062tTjv129780;
        Wed, 6 Jan 2021 02:55:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35w3qram9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 02:55:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1062tftL012359;
        Wed, 6 Jan 2021 02:55:41 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 18:55:40 -0800
Subject: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize the
 SSD?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Cedric.dewijs@eclipso.eu,
        linux-btrfs@vger.kernel.org
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bd65383b-26cd-24ff-54b6-2f1c6a9a407a@oracle.com>
Date:   Wed, 6 Jan 2021 10:55:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060016
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>> ­I have put a SSD and a slow laptop HDD in btrfs raid. This was a bad 
>> idea, my system does not feel responsive. When i load a program, dstat 
>> shows half of the program is loaded from the SSD, and the rest from 
>> the slow hard drive.

The drive speeds are evolving. NVME introduced lower latency than the
SSD. Mixing up drives amid production is unavoidable sometimes.


> 
> Btrfs uses pid to load balance read IIRC, thus it sucks in such workload.
> 

PID is not good when drives are of mixed speeds. But it balances
with the block layer IO queuing and sorting and cache. So it provides
equally good read IO performance when all drives are of the same speed.

>> I was expecting btrfs to do almost all reads from the fast SSD, as 
>> both the data and the metadata is on that drive, so the slow hdd is 
>> only really needed when there's a bitflip on the SSD, and the data has 
>> to be reconstructed.

> IIRC there will be some read policy feature to do that, but not yet
> merged,

Yes. Patches are here [1]. These patches have dependent patches that are
merged in V5.11-rc1. Please give it a try. See below for which policy to
use.

> and even merged, you still need to manually specify the
> priority, as there is no way for btrfs to know which driver is faster
> (except the non-rotational bit, which is not reliable at all).


  Hm. This is wrong.

  There are two types of read policies as of now.

  - Latency
  - Device

  Latency - For each read IO Latency policy dynamically picks the drive
  with the lowest latency based on its historic read IO wait.

   Set the policy sysfs:
   echo "latency" > /sys/fs/btrfs/$uuid/read_policy

  Device - is a kind of manual configuration, you can tell the read IO
  which device to read from when all the strips are healthy.

   Set it in the sysfs:
   First tell which Device is preferred for reading.
     echo 1 > /sys/fs/btrfs/$uuid/devinfo/$devid/read_preferred

   Set the policy:
   echo "device" > /sys/fs/btrfs/$uuid/read_policy

  The policy type round-robin is still experimental.

  Also, note that read policies are in memory only. You have to set it
  again (using sysfs) after the reboot/remount. I am open to feedback.


[1]
V2:
[PATCH v2 0/4] btrfs: read_policy types latency, device and round-robin


Thanks.
