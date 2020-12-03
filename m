Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8912CCCED
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 04:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgLCDAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 22:00:35 -0500
Received: from multitrading.dk ([92.246.25.51]:59763 "EHLO multitrading.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgLCDAf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 22:00:35 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 22:00:34 EST
Received: (qmail 67050 invoked from network); 3 Dec 2020 02:53:12 -0000
Received: from multitrading.dk (HELO ?10.0.3.10?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 3 Dec 2020 02:53:12 -0000
Date:   Thu, 3 Dec 2020 03:53:11 +0100
From:   Jens Bauer <jens-lists@gpio.dk>
To:     linux-btrfs@vger.kernel.org
Message-ID: <20201203035311997396.38ae743f@gpio.dk>
Subject: How robust is BTRFS?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: GyazMail version 1.5.21
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all.

The BTRFS developers deserves some credit!

This is a testimony from a BTRFS-user.
For a little more than 6 months, I had my server running on BTRFS.
My setup was several RAID-10 partitions.
As my server was located on a remote island and I was about to leave, I just added two more harddisks, to make sure that the risk of failure would be minimal. Now I had four WD10JFCX on the EspressoBIN server running Ubuntu Bionic Beaver.

Before I left, I *had* noticed some beep-like sounds coming from one of the drives, but it seemed OK, so I didn't bother with it.

So I left, and 6 months later, I noticed that one of my 'partitions' were failing, so I thought I might go back and replace the failing drive. The journey takes 6 hours.

When I arrived, I noticed more beep-like sounds than when I left half a year earlier.
But I was impressed that my server was still running.

I decided to make a backup and re-format all drives, etc.

The drives were added in one-by-one, and I noticed that when I added the third drive, again I started hearing that sound I disliked so much.

After replacing the port-multiplier, I didn't notice any difference.

"The power supply!" I thought.. Though it's a 3A PSU and should easily handle four 2.5" WS10JFCX drives, it could be that the specs were possibly a little decorated, so I found myself a MeanWell IRM-60-5ST supply and used that instead.

Still the same noise.

I then investigated all the cables; lo and behold, silly me had used a china-pigtail for a barrel-connector, where the wires on the pigtail were so incredibly thin that they could not carry the current, resulting in the voltage being lowered the more drives I added.

I re-did my power cables and then everything worked well.

...

After correcting the problem, I got curious and listed the statistics for each partition.
I had more than 100000 read/write errors PER DAY for 6 months.
That's around 18 million read/write-errors, caused by drives turning on/off "randomly".

AND ALL MY FILES WERE INTACT.

This is on the border to being impossible.

I believe that no other file system would be able to survive such conditions.
-And the developers of this file system really should know what torture it's been through without failing.
Yes, all files were intact. I tested all those files that I had backed up 6 months earlier against against those that were on the drives; there were no differences - they were binary identical.

Today, my EspressoBIN + JMB575 port multiplier + four WD20JFCX drives are doing well. No read/write errors have occurred since I replaced my power cable. I upgraded to Focal Fossa and the server has become very stable and usable. I will not recommend the EspressoBIN (I bought two of them and one is failing periodically); instead I'll recommend Solid-Run's products, which are top-quality and well-tested before shipping.

So this testimony will hopefully encourage others to use BTRFS.
Besides a robust file system, you get a file system that's absolutely rapid (I'm used to HFS+ on a Mac with a much faster CPU - but BTRFS is still a lot faster).
You also get real good tools for manipulating the file system and you can add / remove drives on-the-fly.

Thank you to everyone who worked tirelessly on BTRFS - and also thank you to those who only contributed a correction of a spelling-mistake. Everything counts!


Love
Jens
