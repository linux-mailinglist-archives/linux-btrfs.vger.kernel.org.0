Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755F42B75D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE0OPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 10:15:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfE0OPe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 10:15:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACDB6AD8B
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 14:15:33 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: convert: Workaround delayed ref bug by
 limiting the size of a transaction
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190527051054.533-1-wqu@suse.com>
 <20190527141030.GJ15290@twin.jikos.cz>
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
Message-ID: <5f555bfc-30d6-0d82-d774-d5eff51d0e7a@suse.de>
Date:   Mon, 27 May 2019 22:15:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190527141030.GJ15290@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VBHTsh9qWb7gwDenghQHUfIyjFhthCHM0"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBHTsh9qWb7gwDenghQHUfIyjFhthCHM0
Content-Type: multipart/mixed; boundary="eEUNnP0kxG1HgXBUicaA8R38wvSHTXaEh";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <5f555bfc-30d6-0d82-d774-d5eff51d0e7a@suse.de>
Subject: Re: [PATCH] btrfs-progs: convert: Workaround delayed ref bug by
 limiting the size of a transaction
References: <20190527051054.533-1-wqu@suse.com>
 <20190527141030.GJ15290@twin.jikos.cz>
In-Reply-To: <20190527141030.GJ15290@twin.jikos.cz>

--eEUNnP0kxG1HgXBUicaA8R38wvSHTXaEh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/27 =E4=B8=8B=E5=8D=8810:10, David Sterba wrote:
> On Mon, May 27, 2019 at 01:10:54PM +0800, Qu Wenruo wrote:
>> In convert we use trans->block_reserved >=3D 4096 as a threshold to co=
mmit
>> transaction, where block_reserved is the number of new tree blocks
>> allocated inside a transaction.
>>
>> The problem is, we still have a hidden bug in delayed ref implementati=
on
>> in btrfs-progs, when we have a large enough transaction, delayed ref m=
ay
>> failed to find certain tree blocks in extent tree and cause transactio=
n
>> abort.
>>
>> This workaround will workaround it by committing transaction at a much=

>> lower threshold.
>>
>> The old 4096 means 4096 new tree blocks, when using default (16K)
>> nodesize, it's 64M, which can contain over 12k inlined data extent or
>> csum for around 60G, or over 800K file extents.
>>
>> The new threshold will limit the size of new tree blocks to 2M, aligni=
ng
>> with the chunk preallocator threshold, and reducing the possibility to=

>> hit that delayed ref bug.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Added to devel, thanks.
>=20
BTW, this is really just a workaround.

The ENOSPC itself should be solved by patches: "btrfs-progs: Fix false
ENOSPC alert by tracking used space correctly" and "[PATCH 0/2]
btrfs-progs: Metadata preallocation enhancement".

The root cause of the delayed ref "unable to find backref" bug is still
unknown, but considering how large the transaction needs to be before
hitting that, this workaround should work.

Thanks,
Qu


--eEUNnP0kxG1HgXBUicaA8R38wvSHTXaEh--

--VBHTsh9qWb7gwDenghQHUfIyjFhthCHM0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzr8QAACgkQwj2R86El
/qheSwf/ePwbkvB6qg0wgyonkgs4xb8+YDrKhXoFiPSPkOrK0FODgBm73tGPg6ON
O/yFHFVdfPY1i7PCxQwULzjkCYYTD1p+CnkPaApsDK0XLLXOX7sILs6xNRGItRMF
52Ema5CcPshLrIKd+6io2t03JK1Avn93jabbXzyngac9V/2TTENhr7kfyxAVPbdB
3lGjGE28BXqksrfoGuF9Uen9CgHBsNOfoOid3ZjiymjbtXwu/Sw1addXnm0Vr3Js
UqdlLNQ+yvtT/DDGwlBjLRche7O//lPnwxqKc5sXPCuKLLRDlXYYVcAILYxrrZ4s
NVRr3bgrz2+U43X27oiutKdMa8kYAQ==
=r3kW
-----END PGP SIGNATURE-----

--VBHTsh9qWb7gwDenghQHUfIyjFhthCHM0--
