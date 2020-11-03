Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49B2A5A9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 00:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgKCXgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 18:36:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:60401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbgKCXgq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 18:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604446601;
        bh=3PDn03w37ReFeksPWh1DTqzgoAoGZz4IP5jKQDMBF+w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Zujlfi+3Jar/26BoMhXrZYHymnAEuAct+3yU2j1+XKhaBpA82q6FWchogYtYn5vBu
         8w8UlzIFWELB7pFCRbwwA+cBV4lyiWUwz2nzQ1IqiQvEiXPUZFKi7md3GiwKuBKBEu
         EoTca1GovYr2ycHFeG8D6Xoc+xg3oHviqbh7oB0Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1kgQRl3ReL-006vZM; Wed, 04
 Nov 2020 00:36:41 +0100
Subject: Re: [PATCH 2/3] btrfs: ordered-data: rename parameter @len to
 @nr_sectors
To:     Amy Parker <enbyamy@gmail.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201028072432.86907-1-wqu@suse.com>
 <20201028072432.86907-3-wqu@suse.com> <20201103191609.GC6756@twin.jikos.cz>
 <CAE1WUT75ZSbnb=VVONYbreVOjzZs6_ZhL+RKf9Zot0QYp3jtsw@mail.gmail.com>
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
Message-ID: <efb63a0d-ff2c-dc89-f0ec-fe42d45a9c61@gmx.com>
Date:   Wed, 4 Nov 2020 07:36:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT75ZSbnb=VVONYbreVOjzZs6_ZhL+RKf9Zot0QYp3jtsw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LkMNUTsE1YGGd0zEz4JCmaWJyoSWJIEbj"
X-Provags-ID: V03:K1:B3tOdVyBDyZXpHm1O8w1GHi3R0CzcqYFWLHWn3qQtRB5anRAto7
 kIhWzSRkAd/RC17tdTftYTqvmYD91Qswl+tvQUhvWJwLniF5TJFfIMeUZXvjmBT/KnWafVe
 jIv+6dg6RFlSd/PzYF+wt1aLeOgQFk8U1Tz3ExMthvISx1oa74csBnAssuWHpCfUHNTCaux
 cHBYBL6iYu8A1WI4rwt+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HRDRb0XPCGA=:PJhBbutJeZPoeBtoNZPM/9
 d3k5OMAa+Ik5JMihVgWl0uAwS+gDhNaVcmq8fggU6I5tRtJV3GPjWZCq/LduoL0MFxQTgMCt4
 9WfuPsWjHDolbpT9wQCBFJVTQ9/YWqVdVowFNCjpQ38XzAHU3nKzFqz8EwRyuoqWKRtuN3iT9
 HC7oTP5g01BFE66sqUI+t3h/erhRSGCWJjn5t2zvYpPaGvVjmOnATmy+QVqcuwsKvU+WSoJbh
 OFDUNdA9hx/ofj+Ca75bTdHb3gg9ruPBvmkvQueaSnWwHntjIlupyiN7pekDIkNAdQPDPPzWS
 SJm/pBz7Tp/OCnNx8998SAYrvs3nkOMwR14gBuEeTT1RMbpEEcRiKRh65BSTAJqN9KjwTzlzP
 JPLmTHU1pm3TSxQC4X/2zZ2mO0o2f34mPx0WF8rDRmOM1KAl13oQxcR9SsllRmVoHkQHloJnu
 Gv1YhQTSbiPQN+4XJJTE70ZXCV6woeYjpXtGBF8Km1Rbikn/W0mPKgJx5FvG7zZpCmS5PiM12
 Ld9uR/1FG8zwH0rAsUwMS9oKNXsF+Rc1LhGYCs4j6dOUnKPv9FgFddWbWQdmDSPVFiffvmjcF
 erR18i2vmYALOUlHRxnW43RGouNe2JpRa4w7kKNUcjvGQR28chPxMe8RW0tt98J9ui0SYuLSA
 TpCzvk7uF0GBkRGuoBiVb0Y9Fa0plfXk670PWaZ2lr/mveTY9bvrz0QzfLH/MHWmI3uoZZx0k
 HmQGK90kymyQ4rFGc6b3kXuwJaSgbyHCc+H6FWRFO7jeiM4q5Tp+8LyLGPAdDixifOIB0QJzy
 +I6gnOVPUZ4I0uxDE7PAPOoFAySy/4dQz//79egNYvnH+rBMmjGpU3QUECG0MQWRtOVaoJAEJ
 dKAelhFcuOzF2bFeRElg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LkMNUTsE1YGGd0zEz4JCmaWJyoSWJIEbj
Content-Type: multipart/mixed; boundary="6reZOYAo5J9f926nPCS0IDVOEuUk4d0dm"

--6reZOYAo5J9f926nPCS0IDVOEuUk4d0dm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/4 =E4=B8=8A=E5=8D=883:23, Amy Parker wrote:
> On Tue, Nov 3, 2020 at 11:18 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Wed, Oct 28, 2020 at 03:24:31PM +0800, Qu Wenruo wrote:
>>> The parameter is the number of sectors of the range to search.
>>> While most "len" we used in other locations are in byte size, this ca=
n
>>> lead to confusion.
>>>
>>> Rename @len to @nr_sectors to make it more clear and avoid confusion.=

>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  fs/btrfs/ordered-data.c | 9 ++++++---
>>>  fs/btrfs/ordered-data.h | 2 +-
>>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>>> index ebac13389e7e..10c13f8a1603 100644
>>> --- a/fs/btrfs/ordered-data.c
>>> +++ b/fs/btrfs/ordered-data.c
>>> @@ -802,9 +802,11 @@ btrfs_lookup_first_ordered_extent(struct inode *=
inode, u64 file_offset)
>>>   * search the ordered extents for one corresponding to 'offset' and
>>>   * try to find a checksum.  This is used because we allow pages to
>>>   * be reclaimed before their checksum is actually put into the btree=

>>> + *
>>> + * @nr_sectors:      The length of the search range, in sectors.
>>
>> Please add all parameters
>=20
> Yeah, having all parameters will be important for documentation
> purposes. Shouldn't need too much effort, just quick descriptions
> of the parameters.

No need anymore, as the function will be removed completely.

Thanks,
Qu
>=20
> Best regards,
> Amy Parker
> (they/them)
>=20
>>
>>>   */
>>>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk=
_bytenr,
>>> -                        u8 *sum, int len)
>>> +                        u8 *sum, int nr_sectors)


--6reZOYAo5J9f926nPCS0IDVOEuUk4d0dm--

--LkMNUTsE1YGGd0zEz4JCmaWJyoSWJIEbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+h6YMACgkQwj2R86El
/qhTWwgAppCk2st+4WYhACTNSN+LdIf21DvMUEM8fhQ3aXJMO7YvgAD/W7l4VyRQ
34JNTjDqtocpDB7cSr9kK3YAAkKIf/zoH3cOf2x4zfz/rbxaPLQ4B5fdINCvE2KP
zGXKPBHlVlD2wu0lNRuorMNHIl/gAIF6/APkuH5OlWiIXJzEyzvt00mRQptKvkwv
IwOpWHFmr9OoTjFTgI1PfMUBabf8N6n2F0OZCnloUbfzOFgZbWHohV/uu2uGqgPN
A3OCYhm4Pm9A10OceZB8y682EPsLNjJRCLxglaMqqNH0VsDAid3Y4WoMxFCJTzWU
w4UV+B+L7PZr1ERNvPwfDjdS1YFdgg==
=gBTN
-----END PGP SIGNATURE-----

--LkMNUTsE1YGGd0zEz4JCmaWJyoSWJIEbj--
