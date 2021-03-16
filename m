Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2733D0EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhCPJgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 05:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhCPJf6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 05:35:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0FC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 02:35:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k2so36444260ioh.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gPihnxSkWQWHZsy5TVVheo4uIjPXiEfjhOb6VUGD6rI=;
        b=BxSisfMjJ/AXN1xIb6Hq8FtiX2maDYu9/QL1cx3yh1HHK74u5VeSHFmdahMsSGOXHP
         a6PrkRB21oeIQFY45ywGzATtS1v1AzmbijJg9G0jnftD8c0d4I8VLI9wVEGnExpuytOF
         96aSBbTUiP1kilKIphgG8wgChWXMSBSeC4jJkt+S2+71a+VP8Zw5lnY+p5CjqsjCHlCb
         aXkAcIeXIoRVlg1Tk8vdkVGw37v7lRFyWGQL20lZnVakXURpn2H1O5/vuFWMdXz6p0uc
         qMVGdZjoYIzopB9qKsBhm07m9aY+d73eBiiWIa4+CVimxiVQ9HM2+HGBKxINLKc1Rm0B
         i12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gPihnxSkWQWHZsy5TVVheo4uIjPXiEfjhOb6VUGD6rI=;
        b=QG1OUhpN6pnxiXfroZZNYsfwFWELv31lO5V7i+jgNKcaG3mR96zPWJ5jZs2H9XPuOe
         rTWpjHSZPAoko+dKvxlSRj+y5g6K0ohUVFa92VzyEpt7LfEVb9UFj2h5oGAkWneoQ8fT
         d/2hSRHh3TcGtEhbjfLY8dOiRcWiYVZQWJT590kL5Z9CbW8OFsRVERQd8ixZ1YdaEv6u
         ihFaXhsjPN30rMAWQxJPDgtMtAAHB4EPGt156GPAJ8TsmA7rdETkDz9HXBGrHs0sf+yI
         qrK2UXmJUQo3NyIlgzpgaR1ntfm6P0nvS46Ey05IhpicYVcyVBeN5SbqbLRy7Y7lppK8
         Kmgw==
X-Gm-Message-State: AOAM532ohBHMZgtOR9dr8VCyzQ3kLremNgf76bR3QcoKiPH9KDJ9Pkyu
        ygvoRFKwgTONEb5TPCWzen4aOOqzYEmWOxRhV2M=
X-Google-Smtp-Source: ABdhPJxmAsaGUM2VqEc/GglC83QobT7ZGLO/Pj+PDlBofZmo5D1ar7mT9wcIOZ/hiRT01okLoP8l3mVuyF/STjIQERY=
X-Received: by 2002:a05:6638:1508:: with SMTP id b8mr13217520jat.134.1615887357952;
 Tue, 16 Mar 2021 02:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
 <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
 <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
 <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com>
 <CALS+qHN7hyFzKZHrMj5_95pPTPR9sEgwqzgVqxFK70fs5FW4xA@mail.gmail.com>
 <CAJCQCtRWRq-AR1+hF03W0q+bG3sO618p6GzTtN1EWCJijzKe9g@mail.gmail.com>
 <CALS+qHPDYFU2mrzudR8w057Vo33NZ=YsRWJUYmAFUih1pWbz-w@mail.gmail.com> <CAJCQCtSDsVgrMnunviuAbgC_QFfOTDKdyRD1S=-5-Fbnv3EzBA@mail.gmail.com>
In-Reply-To: <CAJCQCtSDsVgrMnunviuAbgC_QFfOTDKdyRD1S=-5-Fbnv3EzBA@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Tue, 16 Mar 2021 10:35:21 +0100
Message-ID: <CALS+qHNfxPZqmYsWWqZZqPsyGLfWV5+-vrrqUMD84nRU6V_3VQ@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again.

> Looks like the answer is no. The chunk tree really has to be correct
> first before anything else because it's central to doing all the
> logical to physical address translation. And if it's busted and can't
> be repaired then nothing else is likely to work or be repairable. It's
> that critical.
>
> > I already ran chunk-recover. It needs two days to finish. But I used
> > btrfs-tools version 4.14 and it failed.
>
> I'd have to go dig in git history to even know if there's been
> improvements in chunk recover since then. But I pretty much consider
> any file system's tool obsolete within a year. I think it's total
> nonsense that distributions are intentionally using old tools.
> >
> > root@hikitty:/mnt$ btrfs rescue chunk-recover /dev/sdf1
> > Scanning: DONE in dev0
> > checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
> > checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
> > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 0000000=
0
> > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 0000000=
0
> > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 0000000=
0
> > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 0000000=
0
> > bytenr mismatch, want=3D124762809384960, have=3D0
> > open with broken chunk error
> > Chunk tree recovery failed
> >
> > I could try again with a newer version. (?) Because with version 4.14
> > also btrfs restore failed.
>
> It is entirely possible that 5.11 fails exactly the same way because
> it's just too badly damaged for the current state of the recovery
> tools to deal with damage of this kind. But it's also possible it'll
> work. It's a coin toss unless someone else a lot more familiar with
> the restore code speaks up. But looking at just the summary change
> log, it looks like no work has happened in chunk recover for a while.
>
> https://btrfs.wiki.kernel.org/index.php/Changelog

So I ran another chunk-recover with btrfs-progs version 5.11. This is
part of the output. (The list doesn't allow me attach the whole output
to this mail (5 mb zipped). But if you let me know what's important I
can send that.)

root@hikitty:~$ nohup /root/install/btrfs-progs-5.11/btrfs -v rescue
chunk-recover /dev/sdi1 >
/transfer/sebroll/btrfs-rescue-chunk-recover.out.txt 2>&1 &
nohup: ignoring input
All Devices:
        Device: id =3D 2, name =3D /dev/sdi1
Scanning: DONE in dev0

DEVICE SCAN RESULT:
Filesystem Information:
        sectorsize: 4096
        nodesize: 16384
        tree root generation: 825256
        chunk root generation: 825256

All Devices:
        Device: id =3D 2, name =3D /dev/sdi1

All Block Groups:
        Block Group: start =3D 49477515739136, len =3D 1073741824, flag =3D=
 1
        Block Group: start =3D 49478589480960, len =3D 1073741824, flag =3D=
 1
(=E2=80=A6)
       Block Group: start =3D 141942960685056, len =3D 1073741824, flag =3D=
 1
       Block Group: start =3D 141944034426880, len =3D 33554432, flag =3D 2=
2

All Chunks:
        Chunk: start =3D 49477515739136, len =3D 1073741824, type =3D 1,
num_stripes =3D 1
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 1048576
        Chunk: start =3D 49478589480960, len =3D 1073741824, type =3D 1,
num_stripes =3D 1
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 1074790400
(=E2=80=A6)
        Chunk: start =3D 141942960685056, len =3D 1073741824, type =3D 1,
num_stripes =3D 1
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 75414325166080
        Chunk: start =3D 141944034426880, len =3D 33554432, type =3D 22,
num_stripes =3D 2
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 2034741805056
            [ 1] Stripe: devid =3D 2, offset =3D 2034775359488

All Device Extents:
        Device extent: devid =3D 2, start =3D 1048576, len =3D 1073741824,
chunk offset =3D 49477515739136
        Device extent: devid =3D 2, start =3D 1074790400, len =3D
1073741824, chunk offset =3D 49478589480960
        Device extent: devid =3D 2, start =3D 2148532224, len =3D
1073741824, chunk offset =3D 49479663222784
(=E2=80=A6)
        Device extent: devid =3D 2, start =3D 75412177682432, len =3D
1073741824, chunk offset =3D 141940813201408
        Device extent: devid =3D 2, start =3D 75413251424256, len =3D
1073741824, chunk offset =3D 141941886943232
        Device extent: devid =3D 2, start =3D 75414325166080, len =3D
1073741824, chunk offset =3D 141942960685056

CHECK RESULT:
Recoverable Chunks:
  Chunk: start =3D 49477515739136, len =3D 1073741824, type =3D 1, num_stri=
pes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 1048576
      Block Group: start =3D 49477515739136, len =3D 1073741824, flag =3D 1
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 1048576, len =3D
1073741824, chunk offset =3D 49477515739136
  Chunk: start =3D 49478589480960, len =3D 1073741824, type =3D 1, num_stri=
pes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 1074790400
      Block Group: start =3D 49478589480960, len =3D 1073741824, flag =3D 1
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 1074790400, len =3D
1073741824, chunk offset =3D 49478589480960
  Chunk: start =3D 49479663222784, len =3D 1073741824, type =3D 1, num_stri=
pes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 2148532224
      Block Group: start =3D 49479663222784, len =3D 1073741824, flag =3D 1
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 2148532224, len =3D
1073741824, chunk offset =3D 49479663222784
(=E2=80=A6)
  Chunk: start =3D 141085812719616, len =3D 1073741824, type =3D 1, num_str=
ipes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 74690623176704
      No block group.
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 74690623176704, len =3D
1073741824, chunk offset =3D 141085812719616
  Chunk: start =3D 141403740962816, len =3D 1073741824, type =3D 1, num_str=
ipes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 73223891845120
      No block group.
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 73223891845120, len =3D
1073741824, chunk offset =3D 141403740962816
Unrecoverable Chunks:
  Chunk: start =3D 73953460617216, len =3D 1073741824, type =3D 1, num_stri=
pes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 23810225995776
      No block group.
      No device extent.
  Chunk: start =3D 75698291081216, len =3D 1073741824, type =3D 1, num_stri=
pes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 25555056459776
      No block group.
      No device extent.
(=E2=80=A6)
  Chunk: start =3D 139435974852608, len =3D 1073741824, type =3D 1, num_str=
ipes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 49594055524352
      Block Group: start =3D 139435974852608, len =3D 1073741824, flag =3D =
1
      No device extent.
  Chunk: start =3D 140101996773376checksum verify failed on
99593231630336 found 000000B6 wanted 00000000
checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960, ha=
ve=3D0
ERROR: failed to read block groups: Input/output error
open with broken chunk error
, len =3D 1073741824, type =3D 1, num_stripes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 58501817696256
      Block Group: start =3D 140101996773376, len =3D 1073741824, flag =3D =
1
      No device extent.
  Chunk: start =3D 140221215670272, len =3D 1073741824, type =3D 1, num_str=
ipes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 58416992092160
      Block Group: start =3D 140221215670272, len =3D 1073741824, flag =3D =
1
      No device extent.
(=E2=80=A6)
  Chunk: start =3D 141836593135616, len =3D 33554432, type =3D 22, num_stri=
pes =3D 2
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 2034741805056
      [ 1] Stripe: devid =3D 2, offset =3D 2034775359488
      No block group.
      No device extent.
  Chunk: start =3D 141269456125952, len =3D 33554432, type =3D 22, num_stri=
pes =3D 0
      Stripes list:
      Block Group: start =3D 141269456125952, len =3D 33554432, flag =3D 22
      No device extent.

Total Chunks:           72859
  Recoverable:          68784
  Unrecoverable:        4075

Orphan Block Groups:

Orphan Device Extents:

Chunk tree recovery failed



So. Is this good or bad? First, there are a lot of unrecoverable
chunks. And some of them are system chunks.
But my biggest issue seems to be that "bad tree block" error that is
showing up and which I'm getting any time I try to access the
file-system. This error also seems to prevent mounting and btrfs
check. Can I use the position given there to look up the corresponding
chunk? If so:

Block Group and Chunks around bad tree block 124762809384960:

        Block Group: start =3D 124760809799680, len =3D 1073741824, flag =
=3D 1
        Block Group: start =3D 124761883541504, len =3D 1073741824, flag =
=3D 24
        Block Group: start =3D 124798390763520, len =3D 1073741824, flag =
=3D
1

        Chunk: start =3D 124760809799680, len =3D 1073741824, type =3D 1,
num_stripes =3D 1
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 67164766732288
        Chunk: start =3D 124761883541504, len =3D 1073741824, type =3D 24,
num_stripes =3D 2
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 67165840474112
            [ 1] Stripe: devid =3D 2, offset =3D 67166914215936
        Chunk: start =3D 124777989668864, len =3D 1073741824, type =3D 1,
num_stripes =3D 1
            Stripes list:
            [ 0] Stripe: devid =3D 2, offset =3D 67183020343296

The bad tree block seems to contain meta data. Can I somehow recover
this? It seems to be DUP (2 Stripes)=E2=80=A6

> > > And you'll need to look for a snapshot name in there, find its bytenr=
,
> > > and let's first see if just using that works. If it doesn't then mayb=
e
> > > combining it with the next most recent root tree will work.
> >
> > I am working backwards right now using btrfs restore -f in combination
> > with -t. So far no success.
>
> Yep. I think it comes down to the chunk tree needing to be reasonable
> first, before anything else is possible.

Now I tried every possible combination with btrfs restore.
Unfortunately I found no working solution to restore the data
undamaged. As mentioned before the files contain "holes" of 0x00.
These holes are exactly 4 MiB in size. Does this tell anything?
Any ideas how to proceed from here on? Accept the data loss and try to
repair the files as good as possible -- putting them together from
different saves (if available) is a real grind. Or professional data
recovery -- but wouldn't they face the same issue regarding the
chunk-tree?

Kind regards,
Sebastian
