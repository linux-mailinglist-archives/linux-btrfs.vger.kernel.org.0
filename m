Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A223ACAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 03:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfFJB2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jun 2019 21:28:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730007AbfFJB2K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Jun 2019 21:28:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B0B6AE52;
        Mon, 10 Jun 2019 01:28:08 +0000 (UTC)
Subject: Re: [PATCH 3/9] btrfs-progs: image: Fix a access-beyond-boundary bug
 when there are 32 online CPUs
To:     Su Yue <Damenly_Su@gmx.com>, linux-btrfs@vger.kernel.org
References: <20190606110611.27176-1-wqu@suse.com>
 <20190606110611.27176-4-wqu@suse.com>
 <d6909877-43e9-b66d-6d77-cf58820e64a9@gmx.com>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <7bb6a6e4-6d2b-d4d9-ebb6-b47f309d99ce@suse.de>
Date:   Mon, 10 Jun 2019 09:28:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d6909877-43e9-b66d-6d77-cf58820e64a9@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UzXYr6JGSQFS8uhAaNiEkpo2rrcUXzNdl"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UzXYr6JGSQFS8uhAaNiEkpo2rrcUXzNdl
Content-Type: multipart/mixed; boundary="BAG3ihHFZ4xFRuLQX4e5id3oNlgbsdU4H";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: Su Yue <Damenly_Su@gmx.com>, linux-btrfs@vger.kernel.org
Message-ID: <7bb6a6e4-6d2b-d4d9-ebb6-b47f309d99ce@suse.de>
Subject: Re: [PATCH 3/9] btrfs-progs: image: Fix a access-beyond-boundary bug
 when there are 32 online CPUs
References: <20190606110611.27176-1-wqu@suse.com>
 <20190606110611.27176-4-wqu@suse.com>
 <d6909877-43e9-b66d-6d77-cf58820e64a9@gmx.com>
In-Reply-To: <d6909877-43e9-b66d-6d77-cf58820e64a9@gmx.com>

--BAG3ihHFZ4xFRuLQX4e5id3oNlgbsdU4H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/10 =E4=B8=8A=E5=8D=889:23, Su Yue wrote:
>=20
>=20
> On 2019/6/6 7:06 PM, Qu Wenruo wrote:
>> [BUG]
>> When there are over 32 (in my example, 35) online CPUs, btrfs-image -c=
9
>> will just hang.
>>
>> [CAUSE]
>> Btrfs-image has a hard coded limit (32) on how many threads we can use=
=2E
>> For the "-t" option we do the up limit check.
>>
>> But when we don't specify "-t" option and speicified "-c" option, then=

>> btrfs-image will try to auto detect the number of online CPUs, and use=

>> it without checking if it's over the up limit.
>>
>> And for num_threads larger than the up limit, we will over write the
>> adjust members of metadump_struct/mdrestore_struct, corrupting
>> pthread_mutex_t and pthread_cond_t, causing synchronising problem.
>>
>> Nowadays, with SMT/HT and higher cpu core counts, it's not hard to go
>> beyond 32 threads, and hit the bug.
>>
>> [FIX]
>> Just do extra num_threads check before using the number from sysconf()=
=2E
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> This does fix an issue.
> And as the commit says, why limit the max threads to 32?

That's completely due to the hard coded metadump_struct.
We can switch to dynamically allocated pthread_t. Shouldn't be that hard
to convert.

> Does it still make sense in nowadays multiple cores CPU?

Well, thanks to the slow improvement caused by monopoly (cough, cough,
Intel), after one decade we're finally getting mainstream
16core/32threads CPUs in this year.

Personally speaking 32 threads should be already good enough for such a
less-common used tools.

So I'd prefer to keep the hard-coded limit for a while.

Thanks,
Qu

> Can we increase the limit?
> However, this is another story.
>=20
> For this patch:
> Reviewed-by: Su Yue <Damenly_Su@gmx.com>
>=20
>> ---
>> =C2=A0 image/main.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/image/main.c b/image/main.c
>> index fb9fc48c..80f09c21 100644
>> --- a/image/main.c
>> +++ b/image/main.c
>> @@ -2758,6 +2758,7 @@ int main(int argc, char *argv[])
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (tmp <=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tm=
p =3D min_t(long, tmp, MAX_WORKER_THREADS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 num_threads =3D tmp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>
>=20
>=20


--BAG3ihHFZ4xFRuLQX4e5id3oNlgbsdU4H--

--UzXYr6JGSQFS8uhAaNiEkpo2rrcUXzNdl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz9siQACgkQwj2R86El
/qj4jwgAgT68DpR5OugvoMT0QdZPg2DbpCosBYkg3mEikidQCm9YZi2gr5iyomPC
iyjnYZlTp8RgyXJUmWxg7CH6S4Ki4MlVZ4INMoA1RwMYXAE2FCDYcpifzfqu7NSt
4A5LBjPWKezczp8Yg+rDTfqJaVCriQxndRhr2m7Z0ud6nY1nMT5HJ+QWmPruNkSl
t92Cb3zvF4dNYvDpAlM3//gGB8h1BR6NhF7hAqg9VsCTtCKS5gtiwO533+LCCTil
ha7hk6G/8L8CvPp7W8a1oBGYWetjVCCzXRQpvbD7/y9SmEHLt8vChy3RjFa+NaS7
1OJM72DS/TxQnFo3YwOhQ8GMvaMaCg==
=NGll
-----END PGP SIGNATURE-----

--UzXYr6JGSQFS8uhAaNiEkpo2rrcUXzNdl--
