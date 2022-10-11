Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5B5FBC62
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJKUuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJKUuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 16:50:04 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E812D02
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 13:50:01 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k6so13452202vsp.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rqa5+eDk3DvzL2+A4UcDlrv3uuMJxgPB4c7xvWc7qsM=;
        b=X4Sgf++XRnHNNTxo4762O4mNxhP1mEEgQIxpWQ5tEmafl8g4MduvBj0PXZUEmENJ9/
         7O+UVLXbYES5DzM2zeg7Vk7AcguBoT45qhTvToPnOU2Phens8pTN/KIg4bCWI1UHSLNI
         M2Og5W6bSU2tGYX5tvReMKNeW+gdtehyiAfMCdQP5RD85qKGaK7tiZEB/lM3bcyKn3xg
         YhyWqWjBhXscVjq+2wPETU4Nlq8Tq2JNOZ/DW/0Uhj0yyLPnhqX/K3HzMf+rAZYh7uKw
         32rdUW0k21IJmayFgtFBO5FO3BltVF5QkUyAfjYbBU0c0K1cSSyFh834zOxuFlTIpaPC
         Hz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqa5+eDk3DvzL2+A4UcDlrv3uuMJxgPB4c7xvWc7qsM=;
        b=3syQsts8Q0yc7p/tdAipx6asIA4jod/sro05W2cOWM5LC62zYt6Tj19vdSdSqb7VbN
         IKAtATp/dIe4f8biWR1m/US4ibhjr28xq3XIY7kHybmvUi8tSwxdq00ugCSv4TcBQNXG
         ynqJ6q6nnwfch1XKqo3t2j2b2Qb+CYi+DNhLlOy56BuKExeocXLDHrmAG96eX6pFg/yR
         jk0+TIi/ODrd/sAFp5ufyg8aE/WabXJxj+CxV2Hx6hb8kmKCSYG53eEXNiT9VyunxG+Y
         xgz98ZrQQqBteoL9l42FO9CJwH2elLXkVA8TuI5+9SosBS63W2JOB54ppbtcACTVPub/
         Ty0Q==
X-Gm-Message-State: ACrzQf18Mr95C4DDTj+UR2+3rdbJnnB4X8TUxN6WSwvUcRH9ZY0O4plJ
        a/JHviD48eD8mk/8wIvs9BF+c1L+SiV9bw==
X-Google-Smtp-Source: AMsMyM7p0tRMzTfyxTE7VywPNXegMGtURYjpCWqu0wdyFtyJ9L8DTl8hX4GylN+sNS8IO7uGndLXKw==
X-Received: by 2002:a67:fd18:0:b0:3a6:fc4f:13c9 with SMTP id f24-20020a67fd18000000b003a6fc4f13c9mr13387781vsr.84.1665521400505;
        Tue, 11 Oct 2022 13:50:00 -0700 (PDT)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id d14-20020a1fb40e000000b00377b00cdf6esm3093270vkf.41.2022.10.11.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:50:00 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:49:55 -0500
From:   Glenn Washburn <development@efficientek.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs send/receive not always sharing extents
Message-ID: <20221011154955.45aacef8@crass-HP-ZBook-15-G2>
In-Reply-To: <20221010094218.GA2141122@falcondesktop>
References: <20221008005704.795b44b0@crass-HP-ZBook-15-G2>
        <20221010094218.GA2141122@falcondesktop>
Reply-To: development@efficientek.com
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 10 Oct 2022 10:42:18 +0100
Filipe Manana <fdmanana@kernel.org> wrote:

> On Sat, Oct 08, 2022 at 12:57:04AM -0500, Glenn Washburn wrote:
> > I've got two reflinked files in a subvol that I'm sending/receiving to
> > a different btrfs filesystem and they are not sharing extents on the
> > receiving side. Other reflinked files in the same subvol are being
> > reflinked on the receive side. The send side has a fairly old creation
> > date if that matters. Attached is the receive log and a diff of
> > filefrag's output for the files on the source volume to show that the
> > two files (IMG_20200402_143055.dng and IMG_20200402_143055.dng.ref) are
> > refinked on the source volume. This is a somewhat minimal example of
> > what's happening on a big send that I'm doing that is failing because
> > the receive side it too small to hold data when the reflinks are
> > broken. Is this a bug? or what can I do to get send to see these files
> > are reflinked?
> 
> send/receive only guarantees that the destination ends up with the same
> data as the source.
> 
> It doesn't guarantee extents are always shared as in the source filesystem,
> that the extent layout is the same, or holes are preserved for example.
> 
> There are two main reasons why extents don't often get cloned during
> send/receive:
> 
> 1) The extent is shared more than 64 times in the source filesystem.
>    We have this limitation because figuring out all inodes/roots that
>    share an extent can be expensive, and therefore massively slowdown
>    send operations.
> 
> 2) Even when an extent is shared less than 64 times in the source
>    filesystem, we often don't clone the entirety of an extent and end up
>    issuing write operations for the remaining part(s). This is due to
>    algorithmic complexity as well, as identifying the best source for
>    cloning an extent can be expensive and considerably slowdown send
>    operations.

So my example falls into this category. I have a limited understanding
of BTRFS internals, can backrefs be used here to decrease the
algorithmic complexity and duration? Naively, it would seem that having
a backref to inodes that use the extent would be enough to keep track
of where clones should be put in the send stream.

> 
> I have some work in progress and ideas to speedup send in some cases,
> but I'm afraid we'll always have some limitations - in the best case
> we can improve on them, but not eliminate them completely.
> 
> You can run a dedupe tool on the destination filesystem to get the
> extents shared.

Thanks for the explanation. The problem with using a dedupe tool is
(1) that potentially a lot of unnecessary writes are involved, and more
importantly (2) the send will potentially cause more disk space to be
used than is used by the source and thus potentially more than the
target when the target is the same size as the source. Since we don't
know beforehand if send will clone shared extents, the user must assume
that it will clone none and receive on a filesystem with at least enough
free space as the size of the total references data. This may not be an
option for the user (me).

I believe this theoretically could be mitigated if there were a dedupe
tool that would watch the filesystem for writes and do dedup as soon as
a write happened. I don't think any of the current tools do though.
Separately, perhaps there could be a tool that reads the send stream on
the receive side and inserts extent clones.

The easiest way forward seems to me to add options for send to try harder to find
extent clones (at the expense of time and resources).

> 
> > --- /dev/fd/63	2022-10-08 00:31:46.783138591 -0500
> > +++ /dev/fd/62	2022-10-08 00:31:46.787138126 -0500
> > @@ -1,5 +1,5 @@
> >  Filesystem type is: 9123683e
> > -File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng is 24674116 (6024 blocks of 4096 bytes)
> > +File size of /media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref is 24674116 (6024 blocks of 4096 bytes)
> >   ext:     logical_offset:        physical_offset: length:   expected: flags:
> >     0:        0..    6023: 1131665768..1131671791:   6024:             last,shared,eof
> > -/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng: 1 extent found
> > +/media/test-btrfs/test/1.ro/IMG_20200402_143055.dng.ref: 1 extent found
> 
> 
