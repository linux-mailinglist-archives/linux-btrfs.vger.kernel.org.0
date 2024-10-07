Return-Path: <linux-btrfs+bounces-8629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76757993B5C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB0C1C239E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A4190477;
	Mon,  7 Oct 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sfG8Ssut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC418C02A
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344600; cv=none; b=b1viPaL6+TXq8J7lM9s9j0ELLLaqUfIQxssrgg/9I9aEuWGZjWqOyNvzZyVMRalb3Ghz9O9Jj3pstp5DUlo6bYbmpvmPszEPpQnF5ayR1S6piWncF+D3LB40mmGatKxNy9jqV1FjGxxeARi6zo8jvHP+PgDZyfPETmEvLFMfKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344600; c=relaxed/simple;
	bh=f4uO91wKEjDpKLiGkSz9Ix13IS4TUzVRvbPPt80HW/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHYJTr+lhUhBEm7hmwsee1OfBG+NBWbFZtmyhrViGL1Hz645UL5ydkPHZMgLlVt4+zDbesNujQsr9H+fKMhjFCLe/7Fl/JEEvFX/PBetjv+N+VMRp4UbqGkIrU7ZDf+F4vACJAAlPvIHRIHfbaEtc6YPUlxYfzQscjd+FDwbAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sfG8Ssut; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728344587; x=1728949387; i=quwenruo.btrfs@gmx.com;
	bh=hPOkDP4xqZZYp13t+kDSjToj4tm4fCDYdawNqyeaBVE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sfG8SsutOIDNQAun1QhooFOjvowd9uEbV0FHRNfDMXkDE6OHv+ardZN7l8R8OTiv
	 /hoT7NIu/PKF6U7vhn1+t+Xqe6xpa/kj74dKykNZyPM0EBk4z7l5mwlBnWfFOC+vb
	 Yktt3cOpanCGwMv6NSodGKRSCUw0oX/Lur6cmyuciPeZI8hzfxFMU851LO2Gdk4Hp
	 pDCkJPxSDI+Xe92hfGMZ1c3zU1oURzJMSBBQntFUu8e/TdZJrZkeBRHqM8pDcV3iV
	 9oseuIrK74QBgqu5zCVtHhpu10FO1wqrctHFwD+RYQNbodbmmRAcoDidAk+tipDnf
	 IlR0Taq0l/cT/MkNIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1tJK1N1FPK-00HsdN; Tue, 08
 Oct 2024 01:43:07 +0200
Message-ID: <2aac3cdc-4b99-491b-8b52-f27803bc37fe@gmx.com>
Date: Tue, 8 Oct 2024 10:13:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: try to search for data csums in commit root
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <9d12c373a49184e84897ff2d6df601f2c7c66a32.1728084164.git.boris@bur.io>
 <6a34b96c-0b00-46c8-a0e8-69f0028173e4@suse.com>
 <20241007223045.GA388113@zen.localdomain>
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
In-Reply-To: <20241007223045.GA388113@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ieAGgooAC1mhM4sgyAAFI3sjoxWADvwU8rci1WCXvTzrqOp2gfc
 NbzemlQzVoaznH2BcJJPaUi1gfV6vLswqc520zaFNx2+K0Ix0EazU+AhdNQgWrxOLkEbaJF
 9kPjcchhbx5b3jRRbUjEUHKicyOdMP6+peZt4Jq/AAd8o6p5q87nOf/kvO9OmplDShBzgeV
 RzVUxiRAOgPwH/GgByKAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xr4SJ6J8MWE=;IMfh+9LOSGrMyBerV6nHqbTaKOP
 4SyKXFMp/e8AFXQkTPKrvlumsP5iLN0PGbb1QScQ3v6l4+jXutp6ll1jZtcZryPbquRjcHkMX
 LuUj5DZo8xTT/S9IePPxsztqNXt9nGmvZw1WDS+ViA6gLhG9+zTBI68NFcLYddLlP41HMpTcE
 oWXqfSBYQcy4Fp6OKXP3muwPwMVHtUdr2UuJZiKJgDeQhb6qHfMYad4XT/uK99rWKbkUSvYLv
 SWhgymP+4KE5jkrY2har+EhVE/wSIuLcic5bWKXdCGafajo28+PkBqI4wGnF3WeAT8jtXiYly
 qQuWh7rBhDTj9KUTHwmpLtsqRX2Xv4aEWdPgdCDOm5kL8m0KHarBbL8BN/HjKGje4dtCFvoQc
 b38LN/a3MSvxy39RSzOn4iEoiK1uVWuJ8PCyfgs9D72DgPmF0sMXmjFbJ5ot8Od7bQ5/ygJ/f
 4TPfy8KNIJKczf1rU0d9+qgjR1jX4U72y+zmvLmLpuE3W7Sdz1jzwE8yMmvnqEYHiCRF8Ebo4
 fjmXmn1kzZs9+9mqtgHIyhzTAYf8JwXQ6ijvEiG3Xizf0g2b1tcv/LTUWeJtuDfnR5gdRC1ga
 FO2z1YC/cLE+gTiMKwqK5LuYNghI5t077gRN6Dn5dR3B46c94fzc+daDxOk6guM2zVliTkQDs
 GiOSdBZrW2eDByEZMLhbaJ+K/4l+x0e3UybfYzbnj1PH3a52IDKYJ57sxcwbah54QZSlgCeJW
 jFeMJDGF3Kt84Him4a+6cNC41zttIqEMK8cD3fSHf11IRv91f7zmaU3lPoJp09cR4pmv/spGL
 0/3cOZDCpDMGV2E7mYtwQdyDR4JWTFscalxwRHAq1QLPk=



=E5=9C=A8 2024/10/8 09:00, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Oct 05, 2024 at 04:30:29PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/10/5 08:53, Boris Burkov =E5=86=99=E9=81=93:
>>> If you run a workload like:
>>> - a cgroup that does tons of data reading, with a harsh memory limit
>>> - a second cgroup that tries to write new files
>>> e.g.:
>>> https://github.com/boryas/scripts/blob/main/sh/noisy-neighbor/run.sh
>>>
>>> then what quickly occurs is:
>>> - a high degree of contention on the csum root node eb rwsem
>>> - memory starved cgroup doing tons of reclaim on CPU.
>>> - many reader threads in the memory starved cgroup "holding" the sem
>>>     as readers, but not scheduling promptly. i.e., task __state =3D=3D=
 0, but
>>>     not running on a cpu.
>>> - btrfs_commit_transaction stuck trying to acquire the sem as a writer=
.
>>>
>>> This results in VERY long transactions. On my test system, that script
>>> produces 20-30s long transaction commits. This then results in
>>> seriously degraded performance for any cgroup using the filesystem (th=
e
>>> victim cgroup in the script).
>>>
>>> This reproducer is a bit silly, as the villanous cgroup is using almos=
t
>>> all of its memory.max for kernel memory (specifically pagetables) but =
it
>>> sort of doesn't matter, as I am most interested in the btrfs locking
>>> behavior. It isn't an academic problem, as we see this exact problem i=
n
>>> production at Meta with one cgroup over memory.max ruining btrfs
>>> performance for the whole system.
>>>
>>> The underlying scheduling "problem" with global rwsems is sort of thor=
ny
>>> and apparently well known. e.g.
>>> https://lpc.events/event/18/contributions/1883/
>>>
>>> As a result, our main lever in the short term is just trying to reduce
>>> contention on our various rwsems. In the case of the csum tree, we can
>>> either redesign btree locking (hard...) or try to use the commit root
>>> when we can. Luckily, it seems likely that many reads are for old exte=
nts
>>> written many transactions ago, and that for those we *can* in fact
>>> search the commit root!
>>
>> The idea looks good to me.
>>
>> The extent_map::generation is updated to the larger one during merge, s=
o if
>> we got a em whose generation is smaller than the current generation it'=
s
>> definitely older.
>>
>> And since data extents in commit root won't be overwritten until the cu=
rrent
>> transaction committed, so it should also be fine.
>>
>>
>> But my concern is, the path->need_commit_sem is only blocking transacti=
on
>> from happening when the path is holding something.
>> And inside search_csum_tree() we can release the path halfway, would th=
at
>> cause 2 transaction to be committed during that release window?
>>
>> Shouldn't we hold the semaphore manually inside btrfs_lookup_bio_sums()
>> other than relying on the btrfs_path::need_commit_sem?
>
> Yes, I think you are right. Good catch! I will test that version and
> re-send, assuming it still works well.

The problem is, if we hold the semaphore that long, it will be no better
than the regular tree search method...

So I'm out of good ideas.

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>>
>>> This change detects when we are trying to read an old extent (accordin=
g
>>> to extent map generation) and then wires that through bio_ctrl to the
>>> btrfs_bio, which unfortunately isn't allocated yet when we have this
>>> information. When we go to lookup the csums in lookup_bio_sums we can
>>> check this condition on the btrfs_bio and do the commit root lookup
>>> accordingly.
>>>
>>> With the fix, on that same test case, commit latencies no longer excee=
d
>>> ~400ms on my system.
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/bio.h       |  1 +
>>>    fs/btrfs/extent_io.c | 21 +++++++++++++++++++++
>>>    fs/btrfs/file-item.c |  7 +++++++
>>>    3 files changed, 29 insertions(+)
>>>
>>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>>> index e48612340745..159f6a4425a6 100644
>>> --- a/fs/btrfs/bio.h
>>> +++ b/fs/btrfs/bio.h
>>> @@ -48,6 +48,7 @@ struct btrfs_bio {
>>>    			u8 *csum;
>>>    			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
>>>    			struct bvec_iter saved_iter;
>>> +			bool commit_root_csum;
>>>    		};
>>>    		/*
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index cb0a39370d30..8544fe2302ff 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -108,6 +108,21 @@ struct btrfs_bio_ctrl {
>>>    	 * This is to avoid touching ranges covered by compression/inline.
>>>    	 */
>>>    	unsigned long submit_bitmap;
>>> +	/*
>>> +	 * If this is a data read bio, we set this to true if it is safe to
>>> +	 * search for csums in the commit root. Otherwise, it is set to fals=
e.
>>> +	 *
>>> +	 * This is an optimization to reduce the contention on the csum tree
>>> +	 * root rwsem. Due to how rwsem is implemented, there is a possible
>>> +	 * priority inversion where the readers holding the lock don't get
>>> +	 * scheduled (say they're in a cgroup stuck in heavy reclaim) which
>>> +	 * then blocks btrfs transactions. The only real help is to try to
>>> +	 * reduce the contention on the lock as much as we can.
>>> +	 *
>>> +	 * Do this by detecting when a data read is reading data from an old
>>> +	 * transaction so it's safe to look in the commit root.
>>> +	 */
>>> +	bool commit_root_csum;
>>>    };
>>>    static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>>> @@ -770,6 +785,9 @@ static void submit_extent_folio(struct btrfs_bio_c=
trl *bio_ctrl,
>>>    			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
>>>    				      folio_pos(folio) + pg_offset);
>>>    		}
>>> +		if (btrfs_op(&bio_ctrl->bbio->bio) =3D=3D BTRFS_MAP_READ && is_data=
_inode(inode))
>>> +			bio_ctrl->bbio->commit_root_csum =3D bio_ctrl->commit_root_csum;
>>> +
>>>    		/* Cap to the current ordered extent boundary if there is one. */
>>>    		if (len > bio_ctrl->len_to_oe_boundary) {
>>> @@ -1048,6 +1066,9 @@ static int btrfs_do_readpage(struct folio *folio=
, struct extent_map **em_cached,
>>>    		if (prev_em_start)
>>>    			*prev_em_start =3D em->start;
>>> +		if (em->generation < btrfs_get_fs_generation(fs_info))
>>> +			bio_ctrl->commit_root_csum =3D true;
>>> +
>>>    		free_extent_map(em);
>>>    		em =3D NULL;
>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>> index 886749b39672..2433b169a4e6 100644
>>> --- a/fs/btrfs/file-item.c
>>> +++ b/fs/btrfs/file-item.c
>>> @@ -401,6 +401,13 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_b=
io *bbio)
>>>    		path->skip_locking =3D 1;
>>>    	}
>>> +	/* See the comment on btrfs_bio_ctrl->commit_root_csum. */
>>> +	if (bbio->commit_root_csum) {
>>> +		path->search_commit_root =3D 1;
>>> +		path->skip_locking =3D 1;
>>> +		path->need_commit_sem =3D 1;
>>> +	}
>>> +
>>>    	while (bio_offset < orig_len) {
>>>    		int count;
>>>    		u64 cur_disk_bytenr =3D orig_disk_bytenr + bio_offset;
>>
>


