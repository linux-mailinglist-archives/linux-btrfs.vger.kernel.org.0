Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABB02967D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2019 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbfEXLCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 May 2019 07:02:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390540AbfEXLCG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 May 2019 07:02:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFF76AFE1;
        Fri, 24 May 2019 11:02:04 +0000 (UTC)
Subject: Re: [PATCH v2] fstests: btrfs: Validate that balance and qgroups work
 correctly when balance needs to be resumed on mount
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190523011101.4594-1-wqu@suse.com>
 <20190524090205.GN15846@desktop>
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
Message-ID: <d539cf23-f9bf-7b82-6919-46512195a9cb@suse.de>
Date:   Fri, 24 May 2019 19:01:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190524090205.GN15846@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV
Content-Type: multipart/mixed; boundary="6qVQhlPrTJwvkGAkCZVnMDP0UddY4Mv49";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <d539cf23-f9bf-7b82-6919-46512195a9cb@suse.de>
Subject: Re: [PATCH v2] fstests: btrfs: Validate that balance and qgroups work
 correctly when balance needs to be resumed on mount
References: <20190523011101.4594-1-wqu@suse.com>
 <20190524090205.GN15846@desktop>
In-Reply-To: <20190524090205.GN15846@desktop>

--6qVQhlPrTJwvkGAkCZVnMDP0UddY4Mv49
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/24 =E4=B8=8B=E5=8D=885:02, Eryu Guan wrote:
> On Thu, May 23, 2019 at 09:11:01AM +0800, Qu Wenruo wrote:
>> There are two regressions related to balance resume:
>> - Kernel NULL pointer dereference at mount time
>>   Introduced in v5.0
>> - Kernel BUG_ON() just after mount
>>   Introduced in v5.1
>>
>> The kernel fixes are:
>> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
>>  dereference"
>> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
>>  avoid BUG_ON()"
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> The summary seems a bit long, does this look like a proper summary to
> describe the test?
>=20
> "btrfs: resume balance on mount with qgroup"

Wow, that's short.

I'm OK with that.

Thanks,
Qu
>=20
> If so, I'll use this summary on commit.
>=20
> Thanks,
> Eryu
>=20


--6qVQhlPrTJwvkGAkCZVnMDP0UddY4Mv49--

--qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlznzx8ACgkQwj2R86El
/qgjMgf/dJpUSL9OUUsVR6jfSFS4RYp4x1YzCFinUh/DmyteXRsyOay8cddgYdB9
LTw+pmbcdmNARKlvLTZfLHovA/DV3LjCOBZ4heztcAuQUx13WHWFs4EQ3lujkAYd
rhdqBbjTdMTvBWdAMIwpbGCa4brnmrHBfna2GTob57Ms73KD1yijZHshyrPTjjTm
N+rDtq6eEh+5qSoV/UMO3QQUs1E97lJg/fveMaPQ4V3iTL+gMqinTXesji4s5PUR
pzC3rKf1lOpTvZAO1KyTKLfFfsPppgDfclcbrQEWyxh5F/xtNVa4lrIGy6XsL43j
3eBpousNuUI3aFqntyMtmXYDofvyCQ==
=mWk7
-----END PGP SIGNATURE-----

--qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV--
