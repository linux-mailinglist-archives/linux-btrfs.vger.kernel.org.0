Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0D2CCCD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgLCCuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:50:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:34205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgLCCuD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963707;
        bh=M6CLccxbOVU6FwWgk/iW2cpqUnusvTTd57qgIxaTaPM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=H/nFNON/Le/OCPINNtw2SySfgsXNrkwuClATMygO3lYsxVWdkEzzVnAlio2TNQaKc
         nUwCjs1Kvtwpou8YsV9Oychdyhjf+yguVOq2VlOuFKa3WwKNOji7uiUYuCtczDv9+j
         DOWmVdQQ4TgoGZbQewTDv4wtoTJpMkO62wwT6l9M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDIo-1kKQaQ3C6K-00i8Xe; Thu, 03
 Dec 2020 03:48:27 +0100
Subject: Re: [PATCH v3 24/54] btrfs: handle record_root_in_trans failure in
 qgroup_account_snapshot
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <b42b4e2d067681b11ba85503802e8f3128485be9.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a8901013-a7ca-cbd4-f1dc-61105baad93c@gmx.com>
Date:   Thu, 3 Dec 2020 10:48:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b42b4e2d067681b11ba85503802e8f3128485be9.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="creN76nuQiOUNcjpYnGkqFGOFhYpgcy2L"
X-Provags-ID: V03:K1:YTh/qQHaOruxSt++odK5PAJ4kPY6L0V8/aD75MIOGhB6aQEDjIV
 dlEto8lgYxc0g9IOL2E2ONbuYmqkklYjMK2CbOYFYJFAfQnawfi2zjjVhVc44ytFoHdAWsG
 El1EmzyVSOIyQ2oEaXhD/xmFIDl5WCi8s1ZU0JsY9VwFuJ7Ny8psQo4YHU3WT6/mz2eh86/
 ZTBO3gLMmIp/0rBTV7kYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MzZTAInYFOI=:ESXLks4HDnqlSl4WKXwYjP
 Oo4VD2abLK+YrRLTT1ihvag/VsJ2QMkA69kuuDfVloZXar9RpId94w7hWs3QjbO7e/4s65+ld
 fl3NcJ86r1WxvF5Pw2FvDU2JjP4ldxCq5NAyTnFOB3RnEjBE6tnoLvsHl7WSGF8BZvEj1w/qT
 lbuunnLyMAjGDVIeKbX77ZbTwYOn70B0MIyT2kTkdJTglcgDLjBMWeIwHVNXBnOs1Bpm/Dv+r
 qw8i5oFO67X95FqZ67gKqeYWQJ3QqEa0oNFXZ2V+d5U8jrAypOJKA55+JjMYfIbeFT9aqLLO2
 uyKFPUHSj18hIKt5nYVJ1MukiR180+1SwMHt5mPeffXUk12XeugM2Tzfl/S++9X1iJdJY60IE
 Hls95CFHyBfMkRlgRtag9seO0w0OKuPohBPt1TQ6cZbARjLLCO/YF/zxCMvL8V3WcNI5KH2mF
 74rFgUD/Zw3k/Bk//CvmpqcEycZLaWJNFMNtKtgxn/0/cjtQdbmv8qb0I+uu6AcsEnYh1glFu
 sq5NmtcICZA0OnigDKtl5WuVmnNzAGncxwZZ+EbPXQk+BGjNXaH53OC2Kzhay5FwjVRkpnRxT
 YSogMSLOlh9jljX1lLbXa4wreX6DmWFZUVZhlG0Qmj5XZ7A6VJ0MN/7ZWjLyuXjzFGyiHFbax
 P/vwVV7F6j7EZEMuY+NPU3XQJVHpmFwTR3b6gpTRQLyIu84cAL4zo01CcHOTkux9KLLqqU+HQ
 g3L3CO6g543zW5A/Qj4bxapBBRujrgz+zte4W/PW9VmxOie8wCsO/epwa0DuSK8N9yknuDAAA
 CdDXAhLjZag87lrGfv8GbZLmkUDUhoI6aZDdxXR5iACRPEFY0v9nP4laVEu7AsRnFzNESKWve
 UHhYI+Ipz7QveUiElQfQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--creN76nuQiOUNcjpYnGkqFGOFhYpgcy2L
Content-Type: multipart/mixed; boundary="FczHdAuAX8I8ZhK572WvJXVdIIpN4GsWP"

--FczHdAuAX8I8ZhK572WvJXVdIIpN4GsWP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> record_root_in_trans can fail currently, so handle this failure
> properly.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/transaction.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index c17ab5194f5a..db676d99b098 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1436,7 +1436,9 @@ static int qgroup_account_snapshot(struct btrfs_t=
rans_handle *trans,
>  	 * recorded root will never be updated again, causing an outdated roo=
t
>  	 * item.
>  	 */
> -	record_root_in_trans(trans, src, 1);
> +	ret =3D record_root_in_trans(trans, src, 1);
> +	if (ret)
> +		return ret;
> =20
>  	/*
>  	 * We are going to commit transaction, see btrfs_commit_transaction()=

> @@ -1488,7 +1490,7 @@ static int qgroup_account_snapshot(struct btrfs_t=
rans_handle *trans,
>  	 * insert_dir_item()
>  	 */
>  	if (!ret)
> -		record_root_in_trans(trans, parent, 1);
> +		ret =3D record_root_in_trans(trans, parent, 1);
>  	return ret;
>  }
> =20
>=20


--FczHdAuAX8I8ZhK572WvJXVdIIpN4GsWP--

--creN76nuQiOUNcjpYnGkqFGOFhYpgcy2L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUfcACgkQwj2R86El
/qjftQf/aI5of7bab06TfPepjItgAKU2gEkLBu/RTzbxPOfVY6PR+YL+x2wVS+cI
ABt+WF/5JJbY4pINuLRPyfid8P2xk0531cpQQGF4xUmQ1giT8F3LZQanKfn3QrKN
OOQphEEH5/Mw1ZvmgrdmpkE0ro1ob/icOSjZO+i3jeB+nT0qZipJaN1+hKnt973/
pvmC967kx2mmdR7OI/9N8TB+NHq/2DtnZ2GAQOKXvt/J/+KTJYiL3v0BD1ed46Ke
pn29xfkj3519h/dIUZwo7TyriadCf6fontQbufuF3kRjeolZRogN0zrw0YXIY0H7
Ve4unO+aC3qQkIAACWYGLKY5l0NLGA==
=XaS6
-----END PGP SIGNATURE-----

--creN76nuQiOUNcjpYnGkqFGOFhYpgcy2L--
