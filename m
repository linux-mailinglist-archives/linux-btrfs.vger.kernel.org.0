Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1C34F568
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhCaAS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhCaASB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 20:18:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A4DC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 17:18:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v11so17853263wro.7
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cnu6JzsmWK7P+oj9/0OHdo1KHdubnhkGBiWMkFTts+s=;
        b=R2lTQaHUViBMogNCAKlXUFHIr/EpT5eZ3uRnz9U/KCDgOcy6qNrxb0Egpyn/kOYQ1R
         VD0JPnCjGo2PXIQevLQuA/okZF1TIdd0ygUke2lma9pKdLOsgBo2dTBlww4x+AS1GDzG
         R+ladk3BiUdconkydKrmDeF5VGPQER0yUNXiJn65jDZftE4/PPRmAP9PdKXUb2l+hhC7
         BSKd/piLFfG3/IfiIm9qhWGiVZtnzEmnYuAMequUF48VRPkCuEAv28YzKum+STVKPg8M
         tTERxuZnlz5oQKVlWpqd6DuJGNdMFSFH9lTdP/uKzzGztSsu1Q61CC6THbYDmEUikehV
         G7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=cnu6JzsmWK7P+oj9/0OHdo1KHdubnhkGBiWMkFTts+s=;
        b=ITfBTsvi9hvxWrbKWxnyGzmPOZ7nuI0r4d62nbvrIUftB67DhwZLVwSyxWWXOyT5aF
         iBS5jZ+evQJeNOO88MNKxY3ahYyHNx7/Fs4p3kCN4CMEJuDAyojRXwMw3crQJBqbre/m
         vt5g6dmrcaJSvHC1jvxkMTuSS5nZQIaoAmzK+Q6fhpXAUKJD7QYb9lNIpsJkoWrhh4UF
         Tnc3ZjJS6xnDK0ZorXFyCTeYbp/MF+cxbJpILH/RGgM0d/gCxi/2idLaRjvA+860z+Wm
         Zo4pufS/57HmmSOjV2pI8Dw60fa5xu9oCtIKJzsIS3FhmrlMw7F1sTBrSIgCFsyces+/
         HvNA==
X-Gm-Message-State: AOAM531bapmIM1q8N6v+KFO2nTB1zqy86z0Kc7eLSucvkwaIZzOf1j3m
        Fje08A/+V96t180xPYEKuiXbSDUNJfmAgO5TvW7fdreMyE8=
X-Google-Smtp-Source: ABdhPJw1vzEKCdFn6w9Aynrdbzq3NDysdDqTl8U+vS8+QVqS+PPjoOFKeZw58dpPRIQ0T1GyFwa9SD60c8M5p4/puAw=
X-Received: by 2002:adf:ec0b:: with SMTP id x11mr486338wrn.175.1617149879441;
 Tue, 30 Mar 2021 17:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
In-Reply-To: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
From:   Thierry Testeur <thierry.testeur@gmail.com>
Date:   Wed, 31 Mar 2021 02:17:48 +0200
Message-ID: <CABDFzMg1J_CDkNJ8JSvu2CkQT_ARHPw4_72C5BozbmYRxLKO6w@mail.gmail.com>
Subject: Re: Support demand on Btrfs crashed fs.
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

if anyone can help me with the problem above?
Have tried a Photorec (even if i know the chance are really poor), and
have got some non-sens files, lkie pdf of 2Gb, .... most of them are
unusable, except smal size file, like jpg pic...

thanks for any help.
Thierry

Le sam. 27 mars 2021 =C3=A0 12:09, Thierry Testeur
<thierry.testeur@gmail.com> a =C3=A9crit :
>
> Dear btrfs support community,
>
> after a bad power event, my 9 years old Btrfs has crashed.
> This Btrfs partirion is on an 8 disk mdadm array.
> After a few try on different options recovery found on "forums", have
> alreday tryed some
>
> btrfs check --repair
> btrfs check --init-extent-tree
> btrfs check --clear-space-cache,......
> btrfs rescue super-recover
> btrfs rescue chunk-recover
> btrfs rescue restore
> btrfs rescue chunk-recover: result on pastebin :https://pastebin.com/9aHe=
wZU4
> .....
> ....
>   Chunk: start =3D 26461360619520, len =3D 1073741824, type =3D 1, num_st=
ripes =3D 0
>       Stripes list:
>       Block Group: start =3D 26461360619520, len =3D 1073741824, flag =3D=
 1
>       No device extent.
>   Chunk: start =3D 26490351648768, len =3D 1073741824, type =3D 4, num_st=
ripes =3D 0
>       Stripes list:
>       Block Group: start =3D 26490351648768, len =3D 1073741824, flag =3D=
 4
>       No device extent.
>
> Total Chunks:           13797
>   Recoverable:          12233
>   Unrecoverable:        1564
>
> Orphan Block Groups:
>
> Orphan Device Extents:
>   Device extent: devid =3D 1, start =3D 20624466509824, len =3D 107374182=
4,
> chunk offset =3D 26284193218560
>   Device extent: devid =3D 1, start =3D 20625540251648, len =3D 107374182=
4,
> chunk offset =3D 26285266960384
>   Device extent: devid =3D 1, start =3D 20628761477120, len =3D 107374182=
4,
> chunk offset =3D 26288488185856
>   Device extent: devid =3D 1, start =3D 20630908960768, len =3D 107374182=
4,
> chunk offset =3D 26290635669504
>   Device extent: devid =3D 1, start =3D 20640572637184, len =3D 107374182=
4,
> chunk offset =3D 26300299345920
>   Device extent: devid =3D 1, start =3D 20641646379008, len =3D 107374182=
4,
> chunk offset =3D 26301373087744
>   Device extent: devid =3D 1, start =3D 20643793862656, len =3D 107374182=
4,
> chunk offset =3D 26303520571392
>   Device extent: devid =3D 1, start =3D 20645941346304, len =3D 107374182=
4,
> chunk offset =3D 26305668055040
>   Device extent: devid =3D 1, start =3D 20838141132800, len =3D 107374182=
4,
> chunk offset =3D 26497867841536
>   Device extent: devid =3D 1, start =3D 20839214874624, len =3D 107374182=
4,
> chunk offset =3D 26498941583360
>   Device extent: devid =3D 1, start =3D 20840288616448, len =3D 107374182=
4,
> chunk offset =3D 26500015325184
>   Device extent: devid =3D 1, start =3D 20841362358272, len =3D 107374182=
4,
> chunk offset =3D 26501089067008
>   Device extent: devid =3D 1, start =3D 20842436100096, len =3D 107374182=
4,
> chunk offset =3D 26502162808832
>   Device extent: devid =3D 1, start =3D 20844583583744, len =3D 107374182=
4,
> chunk offset =3D 26504310292480
>   Device extent: devid =3D 1, start =3D 20845657325568, len =3D 107374182=
4,
> chunk offset =3D 26505384034304
>   Device extent: devid =3D 1, start =3D 20846731067392, len =3D 107374182=
4,
> chunk offset =3D 26506457776128
>   Device extent: devid =3D 1, start =3D 20847804809216, len =3D 107374182=
4,
> chunk offset =3D 26507531517952
>   Device extent: devid =3D 1, start =3D 20848878551040, len =3D 107374182=
4,
> chunk offset =3D 26508605259776
>   Device extent: devid =3D 1, start =3D 20849952292864, len =3D 107374182=
4,
> chunk offset =3D 26509679001600
>   Device extent: devid =3D 1, start =3D 20851026034688, len =3D 107374182=
4,
> chunk offset =3D 26510752743424
>   Device extent: devid =3D 1, start =3D 20852099776512, len =3D 107374182=
4,
> chunk offset =3D 26511826485248
>   Device extent: devid =3D 1, start =3D 20856394743808, len =3D 107374182=
4,
> chunk offset =3D 26516121452544
>   Device extent: devid =3D 1, start =3D 20858542227456, len =3D 107374182=
4,
> chunk offset =3D 26518268936192
>   Device extent: devid =3D 1, start =3D 20862837194752, len =3D 107374182=
4,
> chunk offset =3D 26522563903488
>   Device extent: devid =3D 1, start =3D 20867132162048, len =3D 107374182=
4,
> chunk offset =3D 26526858870784
>   Device extent: devid =3D 1, start =3D 20868205903872, len =3D 107374182=
4,
> chunk offset =3D 26527932612608
>   Device extent: devid =3D 1, start =3D 20869279645696, len =3D 107374182=
4,
> chunk offset =3D 26529006354432
>   Device extent: devid =3D 1, start =3D 20870353387520, len =3D 107374182=
4,
> chunk offset =3D 26530080096256
>   Device extent: devid =3D 1, start =3D 20875722096640, len =3D 107374182=
4,
> chunk offset =3D 26535448805376
>   Device extent: devid =3D 1, start =3D 20876795838464, len =3D 107374182=
4,
> chunk offset =3D 26536522547200
>   Device extent: devid =3D 1, start =3D 20877869580288, len =3D 107374182=
4,
> chunk offset =3D 26537596289024
>   Device extent: devid =3D 1, start =3D 20882164547584, len =3D 107374182=
4,
> chunk offset =3D 26541891256320
>   Device extent: devid =3D 1, start =3D 20883238289408, len =3D 107374182=
4,
> chunk offset =3D 26542964998144
>   Device extent: devid =3D 1, start =3D 20884312031232, len =3D 107374182=
4,
> chunk offset =3D 26544038739968
>   Device extent: devid =3D 1, start =3D 20885385773056, len =3D 107374182=
4,
> chunk offset =3D 26545112481792
>
> Invalid mapping for 23079040999424-23079041003520, got
> 23080114061312-23081187803136
> Couldn't map the block 23079040999424
> Couldn't map the block 23079040999424
> bad tree block 23079040999424, bytenr mismatch, want=3D23079040999424, ha=
ve=3D0
> Couldn't read tree root
> open with broken chunk error
> Chunk tree recovery failed
>
>
>
> Informations required for support:
> uname -a:
> Linux UBUNTU-SERVER 5.8.0-48-generic #54-Ubuntu SMP Fri Mar 19
> 14:25:20 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> btrfs --version:
> btrfs-progs v5.11
> btrfs fi show:
> Label: none  uuid: f4f04e16-ce38-4a57-8434-67562a0790bd
>         Total devices 1 FS bytes used 24.71TiB
>         devid    1 size 18.83TiB used 18.67TiB path /dev/md0
> btrfs fi df /
> not mountable fs, so no results.
>  dmesg |grep -i btrfs:
> [    3.869542] Btrfs loaded, crc32c=3Dcrc32c-intel
> [    3.927255] BTRFS: device fsid f4f04e16-ce38-4a57-8434-67562a0790bd
> devid 1 transid 524941 /dev/md0 scanned by btrfs (260)
> [  667.478169] BTRFS info (device md0): disk space caching is enabled
> [  667.722168] BTRFS error (device md0): parent transid verify failed
> on 23079040831488 wanted 524940 found 524941
> [  667.722181] BTRFS warning (device md0): failed to read root (objectid=
=3D2): -5
> [  667.742931] BTRFS error (device md0): open_ctree failed
>
>
> If someone have any idea if i  have a little chance to get at least
> some of the data back, i will be very happy, as the last found backup
> of this massive partition was an 5 years old.
> Sorry for my English.
> Thierry
