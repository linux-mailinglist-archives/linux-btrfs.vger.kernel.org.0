Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F53A29E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfH2Wle (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 18:41:34 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:34807 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbfH2Wle (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dirtcellar.net; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To; bh=c4r2g6u62XDnS1hPmD3lB2vdEDi+XMdJWmkpDjN6IhY=;
        b=bDPT9mDkDyI3GEL30YNbr9/8/lLXsTx4tMs/JC2r5Ef2L70yYboZ56rjDf8hZd4aAzAiRR3DDFYuhWXg9JgiMKkLy4mOecnw/iyxDnWdZNN5VeknfYozFLbol6l1/yYTtRXTGdDk1bEPLxtQzSsgrDUjVZAXEW8qedAqajHaQuOG7M5GfiS3IgG2Xs7r+Sn1whVYVY60xUBJuqYn5kkaI2lWJPLy3uQREBOz5YCh2eakztjtBlpSCHQzNtFUNjGx0Gc6BUEWzXZxJzQkBTVe+6neb1RGiaexQfftKEi5mamzvRZE97F5nvMkLOjCL12Cle2JSLfIgGbaPjXf+rF7hg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:1467 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1i3T6h-0008AC-GM; Fri, 30 Aug 2019 00:41:31 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Spare Volume Features
To:     Sean Greenslade <sean@seangreenslade.com>,
        Marc Oggier <marc.oggier@megavolts.ch>,
        linux-btrfs@vger.kernel.org
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
 <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <a15fadad-9d78-d1a2-a7a6-e6fc33c417b8@dirtcellar.net>
Date:   Fri, 30 Aug 2019 00:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Sean Greenslade wrote:
> On August 28, 2019 5:51:02 PM PDT, Marc Oggier <marc.oggier@megavolts.ch> wrote:
>> Hi All,
>>
>> I am currently buidling a small data server for an experiment.
>>
>> I was wondering if the features of the spare volume introduced a couple
>>
>> of years ago (ttps://patchwork.kernel.org/patch/8687721/) would be
>> release soon. I think this would be awesome to have a drive installed,
>> that can be used as a spare if one drive of an array died to avoid
>> downtime.
>>
>> Does anyone have news about it, and when it will be officially in the
>> kernel/btrfs-progs ?
>>
>> Marc
>>
>> P.S. It took me a long time to switch to btrfs. I did it less than a
>> year ago, and I love it.  Keep the great job going, y'all
> 
> I've been thinking about this issue myself, and I have an (untested) idea for how to accomplish something similar. My file server has three disks in a btrfs raid1. I added a fourth disk to the array as just a normal, participating disk. I keep an eye on the usage to make sure that I never exceed 3 disk's worth of usage. That way, if one disk dies, there are still enough disks to mount RW (though I may still need to do an explicit degraded mount, not sure). In that scenario, I can just trigger an online full balance to rebuild the missing raid copies on the remaining disks. In theory, minimal to no downtime.
> 
> I'm curious if anyone can see any problems with this idea. I've never tested it, and my offsite backups are thorough enough to survive downtime anyway.
> 
> --Sean
> 
I'm just a regular btrfs user, but I see tons of problems with this.

When BTRFS introduce per-subvolume (or even per file) "RAID" or 
redundancy levels a spare device an quickly become a headache. While you 
can argue that a spare device of equal or large size than the largest 
device in the pool would suffice in most cases I don't think it is very 
practical.

What BTRFS needs to do (IMHO) is to reserve spare-space instead. This 
means that many smaller devices can be used in case a large device keels 
over.

The spare space also of course needs to be as large or larger than the 
largest device in the pool, but you would have more flexibility.

For example spare space COULD be pre-populated with the most important 
data (hot data tracking) and serve as a speed-up for read operations. 
What is the point of having idle space just waiting to be used when you 
in fact can just use it for useful things such as obvious ideas like 
increased read speed, extra redundancy for stuff like single, dup or 
even raid0 chunks. Using the spare space for SOME potential for recovery 
is better than not using the spare space for anything.

When the spare space is needed you can either simply discard the data on 
the device that is broken if the spare space already holds the data 
(which makes for superfast recovery) or drop any caches it is used for 
and repopulate by restoring non-redundant data to it as soon as you hit 
a certain error count on another device etc...

Just like Linux uses memory I think that BTRFS is better off using the 
spare space for something rather than nothing. This should of course be 
configurable just for the record.

Anyway - that is how I, a humble user without the detailed know-how 
think it should be implemented... :)
