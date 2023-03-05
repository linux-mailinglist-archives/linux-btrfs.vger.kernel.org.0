Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF56AAED9
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Mar 2023 10:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCEJmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Mar 2023 04:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEJmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Mar 2023 04:42:08 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 01:42:07 PST
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9212BDB
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Mar 2023 01:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678009325; i=lukasstraub2@web.de;
        bh=KcHWAD561MnLfLBi9p6PX2UTE7VXmcDIz7RuALr+Z6o=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PbIoqSLdXegMxZIS3JrXmFVVFC08L9tTnp3QFgLpxwPCWn2+/AFrjEIrcnunXTELT
         D7wdsXHHaX4z81vDCJLVyZAI3c1qp+XOsk+FV5PslJpMYtx8iFN0QVrYyXk84ahPE8
         s0vEUP//SSJcwGq9vuULDB7wIUkvTQGvpYji018VYGXirwFU3AX+Zo04Nx6zYw1otn
         iYmYsgcgcD8G9bDwy8FTMhPBMzockBcE+jY1JZPKvHq+LQ+/t6sBW9P0iOY/wPKQ8i
         5081tyRzM86fQfYszRaUXLzOOfIiCcq3N3lS7ZHwA1eVyS/9/pBSX78BJi0nMoupar
         Mm89/lcR8bbmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from gecko.fritz.box ([82.207.254.114]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1prOfi1q6G-00KxdB; Sun, 05
 Mar 2023 10:36:46 +0100
Date:   Sun, 5 Mar 2023 09:36:34 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Matt Corallo <blnxfsl@bluematt.me>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Salvaging the performance of a high-metadata filesystem
Message-ID: <20230305093634.759336dd@gecko.fritz.box>
In-Reply-To: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XAA05Mmf4zNkkk9/XWLEIMU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:/g75cpPuOQDyZ5fTSCmqC1c6Z9sFyjK3m86AnRTNtq7iYJwGMse
 QYVlMYtsQpq39klUlfSsEoiTJ7wgAzu/tT65mPL3MkConiubnkfef9SawR9moxGlmM8tDMv
 pK08ZSpTjGVaeHdd09OsunYJsGcGbdjTJx3QOY+mQJanz+C4B7P6ZXSD+wVJ12YtS41daZs
 M3o9sLFD2Ou3Ydn3+5l8g==
UI-OutboundReport: notjunk:1;M01:P0:P7dDbQM5Sbg=;v4ELPatObGCvdOvNVL6M7sso7h0
 N7iL4BmaS8YQvdRLV6XCR4plQ0PZ8sh5gmcDtRgDgUfGZFVCT7cVWOoXDIVnie1N01ZJN4qxq
 EuukOTtj+sZgJBBcE+wl8hPYwEsmCGjtpleNv+Vh1YIytpiknPo0q+1LEF2yvW1D44fg4Akr3
 7z/a2E/BI0Vgr0lOPTZqUEBl/9yWOe+HmnwFddz8N6/6pm1W4gmFvExLnYVwvyup1srtgo0/B
 gHjBZg6NbjtvGo+V9DspnC89d7qwBq8IfuLc3mqxwf7FGlyNPFr0+JWoHeB3aSlDmG2Oo88bl
 o080yj7+hjgzy7MLnM5n9DC5ZeCdkVgqcrbJ4KtZfbwF0ZgyP8acPOmsQu5Zc7Gg2SnV+SKMB
 1GrodE0KLwdxG6vkUnQHH281Fn8DxH2ZZdz794RuVqPzQXfIj8CT2WRwnXGwwPOqTyhuNZJl+
 E9xQwvuPif5e4TSgmqmKiUW9tb4EYiOZwHFNHZM2KRjhXy9Z/ayOc+SHcGLSANEAhA9sZ6SRo
 KHIUegaFseGVLfBui7oaZ5CnTy1iYO51wIacv+pkhULISffOChxRfXmeSVn7aWgNysjcPBNx9
 wNOduIHC8KmuYXG8YpWBxF19ylxSiLpAmOFH97iB62gbuRfvy0LSjRK/rrpOsFzcM79GKcygx
 MbfdO4eDW8nO+lybSE5FAehjeW1qFT49FUW2rEJvurJrqOrHRQWbUpdGH2WonMNvZcYeLMiT5
 O2y1rlCegbJpY+DvjsCq3+qmSqbpoy67RCMn8tAZM8bAH4bbVaAX+KACwlPImZ9QZKNohnOB7
 SEQ3ZrPiNmE9gZYMy+Un6FUXuXEMiopbGiTHK0sMzL78LEsVksBKqlSQKoFqq8jwMxRjRWPmO
 23nukCDCPm7/I+47tkXXV11TEkdseFcFWrjmWSNZHUeuF7Gy54ko+ISslIgRPIKUer1PU9YFD
 GuotAiyAwRwbiUnc1Z/t8Ej/l3c=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/XAA05Mmf4zNkkk9/XWLEIMU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Mar 2023 20:34:27 -0800
Matt Corallo <blnxfsl@bluematt.me> wrote:

> I have a ~seven year old BTRFS filesystem who's performance has slowly de=
graded to unusability.
>=20
> ...
>
> This has led to a lot of metadata:
> Metadata,RAID1C3: Size:1.48TiB, Used:1.46TiB (98.73%)
>=20
> ...
>
> I recently started adding some I/O to the machine, writing 1MB/s or two o=
f writes from openstack=20
> swift, which has now racked up a million or three files itself (in a dire=
ctory tree two layers of=20
> ~1000-folder directories deep). This has made the filesystem largely unus=
able.
>=20
> ...
>=20
> Thanks,
> Matt

Hi,
I suspect lots of inline files are bloating your metadata. Especially
from openstack swift, given that each object is stored as it's own file:
https://docs.openstack.org/swift/latest/overview_architecture.html#object-s=
erver
By default, btrfs will store all files smaller than 2048 bytes inline
(i.e. directly in the metadata). You can change that with the
"max_inline" mount option

You can count the number of inline files with something like:

find /mnt/hdd -type f -print0 | xargs -0 filefrag -v | grep inline | wc -l

Regards,
Lukas Straub

--=20


--Sig_/XAA05Mmf4zNkkk9/XWLEIMU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmQEYqIACgkQNasLKJxd
sljncg/8CS5hKPGgY+QSBX3FPULfrZpbID/RKyN8RoaJ2k7SHE82D8V6nrPLvgq+
8y+/RztTAfhMmnCqpDKKyTtgQ0j0yKc8sthuIl38BzFNGZ4uuRhHtv5H8Ny4iqo+
aOdIJsp2h8mCCmMwCurbA8S4EtP52rJTR/xfZXZDz7qEjI1aS9v/4JfCWgXGX//5
o1v06B0TeezGEjj29nxZ4HvhCD99PrqIwr08oNgrj4LaJWLpN+Lo3ReInLSfbDjR
KP8/HlRM4mXKQmuk5HcuInDb9YI23a16gJdhxL8d5hRfpcBvHYeNXm0EOGgdM7PZ
pcRO+I9vGJ3vJLLme8FCHEHtzlu88CeWtX2aISdKipZUxTcrRdb0IVvFCQa4wQ29
u2WdIlR4xwG6Ri++phJZYMm4TaXIvkLm9nz/WOdZ6rJDdnoQkkKJr37dxZFJL4Tg
6VCJSBGi/pmbp+wkoP7+fAOOgr95hP2WWNrJxgc/1Npla73lokOCW/EBCR3HXh1y
X9DuXGyJRwzjzsZITZ5vGgqVnhyEtO94koukdc9oxUv1hHXJTGaM1pb4UYS9S3o0
y52HRWsS2BYiO0BJYgfw2oUuZ+UB8dxOqP03O7sMuHabt0Sl7T2eTvxIdiQW/YZ2
kdegPq+zZ2Oj2lCtcgdNMIO9ysecY1PCS6SsQJiI2acpAHo0hjE=
=ctq3
-----END PGP SIGNATURE-----

--Sig_/XAA05Mmf4zNkkk9/XWLEIMU--
