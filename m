Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C33D1562
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhGURGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 13:06:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbhGURGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 13:06:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 720D322549;
        Wed, 21 Jul 2021 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626889634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5d4M2H+hutp1cwW5yrQIoNhg++/8raLllT9JFjUJRY=;
        b=Gf1NqZaq69ziJFVhf6wq/jC/cBbeSknKmDEcyMUOWJBmS2LTciXO1gjL4YMlBHRDJe1Ctf
        dqDjfgjm96g3L8yZ3xAPwJitXTKmZlbIqj010BSHYqLfFNQYQ7RlbQjRUM4Ka/xB47hr8p
        g226074i0Gy5ZxgDtOTflMQGMVJS2rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626889634;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5d4M2H+hutp1cwW5yrQIoNhg++/8raLllT9JFjUJRY=;
        b=F181IRp6NiISID6sZEXwyMipICFdgCjHtwWaEdVhJYoN6/WKJOfxQ5jA0TWv0+RaJIGVIn
        gQ8h+7f6mA6BqWAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 53D15A3B90;
        Wed, 21 Jul 2021 17:47:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 277A7DA704; Wed, 21 Jul 2021 19:44:33 +0200 (CEST)
Date:   Wed, 21 Jul 2021 19:44:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jorge Bastos <jorge.mrbastos@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: "bad tree block start, want 419774464 have 0" after a clean
 shutdown, could it be a disk firmware issue?
Message-ID: <20210721174433.GO19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 16, 2021 at 11:44:21PM +0100, Jorge Bastos wrote:
> Hi,
> 
> This was a single disk filesystem, DUP metadata, and this week it stop
> mounting out of the blue, the data is not a concern since I have a
> full fs snapshot in another server, just curious why this happened, I
> remember reading that some WD disks have firmware with write caches
> issues, and I believe this disk is affected:
> 
> Model family:Western Digital Green
> Device model:WDC WD20EZRX-00D8PB0
> Firmware version:80.00A80

For the record summing up the discussion from IRC with Zygo, this
particular firmware 80.00A80 on WD Green is known to have problematic
firmware and would explain the observed errors.

Recommendation is not to use WD Green or periodically disable the write
cache by 'hdparm -W0'.

> SMART looks mostly OK, except "Raw read error rate" is high, which in
> my experience is never a good sign on these disks, but I didn't get
> any read errors so far, also no unclean shutdown, it was working
> normally last time I mounted it, and after a clean shutdown, probably
> just after deleting some snapshots, I now get this:
> 
> Jul 16 23:27:38 TV1 emhttpd: shcmd (129): mount -t btrfs -o
> noatime,nodiratime /dev/md20 /mnt/disk20
> Jul 16 23:27:38 TV1 kernel: BTRFS info (device md20): using free space tree
> Jul 16 23:27:38 TV1 kernel: BTRFS info (device md20): has skinny extents
> Jul 16 23:27:38 TV1 kernel: BTRFS error (device md20): bad tree block
> start, want 419774464 have 0

When the 'have' values are zeros it means the blocks were empty so eg.
trimmed, or not written at all.

> Jul 16 23:27:38 TV1 kernel: BTRFS error (device md20): bad tree block
> start, want 419774464 have 0
> Jul 16 23:27:38 TV1 kernel: BTRFS warning (device md20): failed to
> read root (objectid=2): -5
> 
> Kernel is kind of old, 4.19.107, but there are 21 more btrfs file
> systems on this server, some using identical disks and no issues for a
> long time until now, btrfs check output:
> 
> ~# btrfs check /dev/md20
> Opening filesystem to check...
> checksum verify failed on 419774464 found 000000B6 wanted 00000000
> checksum verify failed on 419774464 found 00000058 wanted 00000000
> checksum verify failed on 419774464 found 000000B6 wanted 00000000
                                            ^^^^^^^^

This is an artifact of incorrectly printed checksums, fixed in
btrfs-progs v5.11.1

> bad tree block 419774464, bytenr mismatch, want=419774464, have=0
> ERROR: could not setup extent tree
> ERROR: cannot open file system
> 
> Could this type of error be explained by a bad disk firmware?
