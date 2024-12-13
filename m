Return-Path: <linux-btrfs+bounces-10345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB55D9F0843
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 10:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A674F280C8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074481B3934;
	Fri, 13 Dec 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GmlML6Zb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFC1B392A;
	Fri, 13 Dec 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082969; cv=none; b=b0ENV8F//ZqecvnbW6i5Nfjvfp0AZDl/itgRQRY9+7odOiKq65KJYA+fba88CIbHsvrFzsnYkFj4QsW0MMF8OiGwwTGRGx2t9FXscGTBJ4M+Av1i2zcbYr2dILpu5h8mbE59GP6jj3HpVbOFKX3vi9XvxgHJkieLVrPBGX/Amw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082969; c=relaxed/simple;
	bh=LKYBh8tB3GdkUub2WFC5B3syIAsSYO20HZyWKU+GOBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsbV5C6EqudABC6IpNsaOHPTKZvYsv2UXcfMS9npkEdckMoqfJOimjdehqecxu60evSchKyweRusOoUdvwVXrewUXCd7Wyomyw7NaFlvJlfVBK76y9ntFXF2bhB3weUfdfQ+O3hEzmVasdNUGif7HqvYFXhmY7vQXvbSzwtOCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GmlML6Zb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734082959; x=1734687759; i=quwenruo.btrfs@gmx.com;
	bh=wYEr/0qKZ4MfDYVidLAacKgsym7J8vcjzMf/S0OmkaE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GmlML6ZbZc7RnHjU3FPh3t+yMOhDQ+qmWFr+FimW1LYOBbg3XLjQZoqOOGYFMg5E
	 nFmhi64Ltnzl4U/U0/8m/oY+xHiLktgqo4/pmdw9CnVB2NEGR3Jw1fHLDiNl4XfHB
	 u9K37vkE+8zVozQifkGGvFyCSN6rkoEAW618Z9MMpteQNVO/vP7xruK4aiijWZ+4k
	 XtT3j19tAFp5EmM5CLGsRvIHggVRjGLfz5mbSfcqDFndU2FEEEEm5ZUnOmNQIwXHK
	 aWpekWAeFDoBx1+Df9jvrN2SflXqUvgbbkduHicTP/nyQFuO1ldIx5xVYuj9qFp3I
	 kZAMqKcoetEIRpKRfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvPJ-1tCW672an7-00KW5Q; Fri, 13
 Dec 2024 10:42:39 +0100
Message-ID: <9a4bddb5-db55-487f-ada1-d2c0e56b0c77@gmx.com>
Date: Fri, 13 Dec 2024 20:12:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix avail_in bytes for s390 zlib HW compression
 path
To: Zaslonko Mikhail <zaslonko@linux.ibm.com>, Qu Wenruo <wqu@suse.com>,
 David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 linux-s390@vger.kernel.org
References: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
 <85bd7f9b-d9de-46ce-bda9-e7f2db31b8d6@gmx.com>
 <22b856e1-39a9-4926-b3b7-41147519d2da@linux.ibm.com>
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
In-Reply-To: <22b856e1-39a9-4926-b3b7-41147519d2da@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/2xS6T/s+LWWOD4NsJxvbHse5xMWdbbflm7VVpAS2OX+EWecGrm
 HW1mzfLAwztOO2pSAZ5NXKdXWikZPVvVJSS7IKWbRhVoop4HyS3hxb0K0OuigvUZkSABufF
 5w/x3D4CDLYa4HJJAb//0CoNP88WfWAoQyfQQ46mcd3YanAMOHmg/KBSWAl1fVWjw48uKtY
 dYzXHJdyw2vsExsNSXiyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XutC0S2g494=;POYPv2UZB18uInpbjsxkSWvsHRO
 1yFCGHvVz4FKMoM4wVHrUO+lS9ejNtitsg5Fh2tDcBdsIwBJ7tvXgdx6CbW4vllVI8JoukOCW
 VslLxtGJzktyV4RMxfO6mmcsgXZI+lEN+qLCLYFUkt+4FYs0drc7t98oG7Ud8u51FdVweBLzd
 8XWrtoGcJ9X9+Z1tqWuhtwOuAT7i//jlbAhMd657nn77es+yREoUJDldGhaMnpLDCrl7/AGHs
 lnFzUZ3dusZHSBYtskpBagEyhIuBV2Lx2gxP44zEeyNc65mmnf6ktDHcuRWDOF/Fw2OmxGfjS
 Snazzvh9BHgsgD+CzUEZpSHaQIm27XWxIiETbaD9ZI8AezdOYBk3xXT1TaHoUpkLjL2LY6+2r
 ObU6UWiuzp+kCSeE8/PeaYLgQ4tqeAnzYznXZI+n7Uj+QcYnarY5qstiG87X+xCNkkbgWLoP+
 vAoa+YdndIjSKF8heB/WawR8jHke6G/KlqYlVEaaz1WFVbSSkkdm4pncjzPJWU6GFyXAc5i3E
 /LuIbhP6i01GgJgsLlsUmJVLe7lAzGv1mTNSn6Efk4if0aJ1bKBUP+T/r9OaMNoSppxIGeUxy
 NkO8VgGbKOm4rY3lYZ3HavTo83psGrkb+P0hrLSzsecvlRtiAunaMo0LbnsKs2p6AmMuSBy3W
 HjB6lt2xmp9idrmK7AV9JCjW99Y0CH98O94SjR/ILnJb6/4U37DAneV4DDL5FULM+25euXidK
 pIL7B4qz4eJaum5aRJJyMyDJXDGs10Vs42GCiaxkEE0SCccWrc21w8RwYtbH1DU5aKRrEx14I
 y79VdJqnx8DozoDQde0bOK7xy4JIiw/MR3scfCiQ7SWY50u4l9xjtCzPtYCpqnZXIcUFtlYJ8
 EH4eRfCCO0J9OfXPq1/JD35HKVdulJkZ6FZB8vbLpCt5+P9xPetmlp+d3P2x9IN3olOeszV8t
 +a63YAFcBc93514RPnhWJR6mOQQke7ih52v+LDH9xqj95fizw2GhSClNN1VrAle3U7pM4DjTS
 Wbj3d6rywtOf7dUVABy+5HgbN4B4v8eNfj0juzJHO6Vvy9s/csE3yKY5ZzANtzwe/fBkXkxJd
 tJM0m9mNFcLjBlKHcPkXNgoG3HwaU1



=E5=9C=A8 2024/12/13 20:04, Zaslonko Mikhail =E5=86=99=E9=81=93:
> Hello Qu,
>
> On 12.12.2024 21:37, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/13 00:20, Mikhail Zaslonko =E5=86=99=E9=81=93:
>>> Since the input data length passed to zlib_compress_folios() can be
>>> arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE may
>>> cause read-in bytes to exceed the input range. Currently this triggers
>>> an assert in btrfs_compress_folios() on the debug kernel. But it may
>>> potentially lead to data corruption.
>>
>> Mind to provide the real world ASSERT() call trace?
>
> Here is the call trace triggered by one of our tests (wasn't sure whethe=
r to include it to the commit message):
>
> [ 2928.542300] BTRFS: device fsid 98138b99-a1bc-47cd-9b77-9e64fbba11de d=
evid 1 transid 55 /dev/dasdc1 (94:9) scanned by mount (2000)
> [ 2928.543029] BTRFS info (device dasdc1): first mount of filesystem 981=
38b99-a1bc-47cd-9b77-9e64fbba11de
> [ 2928.543051] BTRFS info (device dasdc1): using crc32c (crc32c-vx) chec=
ksum algorithm
> [ 2928.543058] BTRFS info (device dasdc1): using free-space-tree
> [ 2964.842146] assertion failed: *total_in <=3D orig_len, in fs/btrfs/co=
mpression.c:1041
> [ 2964.842226] ------------[ cut here ]------------
> [ 2964.842229] kernel BUG at fs/btrfs/compression.c:1041!
> [ 2964.842306] monitor event: 0040 ilc:2 [#1] PREEMPT SMP
> [ 2964.842314] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6=
 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct n=
ft_chain_nat n
> f_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables pkey_p=
ckmo s390_trng rng_core vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel d=
rm loop i2c_co
> re dm_multipath drm_panel_orientation_quirks nfnetlink vsock_loopback vm=
w_vsock_virtio_transport_common vsock lcs ctcm fsm zfcp scsi_transport_fc =
ghash_s390 prn
> g chacha_s390 aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha51=
2_s390 sha256_s390 sha1_s390 sha_common scsi_dh_rdac scsi_dh_emc scsi_dh_a=
lua pkey autof
> s4 ecdsa_generic ecc
> [ 2964.842387] CPU: 16 UID: 0 PID: 325 Comm: kworker/u273:3 Not tainted =
6.13.0-20241204.rc1.git6.fae3b21430ca.300.fc41.s390x+debug #1
> [ 2964.842406] Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)
> [ 2964.842409] Workqueue: btrfs-delalloc btrfs_work_helper
> [ 2964.842420] Krnl PSW : 0704d00180000000 0000021761df6538 (btrfs_compr=
ess_folios+0x198/0x1a0)
> [ 2964.842426]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 =
PM:0 RI:0 EA:3
> [ 2964.842430] Krnl GPRS: 0000000080000000 0000000000000001 000000000000=
0047 0000000000000000
> [ 2964.842433]            0000000000000006 ffffff01757bb000 000001976232=
fcc0 000000000000130c
> [ 2964.842436]            000001976232fcd0 000001976232fcc8 00000118ff4a=
0e30 0000000000000001
> [ 2964.842438]            00000111821ab400 0000011100000000 0000021761df=
6534 000001976232fb58
> [ 2964.842446] Krnl Code: 0000021761df6528: c020006f5ef4        larl    =
%r2,0000021762be2310
> [ 2964.842446]            0000021761df652e: c0e5ffbd09d5        brasl   =
%r14,00000217615978d8
> [ 2964.842446]           #0000021761df6534: af000000            mc      =
0,0
> [ 2964.842446]           >0000021761df6538: 0707                bcr     =
0,%r7
> [ 2964.842446]            0000021761df653a: 0707                bcr     =
0,%r7
> [ 2964.842446]            0000021761df653c: 0707                bcr     =
0,%r7
> [ 2964.842446]            0000021761df653e: 0707                bcr     =
0,%r7
> [ 2964.842446]            0000021761df6540: c004004bb7ec        brcl    =
0,000002176276d518
> [ 2964.842463] Call Trace:
> [ 2964.842465]  [<0000021761df6538>] btrfs_compress_folios+0x198/0x1a0
> [ 2964.842468] ([<0000021761df6534>] btrfs_compress_folios+0x194/0x1a0)
> [ 2964.842708]  [<0000021761d97788>] compress_file_range+0x3b8/0x6d0
> [ 2964.842714]  [<0000021761dcee7c>] btrfs_work_helper+0x10c/0x160
> [ 2964.842718]  [<0000021761645760>] process_one_work+0x2b0/0x5d0
> [ 2964.842724]  [<000002176164637e>] worker_thread+0x20e/0x3e0
> [ 2964.842728]  [<000002176165221a>] kthread+0x15a/0x170
> [ 2964.842732]  [<00000217615b859c>] __ret_from_fork+0x3c/0x60
> [ 2964.842736]  [<00000217626e72d2>] ret_from_fork+0xa/0x38
> [ 2964.842744] INFO: lockdep is turned off.
> [ 2964.842746] Last Breaking-Event-Address:
> [ 2964.842748]  [<0000021761597924>] _printk+0x4c/0x58
> [ 2964.842755] Kernel panic - not syncing: Fatal exception: panic_on_oop=
s
>
> Let me know if I can provide any other details.

OK, I see the reason.

In compress_file_ranges() we initialize the original length according
the i_size.

The behavior is different from non-compressed write, as non-compressed
write is always sector aligned, for unaligned i_size, it just zero out
the remaining part and still submit the full sector).

Please include this call trace

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>>
>> AFAIK the range passed into btrfs_compress_folios() should always have
>> its start/length aligned to sector size.
>
> Based on my tests, btrfs_compress_folios() input length (total_out) is n=
ot always a
> multiple of PAGE_SIZE. One can see this when writing less than 4K of dat=
a to an
> empty btrfs file.
>
>>
>> Since s390 only supports 4K page size, that means the range is always
>> aligned to page size, and the existing code is also doing full page cop=
y
>> anyway, thus I see no problem with the existing read.
>
> The code is doing full page copy to the workspace buffer for further com=
pression. But the
> number of bytes actually processed by zlib_deflate() is controlled by st=
rm.avail_in
> parameter.
>
>>
>> Thanks,
>> Qu
>>
>>> Fix strm.avail_in calculation for S390 hardware acceleration path.
>>>
>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>> Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage compa=
tible")
>>> ---
>>>  =C2=A0 fs/btrfs/zlib.c | 4 ++--
>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>>> index ddf0d5a448a7..c9e92c6941ec 100644
>>> --- a/fs/btrfs/zlib.c
>>> +++ b/fs/btrfs/zlib.c
>>> @@ -174,10 +174,10 @@ int zlib_compress_folios(struct list_head *ws, s=
truct address_space *mapping,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_page(worksp=
ace->buf + i * PAGE_SIZE,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data_in);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start +=3D PAGE_=
SIZE;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workspace->strm.avail_in =3D
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (in_=
buf_folios << PAGE_SHIFT);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workspace->strm.next_in =3D workspace->b=
uf;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 workspace->strm.avail_in =3D min(bytes_left,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_buf_fol=
ios << PAGE_SHIFT);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 } else {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pg_off;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cur_len;
>>
>


