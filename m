Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF921E71A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 06:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgGNErU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 00:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNErU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 00:47:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB784C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 21:47:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so20818837ljp.6
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 21:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BhYJrh5hK+telL9vfRB2sriezYcOJh2LWgbsSt6CXPA=;
        b=YysOljyTOHMg9fAP5NT7kO8KblMoGTFpPZNKmHvHpXdXdQ9Un14zRrE6VCfH9hXzOO
         Y4AlAEFHx/UynfzKXF0G9C7rw77I+ObbhItdkEC0EtixjCPJCDtxD86E1UDAQloId6L2
         5eHzUTukgb74xNOE83y/DAfbcBoE13blQrJxXQAQQnSRbP+PUyDAgvQz2b06uvK2TFPo
         LEKTRXm5vRTaTF2zbvS68hKKd/n2JVmqtV26VKIgrek21QEBM2vYkVUL/1uXC0vmYPe/
         XQE0fYJfhaQ+cMqKgLoYPoRUnYY5TK+P8b11Nhfp9Z+O6xU5jlIiEsWLcuJ7aNmrlVk1
         38ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BhYJrh5hK+telL9vfRB2sriezYcOJh2LWgbsSt6CXPA=;
        b=Ey/hvTfk9WLvBX+tqQzPNB7fDRjLpCnjaM7S5G4MdNLZuGj7yH9NQArKJHLyA75TBA
         94JbHWBcdFex6TUmuQu0revAgwZ5pK8HvcFc0121bhs5q7+Kd5EI98XfvrB8P6RD4oOp
         4nGV3+iLkjvhFQdxZsk6CohCEbSQdNeRgxDkuOKldmakO0wc/+lMEIDcH0WChonj5yQr
         hyQsqwA4PaLalSb9kGdRtn/3L2M+IJo/sp9U+gDos4T3UMcpgkqmw0Daub/rxVazgpZy
         uNt9mcfYO/AOzURvRQjiUqCkTjIfsZXm3SXsNsynAJl38RjC28DBeE1+R4GbkijNABJP
         sBTg==
X-Gm-Message-State: AOAM532RrfTQjBHzI7noytA/VfSSkENB2E0p0iuG7OF0DXKgv4EChoC2
        UlQ+QAJJBI/a0OW9aF6/K+z9XVp8ArgImgCp+Po=
X-Google-Smtp-Source: ABdhPJylhW/GYc521W2xze9sspr2yckCLz/TPaf/W5HjYLD86mgzNCPLixSP4QCcvdLxVy99g53ZiV/sbJ3GnH9sY0k=
X-Received: by 2002:a2e:8992:: with SMTP id c18mr1297890lji.388.1594702038282;
 Mon, 13 Jul 2020 21:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJt7KB-c4vRYgjJ1WZJyNZuey6nH=y2BcQNVYJa6YAG9MTfKhQ@mail.gmail.com>
 <f37d1f09-e89d-b468-2de9-4dad1d98d750@gmail.com>
In-Reply-To: <f37d1f09-e89d-b468-2de9-4dad1d98d750@gmail.com>
Reply-To: swestrup@gmail.com
From:   Stirling Westrup <swestrup@gmail.com>
Date:   Tue, 14 Jul 2020 00:47:06 -0400
Message-ID: <CAJt7KB_eJWpnmNXkBiZ=-08iuc5Ah_i8Uh0Ma4WCqgd=Qq4SuA@mail.gmail.com>
Subject: Re: Rebalancing Question
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you! That looks like it would work.

On Sat, Jul 11, 2020 at 11:58 AM Andrei Borzenkov <arvidjaar@gmail.com> wro=
te:
>
> 11.07.2020 17:42, Stirling Westrup =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I have a BTRFS built with two devices md0 and md1 on a server. I wish
> > to move as much data as will fit from md0 to md1, but I cannot figure
> > out a balance command that will do that.
> >
> > My use case is a file server with a fixed number of hard drive slots
> > and two raids. md0 is a raid using most of the slots with small
> > drives, and md1 is a raid using the remaining slots with large drives.
> > I'm trying to shrink md0, so I can remove some small drives and put in
> > new large drives to add to md1.
> >
> > I have read the notes on the balance command several times but I can't
> > figure out how to get it to do what I want, if it's even possible.
> >
>
> You should be able to shrink md0 which will relocate data beyond new
> size to another device(s). See example in btrfs-filesystem:
>
>
>        $ btrfs filesystem resize -1G /path
>
>        $ btrfs filesystem resize 1:-1G /path
>
>        Shrink size of the filesystem=E2=80=99s device id 1 by 1GiB. The f=
irst
> syntax expects a
>        device with id 1 to exist, otherwise fails. The second is
> equivalent and more
>        explicit. For a single-device filesystem it=E2=80=99s typically no=
t
> necessary to specify the
>        devid though.
>
>
> This assumes you are using single or dup profiles, as other profiles
> require at least two devices anyway and you may not be able to shrink
> md0 too far.



--=20
Stirling Westrup (he/him)
Programmer, Entrepreneur.
http://www.linkedin.com/in/swestrup
(+1) 514-626-0928
