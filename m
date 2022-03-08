Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39754D2428
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiCHWVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 17:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiCHWVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 17:21:39 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DE25F0
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 14:20:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so897015ejb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=UtUn7VagF2OP0vvodMhf55LihqE0PsE453f7RTB3MUQ=;
        b=ElIWhvaegeq7atHzIfj2Kqt47u83EjAw0dUqFZKxxPy3hVX5EnPZKH/lgwEVznmo21
         7ejLALUAtl79IAWw3QBMkS26eGn8dl28kcXumOLKat190/QmEo0oCU+bTtn32oaPRfMG
         qLo49px9xRTobW5m+Guh+JpRsNOnPylKXH52Y+RFJtBL14Z+zec+6cD9m0Us/yHAgsBc
         Q1veBpceczH9iFXmfXST5N5gjCMPdBQOWEVRyZk9/nZEFC3dqtAi09F9p6TSYlwZvujH
         TxnXryFDI1a+6xj2olJaO7NE+EI+7aCd1BbdWp2vyoM9LDueTHvOOb+i46oBRk9j1CCJ
         S5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=UtUn7VagF2OP0vvodMhf55LihqE0PsE453f7RTB3MUQ=;
        b=daQRWSD8kt2YP1ba7s57c9FEEIQq9Ol9C3BFohfbojmDKRzbGhO7C+o1obi2un97Fm
         r2wQz2Z+AaQFjTdjaRn9EOQoh/tQXEZrOn0N7qVQtjpIJ5jx6J+gh3diOswXTZVKuNaA
         Srd15aDztGjh4okNQw5uHx0G9pjk+QgiUWxebBQjnBSmbnfGzqt8jLEpshCuJK9snr0w
         EZ47XWPApSK504M+mmJh+cPZ5tZqUzCQQ85MSVHqGMUwhH3Bq+hO27cm3K/31bCpylXh
         cAtp9P7B89msWDDKiAYmzhIsNBeqSj0XzwN6L8m/iOvNUnK5lCgnDx9pn9uknGFLLAhB
         1JEw==
X-Gm-Message-State: AOAM530mWE7Ldio4IQe9mGcYm1FYXA6z+HPDBsuyvctD5NH5LspM65GW
        4tMDNFwrX1otjZmXdJSUn+MS01fa4D0=
X-Google-Smtp-Source: ABdhPJwn9i2+U3Y00BQ8GyALlhwjgCkF3phVxtGkkgtU3x1FD55SH1mNQGZoQwYy/T+UNyhX/vimuA==
X-Received: by 2002:a17:906:c145:b0:6da:aaaf:770c with SMTP id dp5-20020a170906c14500b006daaaaf770cmr14867714ejc.504.1646778040460;
        Tue, 08 Mar 2022 14:20:40 -0800 (PST)
Received: from [127.0.0.1] (p4fd0bd82.dip0.t-ipconnect.de. [79.208.189.130])
        by smtp.gmail.com with ESMTPSA id r11-20020a170906350b00b006dae77c09b3sm19765eja.154.2022.03.08.14.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 14:20:40 -0800 (PST)
Date:   Tue, 8 Mar 2022 22:20:39 +0000 (UTC)
From:   Emil <broetchenrackete@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <3a34f457-ed4e-4050-a24e-313af946d84d@gmail.com>
In-Reply-To: <CAJCQCtTgVyWGXG6psu2d_4BuH+y0SBm3Zxqr44qzJB9Huh__0Q@mail.gmail.com>
References: <1cb1e7d9-51d0-4c2e-8cd1-6b02d045bcad@gmail.com> <CAJCQCtTgVyWGXG6psu2d_4BuH+y0SBm3Zxqr44qzJB9Huh__0Q@mail.gmail.com>
Subject: Re: Recover btrfs partition after accidental reformat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3a34f457-ed4e-4050-a24e-313af946d84d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the tip with the overlay. Unfortunately recovering superblocks i=
sn't working:


[bluemond@BlueQ btrfsoverlay]$ sudo btrfs rescue super -v /dev/mapper/sdh1
All Devices:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device: id =3D 1, name =3D /dev/=
mapper/sdh1

Before Recovering:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [All good supers]:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device name =3D /dev/mapper/sdh1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 superblock bytenr =3D 274877906944

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [All bad supers]:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device name =3D /dev/mapper/sdh1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 superblock bytenr =3D 65536

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device name =3D /dev/mapper/sdh1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 superblock bytenr =3D 67108864


Make sure this is a btrfs disk otherwise the tool will destroy other fs, Ar=
e you sure? [y/N]: y
checksum verify failed on 22020096 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 22020096 wanted 0x00000000 found 0xb6bde3e4
ERROR: cannot read chunk root
Failed to recover bad superblocks

[bluemond@BlueQ btrfsoverlay]$ uname -a
Linux BlueQ 5.16.12-arch1-1 #1 SMP PREEMPT Wed, 02 Mar 2022 12:22:51 +0000 =
x86_64 GNU/Linux

[bluemond@BlueQ btrfsoverlay]$ btrfs version
btrfs-progs v5.16.2

For some reason I can't find anything btrfs related in dmesg...

8 Mar 2022 00:29:30 Chris Murphy <lists@colorremedies.com>:

> On Mon, Mar 7, 2022 at 1:10 PM Emil <broetchenrackete@gmail.com> wrote:
>>=20
>> Hi,
>>=20
>> I did a boo boo and reformatted my btrfs partition with NTFS (used the w=
rong /dev/sdX). It was a single drive with standard options (metadata dup, =
data single) and it was the only partition of the drive.
>=20
> You'll have damaged files most likely but there's some chance that
> with DUP metadata the file system can self-repair its way out of this
> mistake.
>=20
> You could check out
> https://raid.wiki.kernel.org/index.php/Irreversible_mdadm_failure_recover=
y#Simple_using_of_overlays
> for guidance on how to use device-mapper to make the drive partition
> read-only, and redirect any recovery attempts (writes) to a file so
> that it's all reversible. Or take a chance and just apply the changes
> to the partition directly... thought it could make things worse.
>=20
> My thought is to start out with wiping the NTFS signature only, and
> making a backup of it (optional, sorta boilerplate but it sounds like
> you don't care about this NTFS file system anyway since it was a
> mistake).
>=20
> wipefs -b -t ntfs /dev/sdXY
>=20
> Next, check status of superblocks before repairing them:
>=20
> btrfs rescue super -v /dev/sdXY
>=20
> If there are damaged superblocks it should give you a choice to repair
> them from a good superblock. You can do that. Next, try to mount it.
> If you're on overlay, just mount it normally and see what happens. If
> not, you might go more conservative with
>=20
> mount -o ro /dev/sdXY
>=20
> I'm actually not fully sure that this prevents all writes. i.e. if
> there's DUP metadata, and btrfs finds corruption with one copy, pretty
> sure it tries to write fixups from a good copy. The ro is a VFS mount
> option, and enforces no writes from user space, but the kernel code
> can still write. I think. So it's a small risk.
>=20
> I'd probably do this with a current stable or mainline kernel, i.e.
> 5.15+. This also allows you the option to use combinations of the
> rescue=3D mount options along with ro, in case too much metadata is
> damaged for normal mount, you can sometimes skip over the broken
> parts. If you're lucky, you might just end up with only some corrupt
> files. This will definitely produce a *lot* of btrfs kernel messages,
> you will get around 1/2 dozen at least per 4KiB block damaged.
>=20
> Good luck!
>=20
>=20
> --=20
> Chris Murphy
