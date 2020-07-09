Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336ED21AB37
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 01:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGIXGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 19:06:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:39109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXGy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 19:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594336009;
        bh=L+dW/m/hPhm3UbrAjjGMeZbmFw7GNaG1fZss9CnRTIQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M9gg5AwnGfLvX6312+MpP1ibd2PCPaXw33IZVamZ/0pw6G2fhKI10M24zOxs7gT0D
         DUeK2CQ7tiA4AquPuRotcD3rrYTS0rhdJyvs9tg7l77NkW0hj9q8AZ8B1mgIAGbUQo
         qxWtjpIQBhjTdipbRsDw67kSm7PmtdgSTfm5ooHA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O6e-1juEOE3y50-003qu7; Fri, 10
 Jul 2020 01:06:49 +0200
Subject: Re: [PATCH v3 2/3] btrfs: qgroup: try to flush qgroup space when we
 get -EDQUOT
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-3-wqu@suse.com> <20200709163246.GB15161@twin.jikos.cz>
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
Message-ID: <85256402-642d-3f0d-d14c-5a2afb21823b@gmx.com>
Date:   Fri, 10 Jul 2020 07:06:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709163246.GB15161@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XixYtvamdB0RIH5zbREejgG1JKo4IJKiq"
X-Provags-ID: V03:K1:yCCR5a8xSrZPphTmqUjbESn2mvalihPrWGKXFhGvGI2Yh3TuF6P
 TngTIQlrg9PLay7OYgpH4zfDwUBfreQUnRIRZj7Qjf7IyZBgkRz6kP4ApjGleXY/0hv7EVS
 K/wALlSiVzMlFXYDsTWEfYQ79w+YddwRNPeH7gu84RI1jiyl9sEURMvdUiKnnKmPf0ak9pt
 Kag/gYeKo7LXQOugK6fUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BSC77fusLNY=:JSXuVVGj898ZPT2K7kzj5/
 veTzWXLcT5zQE739E8JMO59jKJwms2LMxK4f0MHyiLPPiXmWZc0fdeY0QPqMr99iVfH25yDW6
 RN+wgO8zk68av2mhnqpZmof8bcY8LZj1KIFGgcWzUpwGjE5dnkdJSwEMYnpprQlgZRNEPsOHB
 YG8adT/PmUT2ftJ9rRuKp9wdXHiUvE2NQ5cMsYl2hHGKdwqwlXTk38AFGKBjf9imPbDnylf5W
 YYloKZvRs38gqocNNYSR2JTW7+ywbF4rtBn2KCpjddlDXfNKKWZJvd+g8FsKnGY8I2QdITx6b
 +uQ4Lycnovbak1oG0ZXy+Huf4ZVh7Ct5ciEJ3rWwTKGdyo6TtTkorL2iHyoMfEYtug1+rtcA/
 eL30B/PLgeMrw4AzazUlYwgGTczOSAOdivimDUwiDGE3g6rZUG/SbU4xrZtYPEld7L5RtEROY
 vawbWjUynLBJd3RAJRe8fSXsL0jbo8kJ24x9qCZ6tKqczqlJ9jvttkW3Ldg3cTfC2lNpE48ca
 mm+i9AKqhP5t/RjpkgABJl9xaAisYoGiuCNNjr7yr+KA7Nt+IgqWLH+83BbQCBsvHkgNRsraL
 BkweyLQhKbIFy2Oe1EpxTwuSdcojHKU8BrDBx0nvaL0cI4tIO/wNhPDqZXzSc05K+mKnF8JcO
 SrK+omtFYcPjwvluGxwnNm2+uguKOkh7FECh7gMRdLLqnOIyAVH8tTHs9Vd9BVB0auQZVNXCB
 44k/+njGKLSTAEORDAm7CKoH3QKmJtRKeTucqfIop42G9Z21kEEVVRrgkx96q6Z9yfsW4EKFH
 Ubj9HlzzSP90zuZ/FQM8uaEhHYI8kzDCzei6+/s2+i0uzJXx9+6YuE8/k4rTEVU6yhPeC81vR
 /rtcC1xu4R4bQMFOTUdJJHm50KV+jYxvdH8+HeAw4oF//MW2oyl5ABPgnOfCH0UQBOF4rwWTo
 X1qDCMdob4U5TsGN2J+vWEYPVFRCH18UdO9GjA/xYFh1xK4Cc1g0Tb8sAu0ZDp0dg75wF0dVr
 RcSCIbsOWJ8IpPp534Nj86U5IhdOF+zWSUZxc8YE0b0xCnmUPZgvfs3WKJPAJuXl1mflXIskX
 wzGsBC5BErTEWXkjzIXZhEVcaUshhWEEt2I5yPS8Vo94H8iTzyvK+38qRt96cr8WZW8ki1sGx
 N6r7l4phZSfT7cMSmCYjUYf2qvivr9oxttv+CeSKHbXC3PCcoGbQk8f5gV2xxK9vFJw40N0Cc
 X2q2/uqDuYbAy0Hhk2XO88PXwA7EHzPla/AiiLA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XixYtvamdB0RIH5zbREejgG1JKo4IJKiq
Content-Type: multipart/mixed; boundary="v616DZaAUeucw5dJIODDU6oknUIpRDjfg"

--v616DZaAUeucw5dJIODDU6oknUIpRDjfg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/10 =E4=B8=8A=E5=8D=8812:32, David Sterba wrote:
> On Wed, Jul 08, 2020 at 02:24:46PM +0800, Qu Wenruo wrote:
>> -int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
>> +static int try_flush_qgroup(struct btrfs_root *root)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	int ret;
>> +
>> +	/*
>> +	 * We don't want to run flush again and again, so if there is a runn=
ing
>> +	 * one, we won't try to start a new flush, but exit directly.
>> +	 */
>> +	ret =3D mutex_trylock(&root->qgroup_flushing_mutex);
>> +	if (!ret) {
>> +		mutex_lock(&root->qgroup_flushing_mutex);
>> +		mutex_unlock(&root->qgroup_flushing_mutex);
>=20
> This is abuse of mutex, for status tracking "is somebody flushing" and
> for waiting until it's over.
>=20
> We have many root::status bits (the BTRFS_ROOT_* namespace) so that
> qgroups are flushing should another one. The bit atomically set when it=

> starts and cleared when it ends.

In fact, I want to avoid plain wait_queue usage if possible.

Unlike mutex, wait_queue doesn't have good enough debug mechanism like
lockdep.

I see no reason re-implementing the existing mutex code by ourselves
could bring any benefit here.

It may looks like an abuse of mutex, but I could wrap it into something
like wait_or_lock_mutex(), which may slightly improve the readability.

Or am I missing anything?

>=20
> All waiting tasks should queue in a normal wait_queue_head.
>=20
>> +		return 0;
>> +	}
>> +
>> +	ret =3D btrfs_start_delalloc_snapshot(root);
>> +	if (ret < 0)
>> +		goto unlock;
>> +	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
>> +
>> +	trans =3D btrfs_join_transaction(root);
>> +	if (IS_ERR(trans)) {
>> +		ret =3D PTR_ERR(trans);
>> +		goto unlock;
>> +	}
>> +
>> +	ret =3D btrfs_commit_transaction(trans);
>> +unlock:
>> +	mutex_unlock(&root->qgroup_flushing_mutex);
>=20
> And also the whole wait/join/commit combo is in one huge mutex, that's
> really an anti-pattern.
>=20
But that mutex is per-root, and is the slow path.

Converting to wait_queue won't change the pattern either.

Thanks,
Qu


--v616DZaAUeucw5dJIODDU6oknUIpRDjfg--

--XixYtvamdB0RIH5zbREejgG1JKo4IJKiq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8HowUACgkQwj2R86El
/qg03Af/dTtg09icVSxUXnNFgOy6b9l9dgdHX1mMyf6P/4zDaKw7Siwru/gz3uyc
yWXj+7urOfGP8PJmtVt21U11Q9llVMkfoKwKtU1HCUg9Et3IAGpBNVGx677Izqaq
j9N6iiQtFY8P8u+FkJQdoptPS+8NIeK9LC1CrhUidrwwIyffo4/lITDe6QxS1ZQW
rrgL34L4DYh/VfUfyh9YGLKEcXFCugUdC7vQMYQ+CJtHveRTJrcnDLgTyOa3CVSD
Cht3h47+vidjUisr4tdG3yhdSJvyPoRK4VYv++LaCN2n6cQlGI18iCqdVflCLJsY
cTSCQAI9nfK/a+XYQuTubFfA14ey4g==
=itu4
-----END PGP SIGNATURE-----

--XixYtvamdB0RIH5zbREejgG1JKo4IJKiq--
