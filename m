Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F388952C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 02:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfHTAfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 20:35:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:49625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbfHTAfB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 20:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566261293;
        bh=75WNHt2fs1ncZwdsKLpuPx5GCJSxAOh1H4N/qiCHlic=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FZuarS2vkoPDEBj5WEE9+3MHwPTdudmRuC/aeSJVEg73EBnVon4GKQMCKSffCz3du
         gTRmRwHzKjsNVsiJhjqZqZ3hJ740vXXq2JMZNhucvUooZVeJ60muF6DFz2HzW5TADn
         Txmg196teYL02+JfI4fitdhtqzRL/34H3Ywc6hXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LyVIk-1iMY1a3z0Q-015naX; Tue, 20
 Aug 2019 02:34:53 +0200
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
To:     dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
 <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
 <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
 <20190819165713.GK24086@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <4547cf77-15d0-a1fd-29ca-77275619450d@gmx.com>
Date:   Tue, 20 Aug 2019 08:34:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819165713.GK24086@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="edm7rSktmVSHyPIL8PYUxBx4t0dqsHak9"
X-Provags-ID: V03:K1:6HnGoJ9cPjpZH60yUBUv4ogm4XLCNy8ecoOH9Kh07sFycayTX1m
 ItxpabwJAz73xFgKIDsKCjsAAcKsM+F+2wElXvSgebdDE/E6gfQ9g8UJ8MNvTK9t4eVXt56
 AHA8nkOf2yrcj7wWi2jazi9iYjJWmC2CVlJ1o40ic4DjifAHD2IaXELOL+Q+eZKFqASBdBq
 EbUmLyFn41L4DLe4mldRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NSpraq5kXb4=:TmJWFwBVI6fv2QX+YZSJ73
 cK8t8gf6rWQ0QwPJLETHc7jjObZjGVSUD8o7epiD3ZidEr21EaoZ03c7z7uLaj8pp3QlZuh35
 DOaGeUZt+avIestxbgBZH2U8ekAiVXQAvyMHui7fLgY5Fah9X919g9GC79cSO39gMk2LQnFWQ
 qF0Wz16x2UxsIckewbsVGDcqf1jogkdb9qEb770thzAQuFFfIms/F087hmU/eSYhaVTS2bLcn
 UaFQLC8N9e5rJyo9qRqrnS4x8VRChaU4WhcYIQcD9oor8kLswAdMrn9V4GNUYdb/Dj7Na79YL
 2lwCoTlPw0RhFjb7Un1dDBJls9Qdo6gYTv4KeHA9W753+UPYI0BkQ3p7KTKFIsMgFeY1lNUo+
 CwVSZjuty/nXd08GpUNdHX+ZSNSpGQUusrgo2IqkIB7JECAbtpjfCaIkqQ7+IoVEfH+0OwC0E
 RwmyQHIMA1EX6UMAXJO9Bna2fRuTVxmXiRUo6NWXqL+hydAUaFxZ8lrDAeJxI8TrzuRF0n8XU
 xcefU4FFnrHrBrmO59ojO3jkGwE69hjzXBQNwGW9ENXc+d0bOLl19Pqps1XTywU4W4ljR5OI5
 J8I1pGv8hW5mpieyci9SiP1/g19ecaKryO8LZHDJeQPBrB0Eg8+cFF/Jz2CEQEkueAltF/KbP
 YPbyftWAKXmAiIZ8/SRrxbKi5mxlP5y1Ftu7hkmfHRt9ynb4Wc5bvYFCQRlkTZPN7OVwDmVVa
 yvpSjVTzMTRC3opZd/g6lOG8iQnR1FgktQcezMk5xI8FghYi/eK9k8f+YBBMj6dW6S9470wmc
 Qa32ubQzqixDlFvwimjNmjeZ6o/f8XszjOn8SqmSrh6CsVQs/s9gq6eIgPlOFPSpV15XJlger
 DbGLzGgLguBohyBp3Un3ge+yhkWAh0pw88V0E0PNsomcDK+DY3RuQzvCXMbsHhOznl5vZB2aL
 dsTccFsU74XixtZjySIsLRzAEbb6YhgmTuhkGrUaQ2EclMtom+O6iLhxutj/uERjeF5xuUq3V
 5kNy7Iie87y4RAsMDL1sYVKqK9YhGO5+iavRX9Nf/jrtMep0IpXh8EccdEok0B3gnK94igUXh
 omOvxvPv9DOjpy+fIDsQmHpPwrBqjv6WoPxvwluS6DH+LvLQiytqL1CTQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--edm7rSktmVSHyPIL8PYUxBx4t0dqsHak9
Content-Type: multipart/mixed; boundary="kOXQf3pfEhQWsBZXRyG4DUU9T45H9kYwb";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <4547cf77-15d0-a1fd-29ca-77275619450d@gmx.com>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
References: <20190815080404.20600-1-wqu@suse.com>
 <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
 <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
 <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
 <20190819165713.GK24086@twin.jikos.cz>
In-Reply-To: <20190819165713.GK24086@twin.jikos.cz>

--kOXQf3pfEhQWsBZXRyG4DUU9T45H9kYwb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/20 =E4=B8=8A=E5=8D=8812:57, David Sterba wrote:
> On Fri, Aug 16, 2019 at 11:03:33AM +0100, Filipe Manana wrote:
>>> Originally planned to use this feature to catch the exact update, but=

>>> the problem is, with this pressure, we need an extra ioctl to wait th=
e
>>> full subvolume drop to finish.
>>
>> That, the ioctl to wait (or better, poll) for subvolume removal to
>> complete (either all subvolumes or just a specific one), would be
>> useful.
>=20
> The polling for subvolume drop is implemented using the SEARCH_TREE
> ioctl and provided as 'btrfs subvolume sync' command. Is there
> something that this approach does not provide and would need a new
> ioctl?
>=20
That interface is good enough for my use case already.

Thanks,
Qu


--kOXQf3pfEhQWsBZXRyG4DUU9T45H9kYwb--

--edm7rSktmVSHyPIL8PYUxBx4t0dqsHak9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1bQCcACgkQwj2R86El
/qiBgwf/dPKZ0aL/i3jTq3PGEtC8bLqXS4DxD9R1PMGOEJOGwV6XbqusGYsPVZBu
QaM8mQHReM4ZbAXTRbL7nDSs/ZEHUY9Q+bT/GfiEcqRT2fWPdRny1YwLb76CC3Ln
iMGk9Q7SvRm3ryz/pgZCK6VouvRM2VP8JhIxRfUo8GFWqCPStQWZuia2uGaUfSQE
FGnt2W9AUj8lkyGdH4CAOXPoao0hFQHNO+89X+BnifTpMCbttino+oxK12O4gU7/
dN6XiojaOvAwEtPAhK/+5bXYIcXRe0SaclrO29A4K43fph//nCulU7p4mPrtkHxO
Dpmme8qoiXoFhdwh8fMEFNaUroiBtA==
=6wvd
-----END PGP SIGNATURE-----

--edm7rSktmVSHyPIL8PYUxBx4t0dqsHak9--
