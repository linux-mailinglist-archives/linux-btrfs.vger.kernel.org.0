Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3883180D49
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 02:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgCKBK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 21:10:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:52381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgCKBKz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 21:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583889048;
        bh=RbclaePc/viG6ZLYfd8ns4cbR78MYvtQUYtks3a1XW4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U33EIgAZSDbFMQsjORE3GJtPX3GOL7aGPIZXav/l/CmHGu5qMKnP6jplg20hiz8I4
         pTk8Wyf1TqhHxDS2nQvqDCVBdAx5acl5BiuPVQWexf51rpg/oPHPKjue5CzQGNPBSG
         YTgY14F+9mxunLDiEw7vdhd9/RrfE9laAkx4XzzA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0XCw-1jZ7yG0N64-00wYz7; Wed, 11
 Mar 2020 02:10:48 +0100
Subject: Re: [PATCH] btrfs: relocation: Use btrfs_find_all_leaves() to locate
 parent tree leaves of a data extent
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200310081415.49080-1-wqu@suse.com>
 <20200311005034.GD12659@twin.jikos.cz>
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
Message-ID: <00a3d3ce-8b2c-0485-8db4-e3b3b1b8996e@gmx.com>
Date:   Wed, 11 Mar 2020 09:10:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311005034.GD12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k3BuxXdckzKgdtComMELiZlf5G8i4dJWB"
X-Provags-ID: V03:K1:DRd/xzekwbz4CmBlZbqz7V4doX0PI7K+fhUMWoilhTy503vb+2g
 JjCBmOc3H5rCU+jlgBlJIhG0B3vnVcJobiYrXkg9IxFQczfkpk6psw+obreCDnncXLjBFiS
 fcwyqC23v5uCD2ZAnSMGLnU+xvxA4CTiSI4CJUGn94g7UngGTRCQQONn6xZ9J+C5EGKG0IG
 4j7M45mJx4+goHAykBH2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0SrGLhi+gIc=:kOluA+OHlqtvB9bsnp1yjv
 7CAkFdhf+FnU22BXpyUCZF8m1ZGqxOs5bluQx0bWf16iie5bNI8e7mPcP3wsQQoLoM9FgoKTo
 /PPHqITUzxagu2tLwQ+leYBNXew98l2Q/LhUjvTwny9+zky1BtxThi+9SSmTdnBJFtdkTdorb
 2DxjSQ7tFNGN44yUhqQun0IgXXX/DFiqQjvuEoccG33fjzgs0ySU5nACBr6JVh9FbQtOcMsip
 0YDSdxlixJzpGZgjRJ0AJ7NB/gnKVqq4aRjJRH53i9jMgistXia76FlWfwXwb56RTJV4rJlgf
 1CaF2vMZznjlfIjrpgp94v6EWoO77Xnaff2dVpRLO3Q+n9Q3Jpquxwktlj//pB7Jz3fVwxgD/
 52vjNkAl51tw1TdpatFql7pl6HzHqdE+gEmMB9Bo3ELuCpNj8QfVGLHxdn33mqSGC7N62ucno
 yPFeIRR1MuEdKJcwmzClIXDygHdCY2hEh4Ef4YiAsaQsgJYntUSXpX1czuvwaRUosK2ryg1zn
 xs3TWE4uaWJOvmAQb2d3j5kqabpjFJtTuA0OKVJLjSk+Y8qEDwSknepjnf8kl0pEKPtm0wRaj
 fJq1Rnpsg/M01IOVU/T5Y7uud1mNdlvZh0/2w9kDARVlzbNCxjlUtPao0KMQXIyBkiJP0DgRR
 4NUGvdvOXNTJkQ/5uW0jwNp7zkP2hTSJ9WwMftD/bWxeXPnqWiW86FLKNqrtvWR6nxcJKHBR+
 hSI+riqFEqLOOCMn+1++dxPha8Ish7BVeBmJc/mkAMDOWnzgOJNzb+5W3K0FyA1trJhFXaSEF
 KltWcTD9JMMTqbfyo6IXjVNhvY2L7vDYwadqnb19gATUefnUKQItNn9s523aDjczvlLdqtOfn
 6QHpfxQsO1kaoxxRmbAd+dyK/GyKZUJXQvAaCgqPXeN1iGDhu6pyzGQqAUSadIAlT12NtcWTh
 u8nxUGKzehKiNZnIpeE5dgS99+eb5OZD3VeMzZ1Q2hCe/fMjU85GiHQ/TdWccU9psC1TIxROD
 YSaW3RcDPwhIJxmTds6BOvIJprXtxt0PUG2LA1Umh8Tg3aTOno9vj814iVioQjrHbJBOGlZh5
 +MUt8BMIZUyhsdPn9gWfPKIFQXqgl3fJnaWHF+Yoy0PTtbDQ9LnUcxeWMOOBW8ZMi5D7su/Jl
 LwQWsXwQmRuzvwBcqxTsKddJpllhU0MB6VJ0lYrSlyKcudZVz7AKZo49bA19PJOVZMX0tCSlz
 kWFQvtP7brdY1Y3hv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k3BuxXdckzKgdtComMELiZlf5G8i4dJWB
Content-Type: multipart/mixed; boundary="5xdRjIj1ejOB41OmnBGpFLii4xUsCi4eZ"

--5xdRjIj1ejOB41OmnBGpFLii4xUsCi4eZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/11 =E4=B8=8A=E5=8D=888:50, David Sterba wrote:
> On Tue, Mar 10, 2020 at 04:14:15PM +0800, Qu Wenruo wrote:
>> In relocation, we need to locate all parent tree leaves referring one
>> data extent, thus we have a complex mechanism to iterate throught exte=
nt
>> tree and subvolume trees to locate related leaves.
>>
>> However this is already done in backref.c, we have
>> btrfs_find_all_leaves(), which can return a ulist containing all leave=
s
>> referring to that data extent.
>>
>> Use btrfs_find_all_leaves() to replace find_data_references().
>>
>> There is a special handling for v1 space cache data extents, where we
>> need to delete the v1 space cache data extents, to avoid those data
>> extents to hang the data relocation.
>>
>> In this patch, the special handling is done by re-iterating the root
>> tree leaf.
>> Although it's a little less efficient than the old handling, consideri=
ng
>> we can reuse a lot of code, it should be acceptable.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This patch is originally in my backref cache branch, but since it's
>> pretty independent from other backref cache code, and straightforward =
to
>> test/review, it's sent for more comprehensive test/review/merge.
>=20
> I'll add the patch to for-next, looks a bit scary.
>=20

Thanks.

It survives the regular balance/replace/volume groups run.

And any behavior change in the v1 space cache handling would lead to
100% reproducible hang in btrfs/061, so it shouldn't be that scary.

Thanks,
Qu


--5xdRjIj1ejOB41OmnBGpFLii4xUsCi4eZ--

--k3BuxXdckzKgdtComMELiZlf5G8i4dJWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5oOpQACgkQwj2R86El
/qiUMQf8CVRG19ONv098WraEM0qCjWXKynq1mjni1Vr1HOpoqKkEaFNzb8z2bTml
LlkEqsNbd23+LIkB+alNwjfhGIg5NiUZTR0d979KyUoJYLn2TXSkxJOTrAHAKd/2
YiZd4YVFEeH0FlAfzndbbpD8cn6fv/ExeLdYlCaQJSsT4xcMTORf+Q7N2OkmBsUA
lDWo4Qj914qORJzS0RO97J1nq0JspXQ9+gZqwBoqgw0LBIT9sW2zfhfoaDIraOES
oNb003n1AyfV6D8sq5l3Y8l8RUNRSR1/7i4iTt2WDje4oFJrwkZcl4xj1ays9101
GYNFJCXB5e1/+wxvl2QbeLpHLeVBJQ==
=S/2P
-----END PGP SIGNATURE-----

--k3BuxXdckzKgdtComMELiZlf5G8i4dJWB--
