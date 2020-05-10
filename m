Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0C1CCB44
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 15:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgEJNGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 09:06:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:48233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgEJNGH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 09:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589115965;
        bh=heeZFpcoqY7ZfvW2N/AepF20bwtGEjUgJ4HeV+ZRZ+Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cpBbBV1JOpmFqQJVUrbg27VYTRkl7QZhKHO/nmddFKpeMGjnAcHbgzANDUSFJjHnQ
         vbF90IhMiEx1Yyk4I8jdMRwIbOpIIme7Utg0Q0CXeGL9baAQnxyYKerL8ZyGYngmrc
         xlUKSo5ULZ+RHCIpOCMdb78q/5WDwD+lzanLdFe0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MryXH-1ijntq0Roj-00nxoC; Sun, 10
 May 2020 15:06:04 +0200
Subject: Re: Exploring referenced extents
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     linux-btrfs@vger.kernel.org
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <13d76c35-fbbf-c5e1-20ee-70a9a716d11f@gmx.com>
 <f2784429472cb7f9cb4d5cbe4b609494@steev.me.uk>
 <f1a97a6f-4351-147a-ccf3-714387b0f07f@gmx.com>
 <8308bcdede193bdbd55ba10aae0e9370@steev.me.uk>
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
Message-ID: <58ef41dc-6256-bf1f-c9fc-159a02b94a70@gmx.com>
Date:   Sun, 10 May 2020 21:05:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8308bcdede193bdbd55ba10aae0e9370@steev.me.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j1ynudO45ntdMJpURFlXmRkwARVUNVf84"
X-Provags-ID: V03:K1:zrjTJ4qARrEEnabF8myinmgi7Mnzo5WNOjIz/YtulVDZYtHfbkt
 b5E5e4HSVzMKTyEo9TVpe0vbmDbqJkjJdKcP/2VX+xa/YtaI7fitX0rqP6cqyJSt5CTu+wb
 vj3GhN3MKls8S9F30JS7K4sgBjq5nPdwBeBpQa769msBEf3vSIbW7YQCsw1kbBUei3lBxU/
 iGT4d8lZixnkshJBfUglg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YqB2P+avZUE=:MNe1YMzV0bBSm8u8Ff8O+N
 F+L2AbF8YdVEQ72zIXHtV3LxKgFe7XO2twUO2gc7XQBOQiLQlDGoUPu2cyj2EpFMNftPh/IsY
 K7vJyge+U+Jgkozf6ScIwVYkL8qS0iQHZA4DhKdj+LjROTgIWy3gijBKd0fzqQ61wmeAsQjOj
 n6nT2qSy6MTVG1tfEeqPa7OFcfmzpP9A5CSrpVLIWNLBrDFAqL2Q8WsNI5b2O6goK7ydDMncV
 YE9AowbMgmYZO0DPaadRyiVFFDs76PkH3GS/4eYjjeyTgbX0EDMEvF+hbHhpNHt4je5GnorBB
 30q9+ng3h90bUVGcb1zUfuqlGQyC4Ked1LUq7rlOWFK2dY2tdlav7vWUxskJ64ddmYrplxUR7
 eaVMKEd/d+Swt59lYo1YgzP4XxdkMidf4ftDVRao53zKnSpun1GahV6wGhjIcgqSrxQUtvCV5
 5GVpEsKpS98JwjJ/UgQIeUeweSPfdDGmSPlOtMUhdPmelBjVMTqOZdk/p7tXbjmCo6rzgT+el
 SuYsA4p5QTNvd3rh+17U1QO1T55IY68/laUutexy6t3jUvfOUc15tcHBhzmrnOALbyeQq/87A
 OlEp8aKifMFYbterngijZUUSqMVMOSDR9eecyi0btH+ngnCS6k+OgUk8v0FqAIyLHw1tcMCy7
 clQPzpsdPCZd9em6G6iKHUvRJfDk1GAqFfnivC4snnKAvZcnLDP2S5FEWwzI6IB5qhwC9Ycag
 fmbeXvUp7BfaXygad2ZwgXrGiBPbBQpGMWkw2RhCkhYUF0F8Yb6u/H3FEfOfSTBbqULMGyNNK
 8K6psGtKagZYrV4YB/E5WrIm31B4eqEgocJ9L487CmGOiFfRf3NS8e+VOkYzMVnZM0p4gpEt7
 t/vrnLJsZHA++ANNBOBF5ZW7jeLyp6QMSvXCfv+TG8XWLfADFOZ+5wZGgXiEHenep3PDAs+5r
 FVaOFFhiOa5+3qvyTjnJ6+iAV6HUf8SHn4LxIAGYpra8zDH7vIykRssP3SdCWUAzW8fgkoQnG
 f1+oJMEOVJltXW/rshFbWaLRxNhiRnSvzQp7teQZgkYGCZLyWCfiYmGaCVF/W8kF/dEocd5kF
 loLUGrkDBQZkESvO7oThhdMN4xfFCpvKEt2EQ4m9RPUrOFoM+5oa76u5+iwD+huzpft6zUzGr
 iwnIJwhAl8nNQlrHEynzGapaydqi+D+LfiCtLGaKRt1/SVG4L1EiHsUj2qoEu5c+/aMk6757U
 5bDYTC5X20jBhO6wH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j1ynudO45ntdMJpURFlXmRkwARVUNVf84
Content-Type: multipart/mixed; boundary="oecwTewiGeCVWWbMvIQ4HDN8idzT3S1rr"

--oecwTewiGeCVWWbMvIQ4HDN8idzT3S1rr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/10 =E4=B8=8B=E5=8D=888:51, Steven Davies wrote:
> On 2020-05-10 12:55, Qu Wenruo wrote:
>> On 2020/5/10 =E4=B8=8B=E5=8D=886:55, Steven Davies wrote:
>>> On 2020-05-10 02:20, Qu Wenruo wrote:
>=20
>>> Yes, I'm now stuck with a btrfs_extent_inline_ref of type
>>> BTRFS_SHARED_DATA_REF_KEY which I understand is a direct backref to a=

>>> metadata block[1],
>>
>> Yep, SHARED_DATA_REF is the type for direct (shows the direct parent)
>> for data.
>> But there is also an indirect (just tell you how to search) one,
>> EXTENT_DATA_REF, and under most case, EXTENT_DATA_REF is more common.
>>
>>> but I don't understand how to search for that block
>>> itself. I got lucky with the rest of the code and have found all
>>> EXTENT_ITEM_KEYs for a file. The python library makes looking through=

>>> the EXTENT_DATA_REF_KEYs easy but not the shared data refs.
>>
>> For EXTENT_DATA_REF, it contains rootid, objectid (inode number), offs=
et
>> (not file offset, but a calculated one), and count.
>> That's pretty simple, since it contains the rootid and inode number.
>>
>> For SHARED_DATA_REF, you need to search the parent bytenr in extent tr=
ee.
>> It can be SHARED_BLOCK_REF (direct meta ref) or TREE_BLOCK_REF (indire=
ct
>> meta ref).
>>
>> For TREE_BLOCK_REF, although it contains the owner, you can't stop her=
e,
>> but still do a search to build a full path towards that root node.
>> Then check each node to make sure if the node is also shared by other
>> trees.
>>
>> For SHARED_BLOCK_REF, you need to go to its parent again, until you
>> build the full path to the root node.
>>
>> Now you can see why the backref code used in balance and qgroup is
>> complex.
>=20
> I can, I get the feeling that this is now way beyond my abilities and I=

> can see why it will be very slow to run in practice - especially throug=
h
> the Python abstraction. Perhaps if knorrie adds backref walking helpers=

> to python-btrfs it might become more feasible.
>=20
Another problem here is, the btrfs tree search operation is all done on
commit tree, which is the on-disk data (not the running transaction).

Further more, since we need to search extent tree several times, and
unlike kernel space, we can using a transaction handler to block current
transaction being committed (which switch commit root with current root).=


In user space, we don't have such ability to control transaction
commitment, which means we can easily get transaction being committed
during our long search, resulting bad result.

It's already hard to do it in kernel space, it won't be any simpler for
user space.

Thanks,
Qu


--oecwTewiGeCVWWbMvIQ4HDN8idzT3S1rr--

--j1ynudO45ntdMJpURFlXmRkwARVUNVf84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl63/DMACgkQwj2R86El
/qj2lQf/VhhNp7amAHTuXDXaH0uz4qAymzKZv2vr95SlTK3uqB6Ewl3O70n3rAnm
9oHm01n+SQ/VEcRbJ82ALlzB7tiHQvNSjzHazEkMX5Bn14dsIVgD50PDAAZzJ83w
jbBPnNEnJ25Y4sliRSW0LzfY0W/ussrQGBQkcpQbx2kpZcKD2qcwg8DIoGlVHtYT
h3PXRXO8gJscdvXgMzp0rkyVudW9SdAxOeCShFlXNb9LUYu3ujs7VT0gKOO/JxaF
YinJt3R3nwyXSAPO65ab9jiwNiMwBztZSlkYZk4qGBRygU2jwj8Tjmaj0Ph32Jhq
tVynVfoeH/sn1pZG2lm/QVEOeqlvcQ==
=BQkU
-----END PGP SIGNATURE-----

--j1ynudO45ntdMJpURFlXmRkwARVUNVf84--
