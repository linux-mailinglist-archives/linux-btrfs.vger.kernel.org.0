Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D68115AAD
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 02:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLGByK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 20:54:10 -0500
Received: from mail.virtall.com ([46.4.129.203]:40024 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfLGByK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 20:54:10 -0500
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id C5DC339AA3CD;
        Sat,  7 Dec 2019 01:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1575683648; bh=346U6GQgSg7pRRAgvTpwLkWJ1zs1qd4HqNBK38ewPak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Vp5CNASkSQVcDXrumC22mPed6CAbxLupSCZ+A/oLvOX2478qMbD00I4e2/icYfz01
         qPQuQAJfPVIa6uXpZosc30677Hr/54pB9v4y7upy/o4E7BVmoAf30q9P+hRAkKRKDx
         SCHArKXVh9NmFgzEr8AJIHa5udGXg7xvkziVtcilzG5l8o2rTSBi2Ancnv3Bu0mnLr
         RjRaCvCfJZgYYQ1OhkxuJXn+OJEeGt+I4kaiJ69uvdCiRDLd1RL+2DX2seVvL7GbzD
         StHIWSNYRXnjhkDTgqvKfq0iKFB+Fs92gwHEbcKdJur6RRusmMk54icBzStIbqBbIW
         /1CgdHB1eiVaA==
X-Fuglu-Suspect: a258d6a8715f4e138885bf8124b20dc8
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Sat,  7 Dec 2019 01:54:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Dec 2019 10:54:06 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 100% disk usage reported by "df", 60% disk usage reported by
 "btrfs fi usage" - this breaks userspace behaviour
In-Reply-To: <CAJCQCtTB8oKnG0kAkYC_wCvVE1WBYHrAYhWoZR5zKsmGgut6AA@mail.gmail.com>
References: <eb9cfb919176c239d864f78e5756f1db@wpkg.org>
 <CAJCQCtQ9Vg9VuT66diid6KdRMDqicxj9xLigTBF4sbMgqD=5jQ@mail.gmail.com>
 <c768a339fee28c7b4296d94b02beff12@wpkg.org>
 <CAJCQCtTB8oKnG0kAkYC_wCvVE1WBYHrAYhWoZR5zKsmGgut6AA@mail.gmail.com>
Message-ID: <5b5f51dacbb44eb0318c136564c19364@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-12-07 10:05, Chris Murphy wrote:
> On Fri, Dec 6, 2019 at 5:47 PM Tomasz Chmielewski <mangoo@wpkg.org> 
> wrote:
>> 
>> On 2019-12-06 12:54, Chris Murphy wrote:
>> 
>> > What version of coreutils?
>> 
>> This is Ubuntu 18.04 LTS, with coreutils 8.28.
>> 
>> 
>> > Maybe attach a strace of df? (I'm not sure of the list attach size
>> > limit but it's preferred, but something like a pastebin is OK also)
>> 
>> "Unfortunately" I did run a balance, which "recovered" the space for 
>> df.
> 
> Still an interesting data point.

Well, there is some crap there... it went read-only.

[164625.770369] BTRFS info (device nvme1n1): found 683 extents
[164630.127647] BTRFS info (device nvme1n1): relocating block group 
345766887424 flags data
[164650.186985] BTRFS info (device nvme1n1): found 4268 extents
[164658.075685] BTRFS info (device nvme1n1): found 4266 extents
[164663.979192] BTRFS info (device nvme1n1): relocating block group 
344693145600 flags data
[164686.646073] BTRFS info (device nvme1n1): found 3721 extents
[164696.815655] BTRFS: error (device nvme1n1) in 
btrfs_drop_snapshot:5402: errno=-4 unknown
[164696.821925] BTRFS info (device nvme1n1): forced readonly
[164696.834151] BTRFS warning (device nvme1n1): could not allocate space 
for delete; will truncate on mount
[164696.834162] BTRFS info (device nvme1n1): balance: ended with status: 
-4
[164697.468475] BTRFS info (device nvme1n1): delayed_refs has NO entry


Tomasz Chmielewski
https://lxadm.com
