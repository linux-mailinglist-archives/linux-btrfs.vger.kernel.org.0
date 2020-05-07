Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9751C81D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgEGFnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 01:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGFno (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 01:43:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9CC061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 22:43:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h4so4906837ljg.12
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BaQbZ6HqRNDwFrTSK9fjjOiYn2q9Tn59O5Q+HcnYh6E=;
        b=cUmokudZI4RlBjtV3WeM4yFCqHXkoz4iEdyBYz46d6geymAy5TiZRXEmEInLGATOZ3
         NetS6PJOw1pF8A9JapZVsvo+NaIL6E+oeZ1P9CewBu2j4EYP4NipUHeRTiFo1zYGtEvG
         jZrWP93K5a+cHSMZ9AxoC+Zt1hmXisLwPhzi0bi26jlSx8djYs8P+EvfgAEF7ccavJl6
         C+PjiRUzwCPS/AFoaKMMr06lbLovXxInF9vmzyDnUrlhWXu1d6iviIk1jbE0jNhkTkss
         ncPyEfsCToMsigQveL/5/RJpAnK4dL8Es3PNyxjq5IvAoF9RUGqtmX9lUat3PSqA6SBG
         czbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BaQbZ6HqRNDwFrTSK9fjjOiYn2q9Tn59O5Q+HcnYh6E=;
        b=qkc0EXjkjjZpA4C+cqtrB2WYfdtTFdj8+YNGHCq3XEma6j/0yt3UlVaAxoo4ll24SY
         /o38j0IIx+ldNqnKAA7CFFwaH5fiDDBd5J/QPnv02oz150RHHWshBTbs/tR9QCKoJY+U
         f8iC0l6ppf9n+LTG97wOxccliCJebKfcLDXURyfL0zKXnrIBRub3eUH2U5Sh2U+Zx7BP
         PGGaaFR7E6oDqHNs1KdkV2L9LhrsdJejyVhKIGCeBAzM/RzWaeP2WTDLPU0E9ZjqVtJ1
         Fc2AX4DiLZKJmIM51Go5nQ6u+6qcrRJU//8/Y7Pvstb+rGviexjoQtldo3YiRWLmiNlF
         7J0g==
X-Gm-Message-State: AGi0PuYrHuM8ICBavOzET+ojlCt3AlrMQR1T2cQRqTQ61uE2npHAP42q
        fbuw2t6tUsu7BcBJ1LHvLP/Tk9jKLDHT1tp5XCLaBKzcLkg=
X-Google-Smtp-Source: APiQypI8leUL2wa+1+Th/kkbzRCoTY15sjhgl6zgmecYEFxO55u/otlZDlvHNUSWbZwG4lkqcfWqn5nZJq6EwIncvFg=
X-Received: by 2002:a2e:7610:: with SMTP id r16mr7540423ljc.156.1588830222508;
 Wed, 06 May 2020 22:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com> <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
In-Reply-To: <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Thu, 7 May 2020 01:43:32 -0400
Message-ID: <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Well, the repair doesn't look terribly successful.

parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
parent transid verify failed on 218620880703488 wanted 6875841 found 687622=
4
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
parent level=3D1
                                            child level=3D4
ERROR: failed to zero log tree: -17
ERROR: attempt to start transaction over already running one
WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
extent buffer leak: start 225049066086400 len 4096
extent buffer leak: start 225049066086400 len 4096
WARNING: dirty eb leak (aborted trans): start 225049066086400 len 4096
extent buffer leak: start 225049066094592 len 4096
extent buffer leak: start 225049066094592 len 4096
WARNING: dirty eb leak (aborted trans): start 225049066094592 len 4096
extent buffer leak: start 225049066102784 len 4096
extent buffer leak: start 225049066102784 len 4096
WARNING: dirty eb leak (aborted trans): start 225049066102784 len 4096
extent buffer leak: start 225049066131456 len 4096
extent buffer leak: start 225049066131456 len 4096
WARNING: dirty eb leak (aborted trans): start 225049066131456 len 4096

What is going on?

On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.com> wrot=
e:
>
> Chris, I had used the correct mountpoint in the command. I just edited
> it in the email to be /mountpoint for consistency.
>
> Qu, I'll try the repair. Fingers crossed!
>
> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> > > Hello,
> > >
> > > I looked up this error and it basically says ask a developer to
> > > determine if it's a false error or not. I just started getting some
> > > slow response times, and looked at the dmesg log to find a ton of
> > > these errors.
> > >
> > > [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D5
> > > block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generat=
ion:
> > > has 18446744073709551492 expect [0, 6875827]
> > > [192088.449823] BTRFS error (device sdh): block=3D203510940835840 rea=
d
> > > time tree block corruption detected
> > > [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D5
> > > block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generat=
ion:
> > > has 18446744073709551492 expect [0, 6875827]
> > > [192088.462773] BTRFS error (device sdh): block=3D203510940835840 rea=
d
> > > time tree block corruption detected
> > > [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D5
> > > block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generat=
ion:
> > > has 18446744073709551492 expect [0, 6875827]
> > > [192088.468457] BTRFS error (device sdh): block=3D203510940835840 rea=
d
> > > time tree block corruption detected
> > >
> > > btrfs device stats, however, doesn't show any errors.
> > >
> > > Is there anything I should do about this, or should I just continue
> > > using my array as normal?
> >
> > This is caused by older kernel underflow inode generation.
> >
> > Latest btrfs-progs can fix it, using btrfs check --repair.
> >
> > Or you can go safer, by manually locating the inode using its inode
> > number (1311670), and copy it to some new location using previous
> > working kernel, then delete the old file, copy the new one back to fix =
it.
> >
> > Thanks,
> > Qu
> >
> > >
> > > Thank you!
> > >
> >
