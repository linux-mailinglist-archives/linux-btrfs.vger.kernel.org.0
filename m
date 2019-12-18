Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D746B123B89
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRA2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:28:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:40281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRA2H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576628878;
        bh=uH8u3pwPviZTCwPoRXTTllNUhB/IVjtBrVlnUZ0ppi0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NvUT/mYL0klHdmxPDFd44C58Os9zKrFJpHsfar4zHAKL8FN18qXGnFNmgKeUCQTEV
         aOqNSWWgBIzIeRX3P1NM5GqS99p/egOVFZA+5fv8bF6OmU1DmCWptBsO/berREsBls
         M/Y6qg+nkqdYm5wMdSnj2sFfEUN8iKBac8VpoFrQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoRK-1iVm5T1v1S-00EvJm; Wed, 18
 Dec 2019 01:27:58 +0100
Subject: Re: [btrfs-progs PATCH 3/4] tests: mkfs: 005: Use
 check_dm_target_support helper
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-4-marcos.souza.org@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ff0101f8-b05d-5666-a81a-1f37fc025672@gmx.com>
Date:   Wed, 18 Dec 2019 08:27:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217203155.24206-4-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HtK94Lzh6lB4ZmEHDZovsQRWm0DYiQ3RU"
X-Provags-ID: V03:K1:Xyawa0YV3Fd4Hln8gLd3URE4ctpPMxencFpFQFJbvFbkxLQwkpx
 khu35fI5vcA9Mj4Qn810Mo9JWZQhJDPar7dUMBRWgqOj5gcSQo33T2cda1938cdym1UM4EZ
 K2F8fts5sb+3X3b86PD4QnxRKSltMQOe2UXjWAkTPxPNv8eC1NzUQ2LcpYZsr1U92qnx8PD
 ACoGQWqy59AYgb2GMLxoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:59I/EsaVfUw=:Okncc9yvnz0PZ8xsXJahzI
 FpNvQAAebuo2cPC08QvRlPSgGLkrzlYIeMxwXHRtzaidJbHlMXaun496RZiTF6jbIUSnIYilo
 NTgT9PpWpxhRfcb7Ou6fCSiYTPw3EVVvc9sAkKzOyfau5Q7VeMbIj5u3ZR58SlsDtC2gaiWE8
 2gEJDG9XPQr6A7c8rq4DMMcpTFjQ+C7FkykKXSJ+uZloqaHalW5wopveBGH1GcoKg7Rg3cmUt
 LTIzmmXMn7LQQQjQjEcApYmSz2gjRTOs74pDx/ojvc9P7fDmqTft0yJsTS4pzkaMO1//+mxoN
 f2GD1nlVZJuusncflyGekXhxFd1ExQfOEguu/E1Pa+aZybZlC0oRc+nIF7DvhvdYBKKlpnjo/
 uQbwZT2bM8gvLEmhPST+OJUXUFISNE69PRFoCDWaAVfMZScj9GgkbqqQbZHbKiayY/h8Kz4aH
 U8K/6Ty98kIim6KrmwnQd+7PnMhW94k8odulZJvK4L7kLxNt8z4LgfboynQVXFfps6m3aVz3s
 36tCL6lQXGcWoaXQbtu/jejVXReEbTp/ZEUUiLcZg6ZXl/ywKoczPIGaohsNJC9sRNeXE4i0D
 PqPps13nvb9DcOXEURB3I/PmWsSyseACBXvdK2tnr5In+KG380EbujBIWAl/GvLh+1isA+91X
 HfxnCxoCYWkP1iCCIvdHalTr2BWjPXeU0ytP/PxjggnFlRtBKjfYUjmbMUKh2cDg4BqT73Fs1
 +yS8nL3NKZCDLypjVJg+ITjHaeSML4YEG5+i/N6CyUEAaGuyHFR3nVHCVCVJ/aeNOzx02u9FX
 hRh6zUcA/NgOl6Tg3EKEFfB8zABUkwEJ07FsDMmvwhnAwYW/2GRTJkVIoTpi9i6W3+qC5imDs
 vmmm+4CQyHRpXYlKohN7BnVxJJcxRl3eCaGAZwik9g6JNdKp8RnjwUE5qfBuW8mHInVOO+su6
 5+pB4oS8OONtI5/oeXW3vrxIkxn1lJwrcBoVneG3zHkF3gWTwdn9MrBAM/PwhROZGzj47SW2F
 Z6q3AeSmi3hp5QTEzITewhDs3Uh1bdUbCIrOYfKdrnatq/KoLhyt08XxsyifOROJqM7dW5EBi
 qt8nJDDoCbv7uEw0JlGE/GqGiKeP+tunRCq1q7RqBT3VRkn2yOem+OhDUXFPdWVJjZ0q1bLH5
 UYEFZDG3NlkLLZJGBwBnBpPH0EsZafAwZUOnBzysXZz9vh7G0ZbPQxxahXsJKh2gVcmWyF4ef
 Wvrn2yiIAntse+dHXRsTCRUvChCkPn0mVmo/s5zYdiwhyNUsZjGXT5DQmlTc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HtK94Lzh6lB4ZmEHDZovsQRWm0DYiQ3RU
Content-Type: multipart/mixed; boundary="ZanEmlQNU9A35wp7rxwHFeotvqo7lj7dy"

--ZanEmlQNU9A35wp7rxwHFeotvqo7lj7dy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=884:31, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> This way we ensure the linear target is available and skip the test.
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  tests/mkfs-tests/005-long-device-name-for-ssd/test.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/te=
sts/mkfs-tests/005-long-device-name-for-ssd/test.sh
> index e7a1ac45..329deaf2 100755
> --- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> +++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
> @@ -5,6 +5,7 @@ source "$TEST_TOP/common"
> =20
>  check_prereq mkfs.btrfs
>  check_global_prereq dmsetup
> +check_dm_target_support linear
> =20
>  setup_root_helper
>  prepare_test_dev
>=20


--ZanEmlQNU9A35wp7rxwHFeotvqo7lj7dy--

--HtK94Lzh6lB4ZmEHDZovsQRWm0DYiQ3RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35cokXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgPHwgArc4FGynY+Qd8Kgq9xTSQbYQZ
h3sevuIpcPBPPIEjw9Nhk96PsnAE/Syztqcff3Csk8id+Ngs7zBUHaPVFOXMXBih
bI7kFt5JEQzgZJ8Ref1k9Litcy/xQGLaTvXGcd2QecmA5Z89pqMcW5TZKUfTgFwo
6Xo2dkg+0n7OhX2ikcsZGFe6KZM+tIjUL06Ty3TQEJzMa9beugaZo99X6bKrtHTG
c6Rj+qAUho+yWzQleqakM7yUvPa7NgjXhGyW/gGiPBflg2HOBPy4dUDI82o2j/Un
xOrJeUdtejoDyMjtkt/pAqJRnAFCA8Ixf3IrQnJR15dJa5+xwjFoyBvLrNN3lA==
=a3NT
-----END PGP SIGNATURE-----

--HtK94Lzh6lB4ZmEHDZovsQRWm0DYiQ3RU--
