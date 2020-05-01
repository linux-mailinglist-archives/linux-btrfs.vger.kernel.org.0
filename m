Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0971C18D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgEAOzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 10:55:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgEAOzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 10:55:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041ErN4D132377;
        Fri, 1 May 2020 14:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oY9xFcMStXAxAmUY0swjNVrh+5D8Ahs7VbBVHhTum3w=;
 b=xS9FiykUmq9HOLve8uL4FqbPNp3EYLxwTQ0Rt5onxGPeGVCNlQ8LgGcTK0kbcVpjCBw9
 lPunFaxI6Kjkxv0qJrstalJLbenxSBixC2DCMo1MaIJ0V9XUsUSPkY2kfWfJSnqtXhg+
 YrFBVSMPiedeeBX87OOfg9HEDzJt3ezGDLOqAgLfUdwBN5LBalZ+RxFxvREKpW3EnjqI
 5puLfoW3XLHGk2swOcr+ds6CUueoVz22zgy9bGdWcy0S5xee6ivHvUasVHBYQA9LnJ/R
 YvCiN9bHVcLDnLUTfEqN1Ze22DTeqMAFgA9sDmWCWxCHO7v8OgF9/pwri6OiFDu33Aco CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30r7f82kag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 14:55:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041Er0a2067083;
        Fri, 1 May 2020 14:55:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30r7fau9sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 14:55:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041Et2Y1019360;
        Fri, 1 May 2020 14:55:03 GMT
Received: from [192.168.1.102] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 07:55:02 -0700
Subject: Re: [PATCH 2/3] btrfs: include non-missing as a qualifier for the
 latest_bdev
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        nborisov@suse.com, josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <20200428152227.8331-3-anand.jain@oracle.com>
 <20200430134602.GM18421@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <95c7db9e-70bc-ff14-b380-7de677ccbe9a@oracle.com>
Date:   Sat, 2 May 2020 06:54:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430134602.GM18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=2 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010119
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/4/20 9:46 pm, David Sterba wrote:
> On Tue, Apr 28, 2020 at 11:22:26PM +0800, Anand Jain wrote:
>> btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
>> to point to the bdev with greatest device::generation number.
>> For a typical-missing device the generation number is zero so
>> fs_devices::latest_bdev will never point to it.
>>
>> But if the missing device is due to alienation [1], then
>> device::generation is not-zero and if it is >= to rest of
>> device::generation in the list, then fs_devices::latest_bdev
>> ends up pointing to the missing device and reports the error
>> like this [2]
>>
>> [1] We maintain devices of a fsid (as in fs_device::fsid) in the
>> fs_devices::devices list, a device is considered as an alien device
>> if its fsid does not match with the fs_device::fsid
>>
>> $ mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
> 
> Please put each command on one line for clarity
> 

yep.

>> $ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
>> $ sleep 3 # avoid racing with udev's useless scans if needed
>> $ btrfs dev add -f /dev/sdb /btrfs
>> $ mount -o degraded /dev/sdc /btrfs1
> 
> So the cause is a second mkfs on some devices, but is the degraded mount
> supposed to work? The example goes:
> 
Yes. It must work. We don't know if the user is mounting B just after
mkfs or if it already contains some data.

> - create first filesystem with device A
> - create second filesystem with device B and C
> - add device B to the first filesystem, effectively making it missing
> - mount first filesystem, degraded because of the missing device
> 
> For a reproducer that's ok, but is this something that we can expect to
> happen in practice? The flag -f should prevent accidental overwrite, but
> yes the kernel code needs to deal with that in any case.
> 

Its a configuration related, so is left the user how they arrive at
their understanding of what configuration is suitable for them. Yes its
better to fix loop holes in its path. I encountered it when testing
something else.



