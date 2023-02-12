Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DDE6936D9
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBLKUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLKUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 05:20:25 -0500
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 02:20:23 PST
Received: from aarghimedes.fi (aarghimedes.fi [92.223.105.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987175BB1
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 02:20:23 -0800 (PST)
Received: from [192.168.2.103] (79-134-115-245.cust.suomicom.net [79.134.115.245])
        by aarghimedes.fi (Postfix) with ESMTPSA id 5D03C200FA;
        Sun, 12 Feb 2023 12:10:17 +0200 (EET)
Message-ID: <17b150a2-c817-f2fd-ec32-029bc724dc36@aarghimedes.fi>
Date:   Sun, 12 Feb 2023 12:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fi; rv:1.8.1.23)
 Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
Subject: Re: Never balance metadata?
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     waxhead@dirtcellar.net
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
 <1755726.VLH7GnMWUR@lichtvoll.de>
 <c7c1eda1-d0a9-c924-2900-9158c34fc016@gmail.com>
From:   Jukka Larja <roskakori@aarghimedes.fi>
In-Reply-To: <c7c1eda1-d0a9-c924-2900-9158c34fc016@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_50,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Andrei Borzenkov kirjoitti 11.2.2023 klo 13.42:

> Fragmented metadata chunks do not have as much impact on performance,

Although this may be very much true in general case, I do have a counter 
example:

I have a 64 TB Btrfs filesystem (RAID1, so 32 TB available) made up of eight 
HDDs of varying size (all 7200 RPM NAS disks though, so pretty similar 
performance). Every night, backups of hundreds of thousands of files are 
rsynced to file system, most of course unchanged. Some new multi-gigabyte 
video files are also backed up to another filesystem on the same computer, 
making it so that any disk caches are in unhelpful state by the morning.

Now, when I fire up my MythTV DVR computer, which likes to check if there 
are any changes to media files (some hundreds of folders with thousands of 
files, nothing major). That check used to took dozens of seconds. So long 
that MythTV sometimes gave up and reported "no files". Few months ago I 
decided to move to RAID1C3 for metadata. After balance, the everyday 
scanning for changes only takes couple of seconds. Backups are also much 
faster, though as they run during night, it doesn't much matter.

The filesystem was created June 2010 (probably) and every one of the 
original disks and some that came after have been replaced. This was the 
first time I balanced metadata, as far as I can remember. I think it does 
make sense to balance every now and then, if only once a decade :D .

-JLarja

-- 
      ...Elämälle vierasta toimintaa...
     Jukka Larja, Roskakori@aarghimedes.fi

<saylan> I just set up port forwards to defense.gov
<saylan> anyone scanning me now will be scanning/attacking the DoD :D
<renderbod> O.o
<bolt> that's... not exactly how port forwarding works
<saylan> ?
- Quote Database, http://www.bash.org/?954232 -
