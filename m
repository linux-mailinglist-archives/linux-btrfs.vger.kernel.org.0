Return-Path: <linux-btrfs+bounces-1664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5911839D7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 01:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34FC7B2803D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 00:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995D368;
	Wed, 24 Jan 2024 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uY1WuDBe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26B17F3
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054849; cv=none; b=oh1KvLbyT5JjlaNnTK4pKaclx/jPMBvbB1hLrftepmb7w4g9ttjxmy5I8rVCaRj4sMqcGzRDUbt7eah90cqgDNFVaPmnQz9sCMVU27ipWiqd6j9aNYsiS5PvpjyhmdFKjEl+nySOW3vFTniTnZZP6AeP6yM5QPgvou7fgD3Yaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054849; c=relaxed/simple;
	bh=czV1uAGfxA9+Uh6bSTjoGyyWtG26S81goR2ck3TqZQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmOgprVC7N6w2qo6+kBaN08IUwV7GpfGV3EnLGM9wZXLznyHFnPPR77qX+F0qu/hiOhptAJEjKfKLHnZQCifwTv0HRa6yZC+N4fjWzrJgbeJ5NX6oHIVuMKoayFpFuyncbnDmrWVcyG/2+gdzpGn7IN4FPhYIW2YMKP/0Q9vBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uY1WuDBe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706054835; x=1706659635; i=quwenruo.btrfs@gmx.com;
	bh=czV1uAGfxA9+Uh6bSTjoGyyWtG26S81goR2ck3TqZQQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=uY1WuDBeWcjHFiXjUBcIbETm7XLr8Ex9GDkL5J9XaJWT8LWCtqjOGYCym9gW5CFG
	 GyvzzoCMMCZShZrntTtrZxIt7JgaXhoxjImVYR3U8toCtuoMcBEJZE0XgGmeNZ7yc
	 i8Ma5cYK9ff10lDnr0G6AqA12iLYZWeKhsljjZVmR9fc4tmuGA3uR3XMrAryi1I2d
	 h4Fs/Z1uNTrRiZz+qw1MG9y01Yj4Mx4ZaWQZsFQBLq9NPj/zZP8f+AcCDmgA3X7Si
	 zU68RsSOf6pqU7spbsd7JuniTjOznP8xejRk3pi75BisErKeuLwT2MMSHKKtN1HEc
	 ecd1QVyeF6cVg0fnqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmjq-1rdxOb0iRm-00TF3C; Wed, 24
 Jan 2024 01:07:15 +0100
Message-ID: <b12560b9-0fa6-453f-9bcf-94f06371031c@gmx.com>
Date: Wed, 24 Jan 2024 10:37:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: zstd: fix and simplify the inline extent
 decompression
To: Neal Gompa <neal@gompa.dev>
Cc: linux-btrfs@vger.kernel.org
References: <c3bed652c4e20c8a446fba371d529a78dc98b827.1705978912.git.wqu@suse.com>
 <CAEg-Je_OygqAdFoAV02PK8zaZm_4HhkvLz8-FQEK6ZnodYst5w@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAEg-Je_OygqAdFoAV02PK8zaZm_4HhkvLz8-FQEK6ZnodYst5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4qcGPlcn3J1X1SACKXAdKPjBpQHVMKg+Dt8anJSmc7TbpE9X72d
 BIpUqK70KHYuEWG+6bpXwF7zt0/m3tapg86ORWpylguQwSz116gQnmGhfDfkyli1/wu6p9e
 qzs0oTEWMpeE5YA5/mv04eviaFKvvv0CH4E1pYBAxa7irjQEp3JcaCyoeGkR5v0MAi16dZa
 1ywIUZS/HeWparzOWA+Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y8DNbdBtDeg=;OQ7tvkblC7kbcDnEvZiRQ6mvXlw
 8PHy7pt6Sf9IuOpaOyG1cYVBcZ2Ns3dHY8wphV114nIQ4/ngw09+bM7ik3GDJA+OCsJLKJ2wC
 IvIvAemFQdsTGhOH9irJxWKm68VuLHvFT4DTbzYHskBvY1f9WjQ/zXU2O/Il5EkZO8WEjWYeD
 jVHjfz7Wn9CTDNTDAAaIPrLG83yzkF6nYFySHvEVLAdbD4hAcFaFDbf21kSnvBfbHYvrSbtYH
 0SWbu0Vjr604HJMKuUknhC7aqtwXdKvOtwPqrcveo6+SoB+YUZs2iXeMqzZd5vu5YytpQBAnu
 X58+ACAFWi9tGlKckKpHypycGx4a7SMQZY2l2kaoVlrGOuu49QDD/rqg7zio8r/qqpiXyKhaf
 oDfHiuH6T1AI6cWyTmh3rqB4siqswzxE2JHxkTDzgjvT0RUuNvisvnkMCkdY3e9vp0NQg8QbC
 p2BO2GkODtKZj/EVYIEsIPz2SioV25lw9ohrDQLo0Wo66ed3vvH7cHWyDCCM+SO1flnwrCd/c
 TvR/YFK0T1ObacgP9erqKlWZD5zi5uaUFdhbn0e3u01tsoP7ePud7qBmGG2fTDjfXd2/SXD1t
 VxZTQchSt3tzTXNP2s84guuf1xen7m/esd/RHisCx5rzIbGIDNLGLduqhwZ4y2dJRlZCuZoQH
 +4ONy4iwJavJjWdzfXMyMhGG3niWEGlboP5ZBeJJOPYzQ16uSUoFo1Pe2CTix3c/s2si/fCqL
 +POIgSNOJ0YfO8F4BIcxINYxmmX5KG7X7kYad2hlRNuI17Nf5f1mbUwkudFbtL4gn7Kh/DzGI
 WVX3+dUeYohYl7MxynU6t8F0tosCq1iybRAlFPjPX2tTPZFdPBa6xTWr1txBcfyhsOo54RoYB
 Ojwd5QE+X3OQghOiCDKHFxMda4IHmEJ9gQC3VEeBPWae+7U/Duwf7ZIE0dHAiYbcx9HSYg3sj
 60cM9lDzSci5Dbpydaan8RersuE=



On 2024/1/24 10:19, Neal Gompa wrote:
> On Mon, Jan 22, 2024 at 10:04=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> If we have a filesystem with 4k sectorsize, and an inlined compressed
>> extent created like this:
>>
>>          item 4 key (257 INODE_ITEM 0) itemoff 15863 itemsize 160
>>                  generation 8 transid 8 size 4096 nbytes 4096
>>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>                  sequence 1 flags 0x0(none)
>>          item 5 key (257 INODE_REF 256) itemoff 15839 itemsize 24
>>                  index 2 namelen 14 name: source_inlined
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15770 itemsize 69
>>                  generation 8 type 0 (inline)
>>                  inline extent data size 48 ram_bytes 4096 compression =
3 (zstd)
>>
>> Then trying to reflink that extent in an aarch64 system with 64K page
>> size, the reflink would just fail:
>>
>>    # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
>>    XFS_IOC_CLONE_RANGE: Input/output error
>>
>> [CAUSE]
>> In zstd_decompress(), we didn't treat @start_byte as just a page offset=
,
>> but also use it as an indicator on whether we should error out, without
>> any proper explanation (this is copied from other decompression code).
>>
>> In reality, for subpage cases, although @start_byte can be non-zero,
>> we should never switch input/output buffer nor error out, since the who=
le
>> input/output buffer should never exceed one sector, thus we should not
>> need to do any buffer switch.
>>
>> Thus the current code using @start_byte as a condition to switch
>> input/output buffer or finish the decompression is completely incorrect=
.
>>
>> [FIX]
>> The fix involves several modification:
>>
>> - Rename @start_byte to @dest_pgoff to properly express its meaning
>>
>> - Use @sectorsize other than PAGE_SIZE to properly initialize the
>>    output buffer size
>>
>> - Use correct destination offset inside the destination page
>>
>> - Simplify the main loop
>>    Since the input/output buffer should never switch, we only need one
>>    zstd_decompress_stream() call.
>>
>> - Consider early end as an error
>>
>> After the fix, even on 64K page sized aarch64, above reflink now
>> works as expected:
>>
>>    # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
>>    linked 4096/4096 bytes at offset 61440
>>
>> And results the correct file layout:
>>
>>          item 9 key (258 INODE_ITEM 0) itemoff 15542 itemsize 160
>>                  generation 10 transid 10 size 65536 nbytes 4096
>>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>                  sequence 1 flags 0x0(none)
>>          item 10 key (258 INODE_REF 256) itemoff 15528 itemsize 14
>>                  index 3 namelen 4 name: dest
>>          item 11 key (258 XATTR_ITEM 3817753667) itemoff 15445 itemsize=
 83
>>                  location key (0 UNKNOWN.0 0) type XATTR
>>                  transid 10 data_len 37 name_len 16
>>                  name: security.selinux
>>                  data unconfined_u:object_r:unlabeled_t:s0
>>          item 12 key (258 EXTENT_DATA 61440) itemoff 15392 itemsize 53
>>                  generation 10 type 1 (regular)
>>                  extent data disk byte 13631488 nr 4096
>>                  extent data offset 0 nr 4096 ram 4096
>>                  extent compression 0 (none)
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.h |  2 +-
>>   fs/btrfs/zstd.c        | 73 ++++++++++++-----------------------------=
-
>>   2 files changed, 22 insertions(+), 53 deletions(-)
>> ---
>> Changelog:
>> v2:
>> - Fix the incorrect memcpy_page() parameter:
>>    Previously the pgoff is (dest_pgoff + to_copy), not just (dest_pgoff=
).
>>    This leads to possible write beyond the current page and can lead to
>>    either incorrect contents (if to_copy is smaller than 2K), or
>>    triggering the VM_BUG_ON() inside memcpy_to_page() as our write
>>    destination is beyond the page boundary.
>>
>
> Have we checked to see if this problem shows up in the other
> compression algorithms? I know the change was reverted for btrfs-zstd
> because Linus saw the issue directly[1], but I'm concerned that the
> only reason he saw it is because Fedora uses zstd by default[2] and
> this might be an issue in the other algorithms.

Already checked, and new test case is also added (which you have also
replied).

As replied in the other thread, zstd is really the exception.

Thanks,
Qu

>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3De01a83e12604aa2f8d4ab359ec44e341a2248b4a
> [2]: https://fedoraproject.org/wiki/Changes/BtrfsTransparentCompression
>

