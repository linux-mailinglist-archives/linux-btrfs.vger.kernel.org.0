Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5555D33DDA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhCPTfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhCPTe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:34:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A6C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:34:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so169922wmf.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VowNHuK/3giszK+igDy5wTGPaGkDbp4kqyOU4Lc/N78=;
        b=bR6K6+TJ5q20kWJu2j+3e6L1cbG5v3lRvSYIFYtZ+HPwn1YOaLQPgZFWqerR6WpAMl
         Jv/+5bO47NAXZQnSxczpBPyqMloLKGvFuvB3rs8wOfJXdYcz8wZ3xWjuzjY6YzRl82T6
         LL/yCxdLi8GmbPmbrfV/eUY6n5fimh0kfEkIVJ08lXGK8+CVcWzci3O7FazaEggXe4j4
         VCp7VEwrqbNynWVg9A/vhw+p3tG62NAsIhg2/nqVGDuZ6alXdummGFGtR+YHMZleTvoG
         EqjuvVOllHN/tGwSwU3zswKMyDaK7H6ezD6VlvuwMQhjf01Mqay6uhXrP8ZX+IrG/oQd
         hjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VowNHuK/3giszK+igDy5wTGPaGkDbp4kqyOU4Lc/N78=;
        b=K79fz7XnWONLHxgbfowMzagj6nDXN9tUfwdGcekZ/c1cvbgocekKGFUt2T+3t6x4zN
         IrI2+TN+W6/AxuSJBurSTaediIiMuzca/R0zoXXJBQnXMj0k/WzURzlnR3tsHWwS1bB9
         48Lu7VPv/ydph2fgjO0HJoPv2GyoC2M/4uxaxTvXnzgRiImJccjl7S7hYr/s2GV1imtC
         1Kp76yz5Kw6879pYA46L0cf2WblPy5A+aCzMzPRqmaOfEsZrcHgYjEy50vzFLWaD244D
         geflD6sTlR0p4kw6fT7gdEzGf+F73dRo7MTJDvzptJUGZOQmFyyVIgKty7k7a3f2hWs+
         5BAQ==
X-Gm-Message-State: AOAM531niR/u5DkFxRR8vnE60hpn+Ty9Kjja1DVbrkfWaQRrLszwj1dN
        rULdrqmgEh+qX8GC+iZ5ihDwvRxyv+FSK2vjWgqHCnCMSDp4bQ==
X-Google-Smtp-Source: ABdhPJwoCX75lbvIFVmt7GPMfeVoIe41kRFyvcUN8E5CgeEnjpjX7IGd3VbwXQ8UvIQ3Tx6zELV/s+DvNyilS5vwI94=
X-Received: by 2002:a05:600c:acf:: with SMTP id c15mr410613wmr.124.1615923291227;
 Tue, 16 Mar 2021 12:34:51 -0700 (PDT)
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
 <CALS+qHPDYFU2mrzudR8w057Vo33NZ=YsRWJUYmAFUih1pWbz-w@mail.gmail.com>
 <CAJCQCtSDsVgrMnunviuAbgC_QFfOTDKdyRD1S=-5-Fbnv3EzBA@mail.gmail.com> <CALS+qHNfxPZqmYsWWqZZqPsyGLfWV5+-vrrqUMD84nRU6V_3VQ@mail.gmail.com>
In-Reply-To: <CALS+qHNfxPZqmYsWWqZZqPsyGLfWV5+-vrrqUMD84nRU6V_3VQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 16 Mar 2021 13:34:35 -0600
Message-ID: <CAJCQCtT47jRBkYn0D2CXtyeuc1_XFKAJ4oj1pnfOjmxY+NdxgQ@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Sebastian Roller <sebastian.roller@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

The problem exceeds my knowledge of both Btrfs and bcache/ssd failure
modes. I'm not sure what professional data recovery can really do,
other than throw a bunch of people at stitching things back together
again without any help from the file system. I know that the state of
the repair tools is not great, and it is confusing what to use in what
order. I don't know if a support contract from one of the distros
supporting Btrfs (most likely SUSE) is a better way to get assistance
with this kind of recovery while also supporting development. But
that's a question for SUSE sales :)

Most of the emphasis of upstream development has been on preventing
problems from happening to critical Btrfs metadata in the first place.
Its ability to self-heal really depends on it having independent block
devices to write to, e.g. metadata raid 1. Metadata DUP might normally
help with only spinning drives, but with a cache device, it's going to
cache all of these concurrent metadata writes.

If critical metadata is seriously damaged or missing, it's probably
impossible to fix or even skip over with the current state of the
tools. Current code needs an entry point into the chunk tree in order
to make the logical to physical mapping; and then needs an entry point
to the root tree to get to the proper snapshot file tree. If all the
recent and critical metadata is lost on the failed bcache caching
device, then a totally different strategy is needed.

The file btree for the snapshot you want should be on the backing
device, as well as its data chunks, and the mapping in the ~94% of the
chunk tree that's on disk. I won't be surprised if the file system is
broken beyond repair, but I'd be a little surprised if someone more
knowledgeable can't figure out a way to get the data out of a week old
snapshot. But that's speculation on my part. I really have no idea how
long it could take for bcache in writeback mode to flush to the
backing device.

--
Chris Murphy


On Tue, Mar 16, 2021 at 3:35 AM Sebastian Roller
<sebastian.roller@gmail.com> wrote:
>
> Hi again.
>
> > Looks like the answer is no. The chunk tree really has to be correct
> > first before anything else because it's central to doing all the
> > logical to physical address translation. And if it's busted and can't
> > be repaired then nothing else is likely to work or be repairable. It's
> > that critical.
> >
> > > I already ran chunk-recover. It needs two days to finish. But I used
> > > btrfs-tools version 4.14 and it failed.
> >
> > I'd have to go dig in git history to even know if there's been
> > improvements in chunk recover since then. But I pretty much consider
> > any file system's tool obsolete within a year. I think it's total
> > nonsense that distributions are intentionally using old tools.
> > >
> > > root@hikitty:/mnt$ btrfs rescue chunk-recover /dev/sdf1
> > > Scanning: DONE in dev0
> > > checksum verify failed on 99593231630336 found E4E3BDB6 wanted 000000=
00
> > > checksum verify failed on 99593231630336 found E4E3BDB6 wanted 000000=
00
> > > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000=
000
> > > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000=
000
> > > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000=
000
> > > checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000=
000
> > > bytenr mismatch, want=3D124762809384960, have=3D0
> > > open with broken chunk error
> > > Chunk tree recovery failed
> > >
> > > I could try again with a newer version. (?) Because with version 4.14
> > > also btrfs restore failed.
> >
> > It is entirely possible that 5.11 fails exactly the same way because
> > it's just too badly damaged for the current state of the recovery
> > tools to deal with damage of this kind. But it's also possible it'll
> > work. It's a coin toss unless someone else a lot more familiar with
> > the restore code speaks up. But looking at just the summary change
> > log, it looks like no work has happened in chunk recover for a while.
> >
> > https://btrfs.wiki.kernel.org/index.php/Changelog
>
> So I ran another chunk-recover with btrfs-progs version 5.11. This is
> part of the output. (The list doesn't allow me attach the whole output
> to this mail (5 mb zipped). But if you let me know what's important I
> can send that.)
>
> root@hikitty:~$ nohup /root/install/btrfs-progs-5.11/btrfs -v rescue
> chunk-recover /dev/sdi1 >
> /transfer/sebroll/btrfs-rescue-chunk-recover.out.txt 2>&1 &
> nohup: ignoring input
> All Devices:
>         Device: id =3D 2, name =3D /dev/sdi1
> Scanning: DONE in dev0
>
> DEVICE SCAN RESULT:
> Filesystem Information:
>         sectorsize: 4096
>         nodesize: 16384
>         tree root generation: 825256
>         chunk root generation: 825256
>
> All Devices:
>         Device: id =3D 2, name =3D /dev/sdi1
>
> All Block Groups:
>         Block Group: start =3D 49477515739136, len =3D 1073741824, flag =
=3D 1
>         Block Group: start =3D 49478589480960, len =3D 1073741824, flag =
=3D 1
> (=E2=80=A6)
>        Block Group: start =3D 141942960685056, len =3D 1073741824, flag =
=3D 1
>        Block Group: start =3D 141944034426880, len =3D 33554432, flag =3D=
 22
>
> All Chunks:
>         Chunk: start =3D 49477515739136, len =3D 1073741824, type =3D 1,
> num_stripes =3D 1
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 1048576
>         Chunk: start =3D 49478589480960, len =3D 1073741824, type =3D 1,
> num_stripes =3D 1
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 1074790400
> (=E2=80=A6)
>         Chunk: start =3D 141942960685056, len =3D 1073741824, type =3D 1,
> num_stripes =3D 1
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 75414325166080
>         Chunk: start =3D 141944034426880, len =3D 33554432, type =3D 22,
> num_stripes =3D 2
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 2034741805056
>             [ 1] Stripe: devid =3D 2, offset =3D 2034775359488
>
> All Device Extents:
>         Device extent: devid =3D 2, start =3D 1048576, len =3D 1073741824=
,
> chunk offset =3D 49477515739136
>         Device extent: devid =3D 2, start =3D 1074790400, len =3D
> 1073741824, chunk offset =3D 49478589480960
>         Device extent: devid =3D 2, start =3D 2148532224, len =3D
> 1073741824, chunk offset =3D 49479663222784
> (=E2=80=A6)
>         Device extent: devid =3D 2, start =3D 75412177682432, len =3D
> 1073741824, chunk offset =3D 141940813201408
>         Device extent: devid =3D 2, start =3D 75413251424256, len =3D
> 1073741824, chunk offset =3D 141941886943232
>         Device extent: devid =3D 2, start =3D 75414325166080, len =3D
> 1073741824, chunk offset =3D 141942960685056
>
> CHECK RESULT:
> Recoverable Chunks:
>   Chunk: start =3D 49477515739136, len =3D 1073741824, type =3D 1, num_st=
ripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 1048576
>       Block Group: start =3D 49477515739136, len =3D 1073741824, flag =3D=
 1
>       Device extent list:
>           [ 0]Device extent: devid =3D 2, start =3D 1048576, len =3D
> 1073741824, chunk offset =3D 49477515739136
>   Chunk: start =3D 49478589480960, len =3D 1073741824, type =3D 1, num_st=
ripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 1074790400
>       Block Group: start =3D 49478589480960, len =3D 1073741824, flag =3D=
 1
>       Device extent list:
>           [ 0]Device extent: devid =3D 2, start =3D 1074790400, len =3D
> 1073741824, chunk offset =3D 49478589480960
>   Chunk: start =3D 49479663222784, len =3D 1073741824, type =3D 1, num_st=
ripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 2148532224
>       Block Group: start =3D 49479663222784, len =3D 1073741824, flag =3D=
 1
>       Device extent list:
>           [ 0]Device extent: devid =3D 2, start =3D 2148532224, len =3D
> 1073741824, chunk offset =3D 49479663222784
> (=E2=80=A6)
>   Chunk: start =3D 141085812719616, len =3D 1073741824, type =3D 1, num_s=
tripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 74690623176704
>       No block group.
>       Device extent list:
>           [ 0]Device extent: devid =3D 2, start =3D 74690623176704, len =
=3D
> 1073741824, chunk offset =3D 141085812719616
>   Chunk: start =3D 141403740962816, len =3D 1073741824, type =3D 1, num_s=
tripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 73223891845120
>       No block group.
>       Device extent list:
>           [ 0]Device extent: devid =3D 2, start =3D 73223891845120, len =
=3D
> 1073741824, chunk offset =3D 141403740962816
> Unrecoverable Chunks:
>   Chunk: start =3D 73953460617216, len =3D 1073741824, type =3D 1, num_st=
ripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 23810225995776
>       No block group.
>       No device extent.
>   Chunk: start =3D 75698291081216, len =3D 1073741824, type =3D 1, num_st=
ripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 25555056459776
>       No block group.
>       No device extent.
> (=E2=80=A6)
>   Chunk: start =3D 139435974852608, len =3D 1073741824, type =3D 1, num_s=
tripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 49594055524352
>       Block Group: start =3D 139435974852608, len =3D 1073741824, flag =
=3D 1
>       No device extent.
>   Chunk: start =3D 140101996773376checksum verify failed on
> 99593231630336 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> checksum verify failed on 124762809384960 found 000000B6 wanted 00000000
> bad tree block 124762809384960, bytenr mismatch, want=3D124762809384960, =
have=3D0
> ERROR: failed to read block groups: Input/output error
> open with broken chunk error
> , len =3D 1073741824, type =3D 1, num_stripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 58501817696256
>       Block Group: start =3D 140101996773376, len =3D 1073741824, flag =
=3D 1
>       No device extent.
>   Chunk: start =3D 140221215670272, len =3D 1073741824, type =3D 1, num_s=
tripes =3D 1
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 58416992092160
>       Block Group: start =3D 140221215670272, len =3D 1073741824, flag =
=3D 1
>       No device extent.
> (=E2=80=A6)
>   Chunk: start =3D 141836593135616, len =3D 33554432, type =3D 22, num_st=
ripes =3D 2
>       Stripes list:
>       [ 0] Stripe: devid =3D 2, offset =3D 2034741805056
>       [ 1] Stripe: devid =3D 2, offset =3D 2034775359488
>       No block group.
>       No device extent.
>   Chunk: start =3D 141269456125952, len =3D 33554432, type =3D 22, num_st=
ripes =3D 0
>       Stripes list:
>       Block Group: start =3D 141269456125952, len =3D 33554432, flag =3D =
22
>       No device extent.
>
> Total Chunks:           72859
>   Recoverable:          68784
>   Unrecoverable:        4075
>
> Orphan Block Groups:
>
> Orphan Device Extents:
>
> Chunk tree recovery failed
>
>
>
> So. Is this good or bad? First, there are a lot of unrecoverable
> chunks. And some of them are system chunks.
> But my biggest issue seems to be that "bad tree block" error that is
> showing up and which I'm getting any time I try to access the
> file-system. This error also seems to prevent mounting and btrfs
> check. Can I use the position given there to look up the corresponding
> chunk? If so:
>
> Block Group and Chunks around bad tree block 124762809384960:
>
>         Block Group: start =3D 124760809799680, len =3D 1073741824, flag =
=3D 1
>         Block Group: start =3D 124761883541504, len =3D 1073741824, flag =
=3D 24
>         Block Group: start =3D 124798390763520, len =3D 1073741824, flag =
=3D
> 1
>
>         Chunk: start =3D 124760809799680, len =3D 1073741824, type =3D 1,
> num_stripes =3D 1
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 67164766732288
>         Chunk: start =3D 124761883541504, len =3D 1073741824, type =3D 24=
,
> num_stripes =3D 2
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 67165840474112
>             [ 1] Stripe: devid =3D 2, offset =3D 67166914215936
>         Chunk: start =3D 124777989668864, len =3D 1073741824, type =3D 1,
> num_stripes =3D 1
>             Stripes list:
>             [ 0] Stripe: devid =3D 2, offset =3D 67183020343296
>
> The bad tree block seems to contain meta data. Can I somehow recover
> this? It seems to be DUP (2 Stripes)=E2=80=A6
>
> > > > And you'll need to look for a snapshot name in there, find its byte=
nr,
> > > > and let's first see if just using that works. If it doesn't then ma=
ybe
> > > > combining it with the next most recent root tree will work.
> > >
> > > I am working backwards right now using btrfs restore -f in combinatio=
n
> > > with -t. So far no success.
> >
> > Yep. I think it comes down to the chunk tree needing to be reasonable
> > first, before anything else is possible.
>
> Now I tried every possible combination with btrfs restore.
> Unfortunately I found no working solution to restore the data
> undamaged. As mentioned before the files contain "holes" of 0x00.
> These holes are exactly 4 MiB in size. Does this tell anything?
> Any ideas how to proceed from here on? Accept the data loss and try to
> repair the files as good as possible -- putting them together from
> different saves (if available) is a real grind. Or professional data
> recovery -- but wouldn't they face the same issue regarding the
> chunk-tree?
>
> Kind regards,
> Sebastian



--=20
Chris Murphy
