Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67C1F7FEF
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jun 2020 02:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFMAiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 20:38:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:33275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgFMAiS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 20:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592008689;
        bh=D8eOGD4E7aTf4DsHx5NVPBvOJroAZ0XpNw1Nm4QtmJc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G7krF6UGR9XqfAVOl0PKvTg8DFq94VBHeX+09h3QwDCzx/c/EnV0CDeVwB7D4mizx
         lCPO9qWjhqveocAUrulQBfIQGBF6VaJUlr/0BWMulOeIhFNhGfNF4StCgygXrkD+OX
         yC6dkemdcFngqzACYY1bNocoJWBtWe7teRsiReXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH9Y-1jBvoa3taG-00ciqS; Sat, 13
 Jun 2020 02:38:09 +0200
Subject: Re: [PATCH] btrfs: Share the same anonymous block device for the
 whole filesystem
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200612064237.13439-1-wqu@suse.com>
 <20200612164801.GV27795@twin.jikos.cz>
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
Message-ID: <704f930d-1e1e-beb2-f45b-69ae2e6bb1bf@gmx.com>
Date:   Sat, 13 Jun 2020 08:38:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612164801.GV27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="13CLadS0qXjp1j6OzuzGXTkyNxq4yN1EU"
X-Provags-ID: V03:K1:iv3KI1t+ikr2POwImOQ+z/0hCe5X6Cv8pMkjZ2MwCc8PVgzGea4
 U8JSGnNIhTqVdzSJRH7/ZAbbvK+Cjqy3dBxKw7FDUPB64PexQ0tVe29Jj9jX+uy5wzBDe89
 x7sfUkGYQ3jqvTj1c+aNbH6JH2LSmcFYXtHdmBNTgnfUhqdwuRohLavCZQdKJBjoel5oSvU
 JAngmGzk11k1BwNHMixGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BHxUsCYClXM=:P6HfYVn4odIWkTlAtCD81W
 gb/KNqcrcyMANZZH7Q0PiymGLRDXyogPm9ixHn4qGNGYgGFlpNr9IDceNOJsNbTQpnXESpJiQ
 Inpm/2J7JmRoY6+UZ2CjZORCzryO0JuLHU1kw0eBqwAurDBFvcZwTwnUbDN8iX8390fDz1dTW
 jiSWIAScBQRQtl6aMm+tJ3ocKjnJTzPYSc6lIoi5FFuMxDZDBLkQiPwf5STN+4WCPzC3KeXDZ
 BSc89Ymkzy8PwSmItJt6h3N7hi9Wi46Hz8zCYne6NWif/W62jcihG5NcyCI0X+xTxcj6HmPeU
 CHPz0d2GLU3VRTgS3Buzb1Th06HkeZ4b7TEPQTBJSYaTjL0gr/U7vjeiYOgotrfN52oK5A2xx
 pXAGQNjv9SXdItVaH3cVnF5MITmy2KNYM/ahgZddIotMvRFQL7kNoOP+3o/m81aW3yAZ/8B9l
 1eW9ODi4q7IFsmLaxiUGewR/PMNa2sianvBpd+lW5zsnE0bw//pcp5P0u46TwA786CJg0fC4j
 NjXLFmKi3nw+09Xt7Ri1DptUCRvwYBFU2zUh7rpP/5cJUP+Vj7cgl1BPGDbp7kG9QknfDthmY
 AnGoxoOWI4A4Cja8RawMP7JNMioWtetc3eu6Xqd3RTYIcliUY2VspVv1YGif/bP07UhZWN9ap
 wVv0O2s29yP4DH7Dw28WuIgt2E+eOUoEdaWc70IOprgnSmvKYTFrR8BRx5A58Mih5e5Td7sYH
 UNZIKnXgTWkdVMd8xgQ90KP7OuXv0dCpoZ1o7e2zu6twck5tj7hNAI41D2IPl4QRp/K/it0Q4
 R61whfqSCtGZ2jT5Gebgx36S7AOMVKevWuYJzZ1gz6cKOheVwUoSGCgrmqVmKKC1YDsAPmVXG
 bPFvPtn2UcOhYkFqm+cvYLvSD66suzS0vj4atoxQnge6I10ASbV6iXACnhPw7geqgqbNfvioW
 JudeX74Jz8EI6vJr3zedtKIsEP+6hY/SZIZVELeo2huZaqr3NALbIJTxFS5d/T91WrRZpMHgm
 5bDvGlEd6imTUNasAuuJWi1Hso9wu3K+LzI3NFNTZaJFjIuJjPk1FcY08/+y13E9tE0oDcWOs
 kU0qV5B68Ijjr/AKBgcI2819qpfJ8Paksq2FgjvuxmPLwXwIRX9HAKgnse6HddAAko8tqf6Br
 nsjVT4g+5X93eOpWVMeuJo1bqKppgMn5oimdM2d52E954Q24rITXKttTdQMQOUPsg7IQDTeuO
 axUZ7t/PnRRcXdoM5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--13CLadS0qXjp1j6OzuzGXTkyNxq4yN1EU
Content-Type: multipart/mixed; boundary="j0S3Sn1PkPNYtb4YKVv5YpMqm9r0VtKyV"

--j0S3Sn1PkPNYtb4YKVv5YpMqm9r0VtKyV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/13 =E4=B8=8A=E5=8D=8812:48, David Sterba wrote:
> On Fri, Jun 12, 2020 at 02:42:37PM +0800, Qu Wenruo wrote:
>> For anonymous block device, we have at most 1 << 20 devices to allocat=
e,
>> which looks quite a lot, but if we have a workload which created 1
>> snapshots per second, we only need 12 days to exhaust the whole pool.
>=20
> 1<<20 is 1M and that would mean that there that many snapshots active a=
t
> the same time in order to allocate all the anonymous block devices. Onc=
e
> a snapshot is not part of any path the device number is released and ca=
n
> be reused. So simply multiplying the numbers does not reflect the
> reality.

Yes, but for that number we can still exhaust the pool if the subvolumes
are not cleaned up.

>=20
> A plausible explanation is leak of the anon bdev by something else than=

> btrfs on the system.
>=20

I'm not sure if it's a leak. As you can see the free_anon_bdev() call in
btrfs_put_root().


Although I understand that we use bdev as a namespace seperator, but I'm
still not confident about whether it's that important.

One point is, I didn't see much users of bdev member to distinguish any
subvolume, no to mention the "sub" nature of subvolume.
It's not a full volume, since it already shares the chunk, extent, dev,
root trees, if it shares the same bdev, it won't cause any new users any
problem.

That's why I'm pushing the RFC patch. Are there that many users relying
on bdev to distinguish different subvolumes? Any example would be very
helpful.

Another problem is, for such lightweight btrfs subvolume, there are only
that many things we can do to reduce the frequency to hit such problem.
We can never eliminate the problem.

If the bdev problem is really affecting a lot of existing users, I can
make the behavior toggleable, using mount option maybe?

Thanks,
Qu


--j0S3Sn1PkPNYtb4YKVv5YpMqm9r0VtKyV--

--13CLadS0qXjp1j6OzuzGXTkyNxq4yN1EU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7kH+wACgkQwj2R86El
/qgeXAf/Vcl/nGP1itrLcgsT5yEd3MFwC67CWkBFv6NlA2fCzA9uVV85KabBWJmN
f2/InRJWnj+FzQxI+b1Ahyf/2Xzm8+DpcgoaObrtcJ0/Um9yUbtzbz/4djRHrjL7
mx+3uttEm5c5MY4BuIBu55DR1Kf4GWdKPJyS8yxByazpcV4fuxi0y8CPjTh84C9c
Ik+Ou8eBCi/Njc/DjEICrFoeNBTLWvls8zY//IkQUEkGtLQU2djfzM+86TAAtl6X
L6SQn28dT3Wi0g8S11NUD4RzNDQ45r6StbXa5KERMGaGsjm5VQQZVVh/VkAaMx4c
bmAvpHarFF5MhyG06dNPjHd9BmMZ5Q==
=SdnU
-----END PGP SIGNATURE-----

--13CLadS0qXjp1j6OzuzGXTkyNxq4yN1EU--
