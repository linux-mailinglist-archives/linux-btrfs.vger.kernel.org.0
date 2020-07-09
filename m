Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D2219FBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 14:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGIML7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 08:11:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:33299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgGIML7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 08:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594296714;
        bh=xlmEABDIy9Nv+ezM7I+em3aC4tnNZi9A+6TT1ZuApWQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MER6OWnz3PEdEtzszTW5R5K6W8ccpQozEeGmQXUezSdRqFFYILfkZ3AyQCYuXuQyK
         3KgeTI58lPuDaZamcgVxT9hqF6IwWLG94PuS49BQyai6y+nt86EDJVd5l3MiNmXy3X
         /Nd52NoHF0wwjAfw41hJ7z25Om/fow6QgG9pQsPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsEn-1kiaYK0y7b-00swDW; Thu, 09
 Jul 2020 14:11:53 +0200
Subject: Re: [PATCH v2 1/2] btrfs: avoid possible signal interruption for
 btrfs_drop_snapshot() on relocation tree
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200709083333.137927-1-wqu@suse.com>
 <20200709110557.GH28832@twin.jikos.cz>
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
Message-ID: <73b83229-3e08-7466-e979-a9389eba17c1@gmx.com>
Date:   Thu, 9 Jul 2020 20:11:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709110557.GH28832@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nkkMYFvzB02lDy4sAirqeuN13Sf8itZLr"
X-Provags-ID: V03:K1:39Tp3GGMpXOptpdM5JvjwrCjV1r8h8jKjHR4QG7FISovt73eeIY
 HZ3LPHtuA9kFBL0lXN8gqKwz+ewT4UgD20Ax58JFsiBnVHK0QS6z6wJS2vhK+2yx1ui8GIO
 +6tK6AxRQBkdd3cEex3c8Xm4gHASRk2HHobZlx7L5d4RZS/nVRs3FTO50H9/8J6XSrLjc1R
 l5ThrMGC50sDtuZQhWAnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xlAyig0Ubps=:1zhvlfbNV4wGMcAWSsOgYI
 tj/wml8l9vznrTHo6/UNTpVkEP5i7rSkPSOnHzElvp71JHQJlEYDA0xiW7k7bVsqUPPfmX3FI
 3NpC8OVaYSegk7yb6eiRcGIy4oJkKA4LjbpI9UIa88j4Zr2GVZ1Sm0Clm6QlsfzzmrLVzTb18
 gp3SqDL5IhJq/dctT0XrZ1aaMQ/kHrPelVtm7VyhJ1c3zuU5Khyb0WcPLkOPQK05KKDpY82oS
 Gj8TfYBJbySd9y0YUbUOPw36AqNEgLdUc5++Iy7CUyM3bxbRjw7K5NtHJQDZy8Eu2yF1uA1Kd
 OQhh7ZyQy3oMxCKAdKDqZrmXgs2sPuHyupnNf9cp8gZ3Hb9BZiYUyWpa3nxrwd8RMrIscJnsw
 UpKQ9t/bObNbVKiU9CeuLEuyLDDU6YGr26/6366jyBVBuCCzaXGgQdzZRLWASPGmp/TcqSHBa
 7NYfJONb0t1eJqYwa2Dp7UZUZEtCsK9+SrXCKHocqS19Uw32FMMCvRCDu64RdUHUkvGvlfnZ3
 8oNb5rnLvjDoc3MyZ5TudBuApFNwbk2Lrc8oUCB1E79JsGVqtf2qu4pDE8lif29cKxq3ks5wF
 Vlg4SihyPuzgkychuluQ/abKx2sBhoPqOu7k4Liux8w1Vv31otpE3VJKwe3N/izJkBbuVPNC0
 e9l826h4SN1kixRTdwFD5nyEi8CKMBWdtOdwMtGrQJBrRTb6g5EbkQ1C53cJLj3vGRd6I2da4
 XCVNewBuzZfMRbibdonyegqD2avWrUx1fJjo/A9kTfTyVaRz/LKdjBxXd3yOHFEv3c4pMq8mx
 VagUr/BmXmbqwqBp13Cle4il8ZUtjv7Od2FgQQjmBcqIYtLNj/X5borlNy9uwhcaWRs5QiovP
 FPNjt9avPi+/j7W5K2Y2BLKBu5Zfcsy6cjyxuD6EUWLjk3eoLTYuaCi+Fua07TlkEaV3qratq
 yYeekEXuaCkY7jClENF5ge/5g6ybjDmbI2JkbtHN1FQRUblQ0JQAvaNC8phrnFbgiIPqB0JTx
 fAuuHgRQ+esqZnOUJ57O+a6vh9Ilx87JZwWQrIsdi5ah8Jwni8an41AdtAX6uwt8WreUR15cw
 iT6AC6Rze4r226clgfsi5efIVaVOKi+G/RrPKnxOUjWZmOnJjUZn27oSCpLIMj6Yl8yfXsqMY
 q9qAoeWmyFCl2LxwQl+tqJw/Fg085j25B9GGt75/y3xUjILGjRx57VrdxqqQklNj0kezTdrmr
 yqzR0zC9pNEGDiY8kx7fN3rQW49V9KsXcjcSKBw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nkkMYFvzB02lDy4sAirqeuN13Sf8itZLr
Content-Type: multipart/mixed; boundary="P1paY3HBhMbFmd84ghPVq4tny31ijNHRf"

--P1paY3HBhMbFmd84ghPVq4tny31ijNHRf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/9 =E4=B8=8B=E5=8D=887:05, David Sterba wrote:
> On Thu, Jul 09, 2020 at 04:33:32PM +0800, Qu Wenruo wrote:
>=20
>> From the mentioned forced read-only, to later balance error due to hal=
f
>> dropped reloc trees.
>>
>> [FIX]
>> Fix this problem by using btrfs_join_transaction() if
>> btrfs_drop_snapshot() is called from relocation context.
>>
>> As btrfs_join_transaction() won't wait full tickets, it won't get
>> interrupted from signal.
>=20
> Could you please rephrase the text above?
>=20
How about this:

As btrfs_join_transaction() won't reserve new metadata space, it won't
get interrupted by signal at all.

Thanks,
Qu


--P1paY3HBhMbFmd84ghPVq4tny31ijNHRf--

--nkkMYFvzB02lDy4sAirqeuN13Sf8itZLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8HCYIACgkQwj2R86El
/qghDwgAgp08/hzIUm2GrGjMdhecs4vHZTJsQkMLVQA0Sd3ij2527xVImqBEr+PQ
eOzkL++YdF71PnFzW/xBKfI9SUYWcl3MMZLZ1dT673Pbh9aEYxSZ65kqQIcPwAzG
0MKNsJk914X0hYt3HLZHOer41bq/cUpnUZ8KsNG60s2G7g6Y+r7r/s25M2aQjPMN
xDyeu0g5PH3RfqQVb4VEEsKOVZaJrvOz/wNu7PGlDc7lY0JG2UmtroqSlJCSo9ds
StvQokEIM1p8vogv0e7GMnHei+vLMyapvyl2Li27liRgpZ0GWnNvr14ZzSmYw3vH
yDMk9UQjwhcFMh5fIj68IWsS4IoUIA==
=18af
-----END PGP SIGNATURE-----

--nkkMYFvzB02lDy4sAirqeuN13Sf8itZLr--
