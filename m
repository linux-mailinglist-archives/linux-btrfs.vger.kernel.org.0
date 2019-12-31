Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CEF12D53B
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 01:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfLaAZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 19:25:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:41301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfLaAZY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 19:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577751918;
        bh=QY1CmQwSSamNcjwwfC8rZmqpYRFiF49qOZQyOYFHIT8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CE7JfPYjg+1ILLQU3EwQV5PLyn3/p+fxltf9GJ0XpZHxbE49ZOBXtFmgHk2BahiF4
         d8i6jca/zKKqZ2xWcCw580l4ybyd1UhTW3wAKGnrkiNaxG9f9x+se3gQsRVvB2MERY
         hllMv7XU3D/Lbj1z3lHvLyOTl9ynHEFWsqDR0UfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1ipN8T278W-007haz; Tue, 31
 Dec 2019 01:25:18 +0100
Subject: Re: [PATCH RFC 2/3] btrfs: Update per-profile available space when
 device size/used space get updated
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191225133938.115733-1-wqu@suse.com>
 <20191225133938.115733-3-wqu@suse.com>
 <21f4fadd-f081-6acc-1f79-ca52b68607ec@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <fbfe282a-5f37-205e-1f89-f294b768808f@gmx.com>
Date:   Tue, 31 Dec 2019 08:25:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <21f4fadd-f081-6acc-1f79-ca52b68607ec@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YOLLnebUcqxXScSPix06oe4bx6CFgmIa5"
X-Provags-ID: V03:K1:kMpxyrHaGg30m3GVkfsMTR8P+WK723NHaXtxhoY8TfVyxrnaZhO
 r6Dvbi0fpnue4yuj2MJUUmWEb47E8mTrDR0yvUs2yk+NR+gpvzuyJieVSPwC21kuTfhMHAX
 6ydz5aSxrU+RKnUn7x3ydsYqvpyvjl/vv795tiXYBgJqOZxdcKcUTdsCog1IsUhCGnr5vWc
 f7O06qeg2CepLspBUiGcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qi8DQVofvPE=:0QvBk+TyA/Dp2qFdDa+of7
 yGM3EAqjI2BLdaWP0hNpkSPGPIx8Rs9ZnbSwcd5o6RbwsnlmttKYhXPjvY/cH6ZLtXp8Qbxcz
 OlSYzvu6XBbzRKeCEi34G0vu34WtpMTvPWPESYjGzHcdARb21dIebTjKhD28x5LQH6kerU0we
 69anI1BpP0qdUJ8tZ5HxYD2mTwXcC2KzLEW9uQTh9IbOy9JgHDs8sMbqa6B5E0iObO/NPdZZk
 2f7aojO6bcVcthYUrW+ZVtdxBIiRLs9HyVqivzPpVIPQ8KSJma/zDaewnGX7algFJXYL3K/74
 dhpx8WCIaWhPN+GLppQHrYWt88JTmzgSidtnGs/l5I40SBxl7grNvCUyYjrSbsf35wSE4YZbS
 aVzJQHm405XVwkuHsFScWqJijnRJ0oaocDocF5tzD4yUE4L6CyylutdAXZJEGdygECYkEjtZg
 jgdjv0Ksl7neqvmKudWxYaHkj8UMslvbK+nedCxj5uLrdN5XJc8AASnjYCsCjFJZZGB5FFQRt
 zJ+4IBdc6DzMnIn+fluibbDTbilQLXZbG2OBdnV3h/ZszjgXRN+EuZEarDrOggcBtNNMy2ovK
 ttjcw4ZsM92lAZIQT8GRQCxwdH5hj6c1oOWH0+cFuOWQQzwluXd/J2v8GJQoITakPSvyD1hfS
 Q5B8DGkAztZB/xnABivysJTu9bW/Fw9mQANO9YUBnoCrj4qKL0HKrxzWgqZI7ZV9qumm/WF5l
 X5weBVGqwkc8UoMvLMKoKJ9Vg29e4hOxgyT2KfwFWtTurRENed9L94q/mSqGy/Rk2EJpEcocI
 nD0G0A+DCwk4KML2fG0CSbOZHaMIQ6+KzX8ynLpZyC7WezT89PwHv6hxweXiy4xjwfppFibfa
 N9+fNb1kgDWJn9a6tsiUcO4eKFCanuDjdpgqffGOylk/YDlTtmrwJPLuJD19mv1rBJuRuwItz
 IBU9+KO0Lo2A898Gr+r6RzOGfAol/4+GR7hJnNLyarLDZXtkq+o1sAWHuaFXKF58JmwWm1t8P
 yscQkZmpafUPhNLIW7Rj/UOe+hUnbGG0kIEmluqPsIR83VNZ/US23B/uYWhhjiwbA9qSQ8Lt4
 cWj41bOW+XRkc24pbYi+lTxWV0fJ7G5J3CDfeD9yZarLtsiDgx2KQEcsRDJ7X5XQU7d2rprg7
 0Lkc6En+9wqax6ofkye3I1LAQ0mGGwbj9fngsSJRQA4fT1mGbyX9kiNOpFDe04s4zYg8t3x8J
 pexRx0UrrRL6myXgVo9UDZI+eLdEzbMQP/Kp6ghJwu/J9F3BZ2eMW26/r4sU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YOLLnebUcqxXScSPix06oe4bx6CFgmIa5
Content-Type: multipart/mixed; boundary="DG7tECMIXzslgk6XmjDGI4fXWWNplkdXf"

--DG7tECMIXzslgk6XmjDGI4fXWWNplkdXf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/31 =E4=B8=8A=E5=8D=8812:17, Josef Bacik wrote:
> On 12/25/19 8:39 AM, Qu Wenruo wrote:
>> There are 4 locations where device size or used space get updated:
>> - Chunk allocation
>> - Chunk removal
>> - Device grow
>> - Device shrink
>>
>> Now also update per-profile available space at those timings.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Looks like you are missing chunk allocation?=C2=A0 Thanks,

Oh, you're completely right!

I'll fix it and also enhance statfs() to use this facility in next versio=
n.

Thanks,
Qu

>=20
> Josef


--DG7tECMIXzslgk6XmjDGI4fXWWNplkdXf--

--YOLLnebUcqxXScSPix06oe4bx6CFgmIa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4KlWkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qj0HAf+NxkWeidRvlomVoVafooy8SZj
ZsCaahFsdPpbMymLZurpqO0bIKwmueZSp2TRORh1LyX9JIY0BLbSLC5ZOo3IYuqD
/YN90wbJwhs0v4T41QaFlvCd7lGPRtBQefTi+coCAJjQY/DPJVJyyiwhnthEKdrX
y5fNt4ws5YVLNrnG90a+ldAYxg0ov1BUWerMlmvHocWfVMFsyNSMXnf4j0/5w3ec
YMqQ0Yw68mUd+5lF2M87gk8+9qJMrwwXS3mYoSE8+Q6T677PRpJDdl/3H3UUpeV1
geANO9VONohEsrZQFwLCmpqQhECf3wA64ipZx/nK2zT52LFmPRps8UObQEd3jg==
=O7aY
-----END PGP SIGNATURE-----

--YOLLnebUcqxXScSPix06oe4bx6CFgmIa5--
