Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A354D292D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 07:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiCIG4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 01:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiCIG4i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 01:56:38 -0500
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86D616113D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
        ; s=alpha; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender
        :Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xAfuDEV6Lc4BXsGnvxfr4LtT57x8pLsy9CIFBe1vlRs=; b=n4/dSKHTY9WvNWHDCkLWuewoSq
        vNELgclIdIGheaNdfp411W6WAD8qEeX49koGsL01lgF+y4FULyWJnxgOxtC+eHded5Vylc5u8mLtV
        ++fUjxpzbZ4DKO4iL1Z3F4dgB+txpAXk+y0bdtrdixxSIV/sewqwBzeawFNnqWNtoBAURtDqjZQ/j
        +j5cfRgcH96kpbJBEE51+PrB+RKqHJXyR2rt9XOYpXp312kseHNGKl6fhPWbEBmxWaA+QvyXZGaLW
        1A8qOtmAPgn7k0UQ0Jpw8YBhf+4S55F8MT5h/HYWF0/hagXVU8zSO/fCZGj575g87gjHlzZLCcVRX
        l1aVFRUg==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
        (envelope-from <andy@strugglers.net>)
        id 1nRqES-0000vk-T8
        for linux-btrfs@vger.kernel.org; Wed, 09 Mar 2022 06:55:36 +0000
Date:   Wed, 9 Mar 2022 06:55:36 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-btrfs@vger.kernel.org
Subject: Trying to understand duperemove failure to deduplicate
Message-ID: <20220309065536.djkig3d43c4uts76@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

I was hoping to use duperemove to dedupe a set of large backups on a
btrfs fs.

I did a test run and saw hardly any savings. I expected several
hundred GB to be found; duperemove actually reported about 98GB but
"df" only shows around 30GB. So I looked a bit harder.

FS mount options:

/dev/mapper/backupenc /data/backup btrfs rw,noatime,compress=zstd:15,space_cache,subvolid=5,subvol=/ 0 0

Kernel version 5.10.0-11-amd64, Debian 11.

Take for example these two files:

$ stat daily.{0,1}/cacti/var/lib/debconf_selections 
  File: daily.0/cacti/var/lib/debconf_selections
  Size: 94065           Blocks: 184        IO Block: 4096   regular file
Device: 26h/38d Inode: 136346107   Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-01-26 01:45:24.281602018 +0000
Modify: 2019-11-12 08:25:03.528065556 +0000
Change: 2022-03-08 11:28:27.862447446 +0000
 Birth: 2022-03-08 11:28:27.834447672 +0000
  File: daily.1/cacti/var/lib/debconf_selections
  Size: 94065           Blocks: 184        IO Block: 4096   regular file
Device: 26h/38d Inode: 134478113   Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-01-26 01:45:24.281602018 +0000
Modify: 2019-11-12 08:25:03.528065556 +0000
Change: 2022-03-07 20:37:22.993579274 +0000
 Birth: 2022-03-07 20:37:22.993579274 +0000

They have identical content:

$ md5sum daily.{0,1}/cacti/var/lib/debconf_selections 
c5633915f9d847394a6640c77c55f83a  daily.0/cacti/var/lib/debconf_selections
c5633915f9d847394a6640c77c55f83a  daily.1/cacti/var/lib/debconf_selections

They don't currently share extents:

$ filefrag -v daily.[01]/cacti/var/lib/debconf_selections
Filesystem type is: 9123683e
File size of daily.0/cacti/var/lib/debconf_selections is 94065 (23 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      22:  374427125.. 374427147:     23:             last,encoded,eof
daily.0/cacti/var/lib/debconf_selections: 1 extent found
File size of daily.1/cacti/var/lib/debconf_selections is 94065 (23 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..      19:     399511..    399530:     20:             encoded,shared
   1:       20..      22:     306304..    306306:      3:     399531: last,encoded,shared,eof
daily.1/cacti/var/lib/debconf_selections: 2 extents found

So I would expect if I ran duperemove on these two files it would
work out that these 3 extents could be replaced by 1 or 2. But:

$ sudo /usr/local/sbin/duperemove -b 4096 -drhv daily.{0,1}/cacti/var/lib/debconf_selections
Increased open file limit from 1024 to 1048576.
Using 4K blocks
Using hash: murmur3
Using extent-based hashing
Gathering file list...
Using 8 threads for file hashing phase
[1/2] (50.00%) csum: /data/backup/daily.0/cacti/var/lib/debconf_selections
[2/2] (100.00%) csum: /data/backup/daily.1/cacti/var/lib/debconf_selections
Total files:  2
Total extent hashes: 3
Loading only duplicated hashes from hashfile.
Found 0 identical extents.
Simple read and compare of file data found 0 instances of extents that might benefit from deduplication.
Nothing to dedupe.

Am I misunderstanding something about how dedupe works in btrfs, or
duperemove itself?

Is it because this filesystem has compression enabled? Though after
reading the earlier really useful reply from Zygo about dedupe and
compression I had thought this wasn't going to be much of an issue
with duperemove.

I haven't yet tried bees to see if it sees things differently.

Thanks,
Andy
