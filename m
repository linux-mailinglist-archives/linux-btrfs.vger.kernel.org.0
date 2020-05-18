Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A941D7E93
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgERQdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgERQdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 12:33:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD333C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 09:33:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id w65so3311482vsw.11
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GT2/Pt6Vn2AZVHlv5C8E0+5rlYqI35lwWpzT4/MazIA=;
        b=gFeKwukoNm41GQ9xNAegRyLlqqFXTkWpmPPv4sxm70j37qCc88RkiYBoDdhkGnYKIF
         d31/naQsB+eydfzJsY4+h0fXVSv3P2npLSDlabmbECu+bzXrWHA0h4K67FT5gHIYZ/6a
         BtsZB8c1ri2JdCurHR9HzlmYM0E+ADpuW+3/TPnTjEf3Gewc8wGeuW08KvSGivLmCHjd
         Djt/SxArCnl6cvu9XZSOhiPi2CvekN1ECPE7AGooAg5Rst8YH2B+0VqZpR+fqXnBIQYJ
         n/4rLg9NNz8K2AaakigmtnmEdfb6PqaE5qBXt7PxEQTh8S8wIFppfxBKnmjiTIMkAi5X
         Ctag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GT2/Pt6Vn2AZVHlv5C8E0+5rlYqI35lwWpzT4/MazIA=;
        b=DmCE0hAJMmMyvQAPvkocRkpuz49RICgdBLCwjPxISUIbS3lyPm9biv0x59+N/weE9W
         aMwFG2Z9GbHHQ7i6hx3mJVrZ4+gegUIUVnz6y/brxxWKh9WvN4PWQQ13XXt0dxE4fLlh
         ylYquWbyAnf9yt28r1ecFXyzffznHnJs/dcNX7l7NBU3IbrrNR7JdS6DQQp7brCyh2xM
         IAtmHuvXRbuw4Jo6Gg0bur5NkTMCvRLxwIn+J+oyAbUNv9xYAYDIDVDeHxvpMxcfky6A
         wWZr69qCRIB4RbJ/Da5PaI8+olKphyYXKepaVf5oq7G4nuKWR2YWhqjRVBYLuiJ4u2H0
         CwVA==
X-Gm-Message-State: AOAM531PXG7XtnmYYyln52OqjgAIjeETKQp5OPj9Q04QlStqf+k8M2HS
        2TaS5ROhCB0nLC1aKS5wjQbhm38CK69af7vhWhuFIA==
X-Google-Smtp-Source: ABdhPJw6g12+IStyCubV6qTTgTD8IO01koaTBlyqiPJ3fDplHwMI84RO/V3XpXuNArEURCTVkZZg4AzmkDnh2uHhZSw=
X-Received: by 2002:a67:407:: with SMTP id 7mr11140048vse.95.1589819591901;
 Mon, 18 May 2020 09:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <b3f880.1227fea8.1721e54aeeb@lechevalier.se> <CAL3q7H4zkS=9U2+ig=6a3WDF2NXDDZkmnw9havUKi5EbB0t6Og@mail.gmail.com>
 <af4712e3-d7eb-6ba7-0ecd-155e5ee17bc3@lechevalier.se>
In-Reply-To: <af4712e3-d7eb-6ba7-0ecd-155e5ee17bc3@lechevalier.se>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 18 May 2020 17:33:01 +0100
Message-ID: <CAL3q7H6F2s0azBbGO6B9FfX7GVUMVyH-xfXzmWFqkUd8uMKG8Q@mail.gmail.com>
Subject: Re: cp -a leaves some compressed data.
To:     A L <mail@lechevalier.se>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 16, 2020 at 9:01 PM A L <mail@lechevalier.se> wrote:
>
>
> On 2020-05-16 19:18, Filipe Manana wrote:
> > On Sat, May 16, 2020 at 5:51 PM A L <mail@lechevalier.se> wrote:
> >> Dear all,
> >>
> >> I did some testing on copying files with the +c (compression) xattrs s=
et.
> >>
> >> As far as I can tell, 'cp - a' only sets any xattrs after copying the =
data. This means that a compressed file should end up without compression, =
but still with the +c xattr set. However this is not entirely true. Some sm=
all amount of data is still getting compressed.
> >>
> >> I would like to understand why.
> > As discussed on the mailing list:
> >
> > cp copies the xattr only after copying the file data. Since the data
> > is written to the destination using buffered IO, it is possible that
> > while copying the data the system flushes dirty pages for whatever
> > reason (due to memory pressure, someone called sync(2), etc) - this
> > data will not be compressed since the file doesn't have yet the
> > compression xattr. If the remaining data is flushed after cp finishes,
> > then that data can end up compressed, since the file has the
> > compression xattr at that point. Typically for small files, all the
> > data ends up getting flushed after cp finishes, so we don't see any
> > surprising behaviour.
> >
> > I'll look into changing 'cp''s behaviour to copy xattrs before file
> > data next week, unless you or someone else is interested in doing it.
> >
> > Thanks.
> >
> Based on what you say, the file operations are happening asynchronous in
> the background, rather than synchronous.

What I said is that while in the middle of copying, dirty pages might
be flushed for some reason, in which case the data won't be compressed
since the destination file doesn't have the xattr set yet. The
remaining data will be flushed after the xattr was set, so it will end
up getting compressed.

> I guess 'cp' and other tools
> like it should issue a 'fsync' call between setting the xattrs and
> writing data?

I don't understand what you are trying to say. Are you suggesting the
fsync would help the issue you described (I don't see how), with the
file ending up having compressed and uncompressed extents, or is that
for some other issue you are thinking about?

> Is this specific to Btrfs, or is it a Linux design choice?

Can't tell since I don't understand what is the problem.

>
> Also, thanks for looking into changing cp to do the xattrs before
> writing data. I had also asked about this on the coreutils mailing list:
> https://lists.gnu.org/archive/html/coreutils/2020-05/msg00011.html

Great, thanks. The coreutils folks will deal with it the best way.

>
> Thanks



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
