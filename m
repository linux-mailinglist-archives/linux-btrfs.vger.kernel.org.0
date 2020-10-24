Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2684E297A22
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Oct 2020 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757760AbgJXBMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 21:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757755AbgJXBMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 21:12:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D9C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 18:11:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id p88so2715016qtd.12
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jqTb66J1t6zwioBbcZtdu/0rKW6Jl/KdT/owbySX6pY=;
        b=llW8JZh286Bxa/WBjD4B2fpXAYqK0/uKK1JmEftTa2a2k6RFGV8RutH5oVl/UWxEGJ
         atIhZk0hQa7bYi18Sg13+S8J4Gwp0jiLoCQfMsupIlL1MQn/kMZonwdF6VNGcU0w8E5f
         pTCd/iVZkoHQUKSFA/2h34WJW8kvmclxVfbULd17xTdFuVYLOfRV4W84YYTenCa7IHkJ
         CB7aeJ7RQIqbDanH7WXYDIo7LIM3rrfyfoUxPMyY+4xuDZz9EUvpx3Exz/kgPNg0XaiG
         1YWEAMYbWl9tAnrnd7QXoco/0zlYZ70pokw5k4DN5cFvqe4krPoCX3PdJEuJm4AmSTdp
         iCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jqTb66J1t6zwioBbcZtdu/0rKW6Jl/KdT/owbySX6pY=;
        b=sZ+qH83jMpQG3LxrMUXo79Z6tCsQOkiUeB3jiPnZNKn48Y1k7gEjbuQuqBJiQRDuOC
         4/nmjzle52HmBn4L3Jmx06luHfsvlBxfzWJcphqqq98/Q8WgzXl9H3raRLCd0Znl3kjE
         c7QPmANdQyRPZpY0+8B1/NH6A1Unk1d4GiPjh2jy4y6NIm7B4aXYwTZXoG/CmW7eEstb
         OusSpVglRxYWYo7zsfU1PZP97Btx1vvZvl5NNigq8bDDF0OGTfyY4TlUfS1GjoeNqSV2
         PvhUAWHpQC07JnckydHX8gyJZCyfQSGY+IMI1kIPOEhDktfy/nbKa4lTWFmHk9DUgIVS
         p13g==
X-Gm-Message-State: AOAM5324hAlVV+mkCWEDgSihuJG7t8O24tQOOfVZKVRo1j54YQrjE2cq
        BivFBHJOHCNR4bIpr0XiNe6KE7Ban/k=
X-Google-Smtp-Source: ABdhPJwobLFnX0pfn75QnUZ9oC4BcWKlpH04fPRhnaHA9NVS0LaE7oR7/hd0ftirLXFbbCxPbA98kg==
X-Received: by 2002:ac8:5903:: with SMTP id 3mr5350934qty.166.1603501915701;
        Fri, 23 Oct 2020 18:11:55 -0700 (PDT)
Received: from DigitalMercury.dynalias.net (bras-base-mtrlpq0313w-grc-01-65-94-13-54.dsl.bell.ca. [65.94.13.54])
        by smtp.gmail.com with ESMTPSA id 19sm2023829qkf.93.2020.10.23.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 18:11:54 -0700 (PDT)
Received: by DigitalMercury.dynalias.net (Postfix, from userid 1000)
        id 78C882C22FB; Fri, 23 Oct 2020 21:11:53 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     J J <j333111@icloud.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Drive won't mount, please help
In-Reply-To: <DFA69BD3-6415-4342-B17D-2CFBF0BED53F@icloud.com>
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com> <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com> <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com> <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com> <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com> <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com> <6BF631F4-3B9D-4332-AC42-2BCDE387322C@icloud.com> <CAJCQCtTvTH7XeA1F3nd011-X4vVUZJ15zRN2HK8cOL722oJ13A@mail.gmail.com> <DFA69BD3-6415-4342-B17D-2CFBF0BED53F@icloud.com>
Date:   Fri, 23 Oct 2020 21:11:37 -0400
Message-ID: <87sga4ctrq.fsf@DigitalMercury.dynalias.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi J J,

J J <j333111@icloud.com> writes:

> Thanks again Chris,=20
>
> Its btrfs-progs 4.7
>
> I spent an hour just trying to figure out how to update it, and still uns=
uccessful : (
>
> I=E2=80=99m running OMV 4, it=E2=80=99s debian.=20
>
> Sorry for such noob questions but can you tell me simplest way to update =
btrfs-progs?
>

OMV 4 appears to be based on Debian 9 (stretch).  If it's truly Debian,
then it should be safe to use backports.  If you s/buster/stretch/ with
the following instructions you will have access to btrfs-progs 4.20, the
last supported version for stretch-backports.

  https://backports.debian.org/Instructions

If you can upgrade to OVM 5, then you can use buster-backports and will
have access to btrfs-progs 5.7 today, and newer versions as they pass
migrate to testing and are then backported to buster (Debian 10).

If you want to try building the buster-backport on OMV 4, try:

  dget http://deb.debian.org/debian/pool/main/b/btrfs-progs/btrfs-progs_5.7=
-1~bpo10+1.dsc
  cd btrfs-progs-5.7
  apt-get build-dep ./
  dpkg-buildpackage -us -uc

but I haven't tested this, and it may not succeed (IIRC you'll need
newer libzstd and other things), and of course it's easier to use recent
live media as Chris Murphy suggested.

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4qYmHjkArtfNxmcIWogwR199EGEFAl+Tf0kACgkQWogwR199
EGFOLBAAxj9nP38JANb7bFsMMTuPeEqCQDAW2uNlEnfw/MZEI2LtkwiwVShvrmJe
CZoLGYZ20VDtvV27BupSNgItU5IvHut5Fv8EssbfQ4gKq8R2k91VDoZp6A3hIyG8
J0+AWp6kRM7tH4fhsqvmQiDTWtzezEwNCLlZJ0zwse9Y94iZmY/GYcphJYsDlEsW
DRaogN6mvOLWOrcgVnsw9JHKJFW7nf7aUcwyLyKxRLBELN5V7ZjeuTZOMHO/+a9c
Oo7xgGJiswIqJyE8lSXl1GI78lo1J/suWI0vqBUPYzMejumz2F1uqoACKOrW0RQM
zcd857fR/Kpk4flg08r0Ea+ryI8iM5YwLQVdL6qeuV1iaghgsH5rLSbT/5+SNKhA
+UV6Tu52vhFzWhbNw6A8WUBbL6idUOJd8wbHXTlBzVRKA9Cfam66km4KnQIvzTr7
0vPNBQn2FQpurLsBAlc0kEJe6mjMFCLlMeEmj//etTP1i2vDCZ1rdwK1pHXRE1bp
IIYPjEDfPBL2uzNu++pjEdL+P/S+HQEZj779Htme/btIlYc1bKNzeNx41hzrjyxJ
jwpUh4QSm46sXvm4auGoxc2GDSgvOqf4hf8eTFJJWs/SNNV/PV4C3bYQIvHGY31d
wuemu+nozLAVdCMYin1/VnE1iWMI1w9nwgUYhsvno66NhDK9BMQ=
=UsWv
-----END PGP SIGNATURE-----
--=-=-=--
