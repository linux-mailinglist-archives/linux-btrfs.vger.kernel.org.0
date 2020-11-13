Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E822B12F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgKMAC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 19:02:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:48011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgKMAC7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 19:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605225749;
        bh=i/efD5LtCsAQp41ZS6Lu7hbE7azVaEoVpf+NvQh0NRQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Gffrqt7sU4oTYHw1GWNLEvrKo46UiF5RRZ01jpD7MifIdj1qPrqUIyj1wzwD0soQe
         8tP1mlojNTivHmT8AzDwf641UJJ4ptGMrO99ctUOLyEo3BLNpebk9aq06bBBCIioCP
         QmvRZ9CzSsyChG54jCB80O6Rd630HDrZePmKUHVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGz1f-1kZI500C8J-00E50Y; Fri, 13
 Nov 2020 01:02:29 +0100
Subject: Re: [PATCH 01/42] btrfs: allow error injection for btrfs_search_slot
 and btrfs_cow_block
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605215645.git.josef@toxicpanda.com>
 <d4d168d0a592fa8f828174b3f93fa463b922d492.1605215645.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <1f01b959-ad54-106f-4364-77b6cdbd6c0a@gmx.com>
Date:   Fri, 13 Nov 2020 08:02:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d4d168d0a592fa8f828174b3f93fa463b922d492.1605215645.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8qVi9MClw737ZknUdNSGqI0cs43UzObAB"
X-Provags-ID: V03:K1:Da2HCLwk+k637xFdPWQyKOf68rVB/+0yjC54ZuEvYUkFSEDFz+p
 9rTfuYntZAJD0jpSVdb0W9tYLiEhSD21kJM4nbzud8PwS75n3dvM7doQ410reqmb04UJYHA
 l9+FxRNLVJMQd2xXODGcLvHYP81PQkwUorm40RYqoON3OcbQtj0d457MGgWJWGfsaCdup6g
 orjHo5S7jlGZL0CRFk1ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wXKjfQZDnZY=:5yPBA8tqOPjxaOCrNy2vFd
 iVoagR+ApbzGcZ6s5Ta7l8ZnOwDErDDGGPkUoIePIbVBR4jiAB0et76XV4QAdjGp5eR13BG1t
 ZTDq/MYfPWPsKJ7V0bQyzGTmUF3oty7SFPFCgDXtd7hmZ/RMkCA2RUqaepnttWcHXyniRJBPr
 q1TNW4MC4exEmZEIQe8qHP9KxrsSSArhUqsxXpArd/CK5zzIeaUra82MZGwqPzRcqQp7rooc2
 jcwl7Q95qeTEirzAmzIUiH0VZWFX0yjcyXH5/x7/uDbUfImP6K3kT9uAl2fZhX92F7zQe8XWY
 rVxiqIsmGLtWY0K8J41c4b6CGFvc4bE5dG6AdTFvEeOXT5vkOC1JgGtYAuQZ4c8RuKz0bEq3K
 WzQ/Gw7YnftRqKDusJm4fFqKpLV1wYlFTTkGjeLW7vZTLYUdadcf5JbK9i/tVXEN3XQeYK5IX
 sEJsq8SvoqAzrSuCLx6jgJfWb79oS0dB0gegLwMfJxJnOJa/svZacdRIU4pMtBJ7TNfOwiB12
 hgQksTTEseEt1Dp/A8Fjn56qSCeSuRx9HfrKahEAc2dw2EyAV0Rtm7P9b9wXOrmktJfpebY+p
 AKy5XopqeSNdBok/TueONyC/v2WfQIcTPmXR7jTq1yEFNXGUrSBMWZVX/vwTT9E0uOhf2ja2M
 AEEviSvl9TujL2tc15txpaOtSoHYSj8MqKphbnsmns/MhLUlR8M7wfjl5BM8GfRVc/otsPTAV
 jlzlmnGG/eyMIQKZmKluEsBoEHRTJmq2x+7HcIa7Zkqx/Q2qotS1HQ+3CPdncac1KVN290bHC
 HoJwEiAaBzPVsuLP17XmmaCEe/C7p4sz2RqtpJ5VTZ0mArY8SBbIriua3YBIra8DMS6vezYNa
 iqXwIn4gA9SQw6Gyd4Dg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8qVi9MClw737ZknUdNSGqI0cs43UzObAB
Content-Type: multipart/mixed; boundary="E8RJP7Zt9cdoN3r5l0RZyWp1CjbCnZSsA"

--E8RJP7Zt9cdoN3r5l0RZyWp1CjbCnZSsA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/13 =E4=B8=8A=E5=8D=885:18, Josef Bacik wrote:
> The following patches are going to address error handling in relocation=
,
> in order to test those patches I need to be able to inject errors in
> btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
> often in different cases during relocation.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index d2d5854d51a7..a51e761bf00f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1493,6 +1493,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_h=
andle *trans,
> =20
>  	return ret;
>  }
> +ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
> =20
>  /*
>   * helper function for defrag to decide if two blocks pointed to by a
> @@ -2870,6 +2871,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
>  		btrfs_release_path(p);
>  	return ret;
>  }
> +ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);

This concerns me a little.

For error case, wouldn't we also free the path?
But if we just override the error, the path is not freed by anyone,
neither caller nor btrfs_search_slot() would free the path.

Or did I miss something?

Thanks,
Qu
> =20
>  /*
>   * Like btrfs_search_slot, this looks for a key in the given tree. It =
uses the
>=20


--E8RJP7Zt9cdoN3r5l0RZyWp1CjbCnZSsA--

--8qVi9MClw737ZknUdNSGqI0cs43UzObAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+tzREACgkQwj2R86El
/qif/Qf8CHB5o4N4FbW++86fL6+Hjb6M8FXsUEk2aBMJVjhSND5UX41o0Z8bzpQY
U1Xi/xnNr645xFvzt5sB3myFZJBlzUsuGJ2H2IX8e2nmr4PscbGShw/JtmSseLHI
O5lTOqhgJ05vSR96eCVMCLPf2Ddza6zkUAkYuaNh6wpcRfB3qVtD7qcJvE8T3Gvp
7miJePHJRi3COhc74GaRT2lp8j0l/cr4q0U4apWGTihLB/Lp+gR9TRQ88L8lUGxD
hnCQ4/gwu7d+DA5vkBhs0PPUHLJsZ/nb6IpF1Bf+PGvAn6c12y0COipq5+Lgpmjr
bIWdDmE+M0Rp6MmbUy0FIqdkfrAVoQ==
=8XMG
-----END PGP SIGNATURE-----

--8qVi9MClw737ZknUdNSGqI0cs43UzObAB--
