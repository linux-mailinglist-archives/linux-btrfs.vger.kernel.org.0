Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2A7A2229
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjIOPS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbjIOPSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 11:18:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E8C1FCC
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 08:18:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 322131FD72;
        Fri, 15 Sep 2023 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694791079;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uU6INzJdgqjXUWszBnsMQVVBD5FGGQxxhowXXXxARsE=;
        b=eaXORgM03RBpGYjEU+lCWaV4RrnUjXpZafBIdUvetcgPHwg6hImD8KKh7jBlmuwmZLZWsu
        d9XlUzbP5mulcFSqjD5Ru5I7v+ZeFUC1+XpmgS3ll6FOdBUtMYnv2nUqKMSkBTPjyjliqE
        6Pz+iP2w+ir8T7+N3PuExaOUTYPxWKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694791079;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uU6INzJdgqjXUWszBnsMQVVBD5FGGQxxhowXXXxARsE=;
        b=A6qzvN32PBrcoJq7NKiRwFruzKKcZwzxh0phnIeVtHBWuBUYRzBTb7YTrUh3Jstr4+4DwX
        mnp6TVF+PsqiDyDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C6901358A;
        Fri, 15 Sep 2023 15:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C+NTAqd1BGXtFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 15:17:59 +0000
Date:   Fri, 15 Sep 2023 17:11:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Malte Schumacher <s.schumacher@netcologne.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Massive filesystem errors - possible new HDD
Message-ID: <20230915151125.GC2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAA3ktqmgtdDGsubOiCZR+vS=5J3Wf2Hu8vi-t1z48zZB18mC0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA3ktqmgtdDGsubOiCZR+vS=5J3Wf2Hu8vi-t1z48zZB18mC0A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 12:31:44PM +0200, Stefan Malte Schumacher wrote:
> Hello,
> 
> I have some serious problems with my btrfs-filesystem. It started with
> a smart error and "btrfs fi show" reporting the drive as missing about
> once every two weeks. The error went away after a reboot.
> 
> Device: /dev/sda [SAT], unable to open ATA device
> Device info: WDC  WUH722020ALE6L4, S/N:2LG7DJJK,
> WWN:5-000cca-2b3c35da5, FW:PQGNW108, 20.0 TB
> 
> This is the latest hard disk I bought about four weeks ago.Half an
> hour ago I got the error message again, switched the monitor input to
> my file server and watched it boot. Booting  produced some serious
> btrfs errors, but would finish. The filesystem is mounted and I can
> create files on it, but dmesg shows massive errors. I have pasted a
> selection of the errors after my message.
> 
> Is this - in your opinion - a logical error of the filesystem or
> should I immediately exchange the new drive?

This kind of errors looks like problem on the hardware side, here the
filesystem is merely detecting that. It could be caused by loose cables
if the device disappears or controller or the disk itself, depending on
the load.

> Should I try to scrub my
> data? I have a backup but it's rather recent, meaning it could include
> corrupted files because I also bought a new NAS in addition to the new
> drive for the fileserver since I urgently needed space on both. Note:
> The former /dev/sda now is /dev/sdb after the reboot.

Better not use it for other purposes than to read the remaining data.

> Thanks in advance and yours faithfully
> Stefan Malte Schumacher
> 
> Errors from journalctl. Repeat probably from the point the drive was
> not recognized any more.
> Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
> errs: wr 176296937, rd 88151246, flush 477, corrupt 0, gen 0
> Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
> errs: wr 176296938, rd 88151246, flush 477, corrupt 0, gen 0
> Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
> errs: wr 176296938, rd 88151247, flush 477, corrupt 0, gen 0
> Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
> errs: wr 176296938, rd 88151248, flush 477, corrupt 0, gen 0
> Sep 15 11:49:59 mars kernel: BTRFS error (device sdc): bdev /dev/sda
> errs: wr 176296939, rd 88151248, flush 477, corrupt 0, gen 0

Lots of missed writes and reads, plus some flush errors (ie. failed
super block writes.

> Sep 15 11:49:59 mars kernel: scrub_handle_errored_block: 16462
> callbacks suppressed
> Sep 15 11:49:59 mars kernel: BTRFS warning (device sdc): i/o error at
> logical 104647456002048 on dev /dev/sda, physical 3193421500416, root
> 5, inode 7253233, offset 67033587712, length 4096, links 1 (path:
> Film>
> Sep 15 11:49:59 mars kernel: BTRFS warning (device sdc): i/o error at
> logical 104647456100352 on dev /dev/sda, physical 3193421598720, root
> 5, inode 7253233, offset 67033686016, length 4096, links 1 (path:
> Film>
> Sep
> 
> dmesg after reboot:
> [  128.675658] BTRFS warning (device sdc): super block error on device
> /dev/sdb, physical 65536
> [  128.675674] BTRFS error (device sdc): bdev /dev/sdb errs: wr
> 177062143, rd 88533832, flush 479, corrupt 1, gen 0
> [  128.683734] BTRFS warning (device sdc): super block error on device
> /dev/sdb, physical 67108864
> [  128.684228] BTRFS error (device sdc): bdev /dev/sdb errs: wr
> 177062143, rd 88533832, flush 479, corrupt 2, gen 0
> [  128.687400] BTRFS warning (device sdc): super block error on device
> /dev/sdb, physical 274877906944
> [  128.687956] BTRFS error (device sdc): bdev /dev/sdb errs: wr
> 177062143, rd 88533832, flush 479, corrupt 3, gen 0

Here corrupt means that garbage was read from the disk, which could mean
that the sector was eg. zeroed (like replaced from the internal HDD
pool) or stale data found, or crc mismatch.

> [  128.688552] BTRFS info (device sdc): scrub: started on devid 8
> [  128.688561] BTRFS info (device sdc): scrub: started on devid 9
> [  128.688596] BTRFS info (device sdc): scrub: started on devid 10
> [  128.709283] BTRFS info (device sdc): scrub: started on devid 11
> [  128.709320] BTRFS info (device sdc): scrub: started on devid 12
> [  128.720429] BTRFS warning (device sdc): super block error on device
> /dev/sdc, physical 274877906944
> [  128.721452] BTRFS error (device sdc): bdev /dev/sdc errs: wr 0, rd
> 0, flush 0, corrupt 1, gen 0
> [  128.723426] BTRFS warning (device sdc): super block error on device
> /dev/sdc, physical 67108864
> [  128.724651] BTRFS error (device sdc): bdev /dev/sdc errs: wr 0, rd
> 0, flush 0, corrupt 2, gen 0
> [  160.484366] BTRFS error (device sdc): space cache generation
> (1395658) does not match inode (1395902)
> [  209.258959] BTRFS warning (device sdc): failed to load free space
> cache for block group 49783599267840, rebuilding it now
> [  210.267125] BTRFS error (device sdc): space cache generation
> (1395658) does not match inode (1395664)
> [  210.272770] BTRFS warning (device sdc): failed to load free space
> cache for block group 53557835333632, rebuilding it now
> [  210.333332] BTRFS warning (device sdc): failed to load free space
> cache for block group 53599711264768, rebuilding it now
> [  210.682350] BTRFS warning (device sdc): failed to load free space
> cache for block group 53763993763840, rebuilding it now
> [  210.693379] BTRFS warning (device sdc): failed to load free space
> cache for block group 53766141247488, rebuilding it now
> [  211.035247] BTRFS warning (device sdc): failed to load free space
> cache for block group 53904653942784, rebuilding it now
> [  212.349634] BTRFS warning (device sdc): failed to load free space
> cache for block group 54425418727424, rebuilding it now
> [  212.760877] io_ctl_check_generation: 5 callbacks suppressed
> [  212.760887] BTRFS error (device sdc): space cache generation
> (1395658) does not match inode (1396097)
> [  212.768138] BTRFS warning (device sdc): failed to load free space
> cache for block group 54615471030272, rebuilding it now

The free space load warnings are just a consequence of previous errors,
it's recoverable but at this point the HDD/filesystem has worse
problems.
