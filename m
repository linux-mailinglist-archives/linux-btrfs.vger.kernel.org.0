Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C6284C97
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJFNeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 09:34:37 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817EC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Oct 2020 06:34:37 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so7916678qvb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Oct 2020 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=PhSYHCLHjY7Yti7VsKKfnGxg0FbsuipyKeij4j9hyo8=;
        b=p1Mg+qRsL0l5sDjuOHnyhJJXF4sA1WHgAZ+e1jypy7sFqgcEwCdy1wFJAPb4S+b160
         ADmsnOyfZ54qnEIxlgbYuz2FF8wvY/hHc6BDXjnoG8L1hWK+EukmZBxLpfGtZcYYW8iT
         sRSRR0X3FN5Hz5hmvHN3IPtU/aL0huuDgjmd8JOtmcuvj4IS0OmrXjpen3iDE158tdw3
         ER+1lkxwYECTB29s1Irty3fEeIpiisTtvUwFkUbeaTawv/iu+IDj4KPSQPDAfXhCx8ie
         0wwQwoj8d5+XUVE0KjSjOPk+Tj11p5/cpLD2rKw9B/nekBC5D3H3A3ftrh6xH26R0IGU
         FABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=PhSYHCLHjY7Yti7VsKKfnGxg0FbsuipyKeij4j9hyo8=;
        b=RTTLCHMzlFqGNBkkVPtuAZ7Wd8gbmhXIUB0SrBL0AOWHajoM3pOGIXLGTM9cqMfGzF
         /XBaJksN9bPzJ8vRD4aAFBb/ckM7Lveab3PK3h2FcRrUZkOSZcFOw5hN0aonfphk96j7
         Ow3yuola1Fc9uXVkrA+adB/JSAitpXTtHWTqsxDuUbWoSj1sbx6GDAJL6/jSaoksPdmN
         31+nv3gHz1RcDNsYf/pqwwrhHqxa6zzv2t9gwMSP9MP1sODLvQuFrszQ/3/9dTyBh1kU
         uonQxS/fcmrZf/laIH/JReqKiyhcUhAwQzcgLs7mfL71amaV0NtSY8mlBLAXYeupGc3H
         dL2g==
X-Gm-Message-State: AOAM530JLU+R4lG/bDGC33usO9S2mA9hi5mk2x55B4NG7R7ujao3Zz3S
        66KhEF5DAJRiAOi7nUhKbChPdKr2eVEdACadb5NoP5zXYS8=
X-Google-Smtp-Source: ABdhPJxMH9R4QoUlHjlajSl1qABQ2S6CiOTfp4YDH5LbkLpWWzyrwWMkNVFSLnKcKnWLe+48hoZEbbMFPcVxQk30/3A=
X-Received: by 2002:ad4:4e8f:: with SMTP id dy15mr4466326qvb.45.1601991276015;
 Tue, 06 Oct 2020 06:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <87362t3y67.fsf@physik.rwth-aachen.de> <87a6wzplka.fsf@physik.rwth-aachen.de>
In-Reply-To: <87a6wzplka.fsf@physik.rwth-aachen.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 6 Oct 2020 14:34:25 +0100
Message-ID: <CAL3q7H5tCeFKX1-ib3Rf0udxP8vVJK4MPrF7Vs5ibaqzmsTL+g@mail.gmail.com>
Subject: Re: Why so much "btrfs send" data for "cp -a --reflink"?
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 6, 2020 at 1:57 PM Torsten Bronger
<bronger@physik.rwth-aachen.de> wrote:
>
> Hall=C3=B6chen!
>
> Torsten Bronger writes:
>
> > I have two subvolumes A and B.  =E2=80=9EA=E2=80=9C contains 50GB data,=
 B is empty.
> > None is a snapshot of the other.  Now, I copy all data from A to B
> > with "cp -a --reflink A/* B".  This copying takes less than a
> > second.  So apparently, no bulk data was duplicated.  "diff -rq A B"
> > is empty.  So far, so good.
> >
> > However, it surprises me that
> >
> >     btrfs send -p A B | wc -c
> >
> > reports 12GB.
>
> At <https://wilson.bronger.org/btrfs-receive.dump.xz>, I have
> uploaded the output of "btrfs receive --dump".  Apparently, there
> are many "write".  Why doesn=E2=80=99t btrfs detect that all those extent=
s
> are present in the parent?

I  haven't looked at the dump, and don't have the time to do so right now.

But since the files are VM images, very likely what you are seeing are
writes full of zero bytes.
This is because the current send protocol does not have support holes,
instead it issues write operations with a bunch of zeros.
And holes are very common in VM images in general.

Just look at a few write commands, grab the file name, offset and
length, then check if after you read the corresponding file range you
get only zeros.
If so, then it has nothing to do with deduplication/reflinks, just the
lack of support for hole punching commands in the send stream.

Cheers.

>
> Regards,
> Torsten.
>
> --
> Torsten Bronger



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
