Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE614F58D
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 02:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBABAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 20:00:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:46421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgBABAY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 20:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580518813;
        bh=X5yqz1eLiL2/C2guD8krJly0VZMEVx4u7OZcA6Erdk4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cn35FR315hMBNdlw1Z7uARCJo53rZiGLiIRooH9xKF/4Ri6Op/F63OS9kn02hLOgZ
         hNB20da7wSsg2yrmM4zhbYTNRtgOQsD9zzfrscM037W9kWAHaHOnB/+rfBlursdVdJ
         tpkMrMTrMz9tfi7aFUd0L07VgCt7bmmxBXxBz71o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGrE-1j3iVO48dC-00YlvU; Sat, 01
 Feb 2020 02:00:13 +0100
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Martin Steigerwald <martin@lichtvoll.de>
References: <20200131143105.52092-1-josef@toxicpanda.com>
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
Message-ID: <e1ad601a-cd27-7464-57f5-1be39deeac53@gmx.com>
Date:   Sat, 1 Feb 2020 09:00:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131143105.52092-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MvnEwlhih987ruTs1o41Gl7K5XGeDl0QX"
X-Provags-ID: V03:K1:DRCCDAhOI0jtHG8D6GcCjUOoEuzlxes+r+tCod/Z8pr8V9eY3wQ
 S0MYD/X/yp7dpzTTVFP0NkH8f88gtDT6Bc9qD2G1FoKiwvLh8l97/gpH+wQl/NC5HVGN9mp
 evtgCDkvxnFpX6b1SaOf6ACZqkLGbsKcW9cqP9repjzG6Lpj4/425acjkvh+Y55HhXvFn/v
 s6vm9sPZnNpRDjKbzLEfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eAPwBpkzC+8=:whZhPttkJ1hh4e5my+scv9
 ZL5U5rp1YZvC45wor34wZDL/VV4+EeGealkrPGjldQVagVMRqWiDwYv1hgnKme33wZZc5AzL7
 vsPVDTPa4rnMqcw8JUtWTo9u0bCOsY/QoEkmhiL6gBmaTzHWZGJ9dOTrql+yjm1xo/GcVrUY7
 9minXkui1wIW4XU4RbB3tgxOrB64r6rgG4rzHYiesMzY1NbmYSp/GvRFjfFw2COR7k2pgniSP
 f0wytoBBRE354OvKeywnaxn+3NyOp8gn3tOB0GFQxyzfS8TatrCOg1yts6GMdkezsSIt1Ntxo
 1E7IcIspybC/61C9yhAeHq6zu/7Y+1H1kJwZ2vFsTyqm9T6KQV0xTH0X1scUcO1NGaiTBXKIi
 CAol/glR38ZHtke0oj0YzAkBL1Deg75h8DvTxntftvdsWnR4WevkBvIr6P17rTou/u/126Ex3
 6GM4teo6vDIMIp1DTbcdN+ChwHPSlHp/Orm1eWZ1nFWa1hf938mYE00cCCuEisXnDIvxpvCcD
 AUl0UR0ouduHM9wYNfSMsT87KyoNtc5Ps7bK7oth7oMnhEwnOIWQoGTra0JIKjazg5W591pX+
 iJMXQB49z7VBSitXWeMBqeI2WDWQ8+TuucA5ThleOb4K6qHXv8eILBwnyxxtEws+RoyxKpWZj
 L7tSdCl/ZmYY7PcDshK045KEVFouf9Y2J15Ekjclew8CjAaN7pL6pxD/T34nINB4fS0HdDWQj
 diwi5DsgrcRfPwH1XwkibdgtBNEbKlimAre6nbeUvOzac0v/EMn0AOU5ZxtQjNuJ9861+uMgb
 AkVmKrCEcMrSHNviiPIZ6sZefCKZcIjNJkYpNttBA1qx+1MVDf9dmvtFPcZVCVqdd0gKPTVeb
 UnT6mYiHwECH13aaG54YtqdeZ0e/+RyrPR2J2lNp/5FO4AQLi5xmHQP17kL06y8YrDdKWZjnC
 k8A7ekij9FRqsS7gnfp9kqUIdCGOMzRzjKkxMej07u9p6Biw61b3hIdhlm/ndd1O/I1lGaqkI
 SRBEgtYx2jv1VxY2BrmfrV8Djvg+L4i3Ze4LNGwXRxyuXRM61BcUvFgbJ7z7bUVPoJ3A43K27
 TupYbaCtO9NFDYpnQFJz9G70k7h5KXzi41RAoHiM8D6mIWnex7KG7hdQ5N5a6lWodWzaCLhld
 bjOS8fNoQoE881dBPLih57PivKlmcoZy3Zrt32nxQ2+dFd8JGKDsnahCJMEcjrQ12zEogzj+h
 RXH6+mUtRF9xQMDxV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MvnEwlhih987ruTs1o41Gl7K5XGeDl0QX
Content-Type: multipart/mixed; boundary="I0xz7wpoYuIF72rt4fTwx67hdkt8Efl1C"

--I0xz7wpoYuIF72rt4fTwx67hdkt8Efl1C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/31 =E4=B8=8B=E5=8D=8810:31, Josef Bacik wrote:
> There was some logic added a while ago to clear out f_bavail in statfs(=
)
> if we did not have enough free metadata space to satisfy our global
> reserve.  This was incorrect at the time, however didn't really pose a
> problem for normal file systems because we would often allocate chunks
> if we got this low on free metadata space, and thus wouldn't really hit=

> this case unless we were actually full.
>=20
> Fast forward to today and now we are much better about not allocating
> metadata chunks all of the time.  Couple this with d792b0f19711 which
> now means we'll easily have a larger global reserve than our free space=
,
> we are now more likely to trip over this while still having plenty of
> space.
>=20
> Fix this by skipping this logic if the global rsv's space_info is not
> full.  space_info->full is 0 unless we've attempted to allocate a chunk=

> for that space_info and that has failed.  If this happens then the spac=
e
> for the global reserve is definitely sacred and we need to report
> b_avail =3D=3D 0, but before then we can just use our calculated b_avai=
l.
>=20
> There are other cases where df isn't quite right, and Qu is addressing
> them in a more holistic way.  This simply fixes the users that are
> currently experiencing pain because of this problem.
>=20
> Fixes: ca8a51b3a979 ("btrfs: statfs: report zero available if metadata =
are exhausted")
> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/super.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d421884f0c23..42433ca822aa 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2143,7 +2143,15 @@ static int btrfs_statfs(struct dentry *dentry, s=
truct kstatfs *buf)
>  	 */
>  	thresh =3D SZ_4M;
> =20
> -	if (!mixed && total_free_meta - thresh < block_rsv->size)
> +	/*
> +	 * We only want to claim there's no available space if we can no long=
er
> +	 * allocate chunks for our metadata profile and our global reserve wi=
ll
> +	 * not fit in the free metadata space.  If we aren't ->full then we
> +	 * still can allocate chunks and thus are fine using the currently
> +	 * calculated f_bavail.
> +	 */
> +	if (!mixed && block_rsv->space_info->full &&
> +	    total_free_meta - thresh < block_rsv->size)
>  		buf->f_bavail =3D 0;
> =20
>  	buf->f_type =3D BTRFS_SUPER_MAGIC;
>=20


--I0xz7wpoYuIF72rt4fTwx67hdkt8Efl1C--

--MvnEwlhih987ruTs1o41Gl7K5XGeDl0QX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl40zZkACgkQwj2R86El
/qhLngf+KwUT3TlWUYDooidyH7KV3h7xxFw47GDZQcNYnqtnj92APL7E2Ln70APo
fLTxTEnPjKPRolWcbtJDhz5udEbklAlZSom+ZQ45KZ0AP2JoMlo61EQXzykfMJVZ
gZdPgQWoMubQ1PppX72m96RV+mKxhCImcMuOrFL9TIWWypJxX5NFAuhdmC0rFbZh
otEj5D7ftB6ur4ZcyyM9duXNzL4WLBA0eeT8DK348NeTUeUpfQ+TW8q7cxT0qdbl
59/0K1cTSnXkpqGxpw3Nfbjk75CHrC13ziqRXnY7UmN3MFwTzUbdDKCJjMBizAll
RlcONPPfVFbMZjzTlHWivvwWlakQLw==
=11k0
-----END PGP SIGNATURE-----

--MvnEwlhih987ruTs1o41Gl7K5XGeDl0QX--
