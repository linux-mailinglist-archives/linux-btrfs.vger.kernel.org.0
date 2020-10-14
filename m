Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8094528E025
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbgJNL7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 07:59:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:40297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388569AbgJNL7P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 07:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602676752;
        bh=3NFN6Dt2CbYVTBob/TaqofLuQVHqvnLAUV9uWgeEaaE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eQZ8io24wwGawI0uX0YNd7L3z2rCe8PXOiWEIT/CZcpmq9yI6SE2iY7ZFAg0BCh11
         gmYB+21cghfo2i5iWTWpJGiMY61SfBDj8P3uxSw16rnNpQ0tLYnbFqJzFKvP6Y9FLo
         1yMIV2HLCZfC/vLqyrB5T+QNlzho5spqjM1PvpMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mFi-1kKiw715ae-01329e; Wed, 14
 Oct 2020 13:59:11 +0200
Subject: Re: [PATCH] btrfs: space-info: fix the wrong trace name for
 bytes_may_use
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201012065624.80649-1-wqu@suse.com>
 <20201014114414.GK6756@twin.jikos.cz>
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
Message-ID: <d19621c2-2a8c-2676-f848-3c341af3e413@gmx.com>
Date:   Wed, 14 Oct 2020 19:59:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014114414.GK6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DlAry7YsxWt3j4c0JogWt53WUimNLt8lF"
X-Provags-ID: V03:K1:HY2TidZwP6QQJNLh+OLaLw1XJWP9u9K85UbMfH4wM8BnFs4zBjG
 hntRXBOgCrKWuowtanVgIfp/8KBFD8V5Uv6OedYxPYO+k281hnvmwzSsWGMG/ge5My2ZYvT
 QE8jpZ7prS8S7PDQHoqhcMYSSGW/kW9OtWEzGsI5ugJUMiB+i+0Aq0ILc34tCKdtH7PRd8l
 eq97EaG/z6QbjwinE/cfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OxTF+tKNOLM=:9vziV52d0gmkPjgXsW5ZzN
 zGwOtdOcMh+GuoSiJ3s3Ug8hykullEXkwP6idQvJ/LUvUhF6jJq6ajeSp70JzYrrSOfC+iF1/
 KqSA5SFw7hjtZKG1y0GdTyG6rJEuc6wLqFBgJXXruplOZ5zN6iymqR4VkB6rawn+qENzH68RU
 k3h/d4PM/qspHZyxx0I4tY6YVpHzjrq5X/uwQHyEQuTJanCcL/yl7JNU8nnTzVdmEerZ7Azkm
 pHZ4eJUni53u+Ony2d8tmI01PUVJGfAunWE/zQc3p8YX0KVuPxdo5SGsSBJcMjkW2mFlsWzdh
 YutowGZp7B8skb+GyXjijmSexSnajVcqJx2kadDUDVX/Q6STMxkTIa8pyI5H3UBN16xtUCJbU
 A3Y69RqJnVtamD9/v86jF2LuxGhVE51tZYW5UelJKfQKcgyBDIejDRdhZtza5sPgu4/wjZzJl
 hRTo/+/JicJP1m3lZvDPKsmUZF+MRqNsAxFoj+rrgdVb6xOrYWou88JmuRwukBVvy3OraKPkw
 z+wp3EDh9wYdxb7NZTpweoZ1cCiTnwFxFpbQA1ZuJpVA/Y9P0CrI8j1ifnllNl3807yAod9M4
 gtsMGPr4Tq4pqJI3aVFfRytYuZqv8FuJqSluMx0pkI1JFOnyOI/URGIo6wNPyYmp6Q0ZnW81r
 1UTNGvR1p+X/J4ExqrFI5Ovfjw9RB3S5N7cYMYcNK4gPqnZdPnLfJsmfb8D4Wz9Yc/xXHxQSs
 hbAryW66OcB6enlAyFZY1UwLN6C0nkgHdRzzgl+YJwsTZQoSoSFr3JuAPvPRpy5WECSqVxGhA
 CW6gIBbjuN0pfHfnOQaz96BzZmGrtywmjTB0iVlI53QcOhDeZl4SDtTOTEgbhgFQJF1iOylae
 +sYc77rqDhGnonoxzl1w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DlAry7YsxWt3j4c0JogWt53WUimNLt8lF
Content-Type: multipart/mixed; boundary="osb5qgAkRcqVoVsSeCiHuDTp8nw7v5rT5"

--osb5qgAkRcqVoVsSeCiHuDTp8nw7v5rT5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/14 =E4=B8=8B=E5=8D=887:44, David Sterba wrote:
> On Mon, Oct 12, 2020 at 02:56:24PM +0800, Qu Wenruo wrote:
>> The trace_name for bytes_may_use should be "may_use", "space_info".
>>
>> Fixes: f3e75e3805e1 ("btrfs: roll tracepoint into btrfs_space_info_upd=
ate helper")
>=20
> This patch reduced all calls to the definition and kept the same output=
,
> ie. the 'space_info' so it was correct and the Fixes does not seem to b=
e
> right here. You should explain why the 'may_use' is supposed to be
> there.
>=20
The next bytes_pinned still uses "pinned" for its name.

And in the DECLARE_SPACE_INFO_UPDATE(), the @trace_name is only passed
to trcae_btrfs_space_reservation(), to indicate the cause of the trace
event.

Under most case, we pass things like "space_info:enospc" for cases we
will going to return -ENOSPC, and for other cases, we pass what we're
reserving for, like in btrfs_delalloc_reserve_metadata().

For the bytes_may_use case, the DECLARE_SPACE_INFO_UPDATE() is
definitely not called for ENOSPC, thus it should what we're reserving for=
=2E
Since the declared function has no real context, thus using the
"may_use" looks completely sane to me.

The fixes looks correct, as it looks like a copy-n-paste error from that
commit.

Or did I miss somthing?

Thanks,
Qu


--osb5qgAkRcqVoVsSeCiHuDTp8nw7v5rT5--

--DlAry7YsxWt3j4c0JogWt53WUimNLt8lF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+G6AsACgkQwj2R86El
/qi5oAf8C8dgph+ivpQKpjdF9mfXqhp1UVKyLnelVqFEmiJ71AHuyQd6Y9+yDYUm
hQ64Ho0oXmSxhWzbhDRIPRz4JSyXSAseN639IZpODaVmIo18Q4QPOpmQlsHDYHEC
n3TPwGS8rZLgT72FeszrSIKbEC0HQdTGw+LwHUUEC6Ljv2WaRmoDt4smSh2i54lm
8+u271k/J6tesg/uqjfIwbUZQQqz+LU4IPSTdQnUNUkLBqIdLRnHDtVVqJaoaKKP
8viKjUcBwcM2TvCUNuhRS0N9LXmajeZJ3VIsgBNRV83q/PI2Gm4lQ+mVSvS98w55
baZ4O+3Uqo8mEagVAvuroL0+VgFHzg==
=qDVa
-----END PGP SIGNATURE-----

--DlAry7YsxWt3j4c0JogWt53WUimNLt8lF--
