Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26251A020
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350004AbiEDNDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 09:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350129AbiEDNDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 09:03:31 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BF73CFF9
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:59:54 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id A20FB82E88
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 14:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651669192;
        bh=FAGX+LvqH7AUi8mmBDFb9xA9kLi07bpoinqPCTITnk8=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=QY77ikD1jwfLhyGeI9VEVQPX577H0HTO9VTieT1Ew9oyGUOH5AB884RLMeU08vOSH
         CNh3h8xx/ENCBwZI+pK2m3KHDmDVbpGKyEwqog9MiYlJ10/B2PEG9V2zEEpaGriVxY
         4ejcxJ0mvg3swpSmWMeUx917wB9UCb3Bepkz+JWSA6vW4yS9fE1vti6cquVbw2IYia
         ezj+1JnAk6ATsjRJsBk1locQE6TLodhAi3KmZyfPXjuBG7uoXHyU8rN5B/ivlcKbh7
         fH2dbu654ouEUB0Et35Z2VwuIt/qtfP+8NYYB8kgqHWayc+VlEumhoFh9qTIPTnBB0
         6nw8vIS8/gp2A==
Date:   Wed, 4 May 2022 14:59:51 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-Id: <20220504145951.93293c35de0a7a6c464e12c5@lucassen.org>
In-Reply-To: <83b2f5df-fc16-627d-85b4-af07bac9a73b@knorrie.org>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
        <83b2f5df-fc16-627d-85b4-af07bac9a73b@knorrie.org>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 4 May 2022 14:06:31 +0200
Hans van Kranenburg <hans@knorrie.org> wrote:

> > Still new to btrfs, I try to set up a system that is capable of
> > booting even if one of the two disks is removed or broken. The BIOS
> > supports this.
> > 
> > As the Debian installer is not capable of installing btrfs raid1, I 
> > installed Bullseye using /dev/md0 for /boot (ext2) and a / btrfs on
> > /dev/sda3. This works of course. After install I added /dev/sdb3 to
> > the / fs: OK.
> 
> Did you 'just' add the disk to the filesystem, or did you also do a
> next step of converting the existing data to the raid1 profile?

AFAIK this is what I need to do to convert sda3 mounted on / to a
raid1 using sda3/sdb3:

btrfs device add /dev/sdb3 /
btrfs balance start -dconvert=raid1 -mconvert=raid1 /

> If you start out with 1 disk and simply add another, it tells btrfs
> that it can continue writing just 1 (!) copy of your data wherever it 
> likes. And, in this case, the filesystem *always* wants (needs!) all 
> disks to be present to mount, of course.
> 
> disk 1  disk 2
> A       C
> B       E
> D
> 
> If you want everything duplicated on both disks, you need to convert
> the existing data that you already had on the first disk to the raid1 
> profile, and from then on, it will keep writing 2 copies of the data
> on any two disks in the filesystem (but you have exactly 2, so it's
> always on both of those two in that case).
> 
> disk 1  disk 2
> A       D
> B       B
> D       C
> C       A
> 
> If the previous installed system still works well when you add back
> the second disk again, you can still do this. (so, when you did not
> force any destructive operations, and just had it fail like seen
> below)
> 
> Can you share output of the following commands:
> 
> btrfs fi usage <mountpoint>
> 
> With the following command you let it convert all (d)ata and
> (m)etadata to the raid1 profile:
> 
> btrfs balance start -dconvert=raid1 -mconvert=raid1 /

That's what I did

> Afterwards, you can check the result with the usage command. The
> data, metadata, and system lines in the output of the usage command
> should all say RAID1, and you should see that on both disks, a
> similar amount of data is present.

Just chose the grub boot option "Debian 11 on sda6" (an older install),
this works but in fact this seems to be the sda3/sdb3 raid1. I must have
messed up grub somewhere:

btrfs filesystem show
Label: none  uuid: f9cf579f-d3d9-49b2-ab0d-ba258e9df3d8
        Total devices 2 FS bytes used 1.15GiB
        devid    1 size 16.00GiB used 2.28GiB path /dev/sda3
        devid    2 size 16.00GiB used 2.28GiB path /dev/sdb3

Label: none  uuid: 1739f989-05e0-48d8-b99a-67f91c18c892
        Total devices 2 FS bytes used 448.00KiB
        devid    1 size 16.00GiB used 2.57GiB path /dev/sda5
        devid    2 size 16.00GiB used 2.56GiB path /dev/sdb5

Label: 'data'  uuid: 3173a224-830f-41d7-8870-3db0e8c986c9
        Total devices 2 FS bytes used 1020.38MiB
        devid    1 size 187.32GiB used 2.01GiB path /dev/sda6
        devid    2 size 187.32GiB used 2.01GiB path /dev/sdb6

I will first clean up all the mess I created.

"There are two types of people: those who have lost data and those who
will" :-)

R.

-- 
richard lucassen
https://contact.xaq.nl/
