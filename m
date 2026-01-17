Return-Path: <linux-btrfs+bounces-20648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ADDD38C1F
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 05:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFC030341EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 04:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D3312808;
	Sat, 17 Jan 2026 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IBNN2DDR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708D3595B
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Jan 2026 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768622950; cv=none; b=GRb8xJ4XW1wiZh3RBkcerLPrrghcGXPmP3FzpCPIG6wVtkEPssf6tlVBrwk4KLcsp7pYHviZbicrlps27xnSwHCgAiP9XjJKZ2dDo3Visl+GWi32vF/3N1MXHUOgUSVGjgbwoPfRmSTIiCD8rFr9H/COcjoR9yjKVqqzjTsoIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768622950; c=relaxed/simple;
	bh=TRYXrileTKvqRqKprMuNS54M6UqBPwxMeksSlkgLqzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPfAvOWdNOPsLxJNNJGDWx36vNoPSYEevctlxP726l8EJyVRV2Gnu/SnRDWoXLaMudTm3qVXxCOuU6l7fJdRFwrlh8K5QTP8SRwDGLAwOWtUTzwZcvIMrBf8jbtPOAe5eTdnz7wmAofPZ9pbsG63XhCSXzIK6DviDPVEgsUHH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IBNN2DDR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768622946; x=1769227746; i=quwenruo.btrfs@gmx.com;
	bh=qnScdSPproYY0fom5AE+yhKxaeLmteTgJh4zvqusURQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IBNN2DDR0Dcl/IwfpZgbuK6ffCUSKkBsotj/nIzdLADk5J2ZAx+cFFwJQc0sEYcV
	 8GdrnQrzGbktTAvFA/Bhbh5pBF3dwhRh9D737vbhyauCz04MguJj/N4zqlhF7Esso
	 Cn7G/B+LIbovfyGBblxiLmi+YmhBcdcXTTAM9pkyDapxxrth/oI5fm3+Isdq5i07R
	 VBFEFVzl5qWXrve9hX3mG/6+SJJt0PEwUZK8+07r1m1e9yaSzNb8nhLBVp2gsc+oq
	 cOFh5s2jOBK3fiadiEFXm9ONpHEn9rCLlOQni+Pe8EKD+jSWACs7eAa21hlpzlq2f
	 fhpUjMtSHmo0EUI8rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1wKzPK1F1b-00ciJQ; Sat, 17
 Jan 2026 05:09:05 +0100
Message-ID: <9a7a8f54-55ab-43e8-96b5-60e7e43c432e@gmx.com>
Date: Sat, 17 Jan 2026 14:39:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not strictly require dirty metadata
 threshold for metadata writepages
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <6a6b5f2bb0d3cbcdd0d3dc6ee46c3ebfc4ce63af.1768605742.git.wqu@suse.com>
 <20260116233145.GA2693568@zen.localdomain>
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
In-Reply-To: <20260116233145.GA2693568@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PNbtI6yYIhXQKR0++n19vyBwzTqFDqH0S1tsUtMLjwjAmx3iq8Y
 7pcrGKABF3uJFKVwHKZ/SOGeBNvMsJNxDUCamhiUYi99Pr9iF9X2/+PymO39w1UH0Y10TZk
 kXxsmtIIgstrbPtIoHXqQ7yocr4MKD2weYdhD1fKNCo4/Ga5nd9xO3g9bSb+/c5eV3foQ0a
 LfXn7C/yz0HXZrbeQOAtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uICUzcLlseA=;jmGKowTtbyDsbK/9aBBUj3PQuIU
 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



=E5=9C=A8 2026/1/17 10:01, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Jan 17, 2026 at 09:52:31AM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is an internal report that over 1000 processes are
>> waiting at the io_schedule_timeout() of balance_dirty_pages(), causing
>> a system hang and triggered a kernel coredump.
>>
>> [CAUSE]
>>  From Jan Kara for his wisdom on the dirty page balance behavior first.
>>
>>   This cgroup dirty limit was what was actually playing the role here
>>   because the cgroup had only a small amount of memory and so the dirty
>>   limit for it was something like 16MB.
>>
>>   Dirty throttling is responsible for enforcing that nobody can dirty
>>   (significantly) more dirty memory than there's dirty limit. Thus when
>>   a task is dirtying pages it periodically enters into balance_dirty_pa=
ges()
>>   and we let it sleep there to slow down the dirtying.
>>
>>   When the system is over dirty limit already (either globally or withi=
n
>>   a cgroup of the running task), we will not let the task exit from
>>   balance_dirty_pages() until the number of dirty pages drops below the
>>   limit.
>>
>>   So in this particular case, as I already mentioned, there was a cgrou=
p
>>   with relatively small amount of memory and as a result with dirty lim=
it
>>   set at 16MB. A task from that cgroup has dirtied about 28MB worth of
>>   pages in btrfs btree inode and these were practically the only dirty
>>   pages in that cgroup.
>>
>> So that means the only way to reduce the dirty pages of that cgroup is
>> to writeback the dirty pages of btrfs btree inode, and only after that
>> those processes can exit balance_dirty_pages().
>>
>> Now back to the btrfs part, btree_writepages() is responsible for
>> writing back dirty btree inode pages.
>>
>> The problem here is, there is a btrfs internal threshold that if the
>> btree inode's dirty bytes are below the 32M threshold, it will not
>> do any writeback.
>>
>> This behavior is to batch as much metadata as possible so we won't writ=
e
>> back those tree blocks and then later re-COW then again for another
>> modification.
>>
>> This internal 32MiB is higher than the existing dirty page size (28MiB)=
,
>> meaning no writeback will happen, causing a deadlock between btrfs and
>> cgroup:
>>
>> - Btrfs doesn't want writeback btree inode until more dirty pages
>>
>> - Cgroup/MM doesn't want more dirty pages for btrfs btree inode
>>    Thus any process touching that btree inode is put into sleep until
>>    the number of dirty pages is reduced.
>>
>> Thanks Jan Kara a lot for the analyze on the root cause.
>>
>> [FIX]
>> For internal callers using btrfs_btree_balance_dirty() since that
>> function is already doing internal threshold check, we don't need to
>> bother it.
>>
>> But for external callers of btree_writepages(), then respect their
>> request and just writeback whatever they want, ignoring the internal
>> btrfs threshold to avoid such deadlock on btree inode dirty page
>> balancing.
>=20
> The new version is really well written and clear, thanks.
>=20
> I guess my last comment is that this is really a fix for a bug from the
> past. Like I said, I don't believe this bug will surface in this way
> any more now that btrfs doesn't account btree_inode pages to the cgroup.
>=20
> If you reproduce it on a kernel with AS_KERNEL_FILE, I will of course
> eat my hat on that :)

Oh great you have already pushed that btree-skip-cgroup patchset upstream.
With that we shouldn't hit this deadlock anymore.

I was still under the expression that the series has not merged but I=20
can not be more wrong.

>=20
> I still think it's a reasonable change and support landing it, I guess I
> just feel it's sort of misleading to call it a bug and a fix on for-next=
.
>=20
> At this point, IMO, the only motivation is just simplifying
> btree_writepages() and avoiding any weird cases on systems with tiny
> ram. It really hinges on how likely the dirty page limit is to be <32M
> without cgroups involved.
>=20
> We probably do want to send it to stable trees predating AS_KERNEL_FILE
> though?

I'll update the "[FIX]" section to "[ENHANCEMENT]", and update the=20
commit message to explicitly mention that the new AS_KERNEL_FILE flag=20
will make the folio to be owned by the root cgroup thus there should be=20
no more possibility to hit this one.

Thanks,
Qu

>=20
> Thanks again,
> Boris
>=20
>>
>> Cc: Jan Kara <jack@suse.cz>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Update the commit message to include more details about the
>>    balance_dirty_pages() behavior
>>
>> - With that background knowledge explain the deadlock better
>>    It's between cgroup where no more btree inode dirty pages are allowe=
d
>>    and all involved processes are put into sleep until dirty pages
>>    drops, and btrfs where it won't write back any dirty pages until
>>    there are more dirty pages.
>> ---
>>   fs/btrfs/disk-io.c | 24 +-----------------------
>>   1 file changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 5e4b7933ab20..9add1f287635 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -485,28 +485,6 @@ static int btree_migrate_folio(struct address_spac=
e *mapping,
>>   #define btree_migrate_folio NULL
>>   #endif
>>  =20
>> -static int btree_writepages(struct address_space *mapping,
>> -			    struct writeback_control *wbc)
>> -{
>> -	int ret;
>> -
>> -	if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
>> -		struct btrfs_fs_info *fs_info;
>> -
>> -		if (wbc->for_kupdate)
>> -			return 0;
>> -
>> -		fs_info =3D inode_to_fs_info(mapping->host);
>> -		/* this is a bit racy, but that's ok */
>> -		ret =3D __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
>> -					     BTRFS_DIRTY_METADATA_THRESH,
>> -					     fs_info->dirty_metadata_batch);
>> -		if (ret < 0)
>> -			return 0;
>> -	}
>> -	return btree_write_cache_pages(mapping, wbc);
>> -}
>> -
>>   static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
>>   {
>>   	if (folio_test_writeback(folio) || folio_test_dirty(folio))
>> @@ -584,7 +562,7 @@ static bool btree_dirty_folio(struct address_space =
*mapping,
>>   #endif
>>  =20
>>   static const struct address_space_operations btree_aops =3D {
>> -	.writepages	=3D btree_writepages,
>> +	.writepages	=3D btree_write_cache_pages,
>>   	.release_folio	=3D btree_release_folio,
>>   	.invalidate_folio =3D btree_invalidate_folio,
>>   	.migrate_folio	=3D btree_migrate_folio,
>> --=20
>> 2.52.0
>>
>=20


