Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3AC2CD1E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgLCI4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:56:16 -0500
Received: from multitrading.dk ([92.246.25.51]:59782 "EHLO multitrading.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgLCI4Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 03:56:16 -0500
Received: (qmail 67399 invoked from network); 3 Dec 2020 08:55:33 -0000
Received: from multitrading.dk (HELO ?10.0.3.10?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 3 Dec 2020 08:55:33 -0000
Date:   Thu, 3 Dec 2020 09:55:29 +0100
From:   Jens Bauer <jens-lists@gpio.dk>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <20201203095529220651.9e528b11@gpio.dk>
In-Reply-To: <7851285.T7Z3S40VBb@merkaba>
References: <20201203035311997396.38ae743f@gpio.dk>
 <7851285.T7Z3S40VBb@merkaba>
Subject: Re: How robust is BTRFS?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: GyazMail version 1.5.21
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Martin.

I'm happy to hear that you have good experience with BTRFS as well. =)
-One thing I forgot to mention is that I'm also quite impressed with Western Digital's drives; they seem to last, even under such horrible conditions I put them through. ;)

It seems, after all, that one does not *have* to learn from failure. =D


Love
Jens

On Thu, 03 Dec 2020 08:59:38 +0100, Martin Steigerwald wrote:
> Jens Bauer - 03.12.20, 03:53:11 CET:
>> After correcting the problem, I got curious and listed the statistics
>> for each partition. I had more than 100000 read/write errors PER DAY
>> for 6 months. That's around 18 million read/write-errors, caused by
>> drives turning on/off "randomly".
>> 
>> AND ALL MY FILES WERE INTACT.
> 
> Awesome! Really awesome!
> 
> I am running BTRFS on a ThinkPad T520 since at least 2014. After all 
> these initial free space related issues went away with linux 4.5 or 4.6 
> I had no issues with it anymore. In part I use BTRFS RAID 1 with an 
> mSATA SSD on the laptop and it recovered from what I believe had been 
> power loss related errors on the mSATA SSD twice already. Of course that 
> is not anywhere near the dimension of errors the filesystem you have 
> experienced.
> 
> I use it on my backup drives and I use it on my server VMs.
> 
> It works for me.
> 
> Best,
> -- 
> Martin
> 
> 
