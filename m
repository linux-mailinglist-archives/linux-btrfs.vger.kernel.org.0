Return-Path: <linux-btrfs+bounces-15431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE6B00DB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 23:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35AD548602
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57552FE319;
	Thu, 10 Jul 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FiexxIXh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6123506E
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182841; cv=none; b=o6qViNbcGR2SCXR11c6eVfibvJl+vkSHKtx4Mw+Ix0zwSXB5RYeVyRmM2Y66s13s+HpMhF+ZlDQkPR/mLN4FHoZmGz/xZnTIE3cXbBAXcps+GmK9iBgLJrWzHT2jNxGfz1nz3IzcEm5bQGFO0SFIYqIdBrLnSsiGzht6na6ayDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182841; c=relaxed/simple;
	bh=sIVuLMBSOmlGKJ1CsDb5dynfYdi7XSxz+3RJUMdpLLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYpwn3sTkhLl+hnuXLNL++6mfydujIlNX9DdbtygnfZ/bAhtKbLttKWBSo3o+uWe6pOfhFrWm18lNFcEcaxtgHunT+ZK23pm0jl1svbJa669RxYelRY7wJb2j6F8eSmQgTgp4oVUdPm5TJ65xxeLXM5m8XnJH4hiy+LQjV44LmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FiexxIXh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752182832; x=1752787632; i=quwenruo.btrfs@gmx.com;
	bh=9foR64ufZI/PMF3LDtpnVOD9X0seyEesaVdwl4Wju5k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FiexxIXhsgnoh1GRvTzdSZxlmzmKTYW45OpPXaGwxzHf8e9lg9qmjPv3RaSiqRJI
	 sc0fLrEW+cY92xrEYh8Sf+SaCKKZfDvyJsS26TvSWTASNlX7FGaKs+ZRFyloL7pLg
	 l4XI4jGph4N6UsUk/ozpEMnW7fb2VptvK966Ku/Q5coZfhWvGIST1I0Jw2GaVZ9bi
	 bLHMU3+RyYBNWEFFobn69n8yD9GsEw1YfMCK+13VqGy/QbwwT6ZjEkirbkoswlG2Z
	 GGwijV3AZkh3rfY+7X9eN6eUZ0qxLHlpUXqGFu0Dkz6ZgetJxW+fI9PrM7sDqZFWd
	 iNNDPeZEoSNgXfL/JQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1ulzKH2NyN-00uzpA; Thu, 10
 Jul 2025 23:27:11 +0200
Message-ID: <1dbd43cb-7e1f-455c-8de8-4b91826b800e@gmx.com>
Date: Fri, 11 Jul 2025 06:57:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] btrfs: try to search for data csums in commit root
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
 <98154adb-057a-44d7-97a4-9bfd669b9454@suse.com>
 <20250710152606.GB588947@zen.localdomain>
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
In-Reply-To: <20250710152606.GB588947@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LLFYFjl04eYqGaO0SCiGLTCJV95jBZGg6azef9o0i5T7wmFpCY3
 pK1kj9/J4sHfUkMqLqiOfZMZkoMJ93UxL84CqhllBvpww0iEtGH/LyrOt3YCL/f5niCn2AI
 Znq06IsN3dI6SqIL7T5M45daqTILZOtrwtZmlh9D3rItst0BVQ6tbSqeUkveMFK9FvEZXsM
 jHPmVXDIdH0NmU9bqzAIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yrUxbTNg/Lk=;LkYFyD9bArlEw5KT5mUXuAhOXcu
 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
 1t/C8ULgqYkcBYCRwNSIxO4=



=E5=9C=A8 2025/7/11 00:56, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Jul 10, 2025 at 04:45:35PM +0930, Qu Wenruo wrote:
[...]
>> If that's the case, I'd prefer to have a dedicated flag for it.
>>
>> In fact there is a 7 bytes hole inside btrfs_bio, and we don't need to
>> bother the extra helpers for this.
>=20
> I'm happy either way. Sterba said he preferred to not add fields to the
> btrfs_bio on v2:
> https://lore.kernel.org/linux-btrfs/20241011174603.GA1609@twin.jikos.cz/
>=20
> But at that point I didn't even try to find a neat spot in the struct to
> slot it in, and just dumped a bool on the end of the struct.
>=20
> For my learning, how are you finding the 7 byte hole? Do you have a tool
> for dumping a particular compiled version of the struct you like? I
> started trying to count up the sizes of stuff in struct btrfs_bio and
> quickly lost steam halfway through the union with nested structs.

The tried and true pa_hole tool.

Passing the compiled kernel/module, and you get all the structures'=20
layout, with extra cacheline and hole info.

Thanks,
Qu

>=20
>>
>> Otherwise it looks good to me.
>>
>> Thanks,
>> Qu
>>
>>> +	btrfs_bio_clear_csum_search_commit_root(btrfs_bio(bio));
>>> +
>>>    	if (!bioc) {
>>>    		/* Single mirror read/write fast path. */
>>>    		btrfs_bio(bio)->mirror_num =3D mirror_num;
>>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>>> index dc2eb43b7097..9f4bcbe0a76c 100644
>>> --- a/fs/btrfs/bio.h
>>> +++ b/fs/btrfs/bio.h
>>> @@ -104,6 +104,23 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr=
_vecs, blk_opf_t opf,
>>>    				  btrfs_bio_end_io_t end_io, void *private);
>>>    void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
>>> +#define BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT	(1U << (BIO_FLAG_LAST =
+ 1))
>>> +
>>> +static inline void btrfs_bio_set_csum_search_commit_root(struct btrfs=
_bio *bbio)
>>> +{
>>> +	bbio->bio.bi_flags |=3D BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
>>> +}
>>> +
>>> +static inline void btrfs_bio_clear_csum_search_commit_root(struct btr=
fs_bio *bbio)
>>> +{
>>> +	bbio->bio.bi_flags &=3D ~BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
>>> +}
>>> +
>>> +static inline bool btrfs_bio_csum_search_commit_root(const struct btr=
fs_bio *bbio)
>>> +{
>>> +	return bbio->bio.bi_flags & BTRFS_BIO_FLAG_CSUM_SEARCH_COMMIT_ROOT;
>>> +}
>>> +
>>>    /* Submit using blkcg_punt_bio_submit. */
>>>    #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>>> index d09d622016ef..cadf5eccc640 100644
>>> --- a/fs/btrfs/compression.c
>>> +++ b/fs/btrfs/compression.c
>>> @@ -602,6 +602,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio=
 *bbio)
>>>    	cb->compressed_len =3D compressed_len;
>>>    	cb->compress_type =3D btrfs_extent_map_compression(em);
>>>    	cb->orig_bbio =3D bbio;
>>> +	if (btrfs_bio_csum_search_commit_root(bbio))
>>> +		btrfs_bio_set_csum_search_commit_root(&cb->bbio);
>>>    	btrfs_free_extent_map(em);
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 685ee685ce92..a8b3d27699e8 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -101,6 +101,16 @@ struct btrfs_bio_ctrl {
>>>    	enum btrfs_compression_type compress_type;
>>>    	u32 len_to_oe_boundary;
>>>    	blk_opf_t opf;
>>> +	/*
>>> +	 * For data read bios, we attempt to optimize csum lookups if the ex=
tent
>>> +	 * generation is older than the current one. To make this possible, =
we
>>> +	 * need to track the maximum generation of an extent in a bio_ctrl t=
o
>>> +	 * make the decision when submitting the bio.
>>> +	 *
>>> +	 * See the comment in btrfs_lookup_bio_sums for more detail on the
>>> +	 * need for this optimization.
>>> +	 */
>>> +	u64 generation;
>>>    	btrfs_bio_end_io_t end_io_func;
>>>    	struct writeback_control *wbc;
>>> @@ -113,6 +123,28 @@ struct btrfs_bio_ctrl {
>>>    	struct readahead_control *ractl;
>>>    };
>>> +/*
>>> + * Helper to set the csum search commit root option for a bio_ctrl's =
bbio
>>> + * before submitting the bio.
>>> + *
>>> + * Only for use by submit_one_bio().
>>> + */
>>> +static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bi=
o_ctrl)
>>> +{
>>> +	struct btrfs_bio *bbio =3D bio_ctrl->bbio;
>>> +
>>> +	ASSERT(bbio);
>>> +
>>> +	if (!(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ && is_data_inode(bb=
io->inode)))
>>> +		return;
>>> +
>>> +	if (bio_ctrl->generation &&
>>> +	    bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root=
->fs_info))
>>> +		btrfs_bio_set_csum_search_commit_root(bio_ctrl->bbio);
>>> +	else
>>> +		btrfs_bio_clear_csum_search_commit_root(bio_ctrl->bbio);
>>> +}
>>> +
>>>    static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>>>    {
>>>    	struct btrfs_bio *bbio =3D bio_ctrl->bbio;
>>> @@ -123,6 +155,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *=
bio_ctrl)
>>>    	/* Caller should ensure the bio has at least some range added */
>>>    	ASSERT(bbio->bio.bi_iter.bi_size);
>>> +	bio_set_csum_search_commit_root(bio_ctrl);
>>> +
>>>    	if (btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_READ &&
>>>    	    bio_ctrl->compress_type !=3D BTRFS_COMPRESS_NONE)
>>>    		btrfs_submit_compressed_read(bbio);
>>> @@ -131,6 +165,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *=
bio_ctrl)
>>>    	/* The bbio is owned by the end_io handler now */
>>>    	bio_ctrl->bbio =3D NULL;
>>> +	/* Reset the generation for the next bio */
>>> +	bio_ctrl->generation =3D 0;
>>>    }
>>>    /*
>>> @@ -1026,6 +1062,8 @@ static int btrfs_do_readpage(struct folio *folio=
, struct extent_map **em_cached,
>>>    		if (prev_em_start)
>>>    			*prev_em_start =3D em->start;
>>> +		bio_ctrl->generation =3D max(bio_ctrl->generation, em->generation);
>>> +
>>>    		btrfs_free_extent_map(em);
>>>    		em =3D NULL;
>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>> index c09fbc257634..b33742aceacb 100644
>>> --- a/fs/btrfs/file-item.c
>>> +++ b/fs/btrfs/file-item.c
>>> @@ -397,6 +397,33 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>>>    		path->skip_locking =3D 1;
>>>    	}
>>> +	/*
>>> +	 * If we are searching for a csum of an extent from a past
>>> +	 * transaction, we can search in the commit root and reduce
>>> +	 * lock contention on the csum tree root node's extent buffer.
>>> +	 *
>>> +	 * This is important because that lock is an rwswem which gets
>>> +	 * pretty heavy write load, unlike the commit_root_sem.
>>> +	 *
>>> +	 * Due to how rwsem is implemented, there is a possible
>>> +	 * priority inversion where the readers holding the lock don't
>>> +	 * get scheduled (say they're in a cgroup stuck in heavy reclaim)
>>> +	 * which then blocks writers, including transaction commit. By
>>> +	 * using a semaphore with fewer writers (only a commit switching
>>> +	 * the roots), we make this issue less likely.
>>> +	 *
>>> +	 * Note that we don't rely on btrfs_search_slot to lock the
>>> +	 * commit root csum. We call search_slot multiple times, which would
>>> +	 * create a potential race where a commit comes in between searches
>>> +	 * while we are not holding the commit_root_sem, and we get csums
>>> +	 * from across transactions.
>>> +	 */
>>> +	if (btrfs_bio_csum_search_commit_root(bbio)) {
>>> +		path->search_commit_root =3D 1;
>>> +		path->skip_locking =3D 1;
>>> +		down_read(&fs_info->commit_root_sem);
>>> +	}
>>> +
>>>    	while (bio_offset < orig_len) {
>>>    		int count;
>>>    		u64 cur_disk_bytenr =3D orig_disk_bytenr + bio_offset;
>>> @@ -442,6 +469,8 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>>>    		bio_offset +=3D count * sectorsize;
>>>    	}
>>> +	if (btrfs_bio_csum_search_commit_root(bbio))
>>> +		up_read(&fs_info->commit_root_sem);
>>>    	return ret;
>>>    }
>=20


