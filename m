Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C091B1DC1A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgETVy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 17:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgETVy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 17:54:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA8C061A0E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 14:54:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s8so4656108wrt.9
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xwW1h0LNaQN7CBVN1GQg6TzUI+dLBVlSFc5N0Qxdzco=;
        b=OJqEjiyljSwmf8q2ja9Ccjo0xBQMIeDK7cLUp6I6V4rI4dj19jw05DDudEBzUEJx22
         njdWJekklcM0gULS4Nem9Zsf16P4OmybTFZGWcZtL4f8Qy3xepc/DnZ8YBVpI84PGFG1
         7gz0NNSfngzEjAsmrOKwSfUKXnLRb1pk9sGW37QNwGlNaQ1LrNPXolqeIYS8OpMFDcAm
         qpBv0kObiMH5P6lzBwBKcx00J44KmBcJultNwExC7nxfYaDEX+zvXZHOCQJ1mdwfTZQU
         O7MeH8btm5SOkCjquBSlAEsOOHY6b0JB8uSEMJGHkt5JfCNyGEwgYL3RVK+4A0z9B2JI
         wA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xwW1h0LNaQN7CBVN1GQg6TzUI+dLBVlSFc5N0Qxdzco=;
        b=BKN4HbcHfsJ1kgXz0RyWofbgBDc+sLURPypEOsTufsRRzhDwDWoQcTB1ZS0SR/i9+A
         e3/53Ui8/Ken0N2HnTwBcHa1VGrrOegCazHkj9uq23O+gJkwomVvqk/bgC3fC8Knz2cn
         0pujOB33MJ/RAVMFinXrnbDPvr22V/AzqNx2d5PEUbX5sq3UnbnuUMSznNWP2nrnY8Ll
         9b+wbhSS6ocBciqT7WaaDJRCU3Jec6SvdAmhdee4JWlIOONG1ZTHmR56UEMoH9uTtrAC
         N6DKYQNZmXn7iC0ht7XkrOCVtHWS/l/rkRRzhTzY9U+ZOOZdvmRgANv4JFaWxbifrQoz
         2R1g==
X-Gm-Message-State: AOAM533TK7rsGvph/wPvzafFQyYl7gyGdmPOk4azSWC2ID3KFqC12sBd
        yUTHkZA0k3hkESmQzq2fTZeo6nMeyXHFDmroRESdAg==
X-Google-Smtp-Source: ABdhPJwrYJRm5GBDx94hSPDAbEBx+atWjUY5R66968zb7MbSxW2HrkSeg9BXidQkJRYqWPxTTnHmNS/XsGiMG6UJ4D8=
X-Received: by 2002:adf:e703:: with SMTP id c3mr5888577wrm.252.1590011696476;
 Wed, 20 May 2020 14:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
 <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com> <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
In-Reply-To: <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 May 2020 15:54:40 -0600
Message-ID: <CAJCQCtQXBphGneiHJT_O7VHgZkfqfHaxmkAwFEzGPXY5E7U_cA@mail.gmail.com>
Subject: Re: I can't mount image
To:     =?UTF-8?B?SmnFmcOtIExpc2lja8O9?= <jiri_lisicky@seznam.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 3:12 PM Ji=C5=99=C3=AD Lisick=C3=BD <jiri_lisicky@s=
eznam.cz> wrote:
>
>
> btrfs insp dump-s -fa /dev/loop4
>
> superblock: bytenr=3D65536, device=3D/dev/loop4
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0xdc2c003a [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    86180ca0-d351-4551-b262-22b49e1adf47
> metadata_uuid           86180ca0-d351-4551-b262-22b49e1adf47
> label                   sailfish
> generation              2727499
> root                    30703616
> sys_array_size          226
> chunk_root_generation   2342945
> root_level              1
> chunk_root              20971520
> chunk_root_level        0
> log_root                94920704

There's a log tree being referenced, but in an earlier step you zero'd
the log. There might be some data loss for whatever was being written
at the time it was last rw mounted.



> log_root_transid        0
> log_root_level          0
> total_bytes             14761832448
> bytes_used              5075300352
> sectorsize              4096
> nodesize                4096
> leafsize (deprecated)   4096
> stripesize              4096
> root_dir                6
> num_devices             1
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x3
>                         ( MIXED_BACKREF |
>                           DEFAULT_SUBVOL )

Must be a very early btrfs-progs. Default these days is 0x161.


> / # uname -a
> Linux (none) 3.4.108.20190506.1 #1 SMP PREEMPT Sat Nov 30 21:25:45 UTC
> 2019 armv7l GNU/Linux
> / # btrfs --version
> Btrfs v3.16

To attempt a repair, you need something much newer. I suggest 5.6 or
5.6.1 since they're recent. Arch and Fedora Rawhide images will have
one of those. I'm not certain v3.16 can reliably tell us what's wrong
with the file system, in particular since quotas are enabled. Please
update and then repost 'btrfs check' without options.

This is promising though:

>parent transid verify failed on 94920704 wanted 2727500 found 2727499

Weird - why does it want that generation when the super block says the
root tree generation is 2727499? Can you also include output from:

# btrfs rescue super -v /dev/

It might be as simple as 'mount -o ro,recovery' with that older kernel
if it can roll back to the previous transid. If not, then a more
recent btrfs progs might be able to confirm whether the older state
can be repaired. That looks like this:

# btrfs check /dev/
# btrfs check -r 48250880 /dev/
# btrfs check -r 114339840 /dev/
# btrfs check -r 102043648 /dev/
# btrfs check -r 90173440 /dev/


The first two are most likely to succeed. All of these are still read
only, gathering information. There are no repairs yet even though
you're working on a backup image (good idea).

--=20
Chris Murphy
