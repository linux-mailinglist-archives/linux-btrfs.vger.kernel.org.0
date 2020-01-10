Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A391364EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 02:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgAJBkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 20:40:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:41637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgAJBkp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 20:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578620438;
        bh=3O9aGDKtJ+GyphkC1jL/Lmc0hPZqWCVt+iWndNmBlM8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TSszYBFsxy5XZQFjK5lL/R8ZGQeP3AZBEKHXRMuFn3LwBRkjgvdtwJLf26KpcgDBa
         dUpx+5WQG7lqbJU81sqgDU9FxMiEWftroqloAq5SUSqdAf03kg46I/m22nY92B78y9
         xyJBikTzO/EU4FU6fF4PCT01v2bih8Ah8cswIK3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQv8x-1j0ue248YR-00NxlT; Fri, 10
 Jan 2020 02:40:38 +0100
Subject: Re: [PATCH v5 1/4] btrfs: Reset device size when
 btrfs_update_device() failed in btrfs_grow_device()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20200109071634.32384-1-wqu@suse.com>
 <20200109071634.32384-2-wqu@suse.com>
 <69c68e8f-e2f0-0ad9-5c3c-3376246322cd@toxicpanda.com>
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
Message-ID: <4bb19ef4-af6d-0c3e-2588-bbee5153aa0a@gmx.com>
Date:   Fri, 10 Jan 2020 09:40:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <69c68e8f-e2f0-0ad9-5c3c-3376246322cd@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vhQJOLwono7tlhFJ9iwRKXVErDYuznRcc"
X-Provags-ID: V03:K1:AI7Y812sia7humwkdlLou89rpueFv59pEhtn2Q1bnKiUUlW8/Do
 x7Dwxp1/Uk9I7QRNVWbOQRORuocqj/2XjrWX44EE/tTi3TTvPrWYt/ZklQBNyaFLz+/g8zw
 VD2KKi3G6Ucazj35Mhj3lQG6VqlfWeOZiZpDtovwGH+rMzg6b62R22+XTrtlFN7fnxljCL7
 8ZU53MxFWcuJUoWHTGzBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TUorMXu0QA0=:Hwfh5Q+a251OkbMYJ9iQ1F
 +LBHBMqBFkzfY6jnvL/Wd3DIHBLosE2/2dzoRrMakCTtxxfZilxufbzOolzoMOu6m0CeVpx+O
 ok9XhGyi+O+16Wd6xF7vr58nmoklJJbovDw5DYG0gwR6Lqp468/QTpXe8U+ZMRgBEA6uTusZA
 RGiKfI1DUOetjiLh1V3I545KbrvVbAJt4LSTOWgtLtRROinQ86m9yF6BVqphJpBIRpZK1jNtO
 5KMk2RAqYjm3zKwTmUFf82gotJCIaqvVooLXLxQiYX6BhiC+oH9k9bdiWkbuf7Eps6volsdXs
 fGSYerk2G0qHeeIuksczY62K99oV9pwFqEL/wEkRZqkVqyCFZpv7TaltP6f6kEBZizxp26dHP
 MK3FKGznMV7rDRx+sleDv8VUbyN0F5mKJ7o63sd/HMSKO/QTnbf0a3Skf2ub+XfWAe62MfFum
 PBVsB0452mAEOuszeCW2qA60qYuAOFVsOpAeLW2WHD1B2rgKuzAR0Asz5DhmjKYsiUwsnBzXr
 GG/5yzGaKWGMoRMuZiUr8wGHePCYsrGWssWDyIz6kG6RBH2MRqHE2XDK/jnSh7qeXR0ubXOdA
 tseJn/IMZ+K9Z7WNEapWFNcSTvHBzVuCiemgzjPAn75KHoitgPq8ohPSEd1Yt4073Sl9ER7cg
 7LAW71/ebiTt1YPE2l6EKHLCQzWg02EH6jBEuppmnqbc4U6yAwTLXgqKxCe3IdicSD5ml1pep
 rephXP+xnUAZsU+L9PAaGxBaojkr6j/0SQeZWb3BNFbej2MRqk7naMn4RJpZVhhW3YDpJNjhy
 y2odaa2bOWRO1tXnkNr5Mj2kbyS2rAwPJ87NXGX1rLErxsX1cLB37UhS3OxGBzM6Bc6NtenVt
 IzY9+h5nCFhtNphdIIoKkBzIsQ/WY4woyuFYdq4U4+IsGL5K+Y2SUuCzpTWCZL4lQxW//MO0i
 oYv/YclPz+Edeas8yvDn8H2Os5zL+XBzqnZ4bdhqfTjw+d4kkw4r3YBFhew4xMmgCzrQ0LqdS
 BhqgTL7R5aH1QAfhNfm2h1j2AkHVk65Q7NAr1HrpnBd/eX9zIz6yFvR8pLvBZCzn7fWhgqsr4
 1XucnvySdBPgP9Z+9MGcW0GpgrrHrKYOTcHYrX6rw25VLnSLqHrHbFJtjgIFdaC148DG1ydYM
 ahh2GIPlcNL6Rl3d0038kfWqDv86g7IKf1BXUVtprJmb/W1+9oCUWjjFQIOGZTVAzybPTui17
 x5XslTeIQwqlyUneJjKPqnW08nEcWPUOvsptpfu1gi+EehvxNqkodbT//LHg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vhQJOLwono7tlhFJ9iwRKXVErDYuznRcc
Content-Type: multipart/mixed; boundary="IlCjNCalCgWHupL0cM0RuEqhQFk186rXz"

--IlCjNCalCgWHupL0cM0RuEqhQFk186rXz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/9 =E4=B8=8B=E5=8D=8810:21, Josef Bacik wrote:
> On 1/9/20 2:16 AM, Qu Wenruo wrote:
>> When btrfs_update_device() failed due to ENOMEM, we didn't reset devic=
e
>> size back to its original size, causing the in-memory device size larg=
er
>> than original.
>>
>> If somehow the memory pressure get solved, and the fs committed, since=

>> the device item is not updated, but super block total size get updated=
,
>> it would cause mount failure due to size mismatch.
>>
>> So here revert device size and super size to its original size when
>> btrfs_update_device() failed, just like what we did in shrink_device()=
=2E
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Did you test this with error injection to make sure nothing else wonky
> came out of this?=C2=A0 If you are going to fix this I'd rather it be i=
n a
> different series because it's not necessarily related to what you are
> doing, and isn't any more broken with your other patches.=C2=A0 The thi=
ng you
> are fixing in this series is important and I'd rather not hold it up on=

> some error handling shenanigans.=C2=A0 Thanks,

Yes, I have the same feeling.

But sometimes I just can't stop addressing the comment that makes sense.

And you're right, I forgot the error injection test, and it detects one b=
ug.
In the error handling path, I forgot the re-update per-profile
available, causing df showing the grown size, not the old size.

To David, what's your idea on this?
I guess the patchset can't be backported anyway due to new infrastructure=
=2E
I'm OK solving the problem by either removing this patch, or fix the bug
exposed by the error injection.

Thanks,
Qu

>=20
> Josef


--IlCjNCalCgWHupL0cM0RuEqhQFk186rXz--

--vhQJOLwono7tlhFJ9iwRKXVErDYuznRcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4X1hIACgkQwj2R86El
/qglAQf6AoAElOPg6HZQOClL5p82h0ITxeGbpNAxR/ciJ7gk4wFVq3TI1o1KdOuV
sDQj/dWkjlVrP07SAYTvm4Ys1+uD/+nxPNPn12QVr3JIuGybqO8PrrOlw7YsWdoO
cHvX5PCWIco95FJPmwhmkv2ooosN44EvINMYVB01fRfo+5BJUnkz3solTz8mhhxK
/mL36LrHLNA8mCJnx88g++CGzZtZoJj4gUuVQm8/pZZTM4PLD97CdxIqnBoczEx1
loUXZZWu49aY0EtWSTEgo3K5U48dtSE0f61gWxel9mSrqfFKoWEeXZWXBIEVr8AA
genNzBHyEZ6ZrcYYivUAbiUpjzKmdA==
=kH32
-----END PGP SIGNATURE-----

--vhQJOLwono7tlhFJ9iwRKXVErDYuznRcc--
