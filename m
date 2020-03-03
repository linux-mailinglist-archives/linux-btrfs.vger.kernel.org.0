Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF84C1769E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCBRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:17:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:57295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCCBRf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 20:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583198248;
        bh=zeh1V94KYdlBoWVF/fROXFcz01UFb3QA0wiOm9ZawJc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ID03mZP9fNqpYBySL//6oHu4DBEB/IZaMjPMclVcR2EOae0ed8n4SURbCt6OyZeZN
         rKJ7Lyd2KNdqTe1oqO0Pd8xAx7yi48iICjUrSP+KnGn+brLhKzcPtIvv7RRcZQF3fA
         MF4wuFtNubi99izFdGBjfXmasly8dQKMWc+R4hxs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbirE-1jfGOn1GDm-00dIW0; Tue, 03
 Mar 2020 02:17:27 +0100
Subject: Re: [PATCH 7/7] btrfs: remove a BUG_ON() from merge_reloc_roots()
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-8-josef@toxicpanda.com>
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
Message-ID: <f0673600-6327-69dd-01d2-8b73e05f2146@gmx.com>
Date:   Tue, 3 Mar 2020 09:17:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-8-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ks12sO1mGorO6t2nKwroThBVZUVMLJdKL"
X-Provags-ID: V03:K1:lnNswhp+ztfQHsE4y31fOjc/G6+OZvJPv8xoGLujXeNKRzQ2Wvk
 Zg3M9bTfebvOCJAHMmsAN5p04sRbD20XBwqGrgL8+oBRj+F78lSSYx3S9fxPWR5gC9rMp3y
 5ZIQrTTlHS0hLYuydDpeSyalLjeUMkgsbu6Mg1ciLG0eGlx293DKHWmrcQb+6XcsJTiMDBq
 OpJKu3I3a0JQbxrVweEEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kXa9JKlRI9A=:GVt4ehECGzuPYHKIUa2koY
 7d8a0bGEpaNJSqU2DQCjC443qXr1121a2v9zTNZ4UqZAde4D6fHYjPYJ2OL7jHTo1qUCSDuUG
 skcDJJEdcD8VYaAcwxLpO3OFKM32LebGR4g/oB8W6ufvlRRMaC7A6hKiWjPhJFuRNo1uNYdue
 lQgtUUEgzLEkNIZrjTNQv/bdZYELWKwwKkmS/geGYbSy09r+gRRZvrvW3MEyR4ZuXovjmxZ2U
 fm6BkR41zoO5g8K4Htit8Aa5YyvsPd5HbYr7I0Dl8xkQaCS55gE+ieb4xdhknTh3KxGaMlhIj
 cpQR3FQA7b44Xgdpy3KvcZJZGaicMBy1hcjOwvZiwrl5ulvcQ6RpkZwWXQZmgneElvEaFmk9+
 xd2VVR+RVtQHw0RYrQbYnaeiXuw+7exBqV/3zPzhH3pDWUippi9rSSif4JXmHynkyXMCDB+wg
 004Ufd3lIqB2aXCXADVxT0YRC4KJ64c7c+U/IYVvf1N4JzLKRPSKJk/HakEOA2rfTxfuXx+Js
 WDWOYQAS5jL5WTyauhOk8DlMLIgviGk+TEJ6O1LxaqfvLy93pEUTCk1lr3QZ782FCUOyYdozq
 lyruDj2t7OfKcWYni3o/5tOkOqJBWZQkAPzNZlO8gJ+mF0A4Zrj1RAkwdBlm/p7V6SwzSDCsP
 BmnAAItFKUh8BqbXrZJZzBc+fVBvTgkTknojocU413yK570SAGw4MVZpYfT61Gb0lCFc+UgbI
 lAU0orEcVvXum+6LjQTmjGaqliU4/0kez+F0VjSSg8x7YIeK+0xbXqn7/BdZJ3X4z6s62P4xF
 1qBmOSoYYTlcs1umMil+6UCRhq4+/oIjCkjOgzVK0845o9YknzxV4qITIjxaZo0nisI+w1gZn
 RkAMDCr54Ies5caCI35kxokp4vjCdiJnlUtY5MtHX8Dg9UuvAc4LLzJ7YPi8fVJKmecEXHLC8
 SXUJaS/SAf1+KPoegOSnplpPXae8QzssYcQbKc9z+F+gkdeG4YQ1u6+2KY5i0NxTYIlCNAdEM
 rVTPHVz0YBi24cNL92K891BAxOxMMJERUyYD4L9CheamylNp5qvWqatq6FPLPWSUnyVPE5shI
 S7AqLCOW7QghYz17z6+6EGDgiMItehGFb6x1USxUGSQCvcgLm9DcSx653lo5y1100oygDOZ/d
 /Sr3VIavnVBt7M+qROopCpxYn/sbXhsGuuTWTOZcJxa0AuqTnxuyey4yXxor0nStMVeMS0PMY
 8TmfaPYzqsqHX+3Sy
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ks12sO1mGorO6t2nKwroThBVZUVMLJdKL
Content-Type: multipart/mixed; boundary="DobCA6jM3V2q3V8wdW1dS9WeG3Qr5FpK6"

--DobCA6jM3V2q3V8wdW1dS9WeG3Qr5FpK6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> This was pretty subtle, we default to reloc roots having 0 root refs, s=
o
> if we crash in the middle of the relocation they can just be deleted.
> If we successfully complete the relocation operations we'll set our roo=
t
> refs to 1 in prepare_to_merge() and then go on to merge_reloc_roots().
>=20
> At prepare_to_merge() time if any of the reloc roots have a 0 reference=

> still, we will remove that reloc root from our reloc root rb tree, and
> then clean it up later.
>=20
> However this only happens if we successfully start a transaction.  If
> we've aborted previously we will skip this step completely, and only
> have reloc roots with a reference count of 0, but were never properly
> removed from the reloc control's rb tree.

Great, this explains the reason why we're seeing one internal report of
the BUG_ON() get triggered.

>=20
> This isn't a problem per-se, our references are held by the list the
> reloc roots are on, and by the original root the reloc root belongs to.=

> If we end up in this situation all the reloc roots will be added to the=

> dirty_reloc_list, and then properly dropped at that point.  The reloc
> control will be free'd and the rb tree is no longer used.
>=20
> There were two options when fixing this, one was to remove the BUG_ON()=
,
> the other was to make prepare_to_merge() handle the case where we
> couldn't start a trans handle.
>=20
> IMO this is the cleaner solution.  I started with handling the error in=

> prepare_to_merge(), but it turned out super ugly.  And in the end this
> BUG_ON() simply doesn't matter, the cleanup was happening properly, we
> were just panicing because this BUG_ON() only matters in the success
> case.  So I've opted to just remove it and add a comment where it was.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Since there is a comment added, it looks pretty OK to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index c8ff28930677..387b0e7f1372 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2642,7 +2642,19 @@ void merge_reloc_roots(struct reloc_control *rc)=

>  			free_reloc_roots(&reloc_roots);
>  	}
> =20
> -	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
> +	/*
> +	 * We used to have
> +	 *
> +	 * BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
> +	 *
> +	 * here, but it's wrong.  If we fail to start the transaction in
> +	 * prepare_to_merge() we will have only 0 ref reloc roots, none of wh=
ich
> +	 * have actually been removed from the reloc_root_tree rb tree.  This=
 is
> +	 * fine because we're bailing here, and we hold a reference on the ro=
ot
> +	 * for the list that holds it, so these roots will be cleaned up when=
 we
> +	 * do the reloc_dirty_list afterwards.  Meanwhile the root->reloc_roo=
t
> +	 * will be cleaned up on unmount.
> +	 */
>  }
> =20
>  static void free_block_list(struct rb_root *blocks)
>=20


--DobCA6jM3V2q3V8wdW1dS9WeG3Qr5FpK6--

--Ks12sO1mGorO6t2nKwroThBVZUVMLJdKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5dsCIACgkQwj2R86El
/qh51wf9Ey4ULgeOIiB8utUefrULO+K3ChZxmQhBto2yxPjujCJm6WniYEZ6/WxT
LKg9z/mykeVUvy7+vpd1IA/1j5y8l5WpiO8oNncZgMNzlU9Z822eZ42NIP/9mGa6
+ErT4WQvk87ZytqZxP3Qj2Y9mvgmSbKik2U7TEJP00VMMWpQIwbPFUrFOpM4m+oL
di1FTRa3ZTElixxkJwUQgMjFh2AsoVw15FadmNSfNBHbgIqXkjgaUKHSD+8haguV
5FlYWlrOw+ulOhTZDZCE/TjETuO4gyHQHZovEt9NM7CcU6G31OYQnGUz1tq5N7e3
0COP3h+rF8QAlRRcf/P0O/QpIoVmCA==
=02VU
-----END PGP SIGNATURE-----

--Ks12sO1mGorO6t2nKwroThBVZUVMLJdKL--
