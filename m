Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7F24428F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHNAr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:47:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:58629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHNArZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597366042;
        bh=2NH264VYkdDdXmVRkw+viNhPuFsfJNlBRLd1nj+tgTc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k1OXUbZL4ypXAjPCwIVvkHjmN61SJA0hV0tWhsjdx2TTe4vJMrW/t/u1FKlhxRxj6
         DSFxvZmSR/bpyWpHXfDVdb5NL3P39klNwfN/6gbVUpYt9BQYeyDICHuKCTl8LLPLjT
         fxkjGxfN2QdWe5BpN9KnIn6Eq+eCeHD3qeQTU3Ro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4QwW-1knebn1BNm-011Tht; Fri, 14
 Aug 2020 02:47:21 +0200
Subject: Re: [PATCH v4 1/4] btrfs: extent_io: Do extra check for extent buffer
 read write functions
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-2-wqu@suse.com> <20200813140503.GH2026@twin.jikos.cz>
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
Message-ID: <6f6a76e7-57b5-5e73-af6c-855cc5256a34@gmx.com>
Date:   Fri, 14 Aug 2020 08:47:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813140503.GH2026@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GIn1RzZiBQi7UBfs1TV4UwJS4Fyk8fxKX"
X-Provags-ID: V03:K1:0OasViSDXjTMmF19RrRrrHKeRkN/8SWesyIYjgtaIz8o0D74BN1
 nMpBt2SYs17XYKj02gT+fhgnuvgeK4nsdE/Ot6FM5GqfUZO2sk2g6RMzn2wn/6dZF80PHxV
 rAeBHOl6n6TKKU/UVGcBMURbrghd4SPE2p3wlWLhxcQtMxvHz9/QfrwpkzRbEU/Ru6KGbqy
 p0o3hcbE7NpIJOh9G4BoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hdVmmy81cWk=:qSHmwCSq5BbvXGnReHyRAa
 xi609ZH+I98dL1sFDFTkrWRrFxdJ6gd/DsoLA1GMpYx51QkL4lKrdvKEJSkz3Uch2t27mtHw4
 NRi0JEJFoMsqFl96p3AEXbj7HdkxyuJ7JXK8YUhCN0+ftZgUVnJel1mFK85u+rPGT2Ik8fmiZ
 vFHj21+Qk3tOkwWPQlHEDPPvQrVIwe+lY2FbRUvbFrayM7YWKOD0EnZAWCDLfkaWTeXv+ymPK
 F2xjONu8w1SnSjf9DF1SbvTSJEomtT7aWgIGFyxI1qebsuEsWdQ5ig7s9FD/ax4a410xWfeYe
 kNgO3f55ngpJIKrOYaqBBzeAHCABT/VADxEHgHm7CbjhbCbIxlA5zP6tNzvyMEHWHBzcaemRX
 qwxS0WFjkJf2ON/jh7pIwhzpTshuJsEjSl/kV/EHoXBgjCKfadZP4nF43jo4mTPxEqfTmZVMc
 uh044dOyOAr2LDoLN8K/uzwhG8/KZRxjmkLQYtv9mYWUYa2WxdXTbrBvkdZk91sqdigtedJUQ
 TdQNN5F6h7nv3gt4YLyfXK11dSQ4VXHTYew/hMnMt7Xta9zirCWX5VpVj/R/jMFN9CzWMNxhH
 1h8AyIc4S+Z9gvMrJmAYxbnqeacaAcFv7UBl9Zx+g70Yc4Sy567SRCxB6Nuh95jsbplst8IuV
 v8gG87BUR3XA0HEzyvfVi3Wcu+y+Do2bceSSnCALGWTDb9DmRP9w9Ncy+uCWcnPZTlllEjAUW
 rosKfPViHMeJRY7g6+g27Ldb6EeHxLJ1Yk+YTZWR48zIpJ2arn6BEKnbfD1u7liPZ0mQrPpk+
 MyYm4nBKif0Mruj7uKb5l1B6IcFo/Xk+mdBHdKO4R9xb37Jje0uDOiMcAuRxxwJLPBwhnoVV6
 ptk1xAvDP/C4PxKSuPV8lB9n7mTPoy/LAVQ54CW5JUou7N9lvnoscwgUV8Szk++fqKzjkZZwW
 /Px+C3rBj6fOzC/7wF2S3eMApiHPXS7bL/qoQAMmCNcqLqas4d8NpctSG9eOVmMGQp3dm1Utz
 dAhHFTfJjhC6goKb/FXgB07IHFEtkjnjV5Frr8eHahq5blCCrJEUMXo7UjPI38LfBaEhQiSmP
 BlvN9eLsBvBlOm2eu+8PUzjeJkNd5quv5xILiVzVWBLl1Eib3GnKiMjG8OA5pv+y3T/yI1Ir8
 Yvq8Ts5JUgEEd6IcYnKtk8FbznvfD3UVE1jxfqtqDxenAQfMQYsG/ewzHaP8L75wdyc7eUFOz
 jJ1RQ4+R1vJQuNXFKgCi+r9lMh3F17q/kTyYQSQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GIn1RzZiBQi7UBfs1TV4UwJS4Fyk8fxKX
Content-Type: multipart/mixed; boundary="oaPP7hcZXtyPqg3VVsEwk8iYFbR2xVwJ7"

--oaPP7hcZXtyPqg3VVsEwk8iYFbR2xVwJ7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/13 =E4=B8=8B=E5=8D=8810:05, David Sterba wrote:
> On Wed, Aug 12, 2020 at 02:05:06PM +0800, Qu Wenruo wrote:
>> +/*
>> + * Check if the [start, start + len) range is valid before reading/wr=
iting
>> + * the eb.
>> + * NOTE: @start and @len are offset *INSIDE* the eb, *NOT* logical ad=
dress.
>> + *
>> + * Caller should not touch the dst/src memory if this function return=
s error.
>> + */
>> +static int check_eb_range(const struct extent_buffer *eb, unsigned lo=
ng start,
>> +			  unsigned long len)
>> +{
>> +	/* start, start + len should not go beyond eb->len nor overflow */
>> +	if (unlikely(start > eb->len || start + len > eb->len ||
>> +		     len > eb->len)) {
>> +		btrfs_warn(eb->fs_info,
>> +"btrfs: bad eb rw request, eb bytenr=3D%llu len=3D%lu rw start=3D%lu =
len=3D%lu\n",
>> +			   eb->start, eb->len, start, len);
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>=20
> This helper is similar to the check_setget_bounds that have some
> performance impact,
> https://lore.kernel.org/linux-btrfs/20200730110943.GE3703@twin.jikos.cz=
/
> .
>=20
> The extent buffer helpers are not called that often as the setget
> helpers but still it could be improved to avoid the function call
> penalty on the hot path.
>=20
> static inline in check_eb_range(...) {
> 	if (unlikely(out of range))
> 		return report_eb_range(...)
> 	return 0;
> }

I thought we should avoid manual inline, but let the compiler to
determine if it's needed.

Or in this particular case, we're better than the compiler?

Thanks,
Qu

>=20
> In the original code the range check was open coded and the above will
> lead to the same asm output, while keeping the C code readable.
>=20


--oaPP7hcZXtyPqg3VVsEwk8iYFbR2xVwJ7--

--GIn1RzZiBQi7UBfs1TV4UwJS4Fyk8fxKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl813xYACgkQwj2R86El
/qhUMAf/ftNLzeOSif1EMH2gwBgjf2HuXOTKtFKolEEdAN+SSN92DMZ4FW19xQ2s
d1WqHK43oR9HEeP7xmcBJ/1WiBtuXBG6f8+SI0oEJFgh4R+J0AbeUkkS4zK07qPr
uOYPM8eXjisAyBnauTAKxX7UOwyW7oFeo//2xGp0XnqGhCN4p5SU7xNC6EJrwvzH
mPUGynvbbHnuv6FySC18KIQupOD6OBdx/J7wdSw7ntu4gazJ8VhXv1n66cRJtB+R
6syxTDOVaZzOgTxHOTbEWfIvddT/wt2hcSYAaw2EXdhWPPwiman+p1ksjQBnAkmu
wbfb1FuAW/x8nAqY0mJvTmZygqUg0A==
=XeOL
-----END PGP SIGNATURE-----

--GIn1RzZiBQi7UBfs1TV4UwJS4Fyk8fxKX--
