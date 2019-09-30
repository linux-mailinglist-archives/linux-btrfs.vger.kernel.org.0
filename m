Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D3C1E26
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfI3Jhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 05:37:41 -0400
Received: from mail.render-wahnsinn.de ([176.9.37.177]:52578 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfI3Jhk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 05:37:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with robert.krig@render-wahnsinn.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1569836251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQqTjdX+DnJ5qooB+i5VtBz67QXpadyLbnnb4A21S7w=;
        b=PD1jlWWfsxSnn9uZp11ekDLuB++ClEjMsBCLO4X6ooiYuhquT9lYBOHLyS2epjQKp7WehE
        UjZst644v6KoigXgypBWyEdWQm2+ZThg+SjXxxl1l16Q3FQqTR0KP1IvPEuIwf7qUkBQD+
        3f3GyQxLiyN/cEeFGRtXCDQFYHm7Isr0qg4TFnQBWSdQIZ9WxtZBa7+9E5oLuq1acLKZmT
        27FkUFuR8IS5+vps0ju3gDGmi0Q4raotPC4GO3tkAj6Q22LX/IU66lqfJ1me+Bi49w6M2p
        ACl7vbdt0h1eWFL19+ltYVNWexPdxGPFe23AWH0vq6EHgXaaqKfi/1jQEc1KtQ==
Message-ID: <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
Subject: Re: BTRFS Raid5 error during Scrub.
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Nikolay Borisov <nborisov@suse.com>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Mon, 30 Sep 2019 11:37:26 +0200
In-Reply-To: <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com>
References: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
         <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=render-wahnsinn.de; s=dkim; t=1569836251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQqTjdX+DnJ5qooB+i5VtBz67QXpadyLbnnb4A21S7w=;
        b=mp1lHh/Aqn/lA+N+k2N8X5yLDz9J0lVq7+VAUcPZiR2NB/MyKD9U8HwsSuFwCuUVF2gBW9
        C8Zfetrlhpkf7IMk8njM8ZUqA1MpWcAkMElhm9/Y8Fwn+gw9YxOLdmTryUZw8yQbXlgJnH
        aEwH7RiiUDBLFMEludLtdoVpezLPc5G3/0I2sNnQGzDOsh3gGH2k5wOx0G/eXHvk9X3VSe
        T+NcB6+xe5oT+YOObIUcHoWt3xIWTJo2fL8Bj9meyhIv9v2ttDqJfPbvo7fkyvOAvpKuLq
        V4zdJQEx8I/fTXvmI3QIAaeJjujIG/JbxhrbVHaCeLmigpb/XQNodwg8xThflg==
ARC-Seal: i=1; s=dkim; d=render-wahnsinn.de; t=1569836251; a=rsa-sha256;
        cv=none;
        b=YE0fowoDfmnXeo6M2CAF/GEfKd18jznyi8QgwS1iMIXzx3NkFaKn9Azc3WNdDXmKkEoVY9
        X+cIMjsYf6khppEdp4PousvfZ2Mnan4V4Mazwe54SKEFqZ6IS2SHs8tDUfSJsSdu/dGJnU
        26ymjs/ZOBrmX/AqATAtUCXNWFEdAdhDvMqFjyFcYicnanYzdOmi9WlBRxBiRKuQIxhaie
        qlE++qo3AwNozEw0tkY6JUCpvTG4mSz71HGvHSXYjO9xN7LnG0t6x0TFCbdYZZva4jNkRh
        3H9wHa2meVv7p9SRWpQREAiaHAc2aoTzN4Iu7NbPZbfThv1e1CG/FyTiMZHdkw==
ARC-Authentication-Results: i=1;
        mail.render-wahnsinn.de;
        auth=pass smtp.mailfrom=robert.krig@render-wahnsinn.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've upgraded to btrfs-progs v5.2.1
Here is the output from btrfs check -p --readonly /dev/sda


Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: f7573191-664f-4540-a830-71ad654d9301
[1/7] checking root items                      (0:01:17 elapsed,
5138533 items checked)
parent transid verify failed on 48781340082176 wanted 109181 found
109008items checked)
parent transid verify failed on 48781340082176 wanted 109181 found
109008
parent transid verify failed on 48781340082176 wanted 109181 found
109008
Ignoring transid failure
leaf parent key incorrect 48781340082176
bad block 48781340082176
[2/7] checking extents                         (0:03:22 elapsed,
1143429 items checked)
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache                (0:05:10 elapsed, 7236
items checked)
parent transid verify failed on 48781340082176 wanted 109181 found
109008ems checked)
Ignoring transid failure
root 15197 inode 81781 errors 1000, some csum missing48 elapsed, 33952
items checked)
[4/7] checking fs roots                        (0:42:53 elapsed, 34145
items checked)
ERROR: errors found in fs roots
found 22975533985792 bytes used, error(s) found
total csum bytes: 16806711120
total tree bytes: 18733842432
total fs tree bytes: 130121728
total extent tree bytes: 466305024
btree space waste bytes: 1100711497
file data blocks allocated: 3891333279744
 referenced 1669470507008



Am Montag, den 30.09.2019, 09:01 +0300 schrieb Nikolay Borisov:
> 
> On 30.09.19 г. 0:38 ч., Robert Krig wrote:
> > Hi guys. First off, I've got backups so no worries there. I'm just
> > trying to understand what's happening and which files are affected.
> > I've got a scrub running and the kernel dmesg buffer spit out the
> > following:
> > 
> > BTRFS warning (device sda): checksum/header error at logical
> > 48781340082176 on dev /dev/sdb, physical 5651115966464: metadata
> > leaf
> > (level 0) in tree 7
> 
> This indicates you have corrupted checksum tree blocks. Concretely
> the
> checksum in the header does not match the data in the block.
> 
> > BTRFS warning (device sda): checksum/header error at logical
> > 48781340082176 on dev /dev/sdb, physical 5651115966464: metadata
> > leaf
> > (level 0) in tree 7
> > BTRFS error (device sda): bdev /dev/sdb errs: wr 0, rd 0, flush 0,
> > corrupt 0, gen 1
> > BTRFS error (device sda): unable to fixup (regular) error at
> > logical
> > 48781340082176 on dev /dev/sdb
> > BTRFS warning (device sda): checksum/header error at logical
> > 48781340082176 on dev /dev/sdc, physical 5651115966464: metadata
> > leaf
> > (level 0) in tree 7
> > BTRFS warning (device sda): checksum/header error at logical
> > 48781340082176 on dev /dev/sdc, physical 5651115966464: metadata
> > leaf
> > (level 0) in tree 7
> > BTRFS error (device sda): bdev /dev/sdc errs: wr 0, rd 0, flush 0,
> > corrupt 0, gen 1
> > BTRFS error (device sda): unable to fixup (regular) error at
> > logical
> > 48781340082176 on dev /dev/sdc
> > 
> > Is there any way I can find out which files are affected so that I
> > can
> > just restore them from a backup? 
> > 
> > I'm running Debian Buster with Kernel 5.2.
> 
> There was a known corruption issue in 5.2 kernel up to v5.2.15.
> However
> it could result in partial writes of transaction data whereas your
> report seems to indicate data has been written corrupted on-disk.
> 
> As a first step run :
> 
> btrfs check repair --readonly
> 
> (this is a read only command so it cannot do further damage) and post
> the log to see what else btrfs check finds.
> 
> > Btrfs-progs v4.20.1
> > 
> > 
> > Let me know if you need any further info.
> > 
> > 

