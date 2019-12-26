Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8D12AA30
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 06:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfLZFDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 00:03:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:57621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfLZFDy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 00:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577336631;
        bh=xE1bFy0hfmj3ttcDiJPkdlokLYPpMQfYkTIsUywe+Xc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aR19HL18+PRv+/0KaenSAy7AKS664riQDyaS5ivSnYKY8bDjbKQRK84NsoK7VOhjD
         qf7XHpmOjJtcpzFYKpeU72UrdFPZz9Ce4QCRmRU0WcCqD/nZb4DzkIg4rZ6V1CrQjc
         +D2so9xs/aQHDCjNPHaEgKhCIgwh0f7WAlTFNGLo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTqg-1jEbMO3hvK-00WS3I; Thu, 26
 Dec 2019 06:03:51 +0100
Subject: Re: Deleting a failing drive from RAID6 fails
To:     Martin <mbakiev@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAHs_hg00v9zmMAXp7E=7Xe_ZD5kgB2tVBOFCt5UQuJRp+yESAg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3826413f-f81d-de13-8437-4e5b762d812f@gmx.com>
Date:   Thu, 26 Dec 2019 13:03:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAHs_hg00v9zmMAXp7E=7Xe_ZD5kgB2tVBOFCt5UQuJRp+yESAg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="omWFRafaioN4wVdLQAbXD3XHePBtVFkiF"
X-Provags-ID: V03:K1:43AQ7u89FOWDNAw4rTHnGRMn4mpX+Q+rlBbvvEEmU7AK8p9eEGM
 dtvilz4d+YH6udXN9RoR1q5UgrJLpMNdOOaDhdLyYqW4uAGdaY71zUb88opT8E645EkbkJD
 H5tMtjyeT0icQs6KPVqOUzNoXlCkb8GYg7AxJOwZA+nK3Gucx56QKp0oXFVyPI3/uKvT90U
 gh1NBXibxLYaEdyKnyfHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YN2CCtOrptA=:uPVWPaC44FLvXgJt7pZNX6
 +hUJipt7AUFSx2OArNM8Livxh9dJeRGhIanxv6o1F1rYBFkS2Fj0mMKSDQd9BRlZ8b/0NV+hV
 Yk3IITifEeWragOOejs+AjTNfSU90uv9hOFDHlFCgEmH+0T0HOt4+gBpDfQdJBEwoTxUgeFvd
 nNlsoXs1BmxR98BNKqhSuC3DwXcLfnJkGpTFdg6ps6d1J7vqYfhXlrr2+DIFk1G6v4oSP2whA
 TGYXg/n3XPDRhfp7bbv1gmk5QfW3qLfLSFqKmhsLfBMNXPQ69a75lNJJfyej0TzZaNOptFK6G
 CwseBW5htAtTtYw8ZCWUGREuALFJvf3ng+glDy0TTEkFPMU+VwNZOXpOSKNcxf8WNMx9XvMA6
 yST4DjwIFtBQrel5QP/fORSEiTQ3GJxgDiZFLnlDLg/RxFc+S1QrRZjV6p7keg0yBfgpHox06
 2IKr+gh46DrRsvfiUbPnNYdvmRPYtNTaE3sK5y6VVuMPnmtXW5NDqZeMLxvXir0Mb030gmPDT
 9XMbELyW2X6pBDz9tI+8oU396+X24llzepAjmh8+sFFLnv/rOkwSvzLzarR/9R1N1oKatlo1O
 hATYlwHdvPFDhcE2P6C9wKQzE4cp8dY1bID+9/1T3nfTfg5KxIsqTdeelx2RULJfuDx0brNxr
 knkTB8gkSHEBAPWDWtjCSf+lWlCCWerb8QSBRzntcjiFS+I0OxZFd7i+9tIm9xVNam/PR+x8P
 g45xnnUw/qzyTJo3wSevWAa/GRCh1vW74T1Qh7Yop90QWDNJgPqMMctl1T+zyjOs3ZYKRww+y
 jpLs/17b0hy+NyAYsyGUVbP4iq8w1choe/WQe96EvejK0xxORNZvEXJWavAJuBUavehfLIItj
 dlEO7XB1lYQxUiSqdHqIXk7ZPs9tQL+DO9JpX2ln9dvtr0utusQT75cKOaMLd1/N+bzqH8UDf
 Rp3jXA6B7FL1piZTkWFs/edQgKJ0VlXZeIyxkBZiUf11YkW/P7dQ6wWlOt6Rz0iVTVpS4WI7s
 DPpXMoL8rPykgS15TfcczwoAiFAtevJFwn24VO7M6tchaNmWGyWgNsjCwlVLmChVGYOzuxgGL
 StoR4On/PtO8rEN/HNow8NU+C2lwlQSAgA+dGEv5GPG44Qkn5pEfDGwb1VlZSVhMO32Am5/U8
 M6+KBhupufVZ0LgGDEFcKFlssl+5ly9Yajy0NfNYnD1l87ZoyF21iLCzKthFRjq7AxZy+QUa1
 5XYwsy8gnxZqteyty+ILVYkxumnyrn/aNmru41SCPCWex2mdxV3OpnHJqfJA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--omWFRafaioN4wVdLQAbXD3XHePBtVFkiF
Content-Type: multipart/mixed; boundary="jtfzwlZAHf58xBxALpjwuqBKMM4zOKDGd"

--jtfzwlZAHf58xBxALpjwuqBKMM4zOKDGd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/26 =E4=B8=8A=E5=8D=883:25, Martin wrote:
> Hi,
>=20
> I have a drive that started failing (uncorrectable errors & lots of
> relocated sectors) in a RAID6 (12 device/70TB total with 30TB of
> data), btrfs scrub started showing corrected errors as well (seemingly
> no big deal since its RAID6). I decided to remove the drive from the
> array with:
>     btrfs device delete /dev/sdg /mount_point
>=20
> After about 20 hours and having rebalanced 90% of the data off the
> drive, the operation failed with an I/O error. dmesg was showing csum
> errors:
>     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
> 10673848320 csum 0x8941f998 expected csum 0x253c8e4b mirror 2
>     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
> 10673852416 csum 0x8941f998 expected csum 0x8a9a53fe mirror 2
>     . . .

This means some data reloc tree had csum mismatch.
The strange part is, we shouldn't hit csum error here, as if it's some
data corrupted, it should report csum error at read time, other than
reporting the error at this timing.

This looks like something reported before.

>=20
> I pulled the drive out of the system and attempted the device deletion
> again, but getting the same error.
>=20
> Looking back through the logs to the previous scrubs, it showed the
> file paths where errors were detected, so I deleted those files, and
> tried removing the failing drive again. It moved along some more. Now
> its down to only 13GiB of data remaining on the missing drive. Is
> there any way to track the above errors to specific files so I can
> delete them and finish the removal. Is there is a better way to finish
> the device deletion?

As the message shows, it's the data reloc tree, which store the newly
relocated data.
So it doesn't contain the file path.

>=20
> Scrubbing with the device missing just racks up uncorrectable errors
> right off the bat, so it seemingly doesn't like missing a device - I
> assume it's not actually doing anything useful, right?

Which kernel are you using?

IIRC older kernel doesn't retry all possible device combinations, thus
it can report uncorrectable errors even if it should be correctable.

Another possible cause is write-hole, which reduced the tolerance of
RAID6 stripes by stripes.

You can also try replace the missing device.
In that case, it doesn't go through the regular relocation path, but dev
replace path (more like scrub), but you need physical access then.

Thanks,
Qu

>=20
> I'm currently traveling and away from the system physically. Is there
> any way to complete the device removal without reconnecting the
> failing drive? Otherwise, I'll have a replacement drive in a couple of
> weeks when I'm back, and can try anything involving reconnecting the
> drive.
>=20
> Thanks,
> Martin
>=20


--jtfzwlZAHf58xBxALpjwuqBKMM4zOKDGd--

--omWFRafaioN4wVdLQAbXD3XHePBtVFkiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4EPzMXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgaXwgAqbTFY1Yq87zXVrOssCcoORjr
wXKzEq05NWgpxIFrnTfuLNVdoRcLctvvAMiZ/A7LylzWKdEnmXgDiV9aGgfm9XYx
6U1l2AJK1vfp83H/KvA2Vj55snnG8NuL5EhJ8t5iVDU2Jhef6q7HvgUJR69Ac0G/
RvWqgnGFsv+bOxQRLwpvmwbrf0r+lceiVzSpMIPGd59WbZy4UkL5XUwhzJDuYg67
11WVgXa3XnJFbYvdif5BpMhhbHl9PH0yeWBC6hhLLOs/Cihce7ahTahesQYjUHyY
GTrtlbij99ZNJK5n8NuoF1O8/vKF82lkPgJ1+IzhuMvB002XvMOeelMciFVnSw==
=mAS4
-----END PGP SIGNATURE-----

--omWFRafaioN4wVdLQAbXD3XHePBtVFkiF--
