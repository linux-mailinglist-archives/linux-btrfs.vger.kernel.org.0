Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A479AC01A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfI0JCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 05:02:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:54097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0JCo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 05:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569574957;
        bh=rAzwa1wWHv9Jg5/rlGJTefjcz9e7XKt26QpmAa+MpDI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dBEMGgJG+4AZ56YXwk+9MQ9EdKm1Oz0yGoDsKosECPz7yhF7wUEQYVwrU19UXAgqz
         aY18mfHbxRKYgLmgWsckkf4dUuXf66E4awiFGkF08cCqwzDQGrtycgZSOYDQLZ4jqp
         SmnPJursCmk7rIQ1Y9KxBa636w2YR2nyY0B0Q+j0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1igKZw3nS4-00X1Vp; Fri, 27
 Sep 2019 11:02:37 +0200
Subject: Re: [PATCH v2.1] btrfs: Detect unbalanced tree with empty leaf before
 crashing btree operations
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190822021415.9425-1-wqu@suse.com>
 <dbd46651-de06-ed81-29b2-ea547b77269e@suse.com>
 <20190927085245.GT2751@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <10379193-b628-3208-35a0-4f0246922c0d@gmx.com>
Date:   Fri, 27 Sep 2019 17:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927085245.GT2751@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bQPd5bYpKVUVqgzXgG6cIh4fQ1o2fy9Zm"
X-Provags-ID: V03:K1:WeK5F/p+D4iOUJbwRAnyYLlvCirPfxzMqA6/LfdJJD9QGx0yzAv
 RGB9Zi8ECDE+2LaD6QtwzdK+w3Mj4hio/7bmiKJrnD2vFdIU21OcRPcyhbJ4qML07Uw78RL
 tK6MbiGO8/XlHFdWY5jHMZEQrtnbFcdazOWstKFgk1zewrL+x8A/uxSn9VMPMPRpakT/cGO
 9rVi+km40Ib5kZs6Ggeyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+P0tBf2K9Rc=:BiB6zy028geQu5jp6Q41Y8
 cyhNpuh5YPK9xL8VaIRKndk2MMAjYVp9e4BjPViWtL6eB81Dmb41SJmkGGOHgGYPlooUv6Tju
 0zzdCwd+jQO8dFKh/THWr2ZCqCTOaQs+5gpxgtWmdXPHzt1FwUJdSbTKzLKeVChOgQF5rfG1F
 20oSjnoVIzf3X0lodn9j9itywqRfaLHHq0om/GxoUkQ3K8b2K/chGrgbKYaX7nFbdCM6w3+zc
 HNPkVvox7Ygy2EdJmPN2JH73X2X3RVOG77iN3Sb/qfkdO8mAFKOw0zncDr8oAMXvc6VQ8Dyth
 ESvIAVM00TGwByNl4LIq2LJ8Pwi70/Wsl/8p54ftOU0I4AxZue08ccEMf5C+mX0zF9XrX/j1G
 ghvCvX3ZFanutNY/90wfSLOhlhaXigQ01ZD5c2Wb/aA+OuMamVtkHdhH7BFUZL5nCIxuS3bQI
 /PjlhtEb5aeXNMBaHce9TedDrwEYymabrua5O6k3fD55ACqV5iYX6HSf2UuMDE2srTV/YlNQs
 sHp6NekwqNR4ztHU1GEXsL6XlKyk++vledViHLfdKnvBTf7MB3Y9/+XGhYD0NVD3jcBb0ncLg
 dDKk1qSbxb4YZURxgdiOZTXh8aelasYdYPt32g7CSJjU3LanxsjfO0Vw1QT/0E8UrNHL2RQv0
 xAdeeDJ/Naogqfrm5z+nYhHjoIaQLtdchoxdEef8BVpicHmTW/Z+mZaquF8lxks1ENHMdG445
 lm1ve2oQpH1crCZbH0uiQr06V1i+2LGFRV/PaWR+bE2vk8srNbb5yd2FqtsqsgDsw4vf09xi2
 drZjT7vYupXfb6qqSSaEBUkBtQhuAD/jh0eQaNc5dgPRZdUITwAaeVeaA9ljWIrN7keOFycvY
 TgVmDPFerHyj2lU6Yj8ddbr7/M9qmef8+xZuF8EiWYv0SB1aSXPs0dHByC3CvEKOTCtefLyPI
 OVu11SMN4Wlq+iE+A6ocgv8+8y35lFk+sZL90oiHQ23AKTSOl2QkhV+D21l+wbJ2i0oBVmYyi
 9l0DokGKxP+gBKZU9ULlf5P+nJDeYDe3hUjz++PFALBBO+/qL/LFxhMuX41ftayNiY3+UhE7a
 Pb9kIxVAAvnBNt2GlVcVx+26SWlbyrx2b9xNtPkKPio39YbTRYhK4QArf6Jntv3TNdu94/Atl
 RNMuNqo5x4rHM4xb8OUIAZ8h790Xem+4pR1xgtDB93IBSzW4aOt6InYwVTU8FjOawbefabZw0
 O+gVgqCmKftYH6oT3cfuY10xve4mG+dm0gxcDj3+FWNKlLEFIxqZdHPCTVus=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bQPd5bYpKVUVqgzXgG6cIh4fQ1o2fy9Zm
Content-Type: multipart/mixed; boundary="tUxn6gZnwKeHw3tlJchgtHHRHvwnlA2o1"

--tUxn6gZnwKeHw3tlJchgtHHRHvwnlA2o1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/27 =E4=B8=8B=E5=8D=884:52, David Sterba wrote:
> On Fri, Sep 27, 2019 at 07:28:23AM +0000, Qu WenRuo wrote:
>> I see you have pushed the patch to mainline.
>>
>> However I still remember you have hit several false alerts even with
>> this version.
>> Did you still see such false alerts anymore?
>=20
> I have to check again. I know you sent an updated version, we might nee=
d
> an incremental fix. The original version was kept due to close time to
> merge window. Thanks.
>=20

No worry, I'm just not sure if previous false alerts are still reproducib=
le.

Anyway, I'll update the incremental fix just in case.

Thanks,
Qu


--tUxn6gZnwKeHw3tlJchgtHHRHvwnlA2o1--

--bQPd5bYpKVUVqgzXgG6cIh4fQ1o2fy9Zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2N0CgACgkQwj2R86El
/qg+ogf7BD+Ff/0yG75WSIN9ncsq0lzAbnYmoX9+B/921SkDkeobe12fUE7XKcKV
dixymkB7CWHhGB5TMFnySC7NTNHSZ8h+vK5pVkE3z10x8uSqMiiUQ3/mZKEHYQph
syhEOcIdnEVnWLiMC50EPb1o34xmewTJHBGpRpTU3y2Y1KHk722PxkVHjQdx0K2j
s31sCJU3q9A+sbCT5DFnHRNgfgHyZGyCKBoaOOSjS+EU9azYYkQb/rOWi4bt73WE
tjFoX6at2vqiFQiPkqxDEshxDlK4GhTj+DDmNjaz9b+reMOD5gpazIbR88X7Mqz3
0qDVog+Fe/dJcZrApZfdJUC7EExp3w==
=vdWn
-----END PGP SIGNATURE-----

--bQPd5bYpKVUVqgzXgG6cIh4fQ1o2fy9Zm--
