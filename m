Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2BA8C5A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHNBsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:48:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:35827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHNBsM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565747286;
        bh=ls/2Qzlfvu+DmMni1yaPjPVWwHpRrP1n3oYuKoX6iBs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LypLQg9nGTGx7evfZ8m4CJSKFsUC63jsRYY+GvE9lvGk1lj8RM8UpU0RK1G5JbDej
         gFGD3CykrBKKHIVMEt40QqzrkEv4v3+5QftEljOmeR7f99hgcwWogJrL1KlpZlyBzW
         y1NzpCEcPqe4H3+qFRByYRuvVc/k2VBH0ljiPNdM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1iFwId0JQk-00sab6; Wed, 14
 Aug 2019 03:48:05 +0200
Subject: Re: [PATCH 1/5] btrfs-progs: mkfs: treat btrfs_add_to_fsid as fatal
 error
To:     Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
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
Message-ID: <1384c535-c451-25a3-6149-78244e596b40@gmx.com>
Date:   Wed, 14 Aug 2019 09:48:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814010402.22546-1-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EOcXyGeDGolmVzyjMTLzUi9JhyrdBj7ig"
X-Provags-ID: V03:K1:i8yQa40gXRzKqUER/Xabcn4mDoL6Ns/7jAIgB9jACz7tQLzCjec
 XQMA1aU1qjQ/aPyzVpQj2dyh+Xkpu7AM3pshT9/iZIeGWJs6W/ElG92IemEefa7xjytTRkQ
 bMwwjIPDYTcVd7eS7aHBlV/q/e96CzGzjInKN02jemOvbS+wxfZeVF311N1E+sqgPjk+Nxv
 W02Ig5eU/xM5tG5gPSXCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ibtM7+/rheg=:qs7BwZ80wcwH0voAAipKJM
 d2iRtRn7m1RfrDZanUfVaqlPif0n93eK/Mox2JzGizQvQAOjvw5q3Jfoa1gp+pGEs/QPSg4Mu
 /6TS4GjczGkb/znyzchByQrwBnDSam8Ber07dSDfAIIwLAAVcf32uMlrrsXuDDJZP0Z5sppvS
 f28NmKxiGpJlgW07ekHqKonCwTKxAKS9BSDX/8a1YWXuubKA5sEkV173YFq3yXfD9cZ0vdLgp
 ULJTnW+lbBx97w5Ts4k0w52awG2avublDtVacF9in7ue/kZs1cnRFtCLwybo3W6XvgEANv9lR
 8Xs3zM7X1H+wYJWUych9JidgzrKA3b3fBaDV8jDdJbtuxgoSikubixWDbQ8ir8Ur+0hoAQxem
 ymOhwshvnSaJs/z5+PzTZ0C5neXhrc+NX67kh7nmXHdQSWjkH6A+fMdKI4P9QUPDpZJUDY8Lf
 trV2wdS7AjbT/luemLVkNI59J4yqQ7YOANnJkqhb/+jYPsxFlWCkP+Mrk0aFetHIPf73H9XDn
 09inGej5FMNZhqjRSB6d6pquUpAZZrP3QBK/0Tbr24HIcZqUkUfVW74muU+g4hV0P+X6gHRaR
 xwplYY9hZ4ad2uzjzasqhuAl8lthaT8sXbXMJDoXGSh5NYm8k1GKx+aChyIxm89CMP7GfsQ8A
 8J7asqD0v1IUOme2mDDG2aJcEJCw0bkVam4tTS9j3QhxCNkDSA7stlUK8fVnI2yzqq5ljpsIX
 SOCDE/hYYw3Ex84Tc1VHnX8hyLd8UJaflmAaQSI1/EXm8tSqWrQkPD3IFOoezF5MLxDY2E5k1
 OO431AMYT7nLbqWNEEt0sOmmimq3IL28aNApxVxe5Em/tnM8uCklMqoVgJ/1u70erY2yZVDqV
 9TbL+b7+Sn4hC1Segp1RX/mbLADjWZyuN4a6uQmlf2g1St27b6aSMXh6yCsO2gO5a/K35hnn8
 vNsEWci5Q51YvFanrbmM76NtjmroyzekdP1Jfy+aZexOkmERbAf4Lhi6pWJGwjSQUrjB1NAx5
 ig53h/H6fPTxH6AUKjcLVq21YydT4KzA3joD6gMKxeHpvnp708kD//SgCniygkEvDqmp3oARc
 kRxJXQsC9dmVqc14x+TBQ20LCxZOeWWqGCdtQilQRpSJPXhkYTWgnPUqbAZ+ssYhdDpGG0enN
 R+D+qe2Z6S+vxyHArD7BeINPHtZOFUVbD3V8+CiAic6V00Zw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOcXyGeDGolmVzyjMTLzUi9JhyrdBj7ig
Content-Type: multipart/mixed; boundary="dQmtmmdeaVr0xWHzSvjioVTm8rWaMAosj";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeff Mahoney <jeffm@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <1384c535-c451-25a3-6149-78244e596b40@gmx.com>
Subject: Re: [PATCH 1/5] btrfs-progs: mkfs: treat btrfs_add_to_fsid as fatal
 error
References: <20190814010402.22546-1-jeffm@suse.com>
In-Reply-To: <20190814010402.22546-1-jeffm@suse.com>

--dQmtmmdeaVr0xWHzSvjioVTm8rWaMAosj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/14 =E4=B8=8A=E5=8D=889:03, Jeff Mahoney wrote:
> When btrfs_add_to_fsid fails in mkfs we try to close the ctree.  That
> complains that we already have a transaction open.  We should be taking=

> the error path and exit cleanly without writing.
>=20
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  mkfs/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 971cb395..b752da13 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1268,7 +1268,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  					sectorsize, sectorsize, sectorsize);
>  		if (ret) {
>  			error("unable to add %s to filesystem: %d", file, ret);
> -			goto out;
> +			goto error;
>  		}
>  		if (verbose >=3D 2) {
>  			struct btrfs_device *device;
>=20


--dQmtmmdeaVr0xWHzSvjioVTm8rWaMAosj--

--EOcXyGeDGolmVzyjMTLzUi9JhyrdBj7ig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1TaFAACgkQwj2R86El
/qi+tggAoFcA8CQOyIF0GCFlfjCtgDKPMWQ3vX0Iphn+n1huNC7cWDqyfZEwRRYA
Ae1B3BK43z7kC/3z5151ZVjUF/XWuqDFqy87/Z3MgclhnYRjZQC/OfIIkYj2vnTt
l+I/EvlSkYZ1n7cKyjoC98SPoL1ExbWyOi22TsWX8K7Fk46QWwsC4TwJbV0DkrfG
hMjBYy2re3jFCFZkdijLAz1T+AAV3fLU+Qw5TzSebEE1nSHUksjj9ZhV4gqDyti/
ybv3EpMoGpQJlGFJwzdB1H6bVtebBskokxtjaczbPgNXCFacNTL9luiDhaaxM8kQ
Xt8lbJpfeJa2L//rbCfirzWLiSOwAw==
=DXRg
-----END PGP SIGNATURE-----

--EOcXyGeDGolmVzyjMTLzUi9JhyrdBj7ig--
