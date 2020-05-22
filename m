Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705781DEFCA
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgEVTOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 15:14:55 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:57175 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbgEVTOz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 15:14:55 -0400
Received: from [2001:8b0:162c:2:54ae:8afe:7f9d:f73e]
        by smtp.steev.me.uk with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.93.0.4)
        id 1jcD87-00CNl5-Ql; Fri, 22 May 2020 20:14:51 +0100
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
 <20200515195858.GS18421@twin.jikos.cz>
 <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
From:   Steven Davies <btrfs-list@steev.me.uk>
Message-ID: <5a43edf5-6b0e-9523-eb9d-f3744bceeabd@steev.me.uk>
Date:   Fri, 22 May 2020 20:15:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2020 11:02, Anand Jain wrote:
> 
> 
> On 16/5/20 3:58 am, David Sterba wrote:
>> On Thu, Apr 30, 2020 at 05:02:27PM +0800, Anand Jain wrote:
>>>    I am not sure if this will be integrated in 5.8 and worth the time to
>>>    rebase. Kindly suggest.
>>
>> The preparatory work is ok, but the actual mirror selection policy
>> addresses a usecase that I think is not the one most users are
>> interested in. Devices of vastly different performance capabilities like
>> rotational disks vs nvme vs ssd vs network block devices in one
>> filesystem are not something commonly found.
>>
>> What we really need is a saner balancing mechanism than pid-based, that
>> is also going to be used any time there are more devices from the same
>> speed class for the fast devices too.

I can't find documentation about how mdadm chooses which mirror to read 
from (in the absence of --write-mostly) but everything suggests it uses 
different mirrors for different processes which sounds the same as or 
very much like %pid. Are you thinking along the lines of checking I/O 
queue length or average seek/read time when choosing the device?

> There are two things here, the read_policy framework in the preparatory
> patches and a new balancing or read_policy, device.
> 
>> So, no the patchset is not on track for a merge without the improved
>> default balancing.
> 
> It can be worked on top of the preparatory read_policy framework?
> This patchset does not change any default read_policy (or balancing)
> which is pid as of now. Working on a default read_policy/balancing
> was out of the scope of this patchset.
> 
>> The preferred device for reads can be one of the
>> policies, I understand the usecase and have not problem with that
>> although wouldn't probably have use for it.
> 
> For us, read_policy:device helps to reproduce raid1 data corruption
>     https://patchwork.kernel.org/patch/11475417/
> And xfstests btrfs/14[0-3] can be improved so that the reads directly
> go the device of the choice, instead of waiting for the odd/even pid.
> 
> Common configuration won't need this, advance configurations assembled
> with heterogeneous devices where read performance is more critical than
> write will find read_policy:device useful.

+1 for merging this as-is; I'm one of the users with heterogeneous 
devices (SATA SSD and NVMe SSD) and it would bring a feature similar to 
mdadm's --write-mostly. I've seen a few other requests for this feature 
on other discussion fora as well.

-- 
Steven Davies
