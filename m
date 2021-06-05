Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C421639C70A
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jun 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFEJZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Jun 2021 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFEJZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Jun 2021 05:25:09 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FABDC061766
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Jun 2021 02:23:19 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id D0C319C26E; Sat,  5 Jun 2021 10:23:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1622884995;
        bh=fTHLepHKEhH85KaE9QiNLo16d/jRN/Ul2o012DB1qhI=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=VLn0PVr+aOsCPitlDTrUXpwWY15JfG+t9uYc8zOFqn7LkSVcP/lhgiYm28aavOhJk
         1TZy2zyTCjlhZ2Ru1k+0saqJfVDouYyddEzCa5wjVPMpIqrYyR9vD0v7VOH+dF+dtq
         gPC16v3F8hh2H9fxCywgRPNRYS8aGpS8b/4ZD6jLvL9MvT6nv9XwFio8dDmtrc5Mj2
         ZyGn5ksHgcd1X2UNGXgMOyr9Ghbd5EOri9h/w4kt0dSJSrfsVkvzwC9dk0d+Yk02eV
         GmilvbihD3dlcxvxZgguSgPfdUlYnkZNiFatoPWlbNwBnKKSHwK/D/ye26mMIuRfF3
         GUhJaYX5KZYBA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.6 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id B0F919B730;
        Sat,  5 Jun 2021 10:23:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1622884993;
        bh=fTHLepHKEhH85KaE9QiNLo16d/jRN/Ul2o012DB1qhI=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=aQFGynK0KFS05eeKAONq4iIx4nBmhetPiCb2K+yKLeYP9vnoDgefErKUBRFz0JXzV
         Pd1CXT+WP9gBfpHpfao8NUUVefbmG6xWhrFIwBqy1iVsJmTUPbY/VUQkMat1TWYrAR
         GJAExcNz9xtwnR5TRtuyypKEpPD1Sl4fmZfVcEqVGvpSoAwjVC9YLepTE9X4t0EJmi
         viYgsEp+OWatO8iymAd6tZ3DLB1kHkbJOmejHWkCEKyKxK1EnHcurb3GIqL4pB7MgE
         C2WppQKovgbTCjLUVwuGz///cl0edpgK2GYSXe/6iNp9zJddhMuhyUZkV6xbIAnIGX
         Ka4ZFNtMJT8Uw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 6403C24E518;
        Sat,  5 Jun 2021 10:23:13 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Chris Murphy <lists@colorremedies.com>,
        Gaardiolor <gaardiolor@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
 <CAJCQCtRkZPqQ_Rfx1Kk6rXZ_GyxDcLymdFjJkS12zZZ0mep3vQ@mail.gmail.com>
 <5272b826-ec8e-f3a3-6fc1-bb863b698c83@gmail.com>
 <CAJCQCtTdZ6LiYQPi-tb95auE1K1bxJ04iDPbu03k4W-Pu5xbEA@mail.gmail.com>
Subject: Re: Re: Corrupted data, failed drive(s)
Message-ID: <751d9089-15c7-8fb3-4291-407ec5458149@cobb.uk.net>
Date:   Sat, 5 Jun 2021 10:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTdZ6LiYQPi-tb95auE1K1bxJ04iDPbu03k4W-Pu5xbEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/06/2021 00:22, Chris Murphy wrote:
> On Fri, Jun 4, 2021 at 3:27 AM Gaardiolor <gaardiolor@gmail.com> wrote:
.
.
.
>> Turns out my drives aren't very cool though. 2 have >45k hours, 2 have
>>  >12k which should be kinda ok, but are SMR. Just might be that they are
>> all failing.. any idea how plausible that scenario could be ?
> 
> I can't compute the probability. It does seem unlikely. Even if it's
> something weird like all four drives are the same make/model/firmware
> and are hitting some kind of firmware bug that's in common to them?
> Rare but not impossible, perhaps even plausible. I think though, if
> you have memory bitflips, this will show up elsewhere like in-memory
> corruption unrelated to the file system, and cause weird behaviors
> including random crashing. Same if it's power induced. 

I wouldn't dismiss power problems. I had some problems on a small system
where I had added several big disks over time and had some (2 or 3)
sharing a single PSU connection. The problems went away completely when
I recabled each disk to use a separate port on the PSU.

In my case the problems looked like SCSI cable problems (command
communication errors resulting in frequent link resets) rather than data
corruption (but didn't go away when I replaced the cables and didn't
move when I swapped the data cables around) but I could easily believe
other errors could have been seen. And, of course, they were load
related - if all the disks were working at once.

I recommend avoiding sharing PSU connections. Particularly between
heavily used disks.

