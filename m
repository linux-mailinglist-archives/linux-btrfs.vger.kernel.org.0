Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDD1C7D96
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 00:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgEFWsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 18:48:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:37565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgEFWsh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 18:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588805309;
        bh=vUUjEA4Hi/uIlD1Cfk4hzAGGIlFj+o4jNTd+OoK51P4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UjzKzHIyvfb4T4exuzZld4il/GXb5PiEwcnfCbvDCG6/5+xhMOyW4Xgj1RAoS/T2i
         /gagnni4nV2xIocsbqzKgYceeqXpL3hxpxplnlPjAXCRWkOT0RlYzmB/Zv21X/yeze
         CwXzxYq1WudOQcE8jLXGg9N58uC8U0yPg+AB3OT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfYw-1jPozU14wK-00B30X; Thu, 07
 May 2020 00:48:28 +0200
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200402063735.32808-1-wqu@suse.com>
 <288d0020-380f-717e-ab05-3fe6dbc64cd5@suse.com>
 <20200506150448.GH18421@twin.jikos.cz>
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
Message-ID: <c3c68cb4-4d7e-33ae-54fd-b4202148689a@gmx.com>
Date:   Thu, 7 May 2020 06:48:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506150448.GH18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2lI9uXapwfkkhopLGiufeVZKYAi2g3EAa"
X-Provags-ID: V03:K1:uQ7rGD30PeILK5+wz6nrA+s8/OhktvMuH01VehXKcTbWeV20263
 RyQaprcIA+y8enfk1KSfGiY5Avbs1sVZDx2P/jSwSSez/AOJDSmlbwN6dYSMsuRbZ2aSxeO
 hSkvy0zQt5kRmJsZvite42J/+Xizek52/SvwharIGsqCQYrxunkyEqMu7ccgd3X57SpNa0X
 vvwSKV6eQRmjwKd5z6Y7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m9yZUuMw9KM=:wmK/XCyhLotByWTpBpeqwc
 Jwf/6qoxfIBtfTQoi9EgXsgigUd4M3dl/YFP+Lu9mM8M45pl8r3+M9An1k7xQurG4mfIMeN/p
 9r+JSV8DnDBvBIZ+d/cq2xJDTP7gh2G8rOLDTkYSDTu7tRkdg9yFwL1myd6uuhHQCp03sKwPp
 Lz4AYeLR4sS5Nws+IVtkGtUhAmykPYhQoSkuLRzEyFWfl+Ph/7YIReznkp7dO9Flx1fu5ppKk
 aNttRxgwrbbXc/9NpFowCbe8pnBA8alGHkQXpLMDalYRqI154JD/M0E32ONDRlH/HUpRLkkgw
 R8pla2M7nDemKTTPdG8sUzO5X3Sm7A4eMRZ78glMfJ+/gtPMj+rscPOeosNO8t4SidbMIfinC
 jiHuPVyIa+KshW7IsEx5xjxwNXRSpfbTlaEJ8aBctBB+HTH9oAqa7MWIjikTPHtaNOb6sjwem
 ZwKSX9rF7SvpNrGQ20fMZM5fQU6gBC2WthoxbKmVtqKDJ9CD46CaX36VjKtp4GbkSU4WBtOZ5
 mXGhBPhmZMZ8WBuuLyWmvHtxrNfyiHNCzYwo9NQbeZr5FLj47uzIs3UuIL/IOrOY4hsHvsjeG
 pai+PZkF3LdUbrvQ/1k18/BATnzqYZl+AjQB68cCl4+3mdbahxe607MzFkGM5PjP3aaaPNFuE
 Kmxz+pRqL0lIWUY8fIH1Tz9YlgyU/BKKsz2F9N/fJMXC451wLE0jjduHXdyPVCXIR094LDq37
 Dr2UxVUF3qcBdDu3vFBD8cug78wOb6fiQRV7UtOuVHjw6fn4CUUvadupnBl4rWiOItwz+xtsw
 jBJrwWOoyaJOu0hrIpygxmXQNsPKNsma65Pm+Uq1493t8MzN8IYmW0PCqaoUddkgnmg567+fu
 GT7fx4VIao3Zo6b9ztDlBMzCPY+oqEqriN45AW6oU+wJ86W+SGeFoFmiS489Ad3dpQUueXgwL
 7Mw6PfvAPckz5UmHHhRvD4KfvB6j4RRZduxKHHe88hhPMnjwQgEbn2zOtX9oDvKNbhtT1I0dm
 HFM44LerCqj1E8aZu5McJIYwWWzgJE4vtnF8GWM2bAzzlJ2W+BIG7iuQciBWWEGsmkSzER1/t
 aKXLKUuMaX9XZ4mXVNyvuFaNn2kRys5DPAHiMZPQE/U397N5h8wMWuHa/wTtsqmn+K3R3KSA8
 WOam/3OQnQrVvTD5HBcPu1LCs3DSZwQYxcVBVi7hH7kCFdqvTY/GfDjqgoCXTAxq4qS+/3rI4
 kJHK5RWr4/e44HeGA
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lI9uXapwfkkhopLGiufeVZKYAi2g3EAa
Content-Type: multipart/mixed; boundary="NOvyvBVUqWhfodaA5i9s5mmjk0fJBMsnn"

--NOvyvBVUqWhfodaA5i9s5mmjk0fJBMsnn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/6 =E4=B8=8B=E5=8D=8811:04, David Sterba wrote:
> On Wed, Apr 08, 2020 at 08:36:27PM +0800, Qu Wenruo wrote:
>> Forgot to mention, although this doesn't cause any data corruption, it=

>> breaks snapper, which has some kind of "space aware cleaner algorithm"=
,
>> which put all newly created snapshots into 1/0, but not the current ro=
ot
>> subvolume.
>>
>> And since snapper uses snapshot ioctl to assign qgroup relationship
>> directly, without using qgrou assign ioctl, it has no way to detect su=
ch
>> problem.
>>
>> Hopes we can get this patch into current release cycle.
>=20
> It's still time to get it to 5.8, with CC: stable it could get
> propagated to other versions. For 5.7 it's not clear at this point as
> the bug does not seem to be urgent and as far as I understand it,
> there's a workaround.
>=20
> Also with an application (snapper) using some semantics of the ioctls,
> we need to actually test it with patched and unpatched kernel, or maybe=

> snapper needs some fixup first.
>=20
>>> --- a/fs/btrfs/qgroup.c
>>> +++ b/fs/btrfs/qgroup.c
>>> @@ -2622,6 +2622,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_han=
dle *trans, u64 srcid,
>>>  	struct btrfs_root *quota_root;
>>>  	struct btrfs_qgroup *srcgroup;
>>>  	struct btrfs_qgroup *dstgroup;
>>> +	bool need_rescan =3D false;
>>>  	u32 level_size =3D 0;
>>>  	u64 nums;
>>> =20
>>> @@ -2765,6 +2766,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_ha=
ndle *trans, u64 srcid,
>>>  				goto unlock;
>>>  		}
>>>  		++i_qgroups;
>>> +
>>> +		/*
>>> +		 * If we're doing a snapshot, and adding the snapshot to a new
>>> +		 * qgroup, the numbers are guaranteed to be incorrect.
>>> +		 */
>>> +		if (srcid)
>>> +			need_rescan =3D true;
>>>  	}
>>> =20
>>>  	for (i =3D 0; i <  inherit->num_ref_copies; ++i, i_qgroups +=3D 2) =
{
>>> @@ -2784,6 +2792,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_han=
dle *trans, u64 srcid,
>>> =20
>>>  		dst->rfer =3D src->rfer - level_size;
>>>  		dst->rfer_cmpr =3D src->rfer_cmpr - level_size;
>>> +
>>> +		/* Manually tweaking numbers? No way to keep qgroup sane */
>>> +		need_rescan =3D true;
>>>  	}
>>>  	for (i =3D 0; i <  inherit->num_excl_copies; ++i, i_qgroups +=3D 2)=
 {
>>>  		struct btrfs_qgroup *src;
>>> @@ -2802,6 +2813,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_han=
dle *trans, u64 srcid,
>>> =20
>>>  		dst->excl =3D src->excl + level_size;
>>>  		dst->excl_cmpr =3D src->excl_cmpr + level_size;
>>> +		need_rescan =3D true;
>>>  	}
>>> =20
>>>  unlock:
>>> @@ -2809,6 +2821,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_han=
dle *trans, u64 srcid,
>>>  out:
>>>  	if (!committing)
>>>  		mutex_unlock(&fs_info->qgroup_ioctl_lock);
>>> +	if (need_rescan)
>>> +		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
>=20
> This got me curious, a non-atomic change to qgroup_flags and without
> any protection. The function is not running in a safe context (like
> quota enable or disable) so lack of synchronization seems suspicious. I=

> grepped for other changes to the qgroup_flags and it's very
> inconsistent. Sometimes it's the fs_info::qgroup_lock, no lokcing at al=
l
> or no obvious lock but likely fs_info::qgroup_ioctl_lock or
> qgroup_rescan_lock.
>=20
> I was considering using atomic bit updates but that would be another
> patch.
>=20
Isn't the context safe because we're at the commit transaction critical
section?

Thanks,
Qu


--NOvyvBVUqWhfodaA5i9s5mmjk0fJBMsnn--

--2lI9uXapwfkkhopLGiufeVZKYAi2g3EAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6zPrgACgkQwj2R86El
/qiHwQf+IavKLOYUsgtjDaP1WFurIlN2cPMmPIE7JjUVWSTKYbadF8cEy5xBVdql
DgPy+z/xAIzNGwHu6gruU1a5bpziHv1lyAHh2MzGQjY38x2TdmTBmkpdd/4+Lc07
CVCruZVBa1RGk8LFmIMy//xo0MyepUqY2uD+cwDFtLdRAuFEAzz4uZWMLEbd/Uf7
F8S1Xqm2lktzptKQOy/0raUv628Gv8LN3Opn0FAkXk8a+mSaOX+Xbvm5jgNvG78F
RlbRrOy0Jl61dzFU0XRHZJWYl68RAiihdTjvXDGD6Fmp/vSHqzPQ06XQasu8GcXE
mqziraYeAUz21z4dIGsos0gxBg5HOA==
=d9Kd
-----END PGP SIGNATURE-----

--2lI9uXapwfkkhopLGiufeVZKYAi2g3EAa--
