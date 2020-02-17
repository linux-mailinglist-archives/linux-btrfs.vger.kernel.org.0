Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF4A1613F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgBQNvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 08:51:25 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:40010 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgBQNvZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 08:51:25 -0500
Received: by mail-qk1-f178.google.com with SMTP id b7so16199265qkl.7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6DpCdmMYg7Pw7BIsbYt0tHn+xr+iY07M72anhoTr8M=;
        b=lFwwenFw0t/AeAgPZDwlBOu1Ix5ZBwoFuM9TWBiuZJEPYPwkV6O/r22U3zoC0WwioV
         teunpvydU4nAt52l1DhiqnYDWq+uBCX3SLV53y2IvHD2HcxnsfaztAkKYsYPbNDyk/Ts
         72FL4Swgg9qvQG6J4iTAKSVbdvp6MwyQaCNsLNplPCsoryztqpOHIb7KR6XEea9WAyk3
         7+UXJ8Z3mOHdFIeH5US1BbgHgcem2b+YiySay7v1KsxknhODvLn75PCFrqYhwQdDZ5Gl
         tQML0lpHn9TRoOIOjgaUqFFar68Xky4EtsH3b8VCcjSzCR4xJ7uQoQWBMD7VE/8A7ZGe
         iUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6DpCdmMYg7Pw7BIsbYt0tHn+xr+iY07M72anhoTr8M=;
        b=NvFUFspM82C00FfWlgKsbKCDoAiRkab/EpKItuofXjti4BD0dmeQxAZBe85O2Eo5lM
         xEkJPCDJE6VbNM21M/NJsr+8gKBxS5EO9buWMmN5l+7iEwWByUjd6f5OoGI8faM7IGlm
         qqEYfPsR3dp3MAgSrq0oywJ5+96ZL7RdqTCnqcjBuBLKOb6aOPtxf0vPbh60f33ioNZK
         isxL1C6Mrcb2XPzjyCCdZG+oFQPSesgtYM9wK7vG7FtPz4opWbFZGT/Q6KscJPRYIzXJ
         +BCWeaNfypf+AnjUYP7Dt/wAyLGsSdyV54q7HyShKy17Da/XuP7dMe1Hn5Jp44umAKft
         Z+tw==
X-Gm-Message-State: APjAAAWjp+3d6Ga5lS/P0veopMYr7R6HlxrBawFf1ckHUl7t+n82T80+
        W7oeprr/7t/Tjr3oa/dU+zB4yIDO0VNu6Tl6TNfA0w==
X-Google-Smtp-Source: APXvYqwCbTXOwXd6f4nC/D7QkBtIuqrcsqLbPXEVOeuGIg62o+jhySnZtayCKcJX/N1v6jfjfnV5zMSe2HEKGzxsdP0=
X-Received: by 2002:a37:806:: with SMTP id 6mr11079748qki.75.1581947484085;
 Mon, 17 Feb 2020 05:51:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org> <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
In-Reply-To: <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
From:   Menion <menion@gmail.com>
Date:   Mon, 17 Feb 2020 14:51:12 +0100
Message-ID: <CAJVZm6fj9V7G2zLjNpR5MRcZOke0NxydWm1aMY44n2L18fP04w@mail.gmail.com>
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also, since the number of HDD is 5, how this "raid1" scheme is deployed?

Il giorno lun 17 feb 2020 alle ore 14:50 Menion <menion@gmail.com> ha scrit=
to:
>
> Is it ok to run it on a mounted filesystem with concurrent read and
> write operations?
>
> Il giorno lun 17 feb 2020 alle ore 14:49 Sw=C3=A2mi Petaramesh
> <swami@petaramesh.org> ha scritto:
> >
> > Hi,
> >
> > On 2020-02-17 14:43, Menion wrote:
> > > What is the correct procedure to convert metadata from raid5 to prope=
r
> > > raid scheme (raid1 or)?
> >
> > # btrfs balance start -mconvert=3Draid1 /array/mount/point should do th=
e trick
> >
> > =E0=A5=90
> >
> > --
> >
> > Sw=C3=A2mi Petaramesh <swami@petaramesh.org> PGP 9076E32E
> >
