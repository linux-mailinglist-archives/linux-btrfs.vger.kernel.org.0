Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C916B35189A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhDARqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbhDARkE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 13:40:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E3C08ECB9
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Apr 2021 07:00:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c8so1921795wrq.11
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Apr 2021 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FPFA61vKfECcdI9cRIN30iC5eaHjX7gQxGzxBtGA5Bs=;
        b=eUa+e5iTkKSN1H6ln4Nb0Pi/yg/SaJWctgFhOG2kogvvcEPoM1ifaZ3LzAdfZ0sFuz
         FP4LNe+ORIb5uHVoS4nQp3KJhROjMJTy6j4NRC/vbBSZik83b1VIQccSVK1iiv+Et8mU
         I8PZDh7vCcH7b/w30Fi6kIf3MhUJ1EYRdfH30Wx5a8kWE4hnsvCAO+Jd+D8PcWmSnfUm
         rWdqZt2EPnttJ3bJ7GcHRrlc6EWkFLeZcXzMeZIHqd2uwR/rEJYCKj1K9KdwRL+5LKwK
         pV9W33PN22AZQGlkYIyuInrSPd+Vt6wDFkvxuc/KUyjmnc9eSvKzWs/RZ9oci6loD4xQ
         u+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FPFA61vKfECcdI9cRIN30iC5eaHjX7gQxGzxBtGA5Bs=;
        b=OR+pJQG2Vh1GeDwBD7ijrt9+Peq012ALHmYSVyI0BWXBNSNCew5474yXresU+hPeWx
         fbVl1k2xT+xGkOVG8HTElW9kzQNQDShpnLYAhev6jrYv9LGtGtEtxaddtIfLlkp+bTG5
         a9Dx3mGlgcBnQfnp8sbxCd3FlPT8QwHdubksKvJotrBImPNPQfbxjbTMIdjZuHdWibUD
         0DS82gQwlxZV9MqekSjmfD127EeAIFfVu0/52tbbN/g4ANYhmpZnh8WY1P3AnrFsWNVJ
         xYkQ/v+n4akNdgBGNdMN2YG1eYGFHculvRF1cS9f2I/s2OZ4TmYQDkMCQk6o6GxD483j
         TqhQ==
X-Gm-Message-State: AOAM5324nqYnsPkW2Ej7L7O0Bfe0+PPxD9tw1d/n8YCByYIFhaNTWVx9
        Qr2ZuAiOVZqkqQL8ISdWY3FVMweHP4YtSrxcIKf3oFDohng=
X-Google-Smtp-Source: ABdhPJxDQ2wuNZ84DoK0Daaf5xcOP55PXAcxJkqNgI85d++ugrLiy67VNR6aQ0KfB+af79j1BeUKWT2XzhTq856Br6I=
X-Received: by 2002:a5d:518c:: with SMTP id k12mr9944500wrv.15.1617285604918;
 Thu, 01 Apr 2021 07:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
 <CABDFzMg1J_CDkNJ8JSvu2CkQT_ARHPw4_72C5BozbmYRxLKO6w@mail.gmail.com>
 <20210331142327.09af250d@gecko.fritz.box> <CABDFzMiR=b6N+1mp_F4W1awig+kC2Qb3w18C6ev_S3jcQSKchQ@mail.gmail.com>
 <20210401110419.53c8bfbc@gecko.fritz.box>
In-Reply-To: <20210401110419.53c8bfbc@gecko.fritz.box>
From:   Thierry Testeur <thierry.testeur@gmail.com>
Date:   Thu, 1 Apr 2021 15:59:52 +0200
Message-ID: <CABDFzMhAQVTe101PysBAqzN3iisd-thg947FXHH74pYHWmpT_w@mail.gmail.com>
Subject: Re: Support demand on Btrfs crashed fs.
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for your return, but i think the writing of this type of
programs is far away for me. Haven't really coded since the amiga 68k
assembly time, so... :/

I have appreciated your efforts to trying to help me, but i can't
handle this type of solution.

I will let this raid RIP until i will find a solution, maybe with
futur evolutions of Btrfs-Tools.

I wish you a nice day,
Thierry

Le jeu. 1 avr. 2021 =C3=A0 11:04, Lukas Straub <lukasstraub2@web.de> a =C3=
=A9crit :
>
> On Wed, 31 Mar 2021 23:44:28 +0200
> Thierry Testeur <thierry.testeur@gmail.com> wrote:
>
> > Yep, compression enabled (original fstab before having tried restore
> > options): compress=3Dlzo
>
> Okay, that explains why photorec couldn't recover a lot. If you want to
> get your hands dirty, I guess you could write a program that does the
> following:
> For every 4k block/address on the filesystem, attempt to decompress it
> using the btrfs lzo implementation (see fs/btrfs/lzo.c and
> lib/lzo/lzo1x_decompress_safe.c in the kernel).
> Do some sanity checks:
>
> Like, check that the length of the compressed data is reasonable. The
> decompressed size of an compressed extend can be a maximum of 128k, so
> considering the case that data which doesn't compress well may take up
> more space in compressed from, the maximum length of the compressed
> data should be a bit larger than 128k. I'd say like 256k.
>
> Also check that the length of the segments is reasonable, etc.
>
> If all sanity checks passed and decompression worked, look at the
> decompressed size:
>
> If it is exactly 128k, it is likely part of a bigger file. Append all
> such data to a output file.
>
> If it is below 128k, chances are pretty good you just recovered a small
> file, save it directly somewhere. You can use the file(1) utility later
> to figure out the file-format.
> Or it could be the last part of a large file, so always append it to
> the output file as well and fill up with zeroes so the end is aligned
> to 4k.
>
> Finally, you can run photorec on the output file that you appended
> everything to, to rescue files that are larger than 128k.
>
> I wish you luck.
>
> Regards,
> Lukas Straub
>
> > Best regards,
> > Thierry
> >
> > Le mer. 31 mars 2021 =C3=A0 14:23, Lukas Straub <lukasstraub2@web.de> a
> > =C3=A9crit :
> > >
> > > On Wed, 31 Mar 2021 02:17:48 +0200
> > > Thierry Testeur <thierry.testeur@gmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > if anyone can help me with the problem above?
> > > > Have tried a Photorec (even if i know the chance are really
> > > > poor), and have got some non-sens files, lkie pdf of 2Gb, ....
> > > > most of them are unusable, except smal size file, like jpg pic...
> > > >
> > > > thanks for any help.
> > > > Thierry
> > >
> > > Weird, I would have expected photorec to recover more. Did you have
> > > compression enabled?
> > >
> > > Regards,
> > > Lukas Straub
> > >
> > > --
> > >
>
>
>
> --
>
