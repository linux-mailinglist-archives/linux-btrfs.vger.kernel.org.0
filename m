Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A832A4D2A90
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiCIIYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiCIIYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:24:03 -0500
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42083617B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
        ; s=alpha; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=M0k/qygzamcCc8XVu7GxVynGxqXXQAw/3h1970ZP9CI=; b=h3qeJgACiG8pWE8JOnMoha3up5
        Jp6PXPpoeAxndghaoi8GflIekHmtwRatQch9M7k7qEf8z3d2lb5V8Tz8a44Nqi62nsZzmjmaTE0B8
        MZggJkmkRzC16n6RLC7q+aoOQGlJ5/78gAGIv2VHp0TFWFmbYGsiu3SrEKOQVLnkBfi02g3j87xSk
        VW9doc9L5HahvTQNPa0HkR9IIXsq+nJjkIFJXPBsUB3tI2prFcFVmUMFhxhrZMigHgdTnnoYleZOZ
        ao5eRpG4koknNvuatMJ2Glf5pyt7fDoXzk0qdomn5OCp8TYsPE+Mzbv1n2YaV+KZuaBAx/76xsePj
        ns71sVxQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
        (envelope-from <andy@strugglers.net>)
        id 1nRrb5-00059q-62; Wed, 09 Mar 2022 08:23:03 +0000
Date:   Wed, 9 Mar 2022 08:23:03 +0000
From:   Andy Smith <andy@strugglers.net>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Trying to understand duperemove failure to deduplicate
Message-ID: <20220309082303.6uzsrd3r4c2yooy2@bitfolk.com>
References: <20220309065536.djkig3d43c4uts76@bitfolk.com>
 <722c4bfb-514b-05ad-af50-f94908539a0a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722c4bfb-514b-05ad-af50-f94908539a0a@suse.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

On Wed, Mar 09, 2022 at 09:58:27AM +0200, Nikolay Borisov wrote:
> The problem is in duperemove, not btrfs. Basically in the default mode of
> operation duperemove works based on extents, however those 2 files have
> identical content but its logical structure is different 1 vs 2 extents.

Ah okay, thanks.

> Unfortunately duperemove is not able to cope with this, if you want to
> dedupe those file you should be using the block-based dedupe mode.

Is that a mode of duperemove or did you mean to use a different tool?

I saw duperemove's "--lookup-extents" option and tried with that:

$ sudo /usr/local/sbin/duperemove -b 4096 -drhv --lookup-extents=no test/daily.{0,1}/cacti/var/lib/debconf_selections
Increased open file limit from 1024 to 1048576.
Using 4K blocks
Using hash: murmur3
Using block-based hashing
Gathering file list...
Using 8 threads for file hashing phase
[1/2] (50.00%) csum: /data/backup/test/daily.0/cacti/var/lib/debconf_selections
[2/2] (100.00%) csum: /data/backup/test/daily.1/cacti/var/lib/debconf_selections
Total files:  2
Total extent hashes: 46
Loading only duplicated hashes from hashfile.
Hashing completed. Using 4 threads to calculate duplicate extents. This may take some time.
Process 2 files.
Compare files "/data/backup/test/daily.1/cacti/var/lib/debconf_selections" and "/data/backup/test/daily.0/cacti/var/lib/debconf_selections"
Compare files "/data/backup/test/daily.1/cacti/var/lib/debconf_selections" and "/data/backup/test/daily.0/cacti/var/lib/debconf_selections"
Process 2 files.
Removing overlapping extents
Simple read and compare of file data found 1 instances of extents that might benefit from deduplication.
Showing 2 identical extents of length 91.9KB with id ab62a5e4
Start           Filename
0.0B    "/data/backup/test/daily.1/cacti/var/lib/debconf_selections"
0.0B    "/data/backup/test/daily.0/cacti/var/lib/debconf_selections"
Using 8 threads for dedupe phase
[0x5597f1e7b1e0] (1/1) Try to dedupe extents with id ab62a5e4
[0x5597f1e7b1e0] Add extent for file "/data/backup/test/daily.1/cacti/var/lib/debconf_selections" at offset 0.0B (3)
[0x5597f1e7b1e0] Add extent for file "/data/backup/test/daily.0/cacti/var/lib/debconf_selections" at offset 0.0B (4)
[0x5597f1e7b1e0] Dedupe 1 extents (id: ab62a5e4) with target: (0.0B, 91.9KB), "/data/backup/test/daily.1/cacti/var/lib/debconf_selections"
Kernel processed data (excludes target files): 91.9KB
Comparison of extent info shows a net change in shared extents of: 207.7KB

This does seem to have now resulted in a deduplication:

$ filefrag -v test/daily.{0,1}/cacti/var/lib/debconf_selections
Filesystem type is: 9123683e
File size of test/daily.0/cacti/var/lib/debconf_selections is 94065 (23 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      19:     399511..    399530:     20:             encoded,shared
   1:       20..      22:     306304..    306306:      3:     399531: last,encoded,shared,eof
test/daily.0/cacti/var/lib/debconf_selections: 2 extents found
File size of test/daily.1/cacti/var/lib/debconf_selections is 94065 (23 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      19:     399511..    399530:     20:             encoded,shared
   1:       20..      22:     306304..    306306:      3:     399531: last,encoded,shared,eof
test/daily.1/cacti/var/lib/debconf_selections: 2 extents found

So now I've got 2 extents total instead of 3, and that seemed to
work, but perhaps there is a better tool.

> This is explained in duperemove's FAQ in the man page:
> 
> 
> .SS I got two identical files, why are they not deduped?

Ah right, I had missed that - the man page on duperemove's web site
is out of date but I see it in the locally-installed copy.

Thanks,
Andy
