Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF029186462
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 06:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgCPFUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 01:20:09 -0400
Received: from mail.virtall.com ([46.4.129.203]:38896 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgCPFUJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 01:20:09 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 9D6274092297;
        Mon, 16 Mar 2020 05:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1584336005; bh=hQywBCVWORXe0+x3YgcfK2yfwifUzygT+WIOoZP1lng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=F33/oIIEivs/5GUFQgljySkPJF0Uw/+rMQXivySRi0wGfmVjBqbBSlGX0OfkpJ0SI
         L43k4J09Yqw5i3Wa4xM4UOCHz0uY0qI53/tqdFd69tJT/ZEaIbtj0uOMv7BqSUoNTq
         VwRz6ym0sJmvon4TtReYZTO9CdzrRLrU4wofvLGwdzViNem4FqSoFE8Rq3p/oqq3vH
         xcafJAOByFCFyofMmvmr/3/DD+BJWmxSa3xCwzmBB2k7OmfSXct/UT83KeDVBe3ony
         V1mjvjCvTy+IhrzJRgq4Oe+XWViUvezcYzqdi7CjNTHb7y+/OOe9434GTz+SACF3lf
         5jJF2eLEQQQnA==
X-Fuglu-Suspect: 0848f067831b42b8b04febeb5063843c
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Mon, 16 Mar 2020 05:20:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Mar 2020 14:19:59 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: kernel panic after upgrading to Linux 5.5
In-Reply-To: <fa4d1bf5-b800-edba-1fce-ae7108ae023b@gmx.com>
References: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
 <fa4d1bf5-b800-edba-1fce-ae7108ae023b@gmx.com>
Message-ID: <553b4596301e2e7bfa05476065c195d0@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-16 14:06, Qu Wenruo wrote:
> On 2020/3/16 上午11:13, Tomasz Chmielewski wrote:
>> After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), the
>> system panics shortly after mounting and starting to use a btrfs
>> filesystem. Here is a dmesg - please advise how to deal with it.
>> It has since crashed several times, because of panic=10 parameter
>> (system boots, runs for a while, crashes, boots again, and so on).
>> 
>> Mount options:
>> 
>> noatime,ssd,space_cache=v2,user_subvol_rm_allowed
>> 
>> 
>> 
>> [   65.777428] BTRFS info (device sda2): enabling ssd optimizations
>> [   65.777435] BTRFS info (device sda2): using free space tree
>> [   65.777436] BTRFS info (device sda2): has skinny extents
>> [   98.225099] BTRFS error (device sda2): parent transid verify failed
>> on 19718118866944 wanted 664218442 found 674530371
>> [   98.225594] BTRFS error (device sda2): parent transid verify failed
>> on 19718118866944 wanted 664218442 found 674530371
> 
> This is the root cause, not quota.
> 
> The metadata is already corrupted, and quota is the first to complain
> about it.

Still, should it crash the server, putting it into a cycle of 
crash-boot-crash-boot, possibly breaking the filesystem even more?

Also, how do I fix that corruption?

This server had a drive added, a full balance (to RAID-10 for data and 
metadata) and scrub a few weeks ago, with no errors. Running scrub now 
to see if it shows up anything.

btrfs filesystem stats also shows no errors:

# btrfs device stats /data/lxd
[/dev/sda2].write_io_errs    0
[/dev/sda2].read_io_errs     0
[/dev/sda2].flush_io_errs    0
[/dev/sda2].corruption_errs  0
[/dev/sda2].generation_errs  0
[/dev/sdd2].write_io_errs    0
[/dev/sdd2].read_io_errs     0
[/dev/sdd2].flush_io_errs    0
[/dev/sdd2].corruption_errs  0
[/dev/sdd2].generation_errs  0
[/dev/sdc2].write_io_errs    0
[/dev/sdc2].read_io_errs     0
[/dev/sdc2].flush_io_errs    0
[/dev/sdc2].corruption_errs  0
[/dev/sdc2].generation_errs  0
[/dev/sdb2].write_io_errs    0
[/dev/sdb2].read_io_errs     0
[/dev/sdb2].flush_io_errs    0
[/dev/sdb2].corruption_errs  0
[/dev/sdb2].generation_errs  0


Tomasz Chmielewski
https://lxadm.com
