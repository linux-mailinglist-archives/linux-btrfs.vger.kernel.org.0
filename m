Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429EE1BED62
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 03:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgD3BEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 21:04:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgD3BEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 21:04:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U131Jf018331;
        Thu, 30 Apr 2020 01:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GblXpjhWUDuwNKY33m2UNS52qSQxUHZqS0OQPCiW5hs=;
 b=opH0YXxYpKRhiZNxSQAVVV89zEuV4l3FV2uU1/oPXwY3/lohrmKtVWmp6zIUWPlIV8go
 cEimY5QwlOnr3TAjSuFVjaFfCmMs8j9Bc6Zj4T1M8jf5IEHyz3BhXc8Jecg1qgLH13Tn
 xUIX8QsEdq5REzc0Wdut2T4p0GpHiIOSt0v5X/0lUyXnB2PEGb8RS2WYBUfHmkl1atvV
 dS2C22SV3d7YNRPY++gc+O7m1dz2ub3LBXd5vi8rVcGlyX8fywd70Ie23pTLtbE5gnUf
 JENCwtWDjrD/aH5F7hkNBdNINlthqerCdpBuo9LVkQsGqBqAOnZbdP9AbxtIUdoDbM5r 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucg8rht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 01:04:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03U127Ys140697;
        Thu, 30 Apr 2020 01:02:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30pvd29545-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 01:02:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03U12VMU017203;
        Thu, 30 Apr 2020 01:02:31 GMT
Received: from [192.168.1.102] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Apr 2020 01:02:31 +0000
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
Date:   Thu, 30 Apr 2020 17:02:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300003
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  I am not sure if this will be integrated in 5.8 and worth the time to
  rebase. Kindly suggest.

-Anand

On 6/4/20 7:51 pm, Anand Jain wrote:
> v7:
> Fix switch's fall through warning. Changle logs updates where necessary.
> 
> v6:
> Patch 4/5 - If there is no change in device's read prefer then don't log
> Patch 4/5 - Add pid to the logs
> Patch 5/5 - If there isn't read preferred device in the chunk don't reset
> read policy to default, instead just use stripe 0. As this is in
> the read path it avoids going through the device list to find
> read preferred device. So inline to this drop to check if there
> is read preferred device before setting read policy to device.
> 
> __ Original email: __
> 
> v5:
> Worked on review comments as received in its previous version.
> Please refer to individual patches for the specific changes.
> Introduces the new read_policy 'device'.
> 
> v4:
> Rename readmirror attribute to read_policy. Drop separate kobj for
> readmirror instead create read_policy attribute in fsid kobj.
> merge v2:2/3 and v2:3/3 into v4:2/2. Patch titles have changed.
>   
> v3:
> v2:
> Mainly fixes the fs_devices::readmirror declaration type from atomic_t
> to u8. (Thanks Josef).
> 
> v1:
> As of now we use only %pid method to read stripped mirrored data. So
> application's process id determines the stripe id to be read. This type
> of routing typically helps in a system with many small independent
> applications tying to read random data. On the other hand the %pid
> based read IO distribution policy is inefficient if there is a single
> application trying to read large data as because the overall disk
> bandwidth would remains under utilized.
> 
> One type of readmirror policy isn't good enough and other choices are
> routing the IO based on device's waitqueue or manual when we have a
> read-preferred device or a readmirror policy based on the target storage
> caching. So this patch-set introduces a framework where we could add more
> readmirror policies.
> 
> This policy is a filesystem wide policy as of now, and though the
> readmirror policy at the subvolume level is a novel approach as it
> provides maximum flexibility in the data center, but as of now its not
> practical to implement such a granularity as you can't really ensure
> reflinked extents will be read from the stripe of its desire and so
> there will be more limitations and it can be assessed separately.
> 
> The approach in this patch-set is sys interface with in-memory policy.
> And does not add any new readmirror type in this set, which can be add
> once we are ok with the framework. Also the default policy remains %pid.
> 
> Previous works:
> ----------------------------------------------------------------------
> There were few RFCs [1] before, mainly to figure out storage
> (or in memory only) for the readmirror policy and the interface needed.
> 
> [1]
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg86368.html
> 
> https://lore.kernel.org/linux-btrfs/20190826090438.7044-1-anand.jain@oracle.com/
> 
> https://lore.kernel.org/linux-btrfs/5fcf9c23-89b5-b167-1f80-a0f4ac107d0b@oracle.com/
> 
> https://patchwork.kernel.org/cover/10859213/
> 
> Mount -o:
> In the first trial it was attempted to use the mount -o option to carry
> the readmirror policy, this is good for debugging which can make sure
> even the mount thread metadata tree blocks are read from the disk desired.
> It was very effective in testing radi1/raid10 write-holes.
> 
> Extended attribute:
> As extended attribute is associated with the inode, to implement this
> there is bit of extended attribute abuse or else makes it mandatory to
> mount the rootid 5. Its messy unless readmirror policy is applied at the
> subvol level which is not possible as of now.
> 
> An item type:
> The proposed patch was to create an item to hold the readmirror policy,
> it makes sense when compared to the abusive extended attribute approach
> but introduces a new item and so no backward compatibility.
> -----------------------------------------------------------------------
> 
> Anand Jain (5):
>    btrfs: add btrfs_strmatch helper
>    btrfs: create read policy framework
>    btrfs: create read policy sysfs attribute, pid
>    btrfs: introduce new device-state read_preferred
>    btrfs: introduce new read_policy device
> 
>   fs/btrfs/sysfs.c   | 128 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c |  39 +++++++++++++-
>   fs/btrfs/volumes.h |  16 ++++++
>   3 files changed, 182 insertions(+), 1 deletion(-)
> 
