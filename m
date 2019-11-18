Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D933100F70
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 00:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRXd4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 18:33:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:39807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfKRXdz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 18:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574119951;
        bh=JFC1rCAtlAKdB3fCe5K43wowV22wJJUYmyMUn28ya+U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f9Tv7D7lrpu9sKW8v0po1bmsNdsBDAJvRG3aEdZhJ1R9D8dpwsKKPNgsym1INQOdD
         M6n+EOFrFkZU7ml4tDjgjuCCB8Bg3jlbnE38phCr2ToZRz2B9W0Yp4reHI6XmIKTeU
         f14RkLDW3Hyj73+ZWXauDBe8169FE2Jsjua9XjX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9UK-1hhMPi3XQC-00s5ee; Tue, 19
 Nov 2019 00:32:31 +0100
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191118201834.GN3001@twin.jikos.cz>
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
Message-ID: <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
Date:   Tue, 19 Nov 2019 07:32:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191118201834.GN3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SjDNchp8rdtnq2ELaW8RHRLjGsJ87TehW"
X-Provags-ID: V03:K1:9Qg60IyuO/FbYn2jXhvnFx6Aop9E8yFnW4woQJiCnxkps2xCoiu
 y7yPMBt1qaIGzFdJF7cqQOb60ZBAx04RhrmZv+4s0Q6cZaCufaulkcttrG+gZrf/ibk7wmr
 wuX4dbKOJmuPgHJN2SZ+zh2tjTNHi+0a/RF7OA5GyESfmmkdxcVhI6oNU8gqxIeIpU8p7rl
 OaRj3F2Y/OFg1fJ4X76Yg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8jiUjgSTLjQ=:g8EL384Aoo1Sr+DUP0+knc
 rdKqVsSVyaHf7KjeFofkwhtSWTkSa15PydZ+ywU68mCj4F+Kj+vtX+NZst4kJc7TYiF6U+i3j
 A9EaAku/ZOZ/XMi+7fNZM1l/6bEl6Sr34HEhcynhwM34l4tPxSyAJXiaQdNGal5WXjcEma6Ms
 Gklo3pKPp/6uZGsjjPjUG36K9dcnJPvHiTVMnrUQSjpmhC0HBpC8jyn6WT8Z/xzSead4YaXUu
 SAM6uRoyMWXF/xmmmfjzI5SmevCej/hlGw2hdQtUvErHdplFB913+gI0L+Mr+Jh8urn3Wa6CG
 IOJjMm8l5FhA3yh5yk4YGr/8MVeUQzbhJjkoVTL1YC3K/1gnIL5oejQvLV0Fs1Cig9EWqL13I
 iVbVvcrhBBuPRB201X9eV+brW8YVCiPiQeNjcqSuDLrYymtzqq2WG71YHinVDSk0qFpHqVAMg
 Xi47Xjkrx23ynfQI+KuhQw7nC+AyKXkIFlPrC2DW1v8RG2uPOGb3YOslBBziAdDfa/bBt0KCW
 W1wI/DAzP7OXBg76DAUre7Qjjpe9WBHjTw3ql9onw0vlwwP3UiFwMT5SWlt7De9Zk1ZUwYiPM
 ixS960RLMmKTPIzprLXKjm7uuSKiMsDiwy8KVF6L+Q6yJ76PWgL1LW53I0dUsm7tJjbrtoOzz
 WOoGCl3tnfgl52zxw4FNvC1Kxsskb6yMqFwjZipPDW+rcX17w6s9w3dayNGSiiMuQqKYBQl3e
 3epT0S8W3kxnAHhgZW+/nbhmZpuwUg/10uc9s/C22LL1/69doc670IdyW2iO/+18O7H4JiB05
 U0/FB0RhH1iii3luMypYAbrGCvdG0hF49vCSRGnE9p9qh4MkxK2Z7YDkTzsXTwxphmVP8OgJ7
 n8HT24vUC5ra9P4ZhnZuGlxpO0Oqwwhyn8aNroMD6Gw6ofqx8JpHmqab8oge8/HnvVAXDeMY2
 GQ884mh53GFOSrSlKZZI3bs4ZEdrJewWA3m1yX+0qZKw/AR4kvriMwrInDQV/KJo46CjHJDbk
 Ejx9TPpAT+54P5iNdZgBY1q3KigNzfaZzY2IfJ14eHFhaBCVCZ/XmQGqK2GffhcT9OnMxGywZ
 7GlkmLD7H5MGgMWSuSK1N4E1GaiXu949pYBt3Orxz4EJf3s8hv2hPbE2UGN0SJPwqdTwfyljo
 GfXXzW0yKv0X2I1SfA9cDkN2Pu8nFppC0MF2MW6707xx5J3GC4KYz19fwHpFf39eY75GCPbAA
 fBl+Z8H7/8R1THoCAx8iEt22cbh+M6WLhmKysAKPjU+IIsF+z/Q3QkcWu+lY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SjDNchp8rdtnq2ELaW8RHRLjGsJ87TehW
Content-Type: multipart/mixed; boundary="0wuPPiZ9uck4BFl971qXbUu38gAdYAViC"

--0wuPPiZ9uck4BFl971qXbUu38gAdYAViC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8A=E5=8D=884:18, David Sterba wrote:
> On Thu, Nov 07, 2019 at 02:27:07PM +0800, Qu Wenruo wrote:
>> This patchset will make btrfs degraded mount more intelligent and
>> provide more consistent profile keeping function.
>>
>> One of the most problematic aspect of degraded mount is, btrfs may
>> create unwanted profiles.
>>
>>  # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
>>  # wipefs -fa /dev/test/scratch2
>>  # mount -o degraded /dev/test/scratch1 /mnt/btrfs
>>  # fallocate -l 1G /mnt/btrfs/foobar
>>  # btrfs ins dump-tree -t chunk /dev/test/scratch1
>>         item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15=
511 itemsize 80
>>                 length 536870912 owner 2 stripe_len 65536 type DATA
>>  New data chunk will fallback to SINGLE or DUP.
>>
>>
>> The cause is pretty simple, when mounted degraded, missing devices can=
't
>> be used for chunk allocation.
>> Thus btrfs has to fall back to SINGLE profile.
>>
>> This patchset will make btrfs to consider missing devices as last reso=
rt if
>> current rw devices can't fulfil the profile request.
>>
>> This should provide a good balance between considering all missing
>> device as RW and completely ruling out missing devices (current mainli=
ne
>> behavior).
>=20
> Thanks. This is going to change the behaviour with a missing device, so=

> the question is if we should make this configurable first and then
> switch the default.

Configurable then switch makes sense for most cases, but for this
degraded chunk case, IIRC the new behavior is superior in all cases.

For 2 devices RAID1 with one missing device (the main concern), old
behavior will create SINGLE/DUP chunk, which has no tolerance for extra
missing devices.

The new behavior will create degraded RAID1, which still lacks tolerance
for extra missing devices.

The difference is, for degraded chunk, if we have the device back, and
do proper scrub, then we're completely back to proper RAID1.
No need to do extra balance/convert, only scrub is needed.

So the new behavior is kinda of a super set of old behavior, using the
new behavior by default should not cause extra concern.

>=20
> How does this work with scrub? Eg. if there are 2 devices in RAID1, one=

> goes missing and then scrub is started. It makes no sense to try to
> repair the missing blocks, but given the logic in the patches all the
> data will be rewritten, right?

Scrub is unchanged at all.

Missing device will not go through scrub at all, as scrub is per-device
based, missing device will be ruled out at very beginning of scrub.

Thanks,
Qu
>=20


--0wuPPiZ9uck4BFl971qXbUu38gAdYAViC--

--SjDNchp8rdtnq2ELaW8RHRLjGsJ87TehW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3TKgoACgkQwj2R86El
/qhGEAf/aVKoBUL6u7Rd+Ot49jVr5PSLu0ed9yg3vYtzo/fQRXP5aaQiWGA/o4Xn
geekzQeAOtRF62zWCOGcB5DYUwJkS6FeExvu5O9Y8NVhnx4YWFywzbCpXl3Yf5CA
icTt55I2hMner9uia+b4IRZAwoLsPF9hPmqi6jy2605DiE+i7FmbA9kw7b0S0R1a
KQG4vF8jAF708X3DLUu9gW6mHhNy5st+XoxO229VaVCF8SoXpTNqR48l7WgoxvwZ
aQUGn80md0M2QODfUsdM1o/JtbAWfVjs8R8fqhzMC7hh0DJsWkRVZzctE8vEH8Fw
yh4FEo0BudHiZaNlOmGhpnelmJne8A==
=pKjM
-----END PGP SIGNATURE-----

--SjDNchp8rdtnq2ELaW8RHRLjGsJ87TehW--
