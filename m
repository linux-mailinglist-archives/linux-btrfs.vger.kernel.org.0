Return-Path: <linux-btrfs+bounces-13200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F401DA9571B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 22:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298A3165656
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10021EFF92;
	Mon, 21 Apr 2025 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="j8jkJBSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040D10F1;
	Mon, 21 Apr 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266639; cv=none; b=DQYoTWH1JYQNr14vbs8XD/sRhLAErEYOehtNasa2i1pO+ztYPndicBbbWfpt5H+Vp1xOlXxQ7oj+4eJzu7wwBc/KarFFBycDaIX4SgG+DYdrOS0fwAgQLMWwSEn4Q2IXf+yBvrP84CWdFPoPQjmterp6ZILOdcvaVHM4ptxUNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266639; c=relaxed/simple;
	bh=Q/JAEWtzrgPzsySDi9rjzrBEpzZN8sRk3LTMHNObWBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uX+MdZQdrCddwCZs5cQtYkennU2RrfBy9RCvVI1ofPLXOat3PaytzEA3V5/F3mIy1hvdaiqkdAnS46gOPjvNs9sDs+16y5nILinCD1ERSQsQlectzVFXlztSbYy9si04QgttW5pSMjVinGk5RRBeQ8cZGekD7wYWqL/Yzzxsh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=j8jkJBSB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745266630; x=1745871430; i=quwenruo.btrfs@gmx.com;
	bh=fQW7XXs8y5xosVijb4GUfpe4+jqmCK2wYk1FWoenksQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j8jkJBSBK7HwC1PHLYxBrelMUb+Qp0kN6WrQBgM/taSRJmiEHTDenkDopp6vD9jr
	 ekr75KO1r0cAWfyt+XD6Y006eOKxRXdNMCSdrPxo7QVXfVRj9W5yYmP1hWgqzhc7/
	 x1zrA3GWJ4Yn8sqQNw3RDf5hpq+WoyZtUZZ5/u/LyKX7i8wtOsdIFHXo0YQoOi3h2
	 af36CjeUBWb66dfafeahQIRhyYrpP2ajVB8+cP0SxL/RRTMQy/sx6QJW2j8iiE16i
	 3joLXcTlCcChcSR9YHe6Y4AOQqg4clO/PZnVXBr6hlLZx3Iwg3n2kSqXubq4gB2ge
	 gBdkmh94osuZ5RaQSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1vCncs3mQ7-013gkQ; Mon, 21
 Apr 2025 22:17:10 +0200
Message-ID: <1ffd7ba1-8e81-4dbc-8ff0-a2c376b7ffed@gmx.com>
Date: Tue, 22 Apr 2025 05:47:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: stable@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1745242535.git.josef@toxicpanda.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1745242535.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtjcZoFgNu4X0avslzADnN8jG68cAo58LSq6lwUYbswNspUKw2I
 YwpT/fpl6fgpCJhLFI10bfsTQjwiKKfkFQkPipl6pcvAkyduR5rNMFegQ80KpyzyJMuq3p9
 tmxl1AfQ0XH658MbwdPFu451emdIaa9buA3ssQs6xdQawk2RXHiQ+73S33EgHKa4lp575v1
 CGNdppF23tFN/UVZPNZ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MvaGr4aeg/w=;20wsCWRxriNW1pxtrjoOCjiqD/6
 L8mbs2MSitF9Npuo5Ir4CBRwKVJU/HO7b/r3J/WaDkOnhauoD4mE2BnJrVtJpF0Qo3xMtlSHT
 nnuP7gZvmhPelyQcCPxEhbfky/id0wfaj296Wvp2Lrqh3Pgv9Q40HLqwAz0N9llycmag6D6j5
 W+bMIu1y5ICAfiCYkK4sNWli9o83TqIcKRF+1c9ua76Zd57KCh9AlX6+oBuFuiSMZOOoBswGa
 gWajLYHlC885jIqewQo1G5WqFhrCFG+CsYwG/gYchWjg9D8OCPDztBRH4E22CuIjz1H4AYuMN
 xJEN2XNAmBG4vwR0yRC7i2pgTp5pD3mRgh9vr3XJP7Cf6dy8BAGzhnwXPyq3yZE+BKHfpCGMa
 acS2USc0ctlmphYTwNILLUpSAdy5SxkJ7rzkJDnxnJxZhPQrehn9/YHm2mDEP6wTSJbCfDZPW
 unvuFR/4aTuDHR68vi1jTKLMjn0qfpJ5C5Pv4n/ixQRnoT4MW50Ngi9bjoR/M6VSIQInZ9UBV
 SxawVvt1+nCN+aPxzMstqMoJsbFognFBG/FpiBKjyCjSjSLhzrvzTDhgpcJ1B0ssbY2r2e4Jz
 i2QWbHBD5+UNy73/jpt0Pd/Bxj44N6toPMgKkyJF1rn32sw1UIFSsh1CmWAvpQsLpCgZY7pDp
 o25A4EQPb1O554as/Hb9tJdB8BJk69BMaCywlToA2wuGySpASm45zC4tQN3796x2DasQimoxG
 eOxceSs2gakULKsdUF/ZFDkjJutSe2WrZXYYx8VB8gF+5Fpy/5zuF05iU6sWzBbpCU1BLYFjT
 Xm9vcI+BrWNiEf3TJM95H7ud2QadOB+9JG3H/EOjrcshPncvzXbXkSv8Qhz3GpW9/sF2xVxAy
 fniPUS/Ux+lpcPcv+Xg3Ork1szThjMiFRq0AdlZFK/nygiecAae/xWcIXLOjVwBmnZ7HzgiYm
 1IILVfJ9Sreac3MvnEv6eOBfr65Yi2IgzXC8o/IJBMyH02nqpSEQp9oP0ULxfRpIEB7l3610m
 6+iIwI3Xwh4TMAU5RUg5Bd/eMZxb2K9ykuAdxHI4GumMHvtMNjzPi4RMMPaym4YunHqoWqiXY
 6stZoCQ9/kRQhdcJAEPgJgB/EjfbxJjz8MNdJtw1jfIpEZZOe5ntG6lntx5Zi1jeigJ+KNLEh
 bSjuxhD57hT3cfxPOMp/+VmYuwxQoMUz5QV0pcYo4ef9+TIwqXn9ZY3TKuLgUAyjbFovRjgBj
 kfb0FeJAgzTVAyy3okQbm5kA2Z6sC8iOvtHVmnkILDUOcVKQwicvCqW1lx26sK1Aa6sITuGwo
 HSDsfIF26INRFESKB6XaCy9IKpLP4Wp6/VH/2PvW5FofgyvWwKL95fzP5AzQN3M+1TCuq2jJT
 pAtyC3OTQ1LHRCne/Ri+/wMaOA/K0MsKkXfaLR4qqGFcS1LRDwwhT/3+40g+oRxPgKV3ToqWJ
 E51HOLjrWze/+LHr7M3HIJSiTBE38PGyHgd8z7U/Tlhbcwhu8pgGsv9txR6X3BDVBNk44oo8s
 5tdou0x3v4QhfW6Tf2BHZAkk+vwk9dOwYgKHJ3+s3o15gL70nNv8UFqm51ZK/yL6nvg1p/0z5
 clWXnCebweSOrP/WkOo3m0DDp4nQjbPS6TNCSE0M3ZRlCbbN3D1COWICewQ/NCdn/wXGHfgAH
 ATvrwUAjeeJpUNN7KYy8vdb0aK/OJ8mv2adgTEDXEBX4JIjvv2pja/c/PnEXr1d9Rj58bzWmC
 UHl/wkWJKxxUj922itM8UPDmUVULJuz/UOpmWunhM2oknpDIhw5Y727xNnf/+qxMh1YSXvXEi
 QQidFOE129jiFT8jotDcwhEXmPuh2zP00BPwe9xN7bdQ4BiyuZCqalPNOu7lQokanFa3ZE/UY
 JInLuU+kdxrqV6oJugAv/s09szLEiOQTMzTtT1ak/YL9ib4o3NLzW68/cfm9nhvlCp0wlxluH
 CPuvM8hH0/hwA2PyxZ8ptziUb4BsZclqyr93AwiA9T8KyoSx6PS+Q7IH1OeEBnMOcqTXOMGjQ
 d37p7t7c9oS+9o5M/hZQRNwnnbVmFG9IES4diZ3Q4gHUrDCX91L7uedkLxyd43DryE9qlRRQp
 rRrQZ4EXfAhxnyF5f99IUqM4QvWrjRUjA2jfdEe36FH5qto7ppbZ8oZIpDJw6VKCv7U+Sg09Y
 febbc63sCTAe4Wfse5zHbfyfl1fVernljAO1zoWcD7OaqsXL58/Pib7yvTdck/NbD7PmZMYkY
 tbq4UV/n9Aa43/vRS3NU/vSMx5Ne4Z2Nz3lta2hKNls/KbZb3lIpdPhATl1ESwRHkw26eMQT9
 Btl6NHtYMQPewGgG2SsWonuZeAyzZg/g6+e2zNdAeQZeDdzEUkOf5VcHhCvP0xjCRer3WDJdy
 6Edkc4HRE/OZAs+oat7QAS2mpGaph7Vt7Btcj2YQ0TQMZZZZkVw9Cln0cxq6cz8MDwmVeTS9v
 9FAQQKecKlaVj6Sr55fj0ZuraKlCy1kms4OPCu0FmTYq7HrQXu4UtH/NKVmYvuXaSPd06TeY5
 PYGeHepMmNFyqF/FiQaZSzKFLH8LQMHUjEie20s/C+GgeXahC6SgG+kwofM2yzsBnorUjhbyE
 HaObhFJNRqmbPYRrF7ubIbPXKomFzDgqy3OXee8I6pTToBQXJthtcAIgJnwX05nLOJ/brrWo1
 rndpVuz/xj4aSQq/05EqMwFuECKJkksY/IUhkv8j9H7qkLlq/BK13B5EEygL1GLaqbmJ7a0Gr
 QRvemf1CFRMbujooggiMHNa/RJmHfvIqGVsj72Av5l9UVCI5vAkMdCvFG2tTGwmRqsbJ2XkDb
 4mfAt9H3lFjZD1WDyn9NR14O24OiUlthqGm2z6Lel8piWntDrGk7NXLQ4H/Ab0b8hmTb4UmYj
 /BnSfMZCIn3Pfswv0l/2sS8sPCNQIbct4D2TtMGRt78auF9uRVyDKveLBki4RgcL92d68h5j4
 tfKtUh3jjavl62zk/Mhkp2uR0A4WWHdnGexqS50pfFzhV42iVsrP



=E5=9C=A8 2025/4/21 23:07, Josef Bacik =E5=86=99=E9=81=93:
> When running machines with 64k page size and a 16k nodesize we started
> seeing tree log corruption in production.  This turned out to be because
> we were not writing out dirty blocks sometimes, so this in fact affects
> all metadata writes.
>=20
> When writing out a subpage EB we scan the subpage bitmap for a dirty
> range.  If the range isn't dirty we do
>=20
> bit_start++;
>=20
> to move onto the next bit.  The problem is the bitmap is based on the
> number of sectors that an EB has.  So in this case, we have a 64k
> pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
> bits for every node.  With a 64k page size we end up with 4 nodes per
> page.
>=20
> To make this easier this is how everything looks
>=20
> [0         16k       32k       48k     ] logical address
> [0         4         8         12      ] radix tree offset
> [               64k page               ] folio
> [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
> [ | | | |  | | | |   | | | |   | | | | ] bitmap
>=20
> Now we use all of our addressing based on fs_info->sectorsize_bits, so
> as you can see the above our 16k eb->start turns into radix entry 4.
>=20
> When we find a dirty range for our eb, we correctly do bit_start +=3D
> sectors_per_node, because if we start at bit 0, the next bit for the
> next eb is 4, to correspond to eb->start 16k.
>=20
> However if our range is clean, we will do bit_start++, which will now
> put us offset from our radix tree entries.
>=20
> In our case, assume that the first time we check the bitmap the block is
> not dirty, we increment bit_start so now it =3D=3D 1, and then we loop
> around and check again.  This time it is dirty, and we go to find that
> start using the following equation
>=20
> start =3D folio_start + bit_start * fs_info->sectorsize;
>=20
> so in the case above, eb->start 0 is now dirty, and we calculate start
> as
>=20
> 0 + 1 * fs_info->sectorsize =3D 4096
> 4096 >> 12 =3D 1
>=20
> Now we're looking up the radix tree for 1, and we won't find an eb.
> What's worse is now we're using bit_start =3D=3D 1, so we do bit_start +=
=3D
> sectors_per_node, which is now 5.  If that eb is dirty we will run into
> the same thing, we will look at an offset that is not populated in the
> radix tree, and now we're skipping the writeout of dirty extent buffers.
>=20
> The best fix for this is to not use sectorsize_bits to address nodes,
> but that's a larger change.  Since this is a fs corruption problem fix
> it simply by always using sectors_per_node to increment the start bit.
>=20
> cc: stable@vger.kernel.org
> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a s=
ubpage metadata page")
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I'm still a little concerned about unaligned tree blocks, but=20
in practice there should be rarely any converted btrfs from v4.6 era=20
that doesn't get a full balance and still be utilized.

So let's get the fix done and backported first, then reject unaligned=20
tree blocks completely.

Thanks,
Qu

> ---
> - Further testing indicated that the page tagging theoretical race isn't=
 getting
>    hit in practice, so we're going to limit the "hotfix" to this specifi=
c patch,
>    and then send subsequent patches to address the other issues we're hi=
tting. My
>    simplify metadata writebback patches are the more wholistic fix.
>=20
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f08615b334f..6cfd286b8bbc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, =
struct writeback_control *wbc)
>   			      subpage->bitmaps)) {
>   			spin_unlock_irqrestore(&subpage->lock, flags);
>   			spin_unlock(&folio->mapping->i_private_lock);
> -			bit_start++;
> +			bit_start +=3D sectors_per_node;
>   			continue;
>   		}
>  =20


