Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688E3239FAA
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHCGcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 02:32:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:56355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgHCGcf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 02:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596436327;
        bh=uBenratQBOOm4JsyXhshc/uU1DeC6KtxfF6adxRfV4s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Dyv2NAv+nZelzixVZfmJIkqjoTGKyyltzomcsKxT+HTbX15ivgT5PUyTR+gXT8g//
         h9w5iYXzB81Za4UtOKHIXW6ujvyoFR4YyXx7lYDpgJCpfkqT1nFBkM8UmtshgAyjpK
         9hCNNKJtek01Bl4xTFsWwPFlPXXuKTYQq3YhjAac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5GDv-1kizsR06mj-011Dvm; Mon, 03
 Aug 2020 08:32:06 +0200
Subject: Re: [PATCH] kobject: Avoid premature parent object freeing in
 kobject_cleanup()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <guenter@roeck-us.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1908555.IiAGLGrh1Z@kreacher>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
Date:   Mon, 3 Aug 2020 14:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1908555.IiAGLGrh1Z@kreacher>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v9tEawFjVDSHvbf6Mo8qDZaQm5wVdaltb"
X-Provags-ID: V03:K1:Pdunfup7qWrwzUt5YVfdfKovEEqDaRhuVSddWqGy92o2os9xEf2
 tEW7d7HC7ZABXUV41aNGZnIc0zdA8eBSW0kZt02m8HmNTKVAukDjuZBhPFPB2jfKdkqGNmR
 r+X0OOl6oR7ppLob2aVu5zzzi2Ps3lYv/9S35RL0v868IuK1vUZ2T6W4krIJpUqroUnBiPq
 7FFxBbGMWpYK0HmziFEvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x4H1VJrWAB8=:spc1HPZbU+GEgFJUQlQ2zE
 14E+3pAQvNzvIahCv8okYfaZemkWa5qYeS+1/wgQLSLzdfkzDrt6xu3jf1Fyw7L7Wdgnm/2SE
 douWe0T6eL5yJOK8Fe7TG9IhfcP9RmvyeLzsJL2Ks8hSLJbPpgdc9654MAq2wiKv/sdSDWNJC
 cl/4z1UTYIzSMOjniCRBu0S3SkYIAunEyKmSxd7++WnhWPvvgOw4zLa8XzalMAm0A5IisEXpg
 V+PY/Q9ZO5o+Z7b7yZ7r+e7NldahD2jiv5ADo8wDSsNPYjYBgbD4PvgHRwImbGoV5RzaTeB9i
 ML5BV51Gz4mmicuxfyQEx+MUFJBQxMPn7upSwtR1K1PkKLBMRWQ6r0pea9ETGAjlOj70slHO5
 o/bloPmCqitRWnx4tG5g6eqcO22QLKFXehITy7s+ttz+97B2vm3NItQ63s5faYsGFj6JP+tZM
 pzs8COQBHVtcj233vo6ltt09XtVvuJWXah9vi2zTegcNBCK8VejrqbzorYyWu9DS/P4mfqUAE
 wvMzmZ8iNGk7VaX9l72ZbiyZYI4VGwd5z/DzurkjG64oxsPRlYeyw55dQPSWdMKnm9LdA9pox
 LhOc/hnVIqqp5m0Lv18h2QqFc3nAHWdSvGPZvIr6Ha3pKmBoZETVnVJ2qimfSLw2VTjiIBC6c
 wg/bU4TeV++5KEeyWVUm9SOjSutGGy/mNfN/n9X+iXVcjgss8fAymw1Wzr7qwckhVd9Ch4SSO
 MDZmrXmOGscZSSyZ+ASbjL8WVfdjDidj4e59s0xkJ0FIPGNDEPgj97OvhBaYdIKtIq4pvZYRZ
 NsXFRvlyKwJTFxg8kfnj1mNoqsmOgULTW31S9fswaQCx7JStxqKQuLs/9u3zInK1btzU/P5hf
 vxJguKwlfxsooyggbXOStpQXoiOhzx5XLOTwq1agCf0kpE58jne3PvP1jOAY9xDWXRjTn3M+0
 +B1Ob08MJl5CQwolfv8JDiemf0lFbbpfoGotVyFo+FLfRqWh4H4AXP53TQOfzr9xHgPOxYUNp
 oP8zuQIz0qT4Rhw6zC9PhITXn9nf2fF+z5uQeuGEDmlVg9mwU/wsxxNj6mObUjHiSc46xiTPW
 dJBh3PZYc66FgHOqjm9Pu9Ez3KJSVhv2V2W1ycC/ZKD6F/u1qER79ojvBniWPgDaEqzzzPVRr
 BSs+gZ2eS0ewU18hcv/+u++vYERGLxbnE5ZckQlwpSiFw6ranxPWUmJys72eXXXF8m81I6IQi
 DlZYBArc6hxqe4jQssL7JUryi3K0CmK3Lsn8wjg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v9tEawFjVDSHvbf6Mo8qDZaQm5wVdaltb
Content-Type: multipart/mixed; boundary="7oEQ2jU30zhKH5hgVNFELO0Q4qTGllBF5"

--7oEQ2jU30zhKH5hgVNFELO0Q4qTGllBF5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/5 =E4=B8=8A=E5=8D=881:46, Rafael J. Wysocki wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> If kobject_del() is invoked by kobject_cleanup() to delete the
> target kobject, it may cause its parent kobject to be freed
> before invoking the target kobject's ->release() method, which
> effectively means freeing the parent before dealing with the
> child entirely.
>=20
> That is confusing at best and it may also lead to functional
> issues if the callers of kobject_cleanup() are not careful enough
> about the order in which these calls are made, so avoid the
> problem by making kobject_cleanup() drop the last reference to
> the target kobject's parent at the end, after invoking the target
> kobject's ->release() method.
>=20
> [ rjw: Rewrite the subject and changelog, make kobject_cleanup()
>   drop the parent reference only when __kobject_del() has been
>   called. ]
>=20
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_rel=
ease() function"")
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Hi Greg,
>=20
> This is a replacement for commit 4ef12f719802 ("kobject: Make sure the =
parent
> does not get released before its children"), that you reverted, because=
 it
> broke things and the reason why was that it was incorrect.
>=20
> Namely, it called kobject_put() on the target kobject's parent in
> kobject_cleanup() unconditionally, but it should only call it after
> invoking __kobject_del() on the target kobject.
>=20
> That problem is fixed in this patch and a functionally equivalent patch=
 has
> been tested by Guenter without issues.
>=20
> The underlying issue addressed by the reverted commit is still there an=
d
> it may show up again even though the test that triggered it originally =
was
> fixed in the meantime.  IMO it is worth fixing even though it may not b=
e
> readily visible in the current kernel, so please consider this one for
> applying.
>=20
> Cheers!
>=20
> ---
>  lib/kobject.c |   33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>=20
> Index: linux-pm/lib/kobject.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/lib/kobject.c
> +++ linux-pm/lib/kobject.c
> @@ -599,14 +599,7 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(kobject_move);
> =20
> -/**
> - * kobject_del() - Unlink kobject from hierarchy.
> - * @kobj: object.
> - *
> - * This is the function that should be called to delete an object
> - * successfully added via kobject_add().
> - */
> -void kobject_del(struct kobject *kobj)
> +static void __kobject_del(struct kobject *kobj)
>  {
>  	struct kernfs_node *sd;
>  	const struct kobj_type *ktype;
> @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
> =20
>  	kobj->state_in_sysfs =3D 0;
>  	kobj_kset_leave(kobj);
> -	kobject_put(kobj->parent);
>  	kobj->parent =3D NULL;
>  }
> +
> +/**
> + * kobject_del() - Unlink kobject from hierarchy.
> + * @kobj: object.
> + *
> + * This is the function that should be called to delete an object
> + * successfully added via kobject_add().
> + */
> +void kobject_del(struct kobject *kobj)
> +{
> +	struct kobject *parent =3D kobj->parent;
> +
> +	__kobject_del(kobj);
> +	kobject_put(parent);

Could you please add an extra check on kobj before accessing kobj->parent=
?

This patch in fact removes the ability to call kobject_del() on NULL
pointer while not cause anything wrong.

I know this is not a big deal, but such behavior change has already
caused some problem for the incoming btrfs code.
(Now I feels guilty just by looking into the old
kobject_del()/kobject_put() and utilize that feature in btrfs)

Since the old kobject_del() accepts NULL pointer intentionally, it would
be much better to keep such behavior.

Or at least mention we require a valid kobject pointer.

Thanks,
Qu

> +}
>  EXPORT_SYMBOL(kobject_del);
> =20
>  /**
> @@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>   */
>  static void kobject_cleanup(struct kobject *kobj)
>  {
> +	struct kobject *parent =3D kobj->parent;
>  	struct kobj_type *t =3D get_ktype(kobj);
>  	const char *name =3D kobj->name;
> =20
> @@ -684,7 +692,10 @@ static void kobject_cleanup(struct kobje
>  	if (kobj->state_in_sysfs) {
>  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
>  			 kobject_name(kobj), kobj);
> -		kobject_del(kobj);
> +		__kobject_del(kobj);
> +	} else {
> +		/* avoid dropping the parent reference unnecessarily */
> +		parent =3D NULL;
>  	}
> =20
>  	if (t && t->release) {
> @@ -698,6 +709,8 @@ static void kobject_cleanup(struct kobje
>  		pr_debug("kobject: '%s': free name\n", name);
>  		kfree_const(name);
>  	}
> +
> +	kobject_put(parent);
>  }
> =20
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
>=20
>=20
>=20
>=20


--7oEQ2jU30zhKH5hgVNFELO0Q4qTGllBF5--

--v9tEawFjVDSHvbf6Mo8qDZaQm5wVdaltb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8nrzsACgkQwj2R86El
/qgvpwf/Ug1aFwkt5OmwteDRCY9DE9k2L37A9h82ljETuDJSNmcjCepJ13Liee4n
D1vevyaAmgQTP3TI156tRWrY5xaO5oywQSkbazV64bnSqgyEC0hcclatFKXzrrFo
eEWMxhA//hF2sxcEpC8osl7E44g5U/4D1cGtNkCkWYLNJhrfJ4Vg+6k3Qki1rdb9
JpU8/sfdy1JHG4cVxgV11XEvBLae55nj0fYgtNJznYK5N5KLGkPiU04boM7AfEHi
VVkEe6EZDmqkKScs312j8i9RBsEbgRy58n3NA0fwmBiTFb8narXYRJHo3I689xy0
y6rp3EGVCT0Oss6H3xa1TESRUUJVzw==
=fAy8
-----END PGP SIGNATURE-----

--v9tEawFjVDSHvbf6Mo8qDZaQm5wVdaltb--
