Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F41CCAA2
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgEJLzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 07:55:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:47927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgEJLzw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 07:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589111749;
        bh=PUt6ew7dxAU6EXaZ/7cCBF0YT6RZbntAB7PKM9jPaVE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TiQxUHbmiuxhPnwRpFIbbxtVL9WlwwZp+f+HqsYiM6aARbdwirAUppnAdw/FUQqIL
         1yf6oMEGVkHrzlb5ksuAurZyI52cFsZhhMEYKgLw8viS/NCzAHxBsVCpOVB2vtjo6x
         o4/DHo1IqVmr39u4LOu81+iePDfCSKuGFZL13lHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLi8g-1jpHPR00kS-00Hg76; Sun, 10
 May 2020 13:55:49 +0200
Subject: Re: Exploring referenced extents
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     linux-btrfs@vger.kernel.org
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <13d76c35-fbbf-c5e1-20ee-70a9a716d11f@gmx.com>
 <f2784429472cb7f9cb4d5cbe4b609494@steev.me.uk>
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
Message-ID: <f1a97a6f-4351-147a-ccf3-714387b0f07f@gmx.com>
Date:   Sun, 10 May 2020 19:55:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f2784429472cb7f9cb4d5cbe4b609494@steev.me.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pfwQKdoGz6mq5VujbulThLnZOrCInSu56"
X-Provags-ID: V03:K1:6SzPpKpvLeI0P1Kwitr8k7eGkJOks/N0wNy7vzhTsG4W0hMHcud
 lwhySAyJt4r/xNXDKaT9IyfesJQsEQ4DPHGmY3JuRxyLDZzlwkgPaTDk0sjIsw8+ZkaObz6
 jU5JN6XnnGxCafVc0J1D3AB7TJuPgM9X2rtrkQ5V+BpjtS3x3ng5/8DDIg5za3uPEE7xViA
 KoFSm1NrNEFp2NMy9shbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oI+KqAT9lSI=:V86gOps8gnkAM/O7A2CUEQ
 zx6Zir1LUrUrsVBrhzUSpEV3cAuqvPeJUAdhHRVRVpSuPWO7MFYxucqnr95abaqPuxDMofZew
 58KG4R2MD+HYT1EhCDkMCZWXb+ziXGEMZG52EJDZvHg37dJF7L5nq0hFUeMz/FDlmQJvQlzQW
 +iqJ8nVupWAjLfnRwJY/m1fiGu/HBJ5RlYZQ/Q3cwf4FM9o9/t93bW097qKZ2BW9xXKl+1L4Q
 6KpMQLM9bbDmyop/SX5TfDl99XUgTGSF0YhAqO6yOy3QVmZGlV2o9rohctJ+U7WxDM8cFWZUy
 7SueCZMprcz/B0+JowKRYew4XPww1t6tA36dERWvQVC0BM6CLoS5alrshflWrLFzyRUhi+uAB
 QbcIZA1fWVcoytJLaIxltS5zHYGqDXiypTPjfymoclhlFCrxn+PVGdfV2WCPNPSHTUNJ5ZFot
 lF+PhR/B1ux2PKvViSIN+UhqB2PL+WwMzf4Kl9K0DLp/0aIed865Pjwmqzx3CgjHfColOmkwa
 nUF4e8NiWRHTbUMXkbt13rsi7jyEWw246OcMnZTXqdkJiO0U+ptZp3KxkbSarC3ZcHbYYPpCe
 yu8Y9QeJSxfpq/DbYTLLSO7QyfwXh09zVEo+I6Q/B4DXKMLU5WYpxJgkeXhMKTE5w6zUMy6PA
 5VmZkDnB437o302bVxiq8SzqvkNgCjRvlI/RgTz4nuDXYiO0jNW9euQTwjQURmrnFtk70aYIE
 NyHIBSJPLwZagFLdf3FQhr/21zb4tRiZWXjI9ivgfoePoX08PmfYKr/BXBs3ZFRYeOwgwoWEX
 4osMr2YwAY9SLHm18MnUdRwo0ps1C0R613SXrGU2eZ9/Fnr14bdj4+72dSOAiiyAEaA7fZikk
 u+uWK4xi2FGc54rBizRVHHQ6It7g4c1X9K2umW/7Ia0q0eizqXCeQ5F1xY5dTgeLJZsPxo/hW
 /IJc6PpxFpEAtt2Oxrn1HfGvgG+eNYU3r2RGrYgMOuHovgo8mOX5yBGQ5L+dClSn6lOfU24II
 ILY4nSXlLC66Q1RXLquTdew0rsJ5cpy/tIALece5AMR01vZK2pr6Vs4ax7GvXjvP2h1wLrQaB
 2uADFnCif3yUsyI2jNtkZU+zZjBPkgqK/Nr3HOz+Py2l4StQBAhYz33Vaccjy9WHdII85st9G
 NunsLRjTFSq2Zv+lWpAS8FH2X89fEDVgOnVkC3FmpnTVfR3qPWBvuKxji9f32kvc8Osmhdbte
 fKSS/2dcrA+8grRF2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pfwQKdoGz6mq5VujbulThLnZOrCInSu56
Content-Type: multipart/mixed; boundary="9JIGQb0LJzv6S1WeY0d55YkK2HZUGwt0m"

--9JIGQb0LJzv6S1WeY0d55YkK2HZUGwt0m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/10 =E4=B8=8B=E5=8D=886:55, Steven Davies wrote:
> On 2020-05-10 02:20, Qu Wenruo wrote:
>> On 2020/5/9 =E4=B8=8B=E5=8D=887:11, Steven Davies wrote:
>>> For curiosity I'm trying to write a tool which will show me the size =
of
>>> data extents belonging to which files in a snapshot are exclusive to
>>> that snapshot as a way to show how much space would be freed if the
>>> snapshot were to be deleted,
>>
>> Isn't that what btrfs qgroup doing?
>>
>>> and which files in the snapshot are taking
>>> up the most space.
>>
>> That would be interesting as qgroup only works at subvolume level.
>>
>>>
>>> I'm working with Hans van Kranenburg's python-btrfs python library bu=
t
>>> my knowledge of the filesystem structures isn't good enough to allow =
me
>>> to figure out which bits of data I need to be able to achieve this. I=
'd
>>> be grateful if anyone could help me along with this.
>>
>> You may want to look into the on-disk format first.
>>
>> But spoiler alert, since qgroup has its performance impact (although
>> hugely reduced in recent releases), it's unavoidable.
>>
>> So would be any similar methods.
>> In fact, in your particular case, you need more work than qgroup, thus=

>> it would be slower than qgroup.
>> Considering how many extra ioctl and context switches needed, I won't =
be
>> surprised if it's way slower than qgroup.
>>
>>>
>>> So far my idea is:
>>>
>>> for each OS file in a subvolume:
>>
>> This can be done by ftw(), and don't cross subvolume boundary.
>>
>>> =C2=A0 find its data extents
>>
>> Fiemap.
>>
>>> =C2=A0 for each extent:
>>> =C2=A0=C2=A0=C2=A0 find what files reference it #1
>>
>> Btrfs tree search ioctl, to search extent tree, and do backref walk ju=
st
>> like what we did in qgroup code.
>>
>>> =C2=A0=C2=A0=C2=A0 for each referencing file:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 determine which subvolumes it lives in=
 #2
>>
>> Unlike kernel, you also need to do this using btrfs tree search ioctl.=

>>
>>> =C2=A0=C2=A0=C2=A0 if all references are within this subvolume:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record the OS file path and extents it=
 references
>>>
>>> for each recorded file path
>>> =C2=A0 find its data extents
>>> =C2=A0 output its path and the total number of bytes in all recorded =
extents
>>> (those which are not shared)
>>>
>>> #1 and #2 are where my understanding breaks down. How do I find which=

>>> files reference an extent and which subvolume those files are in?
>>
>> In short, you need the following skills (which would make you a btrfs
>> developer already):
>> - Basic btrfs tree search
>> =C2=A0 Things like how btrfs btree works, and how to iterate them.
>>
>> - Basic user space file system interface understanding
>> =C2=A0 Know tools like fiemap().
>>
>> - Btrfs extent tree understanding
>> =C2=A0 Know how to interpret inline/keyed data/metadata indirect/direc=
t
>> =C2=A0 backref item.
>> =C2=A0 This is the key and the most complex thing.
>> =C2=A0 IIRC I have added some comments about this in recent backref.c =
code.
>=20
> Yes, I'm now stuck with a btrfs_extent_inline_ref of type
> BTRFS_SHARED_DATA_REF_KEY which I understand is a direct backref to a
> metadata block[1],

Yep, SHARED_DATA_REF is the type for direct (shows the direct parent)
for data.
But there is also an indirect (just tell you how to search) one,
EXTENT_DATA_REF, and under most case, EXTENT_DATA_REF is more common.

> but I don't understand how to search for that block
> itself. I got lucky with the rest of the code and have found all
> EXTENT_ITEM_KEYs for a file. The python library makes looking through
> the EXTENT_DATA_REF_KEYs easy but not the shared data refs.

For EXTENT_DATA_REF, it contains rootid, objectid (inode number), offset
(not file offset, but a calculated one), and count.
That's pretty simple, since it contains the rootid and inode number.

For SHARED_DATA_REF, you need to search the parent bytenr in extent tree.=

It can be SHARED_BLOCK_REF (direct meta ref) or TREE_BLOCK_REF (indirect
meta ref).

For TREE_BLOCK_REF, although it contains the owner, you can't stop here,
but still do a search to build a full path towards that root node.
Then check each node to make sure if the node is also shared by other tre=
es.

For SHARED_BLOCK_REF, you need to go to its parent again, until you
build the full path to the root node.

Now you can see why the backref code used in balance and qgroup is comple=
x.

Thanks,
Qu

>=20
>> - Btrfs subvolume tree understanding
>> =C2=A0 Know how btrfs organize files/dirs in its subvolume trees.
>> =C2=A0 This is the key to locate which (subvolume, ino) owns a file ex=
tent.
>> =C2=A0 There are some pitfalls, like the backref item to file extent m=
apping.
>> =C2=A0 But should be easier than extent tree.
>=20
> [1]
> https://btrfs.wiki.kernel.org/index.php/Data_Structures#btrfs_extent_in=
line_ref
>=20
>=20
> Thanks,


--9JIGQb0LJzv6S1WeY0d55YkK2HZUGwt0m--

--pfwQKdoGz6mq5VujbulThLnZOrCInSu56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6368EACgkQwj2R86El
/qiy3gf/fIAStyGiWKAz7J9GOHOJaod8fzr4MBK00lZNWR1KqteiGZ0xb21Dmpwg
Gg560WJsdMdnAgJkLp3/nEi33s/HHQRLHt10NZwjo66QsICMQnjIIdB/IbqfFaLC
uNUqu56+NOni0qakrUqHzvpDbW5alkkUgzTG8srPtHWL+sfI4JJpKlnr1Q/eTzva
ejmkOPKyA8JSj7ZGyzWJrHjGda5F0kejuEyhQKlQqAw70BJw8zdtL8gtJxVZj66P
8g+4vmzN4nrT0SqysS/OAgEBQK4bUTCl1Ml6Z3EewQq+RJvt5UbZINBwDyV6I9gN
yNNKnRwn29E19e7gooGRxw+3DSNsMQ==
=tQ+M
-----END PGP SIGNATURE-----

--pfwQKdoGz6mq5VujbulThLnZOrCInSu56--
