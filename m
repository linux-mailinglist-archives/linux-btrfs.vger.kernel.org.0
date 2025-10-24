Return-Path: <linux-btrfs+bounces-18320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DDC083B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 00:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4A4C35138A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EBB304BA8;
	Fri, 24 Oct 2025 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="frQ2ljfj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70123261B92
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761344120; cv=none; b=Qms8OiT98wff3UVpC1siCKxRqyS2k8Wj87VyLYhkhFESPHB0pxJc5nfsFA7Lzzy6R491SiSR8NEt4bLoHyqK5u2dgJsnhopjepXl6Opy5+KMCSYTvdgGZZ30R7gf7yoCBHHunNq5WtWW6p3bY8QcN94VodA/vIMBA337Sl5aeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761344120; c=relaxed/simple;
	bh=nDtcgRvXDnVizXJkci9ZLw1e/4V0I929zeTdGqEvIJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjgT3AiNqfIiyYAgT5gWKE1NCptV8iXh9aUX4QqXTghKymGFWaE5VGCZ3/x+8QLAfQs2Mv32LlmoqfJianjI5BhStE5q1QlfsE9P7ijR1zkxWkyzAHX/mM4NnBbR5cyDsQFYy/ob8aALehcE2bdW9u9dHeJ9v+A00Rxq262oWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=frQ2ljfj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761344115; x=1761948915; i=quwenruo.btrfs@gmx.com;
	bh=1GHAcHbsRPF9An1hucO1ziT4IG9PVUvqKg8umeegPDU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=frQ2ljfjTIBV35aCUEPmnqF+XJggPZSeQXchdXqpdsMaLtHs09FE7SwIpmbkrNce
	 bE6+9CWFqvhUVq7RLhXn1XO4LpeHupA4vM1Vlpi5ZqLKvb4P0bbHRxULxA26MkgF5
	 ncYageCfGBA1qaMqVHklkB37axndPe3POpWgW/dgtCDD4zRISMGzeVajiY8urXJKK
	 +xDusOvW0OgEI+xWNj1kQX7xTvXGL5FlZ0wTMwzPSB4+3y84k0HlEAa5HGy5sPIyS
	 D/O8TCNxH5hwVFflSaJduO/F24fd7IjA1qf9w4nBKn1LZ4MImewqdB63KN6QPpXwA
	 XygtU5oadX5ZTTVrsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1uS2gc2Qx6-00lq69; Sat, 25
 Oct 2025 00:15:15 +0200
Message-ID: <6e338563-97d9-46f5-bfe6-19a1effa8aca@gmx.com>
Date: Sat, 25 Oct 2025 08:45:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
References: <cover.1761302592.git.wqu@suse.com>
 <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
 <aPtbzMCLwhuLuo4d@infradead.org>
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
In-Reply-To: <aPtbzMCLwhuLuo4d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BPfKtunPRzidNZcWghXXc38cQHXtRyhy9aOoGzFG3aeX/sYp7Sy
 ibSAXcKIVbbqQl7RhIhHgl5DWfwuPQSIAWLXp6KQEyeVlb/1H3X6ry6lS8pIxsoqmwhrQWQ
 Y/ZmRjn5EYZS7Fuil8tGI7HUS8e9HnxJ2nmAf/P1EAOKLXezb3sijq21MnEyqTYqH4AtPe3
 e9M6csqCXHS/NXXxntbAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/WdId3Y91zk=;fyXbSPG2BXodT54k3IW3oRwCMwP
 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
 XHugQ==



=E5=9C=A8 2025/10/24 21:28, Christoph Hellwig =E5=86=99=E9=81=93:
> This seems to be a lot of overhead at least for simple checksums
> like crc32c or xxhash.
>=20
> Did you also look into Eric's
>=20
> [PATCH 10/10] btrfs: switch to library APIs for checksums to reduce
> the crypto API overhead, which is probably the worst overhead for
> checksums right now?

That doesn't seem to be the biggest overhead to me, at least for modern=20
hardware accelerated CRC32C.
Although it will definitely help for much slower hashes.


The main bottle neck here is the storage, at least mainstream level=20
storage is still less than 10GiB/s, meanwhile dual channel DDR5=20
bandwidth is at around 50 GiB/s, not to mention 80GiB/s if one go LPDDR5=
=20
or quad channel ones.

This means even if the overhead is reduced, it's not eliminating the=20
latency to calculate the checksum.

So let's use the following theorectic example to check how the=20
difference will be:

- 50GiB/s DRAM bandwidth
- 45GiB/s CRC32C bandwidth (original)
- 50GiB/s CRC32C bandwidth (improved by the new API)
- 8GiB/s storage bandwidth

Original write bandwith with data checksum:

1 / ( 1 / 50 + 1 / 45 + 1 / 8) =3D 5.98 GiB/s

Improved crypt API:

1 / ( 1/ 50 + 1 / 50 + 1 / 8) =3D 6.06 GiB/s

Async csum (no matter which crypt API):

1 / ( 1 / 50 + max (1 / 45, 1/ 8)) =3D 6.90 GiB/s

Even if the new API can cause black magic to make CRC32C to be faster=20
than DRAM bandwidth, it will not remove the latency.


And not to mention there are much slower checksums, some will be much=20
slower than the storage.

If I go with SHA256 which is super slow, around 1GiB/s, then the new API=
=20
will shine much more:

Vanilla:
1 / ( 1 / 50 + 1 / 1 + 1 / 8) =3D 0.87 GiB/s

Improved crypt API (+10% throughput for csum)

1 / ( 1 / 50 + 1 / 1.1 + 1 / 8) =3D 0.95 GiB/s

Async csum (old api):

1 / ( 1 / 50 + max( 1 / 1, 1/8)) =3D 0.98 GiB/s

Async csum (new api):

1 / ( 1 / 50 + max( 1 / 1.1, 1/8)) =3D 1.08 GiB/s

Although in that case, improved crypt API will definitely help us with=20
async csum.

So yes, I think that series will help overall, but still not as good as=20
async checksum calculation.

Thanks,
Qu

>=20
> On Fri, Oct 24, 2025 at 09:19:35PM +1030, Qu Wenruo wrote:
>> [ENHANCEMENT]
>> Btrfs currently calculate its data checksum then submit the bio.
>>
>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered writ=
e
>> if the inode requires checksum"), any writes with data checksum will
>> fallback to buffered IO, meaning the content will not change during
>> writeback.
>>
>> This means we're safe to calculate the data checksum and submit the bio
>> in parallel, we only need to make sure btrfs_bio::end_io() is called
>> after the checksum calculation is done.
>>
>> As usual, such new feature is hidden behind the experimental flag.
>>
>> [THEORETIC ANALYZE]
>> Consider the following theoretic hardware performance, which should be
>> more or less close to modern mainstream hardware:
>>
>> 	Memory bandwidth:	50GiB/s
>> 	CRC32C bandwidth:	45GiB/s
>> 	SSD bandwidth:		8GiB/s
>>
>> Then btrfs write bandwidth with data checksum before the patch would be
>>
>> 	1 / ( 1 / 50 + 1 / 45 + 1 / 8) =3D 5.98 GiB/s
>>
>> After the patch, the bandwidth would be:
>>
>> 	1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) =3D 6.90 GiB/s
>>
>> The difference would be 15.32 % improvement.
>>
>> [REAL WORLD BENCHMARK]
>> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs=
, the
>> storage is backed by a PCIE gen3 x4 NVME SSD.
>>
>> The test is a direct IO write, with 1MiB block size, write 7GiB data
>> into a btrfs mount with data checksum. Thus the direct write will fallb=
ack
>> to buffered one:
>>
>> Vanilla Datasum:	1619.97 GiB/s
>> Patched Datasum:	1792.26 GiB/s
>> Diff			+10.6 %
>>
>> In my case, the bottleneck is the storage, thus the improvement is not
>> reaching the theoretic one, but still some observable improvement.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c       | 17 ++++++++----
>>   fs/btrfs/bio.h       |  5 ++++
>>   fs/btrfs/file-item.c | 61 +++++++++++++++++++++++++++++++------------=
-
>>   fs/btrfs/file-item.h |  2 +-
>>   4 files changed, 61 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 18272ef4b4d8..a5b83c6c9e7f 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -103,6 +103,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_s=
tatus_t status)
>>   	/* Make sure we're already in task context. */
>>   	ASSERT(in_task());
>>  =20
>> +	if (bbio->async_csum)
>> +		wait_for_completion(&bbio->csum_done);
>> +
>>   	bbio->bio.bi_status =3D status;
>>   	if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
>>   		struct btrfs_bio *orig_bbio =3D bbio->private;
>> @@ -535,7 +538,7 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
>>   {
>>   	if (bbio->bio.bi_opf & REQ_META)
>>   		return btree_csum_one_bio(bbio);
>> -	return btrfs_csum_one_bio(bbio);
>> +	return btrfs_csum_one_bio(bbio, true);
>>   }
>>  =20
>>   /*
>> @@ -613,10 +616,14 @@ static bool should_async_write(struct btrfs_bio *=
bbio)
>>   	struct btrfs_fs_devices *fs_devices =3D bbio->fs_info->fs_devices;
>>   	enum btrfs_offload_csum_mode csum_mode =3D READ_ONCE(fs_devices->off=
load_csum_mode);
>>  =20
>> -	if (csum_mode =3D=3D BTRFS_OFFLOAD_CSUM_FORCE_OFF)
>> -		return false;
>> -
>> -	auto_csum_mode =3D (csum_mode =3D=3D BTRFS_OFFLOAD_CSUM_AUTO);
>> +	if (csum_mode =3D=3D BTRFS_OFFLOAD_CSUM_FORCE_ON)
>> +		return true;
>> +	/*
>> +	 * Write bios will calculate checksum and submit bio at the same time=
.
>> +	 * Unless explicitly required don't offload serial csum calculate and=
 bio
>> +	 * submit into a workqueue.
>> +	 */
>> +	return false;
>>   #endif
>>  =20
>>   	/* Submit synchronously if the checksum implementation is fast. */
>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>> index 00883aea55d7..277f2ac090d9 100644
>> --- a/fs/btrfs/bio.h
>> +++ b/fs/btrfs/bio.h
>> @@ -60,6 +60,8 @@ struct btrfs_bio {
>>   		struct {
>>   			struct btrfs_ordered_extent *ordered;
>>   			struct btrfs_ordered_sum *sums;
>> +			struct work_struct csum_work;
>> +			struct completion csum_done;
>>   			u64 orig_physical;
>>   		};
>>  =20
>> @@ -84,6 +86,9 @@ struct btrfs_bio {
>>  =20
>>   	/* Use the commit root to look up csums (data read bio only). */
>>   	bool csum_search_commit_root;
>> +
>> +	bool async_csum;
>> +
>>   	/*
>>   	 * This member must come last, bio_alloc_bioset will allocate enough
>>   	 * bytes for entire btrfs_bio but relies on bio being last.
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index a42e6d54e7cd..bedfcf4a088d 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -18,6 +18,7 @@
>>   #include "fs.h"
>>   #include "accessors.h"
>>   #include "file-item.h"
>> +#include "volumes.h"
>>  =20
>>   #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_=
SIZE(r) - \
>>   				   sizeof(struct btrfs_item) * 2) / \
>> @@ -764,21 +765,46 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *=
root, struct btrfs_path *path,
>>   	return ret;
>>   }
>>  =20
>> -/*
>> - * Calculate checksums of the data contained inside a bio.
>> - */
>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>> +static void csum_one_bio(struct btrfs_bio *bbio)
>>   {
>> -	struct btrfs_ordered_extent *ordered =3D bbio->ordered;
>>   	struct btrfs_inode *inode =3D bbio->inode;
>>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>   	struct bio *bio =3D &bbio->bio;
>> -	struct btrfs_ordered_sum *sums;
>> +	struct btrfs_ordered_sum *sums =3D bbio->sums;
>>   	struct bvec_iter iter =3D bio->bi_iter;
>>   	phys_addr_t paddr;
>>   	const u32 blocksize =3D fs_info->sectorsize;
>> -	int index;
>> +	int index =3D 0;
>> +
>> +	shash->tfm =3D fs_info->csum_shash;
>> +
>> +	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>> +		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
>> +		index +=3D fs_info->csum_size;
>> +	}
>> +}
>> +
>> +static void csum_one_bio_work(struct work_struct *work)
>> +{
>> +	struct btrfs_bio *bbio =3D container_of(work, struct btrfs_bio, csum_=
work);
>> +
>> +	ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
>> +	ASSERT(bbio->async_csum =3D=3D true);
>> +	csum_one_bio(bbio);
>> +	complete(&bbio->csum_done);
>> +}
>> +
>> +/*
>> + * Calculate checksums of the data contained inside a bio.
>> + */
>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>> +{
>> +	struct btrfs_ordered_extent *ordered =3D bbio->ordered;
>> +	struct btrfs_inode *inode =3D bbio->inode;
>> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> +	struct bio *bio =3D &bbio->bio;
>> +	struct btrfs_ordered_sum *sums;
>>   	unsigned nofs_flag;
>>  =20
>>   	nofs_flag =3D memalloc_nofs_save();
>> @@ -789,21 +815,20 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>>   	if (!sums)
>>   		return -ENOMEM;
>>  =20
>> +	sums->logical =3D bio->bi_iter.bi_sector << SECTOR_SHIFT;
>>   	sums->len =3D bio->bi_iter.bi_size;
>>   	INIT_LIST_HEAD(&sums->list);
>> -
>> -	sums->logical =3D bio->bi_iter.bi_sector << SECTOR_SHIFT;
>> -	index =3D 0;
>> -
>> -	shash->tfm =3D fs_info->csum_shash;
>> -
>> -	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>> -		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
>> -		index +=3D fs_info->csum_size;
>> -	}
>> -
>>   	bbio->sums =3D sums;
>>   	btrfs_add_ordered_sum(ordered, sums);
>> +
>> +	if (!async) {
>> +		csum_one_bio(bbio);
>> +		return 0;
>> +	}
>> +	init_completion(&bbio->csum_done);
>> +	bbio->async_csum =3D true;
>> +	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>> +	schedule_work(&bbio->csum_work);
>>   	return 0;
>>   }
>>  =20
>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
>> index 63216c43676d..2a250cf8b2a1 100644
>> --- a/fs/btrfs/file-item.h
>> +++ b/fs/btrfs/file-item.h
>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handl=
e *trans,
>>   int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>>   			   struct btrfs_root *root,
>>   			   struct btrfs_ordered_sum *sums);
>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio);
>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>>   int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>>   int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 =
end,
>>   			     struct list_head *list, int search_commit,
>> --=20
>> 2.51.0
>>
>>
> ---end quoted text---
>=20


