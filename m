Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE12611C18E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 01:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLLAj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 19:39:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:52231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfLLAj5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 19:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576111189;
        bh=oFMrJuIpva3w8KF9MUG/f7V6uZAecLU9bqYNRIDFolw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BbJ+ttheAMCvnAXVECbSU5Gb3qPfP49Y7RVON7weotkInYfwka3k2FyNDr9uQuBa2
         vI0GUp+zh/4+aDXAhWQrX84gPXzY0GlnLsZqiDsj/eNUqvulFzPqGdNU3Q6pTOzsez
         sOsVFL7JsYUOgmV5KufvEpspJoCTSwnOKEtXIxks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCK6-1iKNqC0nu0-00N9ZK; Thu, 12
 Dec 2019 01:39:48 +0100
Subject: Re: [PATCH 0/3] btrfs: fixes for relocation to avoid KASAN reports
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191211050004.18414-1-wqu@suse.com>
 <20191211153429.GO3929@twin.jikos.cz>
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
Message-ID: <74a07fa4-ca35-57ee-2cd9-586a8db04712@gmx.com>
Date:   Thu, 12 Dec 2019 08:39:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211153429.GO3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YferTt61zRjXTiWJ4UjEuuEKgXlOnqvBv"
X-Provags-ID: V03:K1:ChjXBTRwOHWQVHRgUwklvCyOiZFsL3d1KZK++1qaNAcVwPpzQSS
 KLCuVo+ctvxcPPO+31QAVNRuFs7WQ6UqI7VJbnVfJB+AsWU5in77ddwzR1MMidOvvpxn0C0
 /runYNbWG+bqhQOd3a+WqgUZI402R2kB8zzVR3Fsrxu5lFD71y33RZzajNNZPeQ8ttuDzok
 JrTqshnNqpTH67X7Sxf0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKWMpCDQDyQ=:fbCib9ZTD2LUTFQCxQcT6q
 lCTz5Q7kNFbne4NHBp1d/QOoXU50B7WPVCWMT9u11EcgsM4AYMO3YJS9/keX468EI17AOaVY0
 5RrXsdS2LZRSyOeBk8f52Ek5/t9IPb0dB6D2wGj2RYNgh0FKZNVFSwwbmrV67mn4M+tGBLP4v
 yPtY+zdDEfR9ta854eg+Rec4SaD9fdtW7ORHMAMc4xCZwCQa/slErG21dz8ex0fN7PL6p7t1+
 x5f/aTTbYKPCo2tuWkFAhcI6zOE8ovtWvH4Zt6LcFt5AGf6LMb6/f+yIyTpOjQMkenrPioICl
 TGHJUuEyRbRMZjEFowoy8FIgIXOOfNaS1gb8gXUc2yAL6AyzxK0Hxfy+Q9fNoM33rMBbc/Gnc
 8VBkgKBMUolU0rxBXp18EI+kH0lAe+XHaEYONeYLzy3bS05X7/rLaj6DcSpGrPqpBrJLFJv+H
 saR4z64k/SSFeH2Zri0c0muM+vI8W/L325/+fpJsDSa5JAacFwzHCCKHcon8UlJz3FQ0JiC9M
 N88/wo5AgElj5bpy571sfK78u8qZwhwweKrM31ofRqwUE32KwaD1lmqjnHrJA//uFdRW4RmfG
 Ex+kr9PoUiBX4Rx++wUHM9FmggOp/jish7z/xP/WPp2WBwllMAz933XzFb9iEJwieQLdPecmF
 sdo/gnad5/khlGexFA5MfXS9/WSm4L0PGyZHLdF1ZFXizadN50WDxM1IkqQKXVQPxHGK8VUis
 4c4e8vYf9u2UIm31KO+62KseX4Pn7EwWvN9kgyjpOS5QWZkxaa1OyUh8uPQsfWtt+Ls1VmMkE
 olsWosQKQ72JLo7lygkOy1zL86XPXRjKOzalXFGmmB74uNU29qgutNpYjck2AzyKHsArHoVMT
 FfNsoPadJmqTQAMwRJJQARDQvLNBwqgamsf/AmbBrmJ87/ScuPMy/Ip2fw7qORz9+Pux1ltZw
 rs42X9qo2OqpZmiPQ8bwOWif5H27SlqtkWjKG6gkKB3ZEUsbbsVLEKJb9Ed7ywF33iqPhIQxV
 CYXEh1pV0/N/syXTONZo8DLsGQ4oseiF319Xkr2MOR7jkHT8N4hEIpwoQErBJPwuzO7eTRLAc
 bPbp0XrmPcMazlKQ1R+5cczwl6mkOTN8PexQH23bQKKHzLKfTSGj2M/M++yPr664NzDnsonEd
 L8+4cjaiG6tij2AOraLMA+RkiVxr2E7EDW2jPK4V/QwnfC5AW42a/PLKzcUVu9gsjCeWJKigE
 RjoRuWQWzFgiXaK61+lvEjwMyOaToSGNrusjgARRFDce4NsaytqT4V+deKNA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YferTt61zRjXTiWJ4UjEuuEKgXlOnqvBv
Content-Type: multipart/mixed; boundary="G1tXFWUjpa4J02MLTlJXScm5GLlEsoUYM"

--G1tXFWUjpa4J02MLTlJXScm5GLlEsoUYM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/11 =E4=B8=8B=E5=8D=8811:34, David Sterba wrote:
> On Wed, Dec 11, 2019 at 01:00:01PM +0800, Qu Wenruo wrote:
>> Due to commit d2311e698578 ("btrfs: relocation: Delay reloc tree
>> deletion after merge_reloc_roots"), reloc tree lifespan is extended.
>>
>> Although we always set root->reloc_root to NULL before we drop the rel=
oc
>> tree, but that's not multi-core safe since we have no proper memory
>> barrier to ensure other cores can see the same root->reloc_root.
>>
>> The proper root fix should be some proper root refcount, and make
>> btrfs_drop_snapshot() to wait for all other root owner to release the
>> root before dropping it.
>=20
> This would block cleaning deleted subvolumes, no? We can skip the dead
> tree (and add it back to the list) in that can and not wait. The
> cleaner thread is able to process the list repeatedly.

What I mean is:
- For consumer (reading root->reloc_root)
  spin_lock(&root->reloc_lock);
  if (!root->reloc_root) {
      spin_unlock(&root->reloc_lock);
      return NULL
  }
  refcount_inc(&root->reloc_root->refcount);
  return(root->reloc_root);
  spin_unlock(&root->reloc_lock);

  And of cource, release it after grabbing reloc_root.

- For cleaner
  grab reloc_root just like consumer.
retry:
  wait_event(refcount_read(&root->reloc_root->ref_count) =3D=3D 1);
  spin_lock(&root->reloc_lock);
  if (&root->reloc_root->ref_count !=3D 1){
      spin_unlock(); goto retry;
  }
  root->reloc_root =3D NULL;
  spin_unlock(&root->reloc_lock);
  /* Now we're the only owner, delete the root */


>=20
>> But for now, let's just check the DEAD_RELOC_ROOT bit before accessing=

>> root->reloc_root.
>=20
> Ok, the bit is safe way to sync that as long as the correct order of
> setting/clearing is done.  The ops are atomic wrt to the value itself
> but need barriers around as they're simple atomic ops (not RMW,
> according to Documentation/atomic_bitops.txt) and there's no outer
> synchronization.
>=20
> Check:
>=20
> 	smp_mb__before_atomic();
> 	if (test_bit() ...)
> 		return;
>=20
> Set:
>=20
> 	set_bit()
> 	smp_mb__after_atomic();
> 	(delete reloc_root)
> 	reloc_root =3D NULL
>=20
> Clearing of the bit is done when there are not potential other users so=

> that part does not need the barrier (I think).
>=20
> The checking part could use a helper so we don't have barriers scattere=
d
> around code.
>=20
I'm still not confident enough for the "reloc_root =3D NULL" assignment
and "reloc_root =3D=3D NULL" test.

But since the set_bit()/test_bit() is safe, and it happens before we
modify reloc_root, it's safer and is what we used in this quick fix.

Still, I'm really looking forward to Josef's root refcount work, that
should be the real fix for all the problems.

Thanks,
Qu


--G1tXFWUjpa4J02MLTlJXScm5GLlEsoUYM--

--YferTt61zRjXTiWJ4UjEuuEKgXlOnqvBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3xjE8ACgkQwj2R86El
/qjG/ggAlXCqjNxnAwyFrP2Y0boZxQQ4+FZU8piHthuTg1di2meMGqsr0tcgdSMP
yknE+IOvNhvcrk+GgYrQx8WaWqAJMH0TQicBcoVP/4tme0Qzh3tI5WG4qy3l5CwA
KX9VAn9pS4BE2NQyE+sAuhfc/Bnyt/e2kxyg3RBtRYh1Z+myk9a0wO/IIKfo+pBw
2D57DtCp8FtMUApuSDg8Pv6T6bGzVqcRIXC3yyDL6J6/J/c/lvLqrIp4cQtOdw5w
tubvqfHiF4ETyjiS2i10cPO2GR1wQLk5dnSZxLm3/KJ1YqLK9/6NYuBWlu40yEhC
kwe4wCS28Lf3UcBIMphLIc3dHegdwg==
=gU24
-----END PGP SIGNATURE-----

--YferTt61zRjXTiWJ4UjEuuEKgXlOnqvBv--
