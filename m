Return-Path: <linux-btrfs+bounces-6788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540093DAB0
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 00:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F291C23112
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02114A4DB;
	Fri, 26 Jul 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IHn7u16H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1606026A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033155; cv=none; b=rX1DNcjb2MdshqIngBlkxbMdWzTFVYZoonLf6wNgOVTdpV8kDjAnGeLG6yIb5VqTpjFjoQ4szsy6XXn9j2f+oqV6br0gwfjFOCzW3k6oSmc0kItKxfJGfMhIKB2JJx2VK5Qz0FMT2UijdLhi24au+FWuk0QgPF0LspESChbWJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033155; c=relaxed/simple;
	bh=aIa1ZKL9i1L8hUOCtrD9i6lWZehok22ImEMhbIDan2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CI7U+RcJ4wRhIhkKHw1sULlxCbkuGHUw07IebbZjE1uudxsJVUmVrlklF4/acU4vH3k6FLmGeyiddeQ7mcW0N6ivABV3RN1A5AI+m9fFLhlXE1OuPA7TbMYcaa1iWlI04SjPq5V90paTpAv70KSZWPFjQJmCP8VgXGjpSZY+gmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IHn7u16H; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722033150; x=1722637950; i=quwenruo.btrfs@gmx.com;
	bh=4qLKPf5TbcV/xfDTmsM1zya8rfStVbNfTPsSAz8jNzs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IHn7u16H47GLa7BFo4suRhDLNwK3TEtuie0f7Cl8qc14Pd4rSBCOWxCvRNkl7+ix
	 sYfhk28/5M2J07B6eN6YD1k3rSwrAVMfV4RxHQtfvmUdZKu5P6MmlbgKlpZU6HxLb
	 21xQWn1bOy3N2tg8ktWilC4EUIEdgh5c3oz+Gy92cpOGIlzx9GUeUZ8/S9uzIE1LW
	 I7fo+kkAGBAqHz8DcJi2wh7XnjPSYJyKT7WMGaIbFdk16ZyqHpKtmPa6NfYNP44Rd
	 NfO/xNMZqgOROSnTXKdEq08nKe69cL1Ix0/a/TOwsAhRxu95RlY7qhAaI1lw+W0Dn
	 noREF0w4kUBsF75faw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1s6QRM0YYX-00sYJU; Sat, 27
 Jul 2024 00:32:29 +0200
Message-ID: <d5473dd9-69ca-4df3-b4d0-f9d7b0a46a86@gmx.com>
Date: Sat, 27 Jul 2024 08:02:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] btrfs: prefer to allocate larger folio for metadata
To: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <c9bd53a8c7efb8d0e16048036d0596e17e519dd6.1721902058.git.wqu@suse.com>
 <20240726145753.GC3432726@perftesting>
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
In-Reply-To: <20240726145753.GC3432726@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7h6WraEGrXK10WxLyjXjpdDGk9m3yDZ/mMWVwQoYxV3tHaXXGwi
 cuusQx0y4nZ4HMdQEJRG+JGqoWY4LuGuhJ5Vi2vgx5eGTngizbYITfxPCFrWr6AfYo1frcF
 QVVNhBNwE+uVj5PADQy8FIweeUSqNvovA8dfiJnoIhpE4/OnLWbIyW7rtkMXLbmwy9lk4CO
 jyL5A2KwQ2V7nuUIYmltQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vmgehcbHiBU=;s56UGplyIcChghFLyFmqaCIW1jv
 HEILFlkRGyV3iWGMAr9cKQU5WMIo7pwutwwsjm/qEckSAEIDccEc9AKuNYGSCRQ6g+zLMPXL3
 XnJglt+Ow3EWvA3nKZu4KGBsWyIqm8cgzwFw04zg2ANxCgLRLs/EJ8VaEjoVWf2B9crzDNKpM
 trVPHqnBs//22Plzm+HeD1D8TE68QCRdwAE3USRQJAC0gkcF92BK/44fCd/JVHm+FcOrbejMP
 8mjv3Rqg1dbxYHngCVXSp3LXIpCdyfXUCDWL8PpKwKFPykD6V6RoNrGja0EuzRuIai2yGSZdA
 7YmW27fbUQfdlSG1KDlQvimqRzZXzLzlIVpF7MhzxdeDK5WTF8jE/PTsMLxiHoqmZx0Y17izm
 240auhYwmfs2EEPTuQQHnMoz8PBiDQ/Y2XZXRPa3C9YWbgjbq4W+1wLQlcBL8NR7lIzNc1K7V
 3+PAtAVXFD3A/AEwsND9a5mz6bpPQEZ9uvYlR/KV+fdq+d2AzFXS2Km9XOFXl0ntFR6yvr9Rs
 9ooPnbHLcICWTEjf1/I0d+/PbkuChkY939FlnO4NExXNHrBSPQbr6LGu2aemK5je79x8cVWv0
 SzVcYPbEbTyyteAWka4FjUziYcdeCUGRsxBihFiNYbqeOk9XNRnmi2uNDtAP9b98cL1lGzcGU
 PY9ZW84WGYlSrnpxqdZSgFGuJCzIvDx5D1pKowqlW1mJQHStlUNnfZR1QQPIdEuIkgqr7bnCy
 8sZuTFFO1kL0XGUDQ3CxxTgugFaapi/1xREBorrciwa6nQZo75W5fKG4F00OoopvJ1+/uLuxW
 QIMZZBlgL+Rl9Po7rAlU603g==



=E5=9C=A8 2024/7/27 00:27, Josef Bacik =E5=86=99=E9=81=93:
> On Thu, Jul 25, 2024 at 07:41:16PM +0930, Qu Wenruo wrote:
>> Since btrfs metadata is always in fixed size (nodesize, determined at
>> mkfs time, default to 16K), and btrfs has the full control of the folio=
s
>> (read is triggered internally, no read/readahead call backs), it's the
>> best location to experimental larger folios inside btrfs.
>>
>> To enable larger folios, the btrfs has to meet the following conditions=
:
>>
>> - The extent buffer start is aligned to nodesize
>>    This should be the common case for any btrfs in the last 5 years.
>>
>> - The nodesize is larger than page size
>>
>> - MM layer can fulfill our larger folio allocation
>>    The larger folio will cover exactly the metadata size (nodesize).
>>
>> If any of the condition is not met, we just fall back to page sized
>> folio and go as usual.
>> This means, we can have mixed orders for btrfs metadata.
>>
>> Thus there are several new corner cases with the mixed orders:
>>
>> 1) New filemap_add_folio() -EEXIST failure cases
>>     For mixed order cases, filemap_add_folio() can return -EEXIST
>>     meanwhile filemap_lock_folio() returns -ENOENT.
>>     We can only retry several times, before falling back to 0 order
>>     folios.
>>
>> 2) Existing folio size may be different than the one we allocated
>>     This is after the existing eb checks.
>>
>> 2.1) The existing folio is larger than the allocated one
>>       Need to free all allocated folios, and use the existing larger
>>       folio instead.
>>
>> 2.2) The existing folio has the same size
>>       Free the allocated one and reuse the page cache.
>>       This is the existing path.
>>
>> 2.3) The existing folio is smaller than the allocated one
>>       Fall back to re-allocate order 0 folios instead.
>>
>> Otherwise all the needed infrastructure is already here, we only need t=
o
>> try allocate larger folio as our first try in alloc_eb_folio_array().
>>
>> For now, the higher order allocation is only a preferable attempt for
>> debug build, before we had enough test coverage and push it to end
>> users.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> [CHANGELOG]
>> v8:
>> - Drop the memcgroup optimization as dependency
>>    Opting out memcgroup will be pushed as an independent patchset
>>    instead. It's not related to the soft lockup.
>>
>> - Fix a soft lockup caused by mixed folio orders
>> 	 |<- folio ->|
>> 	 |  |  |//|//|   |//| is the existing page cache
>>    In above case, the filemap_add_folio() will always return -EEXIST
>>    but filemap_lock_folio() also returns -ENOENT.
>>    Which can lead to a dead loop.
>>    Fix it by only retrying 5 times for larger folios, then fall back
>>    to 0 order folios.
>>
>> - Slightly rewording the commit messages
>>    Make it shorter and better organized.
>>
>> v7:
>> - Fix an accidentally removed line caused by previous modification
>>    attempt
>>    Previously I was moving that line to the common branch to
>>    unconditionally define root_mem_cgroup pointer.
>>    But that's later discarded and changed to use macro definition, but
>>    forgot to add back the original line.
>>
>> v6:
>> - Add a new root_mem_cgroup definition for CONFIG_MEMCG=3Dn cases
>>    So that users of root_mem_cgroup no longer needs to check
>>    CONFIG_MEMCG.
>>    This is to fix the compile error for CONFIG_MEMCG=3Dn cases.
>>
>> - Slight rewording of the 2nd patch
>>
>> v5:
>> - Use root memcgroup to attach folios to btree inode filemap
>> - Only try higher order folio once without NOFAIL nor extra retry
>>
>> v4:
>> - Hide the feature behind CONFIG_BTRFS_DEBUG
>>    So that end users won't be affected (aka, still per-page based
>>    allocation) meanwhile we can do more testing on this new behavior.
>>
>> v3:
>> - Rebased to the latest for-next branch
>> - Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
>> - Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
>>    and high order allocation"
>>    This allows us to use NOFAIL up to 32K nodesize, and makes sure for
>>    default 16K nodesize, all metadata would go 16K folios
>>
>> v2:
>> - Rebased to handle the change in "btrfs: cache folio size and shift in=
 extent_buffer"
>> ---
>>   fs/btrfs/extent_io.c | 122 ++++++++++++++++++++++++++++++------------=
-
>>   1 file changed, 86 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index aa7f8148cd0d..0beebcb9be77 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -719,12 +719,28 @@ int btrfs_alloc_page_array(unsigned int nr_pages,=
 struct page **page_array,
>>    *
>>    * For now, the folios populated are always in order 0 (aka, single p=
age).
>>    */
>> -static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
>> +static int alloc_eb_folio_array(struct extent_buffer *eb, int order,
>> +				bool nofail)
>>   {
>>   	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] =3D { 0 };
>>   	int num_pages =3D num_extent_pages(eb);
>>   	int ret;
>>
>> +	if (order) {
>> +		gfp_t gfp;
>> +
>> +		if (order > 0)
>> +			gfp =3D GFP_NOFS | __GFP_NORETRY | __GFP_NOWARN;
>> +		else
>> +			gfp =3D nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
>
> This check is useless, we're already checking if (order) above.
>
>> +		eb->folios[0] =3D folio_alloc(gfp, order);
>> +		if (likely(eb->folios[0])) {
>> +			eb->folio_size =3D folio_size(eb->folios[0]);
>> +			eb->folio_shift =3D folio_shift(eb->folios[0]);
>> +			return 0;
>> +		}
>> +		/* Fallback to 0 order (single page) allocation. */
>> +	}
>>   	ret =3D btrfs_alloc_page_array(num_pages, page_array, nofail);
>>   	if (ret < 0)
>>   		return ret;
>> @@ -2707,7 +2723,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>>   	 */
>>   	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>
>> -	ret =3D alloc_eb_folio_array(new, false);
>> +	ret =3D alloc_eb_folio_array(new, 0, false);
>>   	if (ret) {
>>   		btrfs_release_extent_buffer(new);
>>   		return NULL;
>> @@ -2740,7 +2756,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer=
(struct btrfs_fs_info *fs_info,
>>   	if (!eb)
>>   		return NULL;
>>
>> -	ret =3D alloc_eb_folio_array(eb, false);
>> +	ret =3D alloc_eb_folio_array(eb, 0, false);
>>   	if (ret)
>>   		goto err;
>>
>> @@ -2955,7 +2971,16 @@ static int check_eb_alignment(struct btrfs_fs_in=
fo *fs_info, u64 start)
>>   	return 0;
>>   }
>>
>> +static void free_all_eb_folios(struct extent_buffer *eb)
>> +{
>> +	for (int i =3D 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
>> +		if (eb->folios[i])
>> +			folio_put(eb->folios[i]);
>> +		eb->folios[i] =3D NULL;
>> +	}
>> +}
>>
>> +#define BTRFS_ADD_FOLIO_RETRY_LIMIT	(5)
>>   /*
>>    * Return 0 if eb->folios[i] is attached to btree inode successfully.
>>    * Return >0 if there is already another extent buffer for the range,
>> @@ -2973,6 +2998,8 @@ static int attach_eb_folio_to_filemap(struct exte=
nt_buffer *eb, int i,
>>   	struct address_space *mapping =3D fs_info->btree_inode->i_mapping;
>>   	const unsigned long index =3D eb->start >> PAGE_SHIFT;
>>   	struct folio *existing_folio =3D NULL;
>> +	const int eb_order =3D folio_order(eb->folios[0]);
>> +	int retried =3D 0;
>>   	int ret;
>>
>>   	ASSERT(found_eb_ret);
>> @@ -2990,18 +3017,25 @@ static int attach_eb_folio_to_filemap(struct ex=
tent_buffer *eb, int i,
>>   	/* The page cache only exists for a very short time, just retry. */
>>   	if (IS_ERR(existing_folio)) {
>>   		existing_folio =3D NULL;
>> +		retried++;
>> +		/*
>> +		 * We can have the following case:
>> +		 *	|<- folio ->|
>> +		 *	|  |  |//|//|
>> +		 * Where |//| is the slot that we have a page cache.
>> +		 *
>> +		 * In above case, filemap_add_folio() will return -EEXIST,
>> +		 * but filemap_lock_folio() will return -ENOENT.
>> +		 * After several retries, we know it's the above case,
>> +		 * and just fallback to order 0 folios instead.
>> +		 */
>> +		if (eb_order > 0 && retried > BTRFS_ADD_FOLIO_RETRY_LIMIT) {
>> +			ASSERT(i =3D=3D 0);
>> +			return -EAGAIN;
>> +		}
>
> Ok hold on, I'm just now looking at this code, and am completely confuse=
d.
>
> filemap_add_folio inserts our new folio into the mapping and returns wit=
h it
> locked.  Under what circumstances do we end up with filemap_lock_folio()
> returning ENOENT?

Remember we go filemap_lock_folio() only when filemap_add_folio()
returns with -EEXIST.

There is an existing case (all order 0 folios) like this:

=2D-----------------------------+-------------------------------------
filemap_add_folio()           |
Return -EEXIST                |
                               | Some page reclaim happens
                               | Choose the page at exactly the same
                               | index to be reclaimed
filemap_lock_folio            |
return -ENOENT

Remember that between the filemap_add_folio() and filemap_lock_folio()
there is nothing preventing page reclaim from happening.


>
> I understand in this larger folio case where this could happen, but this=
 code
> exists today where we're only allocating 0 order folios.  So does this a=
ctually
> happen today, or were you future proofing it?

It's already happening even for order 0 folios. As we do not hold any
lock for the address space.

>
> Also it seems like a super bad, no good thing that we can end up being a=
llowed
> to insert a folio that overlaps other folios already in the mapping.  So=
 if that
> can happen, that seems like the thing that needs to be addressed generic=
ally.

For the generic __filemap_get_folio() with FGP_CREAT, that's exactly
what we do, just retry with smaller folio.

And in that case, they do the retry if filemap_add_folio() hits -EEXIST
just like us.

>
> This sets off huge alarm bells for me, I'm going to need a more thorough
> explanation of how this happens and why it's ok in the normal case.  Tha=
nks,

Sorry I'm not seeing what you're concerned about.

If you mean why we could have filemap_add_folio() succeeded but
filemap_add_folio() failed, then it's impossible.

Because if filemap_add_folio() succeeded, we will never hit the
remaining code.

If you're concerned about the seemingly infinite retry loop, then it's
the same as __filemap_get_folio().

If you're talking about the fact we are unable to distinguish real
EEXIST and the reclaim race, yes we do not have a good way to do that,
so is the __filemap_get_folio(), except they always try lower folio
order, but that's not something we can do easily here.

Thanks,
Qu

>
> Josef
>

