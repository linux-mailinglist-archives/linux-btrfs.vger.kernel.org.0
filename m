Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10BD123B87
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfLRA1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:27:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:34873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfLRA1B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576628812;
        bh=4QhBEXG32mk7XlsucgRCn0u0P1u+dyHAG+1SWwwPWqc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hVpJApWKREMykN14gk0SItj0uGYrf4hTbY6aFNKPx7W/HAy2OFjrG7nTOMUAWKfNO
         eMTZleW8TVzHMEUcXpooogGs0sv8SsIUNMO05Mrgpk8F1KY4Je042YXtxv0EDXYBxb
         TVKVZUTCe5G6WfSMQYGgjbfIWVgheNsODyDpDUTc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MORAa-1iKkUP3rNG-00PuS9; Wed, 18
 Dec 2019 01:26:52 +0100
Subject: Re: [btrfs-progs PATCH 2/4] tests: mkfs: 017: Use
 check_dm_target_support helper
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
 <20191217203155.24206-3-marcos.souza.org@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <87042bb3-6fdf-0d47-d08e-5c0e8b5cef0d@gmx.com>
Date:   Wed, 18 Dec 2019 08:26:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217203155.24206-3-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cebgtsaDmrAlwkSKLRZaBb3rZecTSdMRY"
X-Provags-ID: V03:K1:JljyvSUmSqN33SSYRtehRDTNOi5SU+8wX35BIAcQBb85Y3sI8ZG
 nNTELyM0oE2m87lZ9vgzPwcypuenwyhTNyvptcjMFqpCl41s+Dv10k2qdRsMtmjgkdHhAtH
 susI529whRP1MglBxitbgDV2Lx/8+aanL4PifXPKwJ5spCZ9opoayfbI9L0dnjeGbjXUfGC
 cJ1h9HjLWltYF8tiI8N+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:js/7F3jVLeo=:OFSvjlXYvfpshiq15HmI1D
 i0KK70L0I0rtJZ2D7V+D5IZPFPLkyCcSAWk0dS7sT2eFdzdessLKDOiCCcy56MWe5BlG2OzjR
 ZolUXLTFPj/RupNi5j8IdomMaTV/2TNkz98L7E3OnAQyycyKU/ahqVxZHaQSIraGeSb3BOXKC
 vBOFAv7uurxSM5VZZZ7Fbhdprg23VMAKkeKx/RDKCyN5ZRqHsyDxfKwEieTM6qhRWMuUueVsK
 yYgJOfNa9Qccl15oq7slsX3i0Dfxswdi/pijNxBbd1hq8ZOX/s6SptiFaKy3jTEaUs0Fc5Y4v
 Z3Pz9GSt0tOyIkhzG81o8mKVhqXY0vTQDpcn2hlGdY5Nhhb4ZJnbnGHvciLv86SdMspmc0DXd
 rUuC99zvut3WguXTQKBo/SwdKcCqNomKuOV1F3M6Wa2YxC6z6z9MN//iO86A7uSTVlOh4o+MU
 1NKYrSEY49S3BDJ3r4ByJlbaotvlLYXPXrhTclCsG0tHZvIl5D4miJF3Mun53wxl1S0Xeb7Lv
 RNf09JGSUOtPN0NotcZZ1io27ZzwuKYODdLcBQSp96u+GFnRaqTfzkYulia1fFxchO+jO0n9l
 eTxmsVldjk3Yfo7V6VRi/i6gkuroawEAJPaCKhwIVzBqmUBgWLNnkhNUbBgUZOP01c6Au2E5r
 5eDtgKH5d81sYIK3ltsosxRR3JjPhH9Qr1PwDu2FUU+Wk+xVPEFoxZMkPB2jkjPSBUqJ43BPi
 O7G7s1fZMpc2Lo6AF4ky75dxUdrqAMOFU4kaLA1k/jR7QnPhbuhr3SrzMRENBVc0V+vaWA1i7
 0UxEYv8ewnzoaUUkJJK4kJPDBNSIj4mzR5t24N+Iv1CZZXD3f1/lloEdw8dQGajiZ8KSV3twg
 6AqjTq2ZQ9l7R5Z+n3T1s3diAhLmGH92gDciOcpqlqZQvACeQH2g0imDRLCt0HR1HernHmqZ/
 cVIE4BxDJ6Lp0uVdAyGuHdCvHvoKxUAjn+pnzCj90SV4qKPIqfNZgD/tV/PYXQM/ffXn6UMsl
 Aca+zkhFOPVao4Ytm0fM2Mf/Kf8/J2gafOAMgtAe/X+13tkuc/YpFvvZ8os9T4L0/4ehhTB+a
 PAVzqLvpdjZ3YOZgDFAtZpgjcp79DjlsO+o0TZTnNtKQKjibIxdvJRAkxSgftsqRei45gYFvT
 RhPPUiG6XLBEIQ6rtETHMUZYZpFjttXO0kWNmT7kmNWtgqITjlPQKe5Jil1TEncnxVXwrojcb
 ddQGREW3Q2/tlysubO8F/4T9RCl2Q0xtu+0C0TC6kQvlBcsunWJvCxR0RuBI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cebgtsaDmrAlwkSKLRZaBb3rZecTSdMRY
Content-Type: multipart/mixed; boundary="DQ75DbAwGOvNE8YSVN1JzBECSWQ220uWt"

--DQ75DbAwGOvNE8YSVN1JzBECSWQ220uWt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=884:31, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> If dm-thin or dm-linear are not supported, let's skip the test altogeth=
er
> instead of throwing an error.
>=20
> Issue: #192
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  .../017-small-backing-size-thin-provision-device/test.sh         | 1 +=

>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/mkfs-tests/017-small-backing-size-thin-provision-dev=
ice/test.sh b/tests/mkfs-tests/017-small-backing-size-thin-provision-devi=
ce/test.sh
> index 32640ce5..91851945 100755
> --- a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/tes=
t.sh
> +++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/tes=
t.sh
> @@ -7,6 +7,7 @@ source "$TEST_TOP/common"
>  check_prereq mkfs.btrfs
>  check_global_prereq udevadm
>  check_global_prereq dmsetup
> +check_dm_target_support linear thin
> =20
>  setup_root_helper
>  prepare_test_dev
>=20


--DQ75DbAwGOvNE8YSVN1JzBECSWQ220uWt--

--cebgtsaDmrAlwkSKLRZaBb3rZecTSdMRY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35ckcXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhBUAgAoXgXonVdG68PlRHcHK0y/XRd
3j0OkQZdU9mqD/o8CErvabyXwNEQoihp5Ckpo58ftYq6hfKHaH5NnP2SG3iQ91ze
i10Vuj7Lixpgk4uDYUJtt2L0VKR2Mr725qR28My3UncLya0Rr6unETQ3s7TttM0R
09uMIDlZ1EZF2+kDvMq9Sr1s6YPqjN2wfsTEtia5yqPk3gllXlKrUd1K34Aux1DU
0DyMuiM9B2LS+u5EVIsv7eKqOsmFVGiTln3gGxxjOURl7Di7UA4M4SdPAW8vBJ5C
iEl666nufxuqca9XYdHh0B+ZB4bKu8W+LsJc47bd69yCy6T0LZF8WXyptDW/GA==
=PqXC
-----END PGP SIGNATURE-----

--cebgtsaDmrAlwkSKLRZaBb3rZecTSdMRY--
