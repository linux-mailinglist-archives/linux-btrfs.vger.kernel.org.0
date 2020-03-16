Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475C9186AB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgCPMOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 08:14:25 -0400
Received: from mail.virtall.com ([46.4.129.203]:37384 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbgCPMOZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 08:14:25 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id AB63C409B0CD;
        Mon, 16 Mar 2020 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1584360861; bh=qBsYaZJWgaJV/6vdliZQyqFEAEWqULdLizsBkecKTy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=P7D3BmZtAzWUQVgERreYDatW9j1XV85im50/oegAEmsCg8L028Zg8SItaSLigL3+J
         itIANa313joMz4Weg411Gi3DYXaw9gfo4RIJPkCJBTO0VmlCXWztkSUgMkTS4jsb8Z
         o3E0WVxWih4py4Z523FNjSr85oLZJLXQHJZIT1+8c7q4k/Cqi753QW/qwSt3Yb3e82
         8RzN7I0o3tF9WeP6Bkda9Jzx6U9LKgKmZM0BHPtXRQsDeQNvF/fqTyKbnWxTGefs3L
         iO3EAMiatqvVDC6rFww3twpdR063FBGBl5PvDdLTEi1DFNDAp0j2P73+sEYpI+l6JZ
         IjNNDqkO9aSMg==
X-Fuglu-Suspect: 0bcf401879dc4959b3c2a108bac74d53
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Mon, 16 Mar 2020 12:14:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Mar 2020 21:14:14 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: kernel panic after upgrading to Linux 5.5
In-Reply-To: <9711f986-0083-0866-68b7-f1cd8e35db11@gmx.com>
References: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
 <fa4d1bf5-b800-edba-1fce-ae7108ae023b@gmx.com>
 <553b4596301e2e7bfa05476065c195d0@wpkg.org>
 <9711f986-0083-0866-68b7-f1cd8e35db11@gmx.com>
Message-ID: <910611ad09d3efb53b13b77bf3c4d99c@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-16 19:26, Qu Wenruo wrote:
> On 2020/3/16 下午1:19, Tomasz Chmielewski wrote:
>> On 2020-03-16 14:06, Qu Wenruo wrote:
>>> On 2020/3/16 上午11:13, Tomasz Chmielewski wrote:
>>>> After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), 
>>>> the
>>>> system panics shortly after mounting and starting to use a btrfs
>>>> filesystem. Here is a dmesg - please advise how to deal with it.
>>>> It has since crashed several times, because of panic=10 parameter
>>>> (system boots, runs for a while, crashes, boots again, and so on).
>>>> 
>>>> Mount options:
>>>> 
>>>> noatime,ssd,space_cache=v2,user_subvol_rm_allowed
>>>> 
>>>> 
>>>> 
>>>> [   65.777428] BTRFS info (device sda2): enabling ssd optimizations
>>>> [   65.777435] BTRFS info (device sda2): using free space tree
>>>> [   65.777436] BTRFS info (device sda2): has skinny extents
>>>> [   98.225099] BTRFS error (device sda2): parent transid verify 
>>>> failed
>>>> on 19718118866944 wanted 664218442 found 674530371
>>>> [   98.225594] BTRFS error (device sda2): parent transid verify 
>>>> failed
>>>> on 19718118866944 wanted 664218442 found 674530371
>>> 
>>> This is the root cause, not quota.
>>> 
>>> The metadata is already corrupted, and quota is the first to complain
>>> about it.
>> 
>> Still, should it crash the server, putting it into a cycle of
>> crash-boot-crash-boot, possibly breaking the filesystem even more?
> 
> The transid mismatch in the first place is the cause, and I'm not sure
> how it happened.
> 
> Did you have any history of the kernel used on that server?
> 
> Some potential corruption source includes the v5.2.0~v5.2.14, which
> could cause some tree block not written to disk.

Yes, it used to run a lot of kernel, starting with 4.18 or perhaps even 
earlier.


>> Also, how do I fix that corruption?
>> 
>> This server had a drive added, a full balance (to RAID-10 for data and
>> metadata) and scrub a few weeks ago, with no errors. Running scrub now
>> to see if it shows up anything.
> 
> Then at least at that time, it's not corrupted.
> 
> Is there any sudden powerloss happened in recent days?
> Another potential cause is out of spec FLUSH/FUA behavior, which means
> the hard disk controller is not reporting correct FLUSH/FUA finish.
> 
> That means if you use the same disk/controller, and manually to cause
> powerloss, it would fail just after several cycle.

Powerloss - possibly there was.


Tomasz
