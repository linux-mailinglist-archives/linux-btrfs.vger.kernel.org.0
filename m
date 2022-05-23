Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1C5319CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 22:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiEWSwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 May 2022 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbiEWSwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 May 2022 14:52:06 -0400
X-Greylist: delayed 4608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 11:39:18 PDT
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78210167CA
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 11:39:18 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1653326504; bh=/iJDHKmUCBPG8n5yPvuETXJc3TFRbADeHGb/9SqrqcA=;
        h=Date:From:To:Subject:From;
        b=QZWCb7R39Wgpu3CXhfFFshBXvF7yJh5X1FZEc2W3oilFrHjWAoOlu7yPlvt8RKBpG
         QOVHfLGpHCu4IcVRevYLS8OyPXnzBtt/voioB55iGESPhY1tPQTYHDYcj6ElGv0Wl5
         //TU2qHzkrwtBL4XhSk8WP24GAi3+21U9IbAFSZtMjcH+AM4TCKxrMEMZPx9ZMY4c6
         AowfQ6dqLHJt2b6EoDTsy6pqa+tdgidQOe0aZibmR7Vg7rSF+DqZ9jjqgLKBjxv4oJ
         U0bpxjqxhWU/rZoeETDpF6aBwHQPCz9tPBVd12fJ2KXxWZ3pTrrcsdB886pbkDddtH
         fnXCFuo8g9s6w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 May 2022 18:21:40 +0100
From:   efkf@firemail.cc
To:     linux-btrfs@vger.kernel.org
Subject: Tried to replace a drive in a raid 1 and all hell broke loose
Message-ID: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
X-Sender: efkf@firemail.cc
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, this is my first time interacting with a mailing list and the 
first time actually using btrfs.

THE CURRENT SITUATION:
I think I have two working drives with dm-crypt in what i think is raid 
1
when booted on a either fedora live disk or debian testing i can mount 
the filesystem but check fails and scrub aborts.
    -= FEDORA =-
The first time i scrub i get this on the kernel log: ( attachment 
fedora_scrub_1 )
i unmounted, mounted and scrubbed again and got a different error: ( 
attachment fedora_scrub_2 )
check says this: ( attachment fedora_check )
This is the distro info: ( attachment fedora_info ))

  -= DEBIAN TESTING =-
The first time i scrub i get this on the kernel log: ( attachment 
debian_scrub1 )
I unmounted and got a call trace and register dump on the kernel log: ( 
attachment debian_unmount )
i mounted and scrubbed again and got a similar error to fedora's second 
scrub: ( attachment debian_scrub2 )
check says the same thing
This is the distro info: ( attachment debian_info )

THE BACKSTORY:
here is a timeline of the events that lead up to this
(by the way, all of this was done with clean unmounts and reboots)
  [ Using debian stable btrfs-progs 5.10.1-2 ]
- Btrfs raid 1 works great srubs ok with 2 drives
- One drive starts dying, i get one to replace it
- Add the new one to the array (with all three plugged in) (i now know i 
should've use replace instead)
- run btrfs balance (with all three again)
- tried to delete the drive but failed (around this time i started 
running into weird errors)
- updated debian to testing, updated kernel, rebooted ( btrgs-progs 
5.10.1-2 -> 5.17-1 )
- managed to remove the failing drive (not sure if the update helped)
- Have to mount degraded and check shows a lot of errors
- bite the bullet and run check --repair, it says it is fixing errors 
and at the end it says no errors
- run just check again and get the same errors as before roughly
- run check --repair again, gets stuck in what seems to be an infinite 
loop. Says its fixing the same things again and again
- joined the irc channel to ask for help
- send sigterm to btrfs check --repair ( no one had replied by then)
- it actually mounts without needing -o degraded now
- get told to run 'btrfs fi us -T /mnt' and realize that i have both 
raid1 and some small single chunks
- run btrfs balance start -mconvert=raid1,soft -dconvert=raid1,soft /mnt
- btrfs check shows much less errors and all single chunks are gone ( 
the btrfs check output at that point is attached as old_completing_check 
on the email )
- try to run scrubs, they abort
- check and there are some single chunks yet again
- try fedora, run check and it gives the error i have attached and 
doesn't go through with actually checking everything
- try debian again and now checking doesn't complete with the same error 
as in fedora
I also tried running 'btrfs balance start -mconvert=raid1,soft 
-dconvert=raid1,soft /mnt' again now and the first time I run it, it 
says
ERROR: error during balancing '/mnt/sd': No such file or directory
and it the second time
ERROR: error during balancing '/mnt/sd': Read-only file system

Thanks a lot for reading my email and sorry if it winds up being 
something not related to btrfs
