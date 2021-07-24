Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56DA3D4745
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhGXKXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGXKXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 06:23:52 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445FC061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nl6Vi/09tFyy2goiePcBjbhWTHpgeumKjNxPO5vBuaY=; b=wxe4VvSBTA+NVbuX/d9b/LKmqW
        lj38Jhrtd7gnEQJBDK44JK07hy4xU/SA6jmOTKhTgYFhkpellBbgq+mJQbT7e5CospWfqIKvtAJN+
        tNOfywrD+A+jQKViuVEMBAf5tCGSnVD7tp3i/9+z9PGMuy87jIPjpddCK2cctVbY7lqlQjAxC61+C
        VA6LmcuCre3UsbZvf8jpjZ6ZjZK5bEdUW4hvuh7yUFVKChV1gYwlbhlrIOe9Gak2I6KBk/tczAdJd
        hHU+P3VsQtzBE5A9hAbQ/8F+nUyeCgw/9OPn8v27rwol9camQReh96AU0dlarQIXA9uw0W6W3QA7U
        +S2zzL2A==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:44922 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1m7FS8-0008G4-Om; Sat, 24 Jul 2021 13:04:20 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
To:     dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz> <20210723222730.1d23f9b4@natsu>
 <20210723192145.GF19710@suse.cz>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <18a1bdd5-321e-68d3-517f-84c8d9bacb9c@dirtcellar.net>
Date:   Sat, 24 Jul 2021 13:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.8.1
MIME-Version: 1.0
In-Reply-To: <20210723192145.GF19710@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba wrote:

> Maybe it's still too new so nobody is used to it and we've always had
> problems with the raid naming scheme anyway.

Perhaps slightly off topic , but I see constantly that people do not 
understand how BTRFS "RAID" implementation works. They tend to confuse 
it with regular RAID and get angry because they run into "issues" simply 
because they do not understand the differences.

I have been an enthusiastic BTRFS user for years, and I actually caught 
myself incorrectly explaining how regular RAID works to a guy a while 
ago. This happened simply because my mind was so used to how BTRFS uses 
this terminology that I did not think about it.

As BTRFS is getting used more and more it may be increasingly difficult 
(if not impossible) to get rid of the "RAID" terminology, but in my 
opinion also increasingly more important as well.

Some years ago (2018) there was some talk about a new naming scheme
https://marc.info/?l=linux-btrfs&m=136286324417767

While technically spot on I found Hugo's naming scheme difficult. It was 
based on this idea:
numCOPIESnumSTRIPESnumPARITY

1CmS1P = Raid5 or 1 copy, max stripes, 1 parity.

I also do not agree with the use of 'copy'. The Oxford dictionary 
defines 'copy' as "a thing that is made to be the same as something 
else, especially a document or a work of art"

And while some might argue that copying something on disk from memory 
makes it a copy, it ceases to be a copy once the memory contents is 
erased. I therefore think that replicas is a far better terminology.

I earlier suggested Rnum.Snum.Pnum as a naming scheme which I think is 
far more readable so if I may dare to be as bold....

SINGLE  = R0.S0.P0 (no replicas, no stripes (any device), no parity)
DUP     = R1.S1.P0 (1 replica, 1 stripe (one device), no parity)
RAID0   = R0.Sm.P0 (no replicas, max stripes, no parity)
RAID1   = R1.S0.P0 (1 replica, no stripes (any device), no parity)
RAID1c2 = R2.S0.P0 (2 replicas, no stripes (any device), no parity)
RAID1c3 = R3.S0.P0 (3 replicas, no stripes (any device), no parity)
RAID10  = R1.Sm.P0 (1 replica, max stripes, no parity)
RAID5   = R0.Sm.P1 (no replicas, max stripes, 1 parity)
RAID5   = R0.Sm.P2 (no replicas, max stripes, 2 parity)

This (or Hugo's) type of naming scheme would also easily allow add more 
exotic configuration such as S5 e.g. stripe over 5 devices in a 10 
device storage system which could increase throughput for certain 
workloads (because it leaves half the storage devices "free" for other jobs)
A variant of RAID5 behaving like RAID10 would simply be R1.Sm.P1. Easy 
peasy...  And just for the record , the old RAID terminology should of 
course work for compatibility reasons, but ideally should not be 
advertised at all.

Sorry for completely derailing the topic, but I felt it was important to 
bring up (and I admit to be overenthusiastic about it). :)
