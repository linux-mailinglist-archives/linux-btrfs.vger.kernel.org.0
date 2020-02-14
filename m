Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8615D4DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgBNJhJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:37:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:57677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgBNJhJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581673020;
        bh=yjE1pgv3C9A/42TE/9R5s4CtPyxyAqJ8NQcL7rJiLzo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eKhNAIHqVQPpGruXd92L/hL92eP56Lx7Fa9sGZkuSX1cfjrFyqnUkhBwzulF12AsR
         W95s19j0wN4yX8CZ99vQiS0zBTh+IYHLoBj6FsP09ZiBs61eQRVmb1AdH1ft0HTK7k
         QeOQoHBcDH+/6zSS+8H8omMrMnV69gO1Qr5UH6nw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU5R-1jg0x50UTL-00ee8S; Fri, 14
 Feb 2020 10:37:00 +0100
Subject: Re: [PATCH v2 3/3] btrfs: relocation: Use btrfs_backref_iterator
 infrastructure
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-4-wqu@suse.com>
 <SN4PR0401MB3598CB039EE0C0220A06F6039B150@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <6b9f7d71-2164-e74d-42bf-92e1aaa8153d@gmx.com>
Date:   Fri, 14 Feb 2020 17:36:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598CB039EE0C0220A06F6039B150@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QMOexNHvzuDMRvoh6Q5A8t2GrSHAbK0bm"
X-Provags-ID: V03:K1:QBgghWvkjtwD0kgw8D556+c/w5ySNknMGWtzzwj9Mv96Tqd2MyN
 0c42gUl1p5I30KMx7lbtt3iBBYI9wO8osPEvd4nWN5yceyKYWgf4nEIa3JQpQNu6xna/nW/
 XYKeWDg2KNbpr+RLmS/Psr9md2ZrmtzqUZ5Ygcr05SwIx/peck+LZrv+aEMbpErSvNYF9w0
 A40CmGDHHaBBQnr86tDoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:20dIYRpYUDo=:fkg8Le12c+R7ljMRckUQLR
 dV4lLNT9UMUagCBTGJ5X5TT8fzmxEr0v9lNDneY9gqQu61Q49nKFh2nMZIfNSQwE9YAjIZA3m
 rleADTB3mLgIxJ6fmhXg1g7iEAsgTH++Xp414Hj3rjJ2aPcxul9y4D/EAMHlMfjQyz9+1z1fJ
 W9TM6ErVkDzQ91hWoPWqaB9iMgi3n/BkqAoApZO7IlL25NsboglLG1UTOdcGlxbaaRxd7dlIm
 Of+ApsQwssfoZiUrSO2OtKzZQg2K3LyY+7Oxbkd2T2u0GzWDrVu8DovaDu/xrG8UMznBmnX1V
 VwpMnLZWIbiILAoloh13OZkPvDRVeA/dDQBLPANRK642OL/lr26NGf/n6sk0m+jHk5Gz7DOEi
 9aDVDCmBjiTmJc12upBsGxoITldxcFnz0QuAwGkx7jnnOSs4ch3qd47zXbM2/TH3Wk5okRLX+
 aRmkCOFOhE1KX2LOHhfecaL4A4bxak/Lh5w+kbYbe4UFqZqFitLPqbiaep74pgzt/YiwDdez0
 LBxmxd0VXdM7WHIDUn2M1+Ltz57fg0/EFAMmasGoyHBjC0Agp06YlMq4pyNiBr0KO8OkQZDY6
 cFIAHuIwiKdVYdJ8EajzpUO32oyWNxjeTjeVg6ZSWvZyE2feC5elZExDU7n+oW9jU11D4Go3t
 v/CDkr5XfRJyCcTEd/85ZnKQ9gEIhk+dk2DHW9CWukXaOZwuPItIQCvf2ZQmpAI5OjE0DCFAR
 AQLiMZ+9frGZuBUKr2A4YVQ38cC02iMHmHMiskhb2jhB/Ekm8oQvrdSu1l4iy2YRtx878ALJh
 sRccZtgYacpu/TX8I3ywta65toP3vZODq5K+kprsjVKXDV6tHVW/8+Kf1s4JeWBc/lC5tCirT
 Z0uX3tT3vUOMDr2jFfsDBfX3KkYv9F9daiJ61ojiyVv8SylgivV/Nkw5qMQ/LanfxsjUFF6Ns
 7nkZH41DDEVxSIGlarZ4YLdElRC5FY3SAg11Lr6JcnpC7rRQhaRNQxI6TtUl2q55KtLtMP+S9
 dFbmGjaYJZ4CB0shPgJwCTUUjCSF1zkVQXsucjKFYIpUkExVmRWPB3r3GLVAC8IeHy25NC3t8
 7+4aMsWdDpfCWXU7nvnhjxjvr58Ki1d356LNaS2hiiUyeDKBu0kCPXSu4lD2uYjXVjhsKBi7V
 nC/WoQYOm3unM0OpOeUlfpNcFlZ1MXaaarY+JVcCa05TeBj8FyDOYdAMGx4UUzZ4Q3mlDM3HN
 EydVGLb2iEKSiB/Lf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QMOexNHvzuDMRvoh6Q5A8t2GrSHAbK0bm
Content-Type: multipart/mixed; boundary="hxvyzPbckXKhnuWgrX0z0GqstyVpNs0UE"

--hxvyzPbckXKhnuWgrX0z0GqstyVpNs0UE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/14 =E4=B8=8B=E5=8D=885:00, Johannes Thumshirn wrote:
> On 14/02/2020 09:14, Qu Wenruo wrote:
>> @@ -677,9 +635,6 @@ struct backref_node *build_backref_tree(struct rel=
oc_control *rc,
>>   	struct backref_node *exist =3D NULL;
>>   	struct backref_edge *edge;
>>   	struct rb_node *rb_node;
>> -	struct btrfs_key key;
>> -	unsigned long end;
>> -	unsigned long ptr;
>>   	LIST_HEAD(list); /* Pending edge list, upper node needs to be check=
ed */
>>   	LIST_HEAD(useless);
>>   	int cowonly;
>> @@ -687,14 +642,14 @@ struct backref_node *build_backref_tree(struct r=
eloc_control *rc,
>>   	int err =3D 0;
>>   	bool need_check =3D true;
>>  =20
>> -	path1 =3D btrfs_alloc_path();
>> -	path2 =3D btrfs_alloc_path();
>> -	if (!path1 || !path2) {
>> +	iterator =3D btrfs_backref_iterator_alloc(rc->extent_root->fs_info,
>> +						GFP_NOFS);
>=20
> btrfs_backref_iterator_alloc() can fail and I don't see where a
> iterator =3D=3D NULL condition is handled.
>=20
Oops.

Thanks for catching this!
Qu


--hxvyzPbckXKhnuWgrX0z0GqstyVpNs0UE--

--QMOexNHvzuDMRvoh6Q5A8t2GrSHAbK0bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5GajcACgkQwj2R86El
/qi0owf/Z0p/tBlEf7Xv6Y7NvKmZLPTOBi1ueBMD2z1UBdh5XZP9GAlbnP3B5E/F
vZdJFJ+vNifmPqdOv2isT0nydgjbWtIItNlnFLXDfumvoUokZeakWnafbuMjV+ww
OvHACD7RZvteeO4g5NkWxupspVUfoMKCnCBsV0+3feldbOkIMwL082scAtApQoQw
RVXW0/q7KEWALX8UiWUD3XbSKMk3je9BWHwdy7sa3BNUR+SDv0gQxC/BKTKzUcS2
P6pKov5jqV3OPoW8yGDTpTKce0oMhIPGOLljemV6iB8PBEESOpCaWuxMe9EtIOgL
YG/Abg1SbYy+5w2WQZkoVhb1TqEm5g==
=iyj+
-----END PGP SIGNATURE-----

--QMOexNHvzuDMRvoh6Q5A8t2GrSHAbK0bm--
