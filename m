Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8303F1F7390
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgFLFiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 01:38:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:58281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgFLFiL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 01:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591940288;
        bh=rMf4x8/SNDIeYbS9sgo27e04hB7EE2AeXIeKQyeKeSo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cK2C7PEehyW8eA/5d6Bkhd6nvSaWXgXfp6dW8Pryel+IAC89YcD9iH+0JaKNN8SFK
         oMmnia4fLbK8pDIt8LRu8Hd6VkbInA5Ssfixaitga77+ZGKIjt9TWssnojJiILGOAh
         W3VGWPi3fSRFOQlayJbT3OeMk4Djfn6D4JG4G26Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MStCe-1jM4yv15Yc-00UMQl; Fri, 12
 Jun 2020 07:38:08 +0200
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
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
Message-ID: <434d03cf-01ba-3051-8dcb-22fd70de9957@gmx.com>
Date:   Fri, 12 Jun 2020 13:38:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611135244.GP27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YFtLf5xZUeuJnpu54PVPaHRvkz9sxI82T"
X-Provags-ID: V03:K1:qmfQzOAxzW0tnn5NN/0AU+UzSdNbhz0iNMHiaeHEpevlHHuYeh0
 MlIgfTKrTgOlCSwAubCifzNP3H8VpuaLH1tnlXmPenT0HSJkq0fqbkA6G8ZolWqGSWfLSSt
 SqCcdRo7X77nJvuo9AhUK9inlREODbsu71Yo4Bkn6XyiLGKNN0KMiNjaO5KS9+sfA/8Ix+C
 4RmgG7tUp4jdrWTbDvzHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7OK8c1NO/4=:7CeZBDwUXhHEpldcVIsWb1
 SRYwPRM+KTIz8UBhK1h73LpOT5PWCgUBzByCir5JZZD3MnaG+ZIJxy8wXJzfrX+hoV31w77mz
 ONFVU69mwzDm46xLpgQuiSTx634H7/AUmYajkj4AUXcVfP0CnUWm+JV95+jrPYycQvQxYjQJt
 /21VViB9zRNGwfxhX2ssU3BUVBvVwZ+oGAkzXuQjTCaQh93Sez5amqQKr7TE+MdAnw7BOMwjK
 oahi+YSUo0gUv4N/rcmNOCZOGd8TRQkDCl+In6K7uORqawduIZSh9x57Stz9AuYtcBR26A8YU
 G1LwO3DdhRtm5q3i376/cD+7RsBo1KWSxAhXshOUJcLl8eEuuxbNd2k9LyyjOKpl0FFsnH7yb
 Rc/rBYIwuW9Ngbpi45F/wFmCjFMuzHZd3h0j1PAN1DDDcUk2syWY6jqrpH4PS6PfU2hKTQHe9
 0R/bnHtuwQiTDqAvPVCapLdl4/RNXn9P4x1vVeoB3em0VO5atSu850H84frra7BbLGX4danua
 rR119FZh9H7cKVYRq6TBYy701x25cYhKv46oKKKaoCeovz/SZH/BlKVX3hkVO2Se8tpqH+DVU
 MWVH5mibi7f0xCg4WFRejopxdlwhEzYFruHSarO4V6xZLtDIH5i8MJ+Ua6HTBCxoYLpwvwp18
 bMDgcUTVRWIzLKKjPsnb28GQsGfgJifWyfBCZT3PwFILDS2993YI4S7fpuWLhVNor4wBcHTSp
 lr7tC5FeqrgnpS3xi0GvPxsU9SCwvXkFWYThyF1SK6w3PVdU0jTHRTGQUw+OkMsIq99HnFoz9
 nmBD2dKBmUHHykEgfhzPzN6MnIBgRaWmamv9y5ndK2DBr1g1L1R3WZphs9KPzIYNSVQmaVhBa
 gOpW7JWj4MlJF/JFwSNJ2UXKmA/My5bh+19kSeVfrn2opiK4zzZriRYE9lITvV/x3kI/Hwri6
 nhnRx4irOGxIUo+XxQVolTr47ZzA0yuAEKW0btSs04Pe5iIL0E9vEXfVGioIa6BddeOXMddrK
 zh3ANhyoo5/j9pM5l9eou+sN3UtlaGikpp1RNWxD0Cd5b+2iA9C64DT72R2PTPGhuIYWqgLSI
 6Zt7DfK0NTgU152xkxVE6//TAgGg+bkcDIA5MXFY2TJpgbNbureMpMiyHc/bkXBLJi8H9juCr
 c8VrDvejGvv+GBhwj9Q10juvU0u5AdTTonQEzwtARbC3RVq5YwW4k6QxgT1+ZtUU2nxwGaVBF
 zMpF8bll9FDEL1682
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YFtLf5xZUeuJnpu54PVPaHRvkz9sxI82T
Content-Type: multipart/mixed; boundary="Dqc8Jn12xlA0FRFlzboH4Djp3pC83ANsk"

--Dqc8Jn12xlA0FRFlzboH4Djp3pC83ANsk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/11 =E4=B8=8B=E5=8D=889:52, David Sterba wrote:
> On Thu, Jun 11, 2020 at 08:37:11PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/6/11 =E4=B8=8B=E5=8D=887:20, David Sterba wrote:
>>> On Thu, Jun 11, 2020 at 06:29:34PM +0800, Greed Rong wrote:
>>>> Hi,
>>>> I have got this error several times. Are there any suggestions to av=
oid this?
>>>>
>>>> # dmesg
>>>> [7142286.563596] ------------[ cut here ]------------
>>>> [7142286.564499] BTRFS: Transaction aborted (error -24)
>>>
>>> EMFILE          24      /* Too many open files */
>>>
>>> you can increase the open file limit but it's strange that this happe=
ns,
>>> first time I see this.
>>
>> Not something from btrfs code, thus it must come from the VFS/MM code.=

>=20
> Yeah, this is VFS. Creating a new root will need a new inode and dentry=

> and the limits are applied.
>=20
>> The offending abort transaction is from btrfs_read_fs_root_no_name(),
>> which is updated to btrfs_get_fs_root() in upstream kernel.
>> Overall, it's not much different between the upstream and the 5.0.10 k=
ernel.
>>
>> But with latest btrfs_get_fs_root(), after a quick glance, there isn't=

>> any obvious location to introduce the EMFILE error.
>>
>> Any extra info about the worload to trigger the bug?
>=20
> I think it's from get_anon_bdev, that's called from btrfs_init_fs_root
> (in btrfs_get_fs_root):
>=20
> 1073 int get_anon_bdev(dev_t *p)
> 1074 {
> 1075         int dev;
> 1076
> 1077         /*
> 1078          * Many userspace utilities consider an FSID of 0 invalid.=

> 1079          * Always return at least 1 from get_anon_bdev.
> 1080          */
> 1081         dev =3D ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORBI=
TS) - 1,
> 1082                         GFP_ATOMIC);
> 1083         if (dev =3D=3D -ENOSPC)
> 1084                 dev =3D -EMFILE;
> 1085         if (dev < 0)
> 1086                 return dev;
> 1087
> 1088         *p =3D MKDEV(0, dev);
> 1089         return 0;
> 1090 }
> 1091 EXPORT_SYMBOL(get_anon_bdev);
>=20
> And comment says "Return: 0 on success, -EMFILE if there are no
> anonymous bdevs left ".
>=20
> The fs tree roots are created later than the actual command is executed=
,
> so all the errors are also delayed. For that reason I moved eg. the roo=
t
> item and path allocation to the first phase. We could do the same for
> the anonymous bdev.

The first question is, do we really need per-root anonymous bdev?

IMHO btrfs can shared the same anonymous bdev across the same fs, no
need for each root to own one.

The user-visible change would be, statefs() will alwasy return the same
bdev for all roots.
User would lose the ability to distinguish different roots from the same
fs, but I doubt if that would really impact the use cases.

Thanks,
Qu

>=20
> The problem won't go away tough, the question is why is the IDA range
> unnamed_dev_ida exhausted.
>=20


--Dqc8Jn12xlA0FRFlzboH4Djp3pC83ANsk--

--YFtLf5xZUeuJnpu54PVPaHRvkz9sxI82T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7jFLsACgkQwj2R86El
/qhCxAgAj1HONylb54kG1/8BOESyxwXnYMurzcZBmyeipf5vOqgau3gHJ0h8xzIH
5CDog5ii7lCJ4a6eDV+TlOCloahGWbeIDTLTIzCcqFUeT79Z0PYwB4JK5bOiSbpt
aESxYTpW9r+7fupBsQzY9lkOGZ2Mt0QfNJFChAyvyYa25GzodR23x4sFX1/zVVxl
ebmSlhu+Pnh7B5F3JWow9nR8J5xxQKSXZ3PLfwYF7ESuR4kmmNsRLnBAEkbPhOG6
BsAgGZrCpn9u+KtqX/JyRsrpQTYlOy3YOkw8S72gE5J4+8o1rou5H+RtHzbpbzcO
9v2hmZUh/jJwlyZNC/mI4dF5mRjX4Q==
=vNEY
-----END PGP SIGNATURE-----

--YFtLf5xZUeuJnpu54PVPaHRvkz9sxI82T--
