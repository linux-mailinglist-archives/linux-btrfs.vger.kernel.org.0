Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCD2D3FE3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 11:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgLIKaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 05:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgLIKaR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Dec 2020 05:30:17 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BAC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Dec 2020 02:29:36 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id n9so318696qvp.5
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Dec 2020 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FXoHlHAVS5QaXQQ3hswe0UyvJg/XdYoumT/fLlox9YQ=;
        b=cKuPDL7uBcZDGReDzHlsqaQ5JOzj7Q5qV4pTVgvSg2SuWGcl2ud6NeTnuYFZioE4hj
         kNO09l1RSn69Vo0+jKo3M+yMOAnj/Dh7QDIKyUdwBUGTMYZziQRPLawcWQltS/2VmAdR
         uaSLz3QvFrDopee3K9QsgGiU8j8tPk/akCkC60h9Go8PorPV1QxEWuisr3FWNRZoBaMK
         HVoa/9hV4GhkBjX5WwUOSAFECeZlhVrhmhVjnnGkilmhXtEAuCjxBQvZLQ5tUsn7nmhj
         JLel8IG5892jbwA3SSN8y8A0XlepSCIThyM3Fvr5cVbNUWyKpwqBkZxa9F9UKvVl58AS
         5ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FXoHlHAVS5QaXQQ3hswe0UyvJg/XdYoumT/fLlox9YQ=;
        b=Ka2fIgPd9kBSUuUTIo2KBWyIWn/cztJBoBqpaB0P+LhyjTZQ+T/srJmWhpBdiN2oUo
         kiiVF4C8L78Kig5dDiNv0V4esx+d2jbAsxJ5eWAoRbIzmWro8/dkI4g4k8F0GJmL3AcY
         xD07p/Sei5L6+ouMPvfhEa4p9HSm5t80MsuyrcowHmD70o+6vlPrf3gR5DgxIOcWLmcU
         JRErKowieZZaYmFbj1TqJSZ38rzmWDq70HuPmIG0VxTwp3oiAZxUuHU3haja/04+M/l9
         INyRHD8GlX6LIPVEzzGVWM77Vyv1/RRPTdorzQxCbEf45613QxtJ83n5tAkDqHzPE3Ql
         joOw==
X-Gm-Message-State: AOAM532rHpw+4fZl7RsT4aGPuJG/crctycud8VdReKozw7IeJC6gTYS7
        Rl9JjmOQ3U4au7fpAeejIS2Xj3WiW15qOKLGjCFJQLgwqdIRNQ==
X-Google-Smtp-Source: ABdhPJx2DU7AdaJs0WcUySKv0+ACVD+K55xtejF+c6PSwj+T4RwffN+KjoeASMGok2P5SoLHbkh2py16dPPRYfpWhiE=
X-Received: by 2002:a0c:ac44:: with SMTP id m4mr2072473qvb.45.1607509775889;
 Wed, 09 Dec 2020 02:29:35 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
 <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net> <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
 <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net> <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
 <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net>
In-Reply-To: <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 9 Dec 2020 10:29:24 +0000
Message-ID: <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 9, 2020 at 10:10 AM Massimo B. <massimo.b@gmx.net> wrote:
>
> On Fri, 2020-12-04 at 15:00 +0000, Filipe Manana wrote:
> > Great, try this patch then:  https://pastebin.com/raw/8NcPVUb0
> >
> >
> >
> > I haven't had the time yet to craft a reproducer and confirm that is
> >
> > the case you are running into, but from the receive -vvv output you
> >
> > provided before, it seems clear what the problem is.
>
> No, that is not working.
> It does not fail anymore and looks like transferring as expected. But the
> receiving subvolume is exploding and creating lots of sub directories. I =
killed
> the send|receive processes.

Just to be clear, you mention that it does not fail anymore but then
you said you killed the processes.
If you kill it and don't let it end, it's not unexpected to have
temporary files/directories.

>
> du is far bigger than the origin subvolume and reveals some of those subd=
irs:

Ok, that is not unexpected and it can happen often, see below.

>
> ~ du -sh /mnt/local/data/snapshots/root/root.20180114T131123+0100/
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o1568-359797-0': No such file or directory
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o6060-359797-0': No such file or directory
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o9279-359797-0': No such file or directory
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o19075-359797-0': No such file or directory
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o19076-359797-0': No such file or directory
> ...
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o65078-359798-0': No such file or directory
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o65084-359798-0': No such file or directory
> du: cannot access '/mnt/local/data/snapshots/root/root.20180114T131123+01=
00/o65095-359798-0': No such file or directory
> 22G     /mnt/local/data/snapshots/root/root.20180114T131123+0100/
>
> compsize also reports about 20G referenced data.
>
> The origin subvol has only 12G referenced.

Ok, the size differences are not something unexpected - send does not
guarantee the sizes are preserved, neither does guarantee the same
extent layout as the source.
There are mainly two reasons for that:

1) Send currently doesn't have a command for hole punching, so holes
are considered a write full of zeros - if there's a 1G hole for
example, it's sent as a write operation with 1G zeros;

2) Sometimes shared extents are sent as regular writes and not clone
commands, one of the reasons for that is that when there are many
references for an extent, it's too slow to iterate its backreferences.
Also in a few corner cases we skip extent cloning.

I haven't got yet the chance to work on that, but at least that patch
fixes one type of problem, maybe you are hitting other different
problems too.

So to confirm if there are other problems, you really need to let send
and receive processes finish (don't kill them). If they finish without
failure, then check if temporary directories (or files with the same
name pattern) still exist or not.

Thanks.

>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
