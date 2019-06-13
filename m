Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32CC44709
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393047AbfFMQ4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 12:56:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:58161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfFMB0L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 21:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560389162;
        bh=DRbVvTYDMmnK5Zt6hgoQCe/UvIGxdQl5A1ucykxpL/Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XB0rSeJCqhtjvZJNfnS3uvr9d3elURc8/iax4ILJUJs2NEvfJtv1NAI573HDyUGr/
         fIejrddJ15kKNNMDBnO/ycjsUmLKCrw2oXdAhMWS6X4ZhVUWREQtnzhgC+JV+HtxU3
         bSQJMlQTnV5BH7vl1vQnBNRxKgXBxS34RHFgGBYI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwwZX-1iYrR420SZ-00yO4L; Thu, 13
 Jun 2019 03:26:02 +0200
Subject: Re: [PATCH v3 1/3] btrfs: Remove "recovery" mount option
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-2-wqu@suse.com> <20190612145825.GO3563@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <972c609e-5956-c2b9-6b8a-03737de6b630@gmx.com>
Date:   Thu, 13 Jun 2019 09:25:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612145825.GO3563@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="npjxtVUdrv5FCA3VnfufqWpelo2lAP7Hs"
X-Provags-ID: V03:K1:JZMSXmFREfLGULilHsGl3dszyqIySa9HviQEULkug12gZe0yetG
 lJSAKmxctxo2TKQdMWSr3rgLBRxRDpcMf0mSA70emI/bsvRoedsIRUo2X8z/gDeYBu4pUjp
 XVeThOtOe0Kc1q4s3HeLavSjQqdVHcg5DRcnOt85kTzzRjGa6n5hi3BGLac5JQtNqabZFBO
 y+eYqd2qCm2vdRXDm6uug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCrKuNy7YI8=:Tru/iCVcGXQKOkrd/qDO4m
 zUJvkxf5+9RJIBaaVUtcfiT93G+kh6hak95/WwAu/uYdyuepJrcgCfULWREEgzi3RTnSDUer2
 pez3dd4zgilY6iUlmV1Er8VA0S5Ypt81drLUDxv+iD9VGCmZWMQUZfcjqJ3c0iUfODxUTUhHx
 8sW0DI+YuvzmeLkkhJGKkT8KhQDgt0c3PKPCIT5y2qpwHbtn9aepG0yTsApJaPrEsLd4to2W3
 WCFWCRIWtcFRM2MRuzWm2PfDsCf4cFQwNwcVUdZFvHgWXaS2lgik3bMLWRIpGbfgvRmIqqydH
 a/7+EzO+qzNw/+frQ4CqeT0H3Fxgerm479yhanbKvi9UTDNFTJkCjw/ZNsfRyM/fIAnbZBWMa
 txOi1ty4x7EPPO7wXwYVsHycJJSv6vUfOEtF6vE5ng39l+4QpYKlbNglScLYtPpwugaIBm+1b
 uRp59c/TC2gcrmFGn7I7GqNT/lLWv+9hbya+TNDWm8aXYin6+6AI8iFy0zsAM6wYoACk5lQ/O
 LVIQc+Lg3S6ITuk2sHjy15VWlsZ5J9brqUprGTb4Xg7VLqOJ30V+p2kdbMcVJ6mFaPazUenWT
 czLLzMburaSh5wtG/R4OKaAu/pzQ0hYcl/gKZb8r1Bkt6u6gDRfcUTMKDwcjGYt/jvYxP4+bu
 k4/pqhl0jmITvhg42S9hVFO43a9VhWWBXSxwm0S3L241AJIPuXopg1/+whG4zKiaZZhcgPjwH
 zIggKvyTsWAq1gQdL84pboaUtp/wNen9NrdsfF/g2ELEmyJKPHctDYP9XkRYNxZ0rF7RmH1vK
 gNdsez1yKr2sk163Nl4HoOHJAizOBn92P4WHFjBXUsZdQlDYfAoPXx1Job1bueoY3HZHVzE/s
 SK0MZjVZ3qFnAF6JoDuwhNNjGOTvyc93oSLi8VCmdoA3MqFy3v5Ux4e74Rzl71eV2jwmz38+L
 C+vvQuLJGpQXkE2SNqQ/EVh9mnSUvW20=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--npjxtVUdrv5FCA3VnfufqWpelo2lAP7Hs
Content-Type: multipart/mixed; boundary="XWSoiklPjFFc8Iy69jdZdO4359CLgEvUM";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <972c609e-5956-c2b9-6b8a-03737de6b630@gmx.com>
Subject: Re: [PATCH v3 1/3] btrfs: Remove "recovery" mount option
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-2-wqu@suse.com> <20190612145825.GO3563@twin.jikos.cz>
In-Reply-To: <20190612145825.GO3563@twin.jikos.cz>

--XWSoiklPjFFc8Iy69jdZdO4359CLgEvUM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/12 =E4=B8=8B=E5=8D=8810:58, David Sterba wrote:
> On Wed, Jun 12, 2019 at 02:36:55PM +0800, Qu Wenruo wrote:
>> Commit 8dcddfa048de ("btrfs: Introduce new mount option usebackuproot =
to
>> replace recovery") deprecates "recovery" mount option in 2016, and it
>> has been 3 years, it should be OK to remove "recovery" mount option.
>=20
> Well, that's what we never know if it's ok o not so the deprecated
> options usually stay. Eg. subvolrootid is still there.
>=20
> 3 years might sound a like a long time but there are old kernels that
> follow the stable branches so I'd rather derive the time to removal fro=
m
> that. And eg 4.4 still has the 'recovery' option not among the
> deprecated, same 4.9 and 4.14.
>=20
> Since 4.19 it's deprecated so we'll have to wait until that is EOL,
> Dec 2020.
>=20
OK, I'll remove the patch from the patchset for now.

Thanks,
Qu


--XWSoiklPjFFc8Iy69jdZdO4359CLgEvUM--

--npjxtVUdrv5FCA3VnfufqWpelo2lAP7Hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0BpiEACgkQwj2R86El
/qgVCAf/bOTte37kVIhbsQ2dR4Aqf5yAsEMH6nEhlyIaI+S7huytvpnkrH7Lvo8U
bC2CShpGPHv94H/n3wUIWL04uUD0Fe6kdru4B7yul5KJrQ12a71u1gAqq7qc3wF3
ypxiMKi6aZTlFTWTA98HGFP19+HCeMImsl7HnGXE9HxMqb8Eu9q/fUftkcopy5Pf
C3ITThaxw8tcQKyZEB2nqldCPogidGRBS8oJqYt9N+dFBsesxYxDFNnBf/lPLm21
d5tH0Tue7FR2KWGMtAhjuoCCxDuDRDAjIPC4RQlHJbFk/gLXHwHjccKiBomh5bKe
KxXGEMgf8dbiJa9Jgpsf3kRLQGAtGQ==
=Q37z
-----END PGP SIGNATURE-----

--npjxtVUdrv5FCA3VnfufqWpelo2lAP7Hs--
