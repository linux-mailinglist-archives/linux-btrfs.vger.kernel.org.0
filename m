Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF06130F02
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 09:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAFI41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 03:56:27 -0500
Received: from mout.gmx.net ([212.227.15.18]:53725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgAFI41 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 03:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578300975;
        bh=EevMvVqS8Asv+063Cb4z/6k+5ufQS41WpjP6ja7rmrY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V9WaTkcPd/221sly84odxAUyZoUZ4ml46LTz5i7rMrubcAwPXPplv5/yNxR3nAGDr
         rhh/KYbjPVnvIxaLrkz+NG2fq1TY11DO92vV1pjNkC3ZJ+uZdAcKFK52UxdA797LrS
         CqNXUXrPsb2Ei26TgLdyDBAaujeXt4YvuzOOgrAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAwbz-1izde33qUj-00BLyj; Mon, 06
 Jan 2020 09:56:15 +0100
Subject: Re: [PATCH] btrfs/140: use proper helpers to get devid and physical
 offset for corruption
To:     Eryu Guan <guaneryu@gmail.com>, Johannes Thumshirn <jth@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200103111810.658-1-jth@kernel.org>
 <20200106081647.GE893866@desktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1c1dd1ae-e484-ee02-a7d8-077f95f7d4cf@gmx.com>
Date:   Mon, 6 Jan 2020 16:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106081647.GE893866@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mAsfxpBkW8TiT1wuLBXB0vftMz52Favf8"
X-Provags-ID: V03:K1:AFnykzjQJQJOQhO/2AZRXpMIxXgBYjHz8Fx67s6ece82FUvd1Q8
 W8c+4FKgYTjDN14QBSu1daZXVnEcRmAEAweG1iWcj1dhzOgDUFzcvGqHx1QKPNCzJ2F4/iy
 tZYGB5VH/97qI5VbDygeIrnMMmo0bWPbHVnUcnnnQOyuMbvQo06cvLlNYeV/7nHkx8OsYAI
 Q2vXWLCpasBMVQgomYMyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qX4rA4lklPA=:idrTa7PcBiLGmzA7uKswhc
 y/adt9VOk6wOTWOxG8lWTX/VaTNVrLooBW0o8RoBOfPjtdddcg5Ku5tbaQrIEWhvY2rB40Lil
 tkcmwra0eWYzpQZcQA/iypx9fV1B7x1NDvZ0pa0cSuQpe22rnuFPzkjJndHe1hnTDyjwlLi5/
 /JUkPIWEECW3jysl32YoQw8b2zFLwewY1GbOv2sq3lCzCGgCBH9y0rCjllR/cfw8XLx65Zf6b
 t6rtBNCr/lbj3iOQ0lnK9yQ3tpzCuUWJe7BmKeX5tRRSqUrGhQYCmExx54K5ijYnzVn2aEdtm
 QYK67M/KZdaMkiF6G90zqOYU7BdaYhrUITphpAligquNFn1hY8ABjp+Epw0rcYJsgqowhbsWI
 dJ22phLUJyWFk8JblzPjcXdyAwmRTOcoKtGuXkOJB02BFMvIss7IclubfuMi971cPP77CHa6C
 GSDYavxcpsHcBbTu1Hu7smR4DInh5nCEIVoiWghUr/+wjJ2DAG2o2fEZkB1+8mW/DYg0ncgfF
 Qace01zrj92u9FN7ZRD25SzX9YaTDPKqGR7mE2Pqfs6aVkMKov6G7DjgSWHLNz73IAQU9U/dt
 AF6cl6hn9XtK4a/kqLB+1XUTxh0TxrFUyKL8+eyUO2O0UIsPRAICNBJiP5mp/q0Q4w+IL2ai5
 BNyetyXPEFcUQ7JfMOmVMl/lqtH706c5aPtCL5rCZYuj92QkSUGc6DAqTlXfmwS1y1xpKM7YI
 gANppq/GL+SnIgRO06lVpVZVVINr22vzKI3prCXCg2QlmOor5cilWiqflNa0dscgQMhATY9Gy
 GEDihyBQT9TlwuWAsvQ0nA/YR+1YK5dI9OR+rzGP3EAS26stKvBHPbY8Km7yUmnNsf5gYG94R
 uRDKm4SZqsVPlhiKisZvUEBuBafyTn3FeD+IYUVl5QboYke/FpEqagbNS5wo2bzY1PnQRktLN
 sYwopP0TWDlenpEWZLoq0dFwd0eyAI/176+Kr3d73l6qg/u7OU1Vmgbl43VmZmvGX4C3eN2z/
 1lgnAHBtOmW96FG70radP+31hkQSZM027G+kCFJqeEoPGdnVJNTu+HyV6bhDf2V9sFeh5Kqql
 nRl2OwJ9LHpP9AEXb/vE+MTHEy1ULmzlPgMXVNwW6hSJgkH/Egzb4Ej7ddqkcwPZYWIUCj9l0
 6wGuSipcRpUaxLu3j+g/KwHGtUzdbvXWzx4dMjjQ0sKQ1yaNdyPVumXI2jtPXoI3PEybNJMHE
 yy/c+nu75MUWFk3oV7mycxZB+/6IIv/qXgynj/MV1hIUG1DcsEHin/npYnpA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mAsfxpBkW8TiT1wuLBXB0vftMz52Favf8
Content-Type: multipart/mixed; boundary="0UXar6WGGfw181H4z1HFHG2Y5hAqAHtGn"

--0UXar6WGGfw181H4z1HFHG2Y5hAqAHtGn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/6 =E4=B8=8B=E5=8D=884:16, Eryu Guan wrote:
> On Fri, Jan 03, 2020 at 12:18:10PM +0100, Johannes Thumshirn wrote:
>> Similar to fstests commit 1a27bf14ef8b "btrfs/14[23]: Use proper help =
to
>> get both devid and physical offset for corruption." btrfs/140 needs th=
e
>> same treatment to pass with updated btrfs-progs.
>>
>> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
>> ---
>=20
> Qu Wenruo has posted "fstests: btrfs/14[01]: Use proper helper to get
> both devid and physical for corruption" earlier, and I'll apply his
> patch instead.

Thanks.

The timing is great since I was just going to ping that patch.

Thanks,
Qu
>=20
> Thanks,
> Eryu
>=20


--0UXar6WGGfw181H4z1HFHG2Y5hAqAHtGn--

--mAsfxpBkW8TiT1wuLBXB0vftMz52Favf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4S9ioXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qi0nQf/ScPmHwFKzsz1FTIHQ68SpvN6
io/r0YV8m9Hgt6VMUmOdpIhXEays8dR8awfux2cbPcz+EcbMEDSN1flmXb/IVitX
IyWT7ofmtahjzuC0BJy8G8ieB2xXro3sY0b6a/h1IrL6bK1sFIrOS4kdIGhEvYrR
L+yE6vKVmZV9XBckMGpILVJT3UNkqy05NSu0wsgu171+klyCZoU1HzD3rBJdBKIK
/SWduKF5F3XpGAFkn0Rd+zRGAIynQiHSNWGAQuqmioToPLFWNtJ7V5YMqGLGRF6m
itqQ+3MsdfEyloxBmgGvmdHWawDlDU61bsvZB/9yIam2QhAmEVllzuhO2fxaeg==
=cioM
-----END PGP SIGNATURE-----

--mAsfxpBkW8TiT1wuLBXB0vftMz52Favf8--
