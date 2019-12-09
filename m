Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82346116459
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 01:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfLIAaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 19:30:30 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37494 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLIAaa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 19:30:30 -0500
Received: by mail-il1-f196.google.com with SMTP id t9so11216729iln.4
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2019 16:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1UpiykcesiAf8Py7tQ1tGDEsp0Xxd8VgOhbAqT1GHXA=;
        b=OqWsxx5itwiAQJ+QS3Y4i4ReQCehEy9i599+BfOOqhH9OTHCHdzQr7comcF6T/qsWA
         o2fVpUv8UgrAwMjk2bM9J8LrFPDlMle6GEgtRV2Me333Dkm3Ttn5tEBd6FOsQ6DLfaIp
         A3IZrOmm+ha00nh0kohUC4zVHHU2fKoiQAxT90D1oYxEf2fcp9Lezct2b2dJmI/k4YA4
         QbYLb7bLan/GoT2roGPtskZHn6GIqEqL9s4XdW/ZAl7RwLbxMGB40EDYFOZRVWJ18Ctk
         5g9hvzdnLmKeFHUE+aJfsfDhrdVio18O9LM6qYr1ycomULHwHjkr8tPO38kVyAG9EjEo
         yd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1UpiykcesiAf8Py7tQ1tGDEsp0Xxd8VgOhbAqT1GHXA=;
        b=eXco/WgYsbmM2qzAMbjLoi+zY/YCjAk/1kDSA38kTFJuSz5FCHctBRPV60F4u0R1mj
         91jXoEI1vQtZ8HFgWT6n4kS9edXiOSWBSzkpkbRujse5SZcqFEgmpdsHC2lBQQF6LMAZ
         glre6ffAM55NOzGIemXZfA5BJQLxjWUx7ZMwoZh6vTJ0R/6PGFHF2hya//q1/ZDtcxKN
         ANcSZl/yWoq2cg4DebcPGCuZr9pvjA1vSVfkMgxSCjRbShFzvIAbf/0Emj3Pd5eF/OdL
         OKfFhg68DUaLd9Kcr8Ur03v9M/V1UJlzsYD+mlUdXfbhH34tm4iWFF9JwIaF2kkX4Zr6
         GEnQ==
X-Gm-Message-State: APjAAAWL8SAYRSWT+qnq7l4g0imtzyya4fJVsZuZIO1PEBUb4/HsoTHO
        MnufU/xMTa46iU05NRaesAtVK7IH7wo0NcIM6DI+HsH1jQg=
X-Google-Smtp-Source: APXvYqyQsXIw1wlR/Cs5iKbFUTbGZV2agsgWrjEzAPpz2/4ZVe4D3FP3qO5Aogf0RoLo8Q4dKH9skwEHh0VwQzyKcF8=
X-Received: by 2002:a92:6b01:: with SMTP id g1mr25013708ilc.54.1575851428954;
 Sun, 08 Dec 2019 16:30:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
In-Reply-To: <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
From:   Mike Gilbert <floppymaster@gmail.com>
Date:   Sun, 8 Dec 2019 19:30:23 -0500
Message-ID: <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
Subject: Re: Unable to remove directory entry
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 8, 2019 at 7:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/9 =E4=B8=8A=E5=8D=883:19, Mike Gilbert wrote:
> > Hello,
> >
> > I have a directory entry that cannot be stat-ed or unlinked. This
> > issue persists across reboots, so it seems there is something wrong on
> > disk.
> >
> > % ls -l /var/cache/ccache.bad/2/c
> > ls: cannot access
> > '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> > No such
> > file or directory
> > total 0
> > -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.man=
ifest
>
> Dmesg if any, please.

There's nothing btrfs-related in the dmesg output.

> >
> > % uname -a
> > Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> > Phenom(tm) II X6 1055T Processor
> > AuthenticAMD GNU/Linux
>
> The kernel is not new enough to btrfs' standard.
>
> For this possibility name hash mismatch bug, newer kernel will reported
> detailed problems.

Would 4.19.88 suffice, or do I need to switch to a newer release branch?
