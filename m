Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4404020034D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 10:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgFSIKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgFSIJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 04:09:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB4C06174E
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 01:09:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id y6so6896526edi.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bpbj0A3FOGPHz5pcq4LICzxN3fLHGhtQHIV+yki0sTk=;
        b=l+km7JZEn06gjPJaWYK1kTH1YFRHhUk4QouuY2PFdH3q0elrij885jjr3D/pe1/QQ5
         pN9++mtLvGBlHGaAK33QjK30gB2n3gdcoC4e0IitTRaspL1quoNx2RSemUMkkLnZ30Jh
         5u0bolDH6VK4En/iip9Q9BDl69iy2etdyxfNIsrcm1iwksDk5TS+1dA7T8YdrSesWRgN
         WzfoPZoDrUKt5aqrU4U/+FRIPHJ+F4N5zHrqjtsYYa42zAfPD2BuTzH2h88kgH2Ectf1
         WMr/2g44g5BAYVtDoVUj2ALGnFbJVDFB7Jq8bCpMWWHTkZPXY/QThv0clzU7kodVOD4u
         E2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bpbj0A3FOGPHz5pcq4LICzxN3fLHGhtQHIV+yki0sTk=;
        b=Dtk8c4vKpyevRMF0GdYSBU4TEQx8I5FQl/bTVn/cxTah7fYY7T/s4hC48RS6lJsxfa
         aQiznKsbLzZCl6lRGJL6mDQJpspPVWKWacIgqnHv1EhMDSDD6hgxWmafPliSkRcVZamp
         IeEp/Tknp2WI5+nr5Tke10bNWKMCCjXJQw7UmKvXfZnwUuCzojC6CUYrB0N9IR6Xtx4R
         Htr/nuCRLS3w1eNu3s7JUoGfeWTpqQwV8q/GA7CJSXiSVAAoJvYo0zsCPRmazO1ByA+a
         cgA1d7VnzwIp6CKpCUCVBr93ZKdV+6JK9VszeYnpd8r8MxZTnsPHGnX8cM7CqKB+vrkZ
         eatg==
X-Gm-Message-State: AOAM53238AjE6nrLhZ3aPCajrdSIiInj28XDKgY8DGc39aFFR5hzyz1V
        gtemlcTYMB0xuYsWaCdnEXljNQs6JAJQfBe3tgo4fzoT
X-Google-Smtp-Source: ABdhPJw5LvZFQvHtAqS27uP2pYLrR6+upqNamLTK/C7+h6StGFKtf3yYsi6VDCbvy/uWlz5SdQWSZTiMODOMcDnw/cc=
X-Received: by 2002:aa7:cd4e:: with SMTP id v14mr2075532edw.297.1592554159869;
 Fri, 19 Jun 2020 01:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
 <20200619124505.586f2b63@natsu>
In-Reply-To: <20200619124505.586f2b63@natsu>
From:   Daniel Smedegaard Buus <danielbuus@gmail.com>
Date:   Fri, 19 Jun 2020 10:08:43 +0200
Message-ID: <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
Subject: Re: Behavior after encountering bad block
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 19 Jun 2020 at 09:45, Roman Mamedov <rm@romanrm.net> wrote:
>
> On Fri, 19 Jun 2020 09:24:26 +0200
> Daniel Smedegaard Buus <danielbuus@gmail.com> wrote:
>
> > I was testing btrfs to see data checksumming behavior when
> > encountering a rotten area, so I set up a loop device backed by a 1GB
> > file. I filled it with a compressed file and made it rot with, e.g.,
> >
> > dd if=3D/dev/zero of=3Dloopie bs=3D1k seek=3D800000 count=3D1
> >
> > That is, the equivalent of having data on a single block on an actual
> > hard drive go bad.
>
> Not really, because when real on-disk sectors go bad, the (properly behav=
ing)
> drive will return I/O errors, not blocks of zeroes instead.
>

Well, that's why I wrote having the *data* go bad, not the drive, even
though either scenario should still effectively end up yielding the
same behavior from btrfs, albeit more slowly, and with more chatter in
the kernel log :D But check out my retraction reply from earlier =E2=80=94 =
it
was just me being stupid and forgetting to use conv=3Dnotrunc on my dd
command used to damage the loopback file :) Btrfs behaves exactly as
expected when I damage the loop back file properly.

Cheers :)
Daniel

> Roman
