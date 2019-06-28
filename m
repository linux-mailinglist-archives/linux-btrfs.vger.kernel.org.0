Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17458FB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF1B1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 21:27:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbfF1B1B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 21:27:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AF91AF0A;
        Fri, 28 Jun 2019 01:26:59 +0000 (UTC)
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
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
Message-ID: <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
Date:   Fri, 28 Jun 2019 09:26:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627145849.GA20977@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eqTWI4KoB6hCpE4i08WK2YVUBY5PjloZ8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eqTWI4KoB6hCpE4i08WK2YVUBY5PjloZ8
Content-Type: multipart/mixed; boundary="8tzf9JWCuftR0dbxssC7BTWOAJYykLn7y";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <dafc56c9-1cd8-2727-049d-99db6504b7e2@suse.de>
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
In-Reply-To: <20190627145849.GA20977@twin.jikos.cz>

--8tzf9JWCuftR0dbxssC7BTWOAJYykLn7y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/27 =E4=B8=8B=E5=8D=8810:58, David Sterba wrote:
> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
>> Ping?
>>
>> This patch should fix the problem of compressed extent even when
>> nodatasum is set.
>>
>> It has been one year but we still didn't get a conclusion on where
>> force_compress should behave.
>=20
> Note that pings to patches sent year ago will get lost, I noticed only
> because you resent it and I remembered that we had some discussions,
> without conclusions.
>=20
>> But at least to me, NODATASUM is a strong exclusion for compress, no
>> matter whatever option we use, we should NEVER compress data without
>> datasum/datacow.
>=20
> That's correct, but the way you fix it is IMO not right. This was also
> noticed by Nikolay, that there are 2 locations that call
> inode_need_compress but with different semantics.
>=20
> One is the decision if compression applies at all,

> and the second one
> when that's certain it's compression, to do it or not based on the
> status decision of eg. heuristics.

The second call is in compress_file_extent(), with inode_need_compress()
return 0 for NODATACOW/NODATASUM inodes, we will not go into
cow_file_range_async() branch at all.

So would you please explain how this could cause problem?
To me, prevent the problem in inode_need_compress() is the safest locatio=
n.

Thanks,
Qu


--8tzf9JWCuftR0dbxssC7BTWOAJYykLn7y--

--eqTWI4KoB6hCpE4i08WK2YVUBY5PjloZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0VbN0ACgkQwj2R86El
/qhDjQf/cPBdRA40VGMMbvulMVpdcjMH3pfASSGn8A++gMjzeG3nvrzhnpL8PLFP
y103i/gyiUC6jKGr5oNtO+CcgmUY3s5HVpcpho+jRayEyvDUrf5ibu+zU37x2a3u
nNQJW5ideb6dIm/pzzNd1cGKDTzeAqCat7w2qh0wUlqsDX/GN2qGC27rCrx3KegW
0wakyHlu2LkI5YHKovr5SwEg0oMroGwAFCv65dhVMO4dDYlQ142Nuq5uF4O3jLXQ
lKlBxjNxRCGk4Gwzkdcr2LC+/v92/6Etus8C8HxgfeEs/Di99VoxaD6vQaUlfFfz
FyMfIdSeZzaOGuLDRvDnGww/3L6Jlw==
=iy07
-----END PGP SIGNATURE-----

--eqTWI4KoB6hCpE4i08WK2YVUBY5PjloZ8--
