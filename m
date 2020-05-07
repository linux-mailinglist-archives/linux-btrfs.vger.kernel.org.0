Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC11C9583
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEGPxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEGPxJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 11:53:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB9C05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 08:53:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u4so4891019lfm.7
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C/AXJ6sQUFOM3d7Q0le9bUFg6xPfG8tv82Vnc3Ew9sU=;
        b=dhcAQPJ7PRraGksQSAzz/JemMTrN7kINGp7z2HZzOgOGhcIZduYaQGT67i4igkKV1e
         9NwxL51dof5Gm+YuRyMMZ/IvVYP3035t8XQgPa+Iic02SKIihVYU/1hst08vuUjYZiSk
         evguZ2wCcWUS0MwQw3nVBwOcrAjGuT4MZEgIuMwepTJvdMW4uNjTWujwsS6CdM6bfftl
         A1DamEtdokiAWMdt1PkP68HD9SIJP95OOPUfNCvCwDrAdtLmmqfdj8HxkLqVEiOuyWpD
         in9K9hxzgbkEWIdOGdeNyvd3WligmlcTeLz+REbwX0eev5TQUliSDwGUavZPlHT/AFlV
         H+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C/AXJ6sQUFOM3d7Q0le9bUFg6xPfG8tv82Vnc3Ew9sU=;
        b=Uu1sGtxuHKTejvVVNhBX+bO3Vj25S6jdlGbBB4khLIFrrc3g/bt2NLFgehL8KYT+J4
         y+JYN4CxtnioLLmuSEBIAfBYiDeJOj6X35mAZYcVt/334xo5iPPeA/I+EgNG+Pm3qGxF
         FH/x1AN2uZpAFgApkqjpzhThj7OTXgeBb7Kgy60rFIgcECVBYDkO+DjD0X76fRGzjsgY
         qBwmEI5mHLsAap6Rn3eRdrQ3asyDc6dN9WjXfFP/JLuS9xQLPlrdluWzGNC5pUdobx5L
         h2GRN8KU4aaWDnFLZjb1Mpjh6CWIHkcYS1QjeyI1Tuplmlv/fTeu9QIkJt4KTpnoeSPZ
         9jbg==
X-Gm-Message-State: AGi0PuY6Lx+rPznOmk3hiTCPkjWaatX4d4XwQFlu4D7LBKFRFodZC4pA
        /lbel7kY0AxDXE31kxUuLEVnaZnxzLAJv0KSfYY9etSs
X-Google-Smtp-Source: APiQypJNo6mQYma/esqBgrl8+oZj2JtVpKFexhkvLPBmiJ4h1g3GJEjyLW7OVcFEX+C7PldTj+8CbGI+o//hMusRy2w=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr5607748lfi.21.1588866787259;
 Thu, 07 May 2020 08:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com> <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com> <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
In-Reply-To: <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Thu, 7 May 2020 11:52:56 -0400
Message-ID: <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for helping. The end result of the scan was:


[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
there are no extents for csum range 0-69632
csum exists for 0-69632 but there is no extent record
...
...
there are no extents for csum range 946692096-946827264
csum exists for 946692096-946827264 but there is no extent record
there are no extents for csum range 946831360-947912704
csum exists for 946831360-947912704 but there is no extent record
ERROR: errors found in csum tree
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 44157956026368 bytes used, error(s) found
total csum bytes: 42038602716
total tree bytes: 49688616960
total fs tree bytes: 1256427520
total extent tree bytes: 1709105152
btree space waste bytes: 3172727316
file data blocks allocated: 261625653436416
 referenced 47477768499200

What do I need to do to fix all of this?

On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
> > Well, the repair doesn't look terribly successful.
> >
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
>
> This means there are more problems, not only the hash name mismatch.
>
> This means the fs is already corrupted, the name hash is just one
> unrelated symptom.
>
> The only good news is, btrfs-progs abort the transaction, thus no
> further damage to the fs.
>
> Please run a plain btrfs-check to show what's the problem first.
>
> Thanks,
> Qu
>
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > parent transid verify failed on 218620880703488 wanted 6875841 found 68=
76224
> > Ignoring transid failure
> > ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> > parent level=3D1
> >                                             child level=3D4
> > ERROR: failed to zero log tree: -17
> > ERROR: attempt to start transaction over already running one
> > WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
> > extent buffer leak: start 225049066086400 len 4096
> > extent buffer leak: start 225049066086400 len 4096
> > WARNING: dirty eb leak (aborted trans): start 225049066086400 len 4096
> > extent buffer leak: start 225049066094592 len 4096
> > extent buffer leak: start 225049066094592 len 4096
> > WARNING: dirty eb leak (aborted trans): start 225049066094592 len 4096
> > extent buffer leak: start 225049066102784 len 4096
> > extent buffer leak: start 225049066102784 len 4096
> > WARNING: dirty eb leak (aborted trans): start 225049066102784 len 4096
> > extent buffer leak: start 225049066131456 len 4096
> > extent buffer leak: start 225049066131456 len 4096
> > WARNING: dirty eb leak (aborted trans): start 225049066131456 len 4096
> >
> > What is going on?
> >
> > On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.com> =
wrote:
> >>
> >> Chris, I had used the correct mountpoint in the command. I just edited
> >> it in the email to be /mountpoint for consistency.
> >>
> >> Qu, I'll try the repair. Fingers crossed!
> >>
> >> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >>>
> >>>
> >>>
> >>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> >>>> Hello,
> >>>>
> >>>> I looked up this error and it basically says ask a developer to
> >>>> determine if it's a false error or not. I just started getting some
> >>>> slow response times, and looked at the dmesg log to find a ton of
> >>>> these errors.
> >>>>
> >>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D5
> >>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode genera=
tion:
> >>>> has 18446744073709551492 expect [0, 6875827]
> >>>> [192088.449823] BTRFS error (device sdh): block=3D203510940835840 re=
ad
> >>>> time tree block corruption detected
> >>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D5
> >>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode genera=
tion:
> >>>> has 18446744073709551492 expect [0, 6875827]
> >>>> [192088.462773] BTRFS error (device sdh): block=3D203510940835840 re=
ad
> >>>> time tree block corruption detected
> >>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D5
> >>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode genera=
tion:
> >>>> has 18446744073709551492 expect [0, 6875827]
> >>>> [192088.468457] BTRFS error (device sdh): block=3D203510940835840 re=
ad
> >>>> time tree block corruption detected
> >>>>
> >>>> btrfs device stats, however, doesn't show any errors.
> >>>>
> >>>> Is there anything I should do about this, or should I just continue
> >>>> using my array as normal?
> >>>
> >>> This is caused by older kernel underflow inode generation.
> >>>
> >>> Latest btrfs-progs can fix it, using btrfs check --repair.
> >>>
> >>> Or you can go safer, by manually locating the inode using its inode
> >>> number (1311670), and copy it to some new location using previous
> >>> working kernel, then delete the old file, copy the new one back to fi=
x it.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>>
> >>>> Thank you!
> >>>>
> >>>
>
