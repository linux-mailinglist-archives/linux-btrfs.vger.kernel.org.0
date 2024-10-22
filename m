Return-Path: <linux-btrfs+bounces-9078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB909AB828
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C661C240BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3731CC14A;
	Tue, 22 Oct 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iTvVr7Bq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0813AD2A
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631098; cv=none; b=agfk//i9dj75wXs7TeI3uHhiEDQPBdT3roe1xxC0OlYGCQcxGpIArbZ+W0mOmtmk7bIKCQqOa3QBaXlwTuuonuEgiRlsPUE3Q0OWUVkIk5biNVYG2qsvcHDqz3iz9peT/nlKdeGVxOFxO75vZzdUJQh5ORrSCWUEaaiq8ftSGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631098; c=relaxed/simple;
	bh=BGP/JiL6e5Q/E5uZ0c90p4kf1r352P1DYmM+YfVCbS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPclPw6MsSwQtXOgPx01si0ZszhsMe8Z2GzEMOD1R44AF7dTYjFM99C/2FUsWD4DZiMNo4Of+x+V2eSsl1cXiAxAnNuyYHafWwkxX6LAdpiNtRuppoSWf9Iz2fGL2FGhifOPVEL7kgwaYPNXuf75gDDdHFN2jH4pxLwkgu+32nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iTvVr7Bq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729631087; x=1730235887; i=quwenruo.btrfs@gmx.com;
	bh=I0YxWrMLFrXXhwcYbIBqQ6xKEbM9RoTBw4EJaz67y90=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iTvVr7BqjFfA9ASvK4R9x3Clj5EEVU32BDYgWPIE+QpA5hpFrz6Q4agAAU9oLfu5
	 6HboQAbsjBk26wGfGIhwZnKvOyexAIcqSpt3G05kx7t/dDNyyfAtpKK3nUUHgPATN
	 Wt2tapAxPJqn5MjGjMEG6dU0QW2eXOzIprd4e8sbEhDLLM+HCC8XJ9A0eyOEIajtr
	 qsbvX3EeZs9uhCSxnmUGBLy6qzSkBkoQO5iCwe7kBh4svMCDVXJ4OZhE2PoEpsRxa
	 a3Zy6T4eeeV2gaVBxozeWUmW6ZU5en+nIEh/YLFuD2nshlsgsDuj+XJOhyyQei21g
	 BcRFe2XMAF767ig4Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJVG-1tZvSK2UXm-00nwYI; Tue, 22
 Oct 2024 23:04:47 +0200
Message-ID: <88cc2302-bf4d-4296-bfcd-a5acd84cab4d@gmx.com>
Date: Wed, 23 Oct 2024 07:34:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid deadlock when reading a partial uptodate
 folio
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <68342f70406107c376dc8e3b1a6cd67a7e9a6b3e.1729392197.git.wqu@suse.com>
 <CAL3q7H4TeBx=QGXKsHBB_HWShCL+YYpbJBEmHBbOazYzBDuuHQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4TeBx=QGXKsHBB_HWShCL+YYpbJBEmHBbOazYzBDuuHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fBAbGqShmTRvvtYepWY3WhM3k9WDPzBtZugf7Sehje3fao0+iqN
 ho0yLIpoErSOimKCa5PuQ8qAd5EISRsqneYv4EAvcyCojGAv8VC9IS8eecDRJlJI3LV4BW3
 WU5EXD13EvuVuxWc3uFgRHDPNL7noHB0edU+M+sDLI7lxUuajY8XTUIOPQ7/Lbm5FdYvsf1
 csofRObmJITweyU8pGCyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WDj/E0Zb9TM=;0Hl+qA0UVNFCdmPxX0iOa459BkF
 NGK0wiTN6mIWNbT6z+Vapq5Zvdq17VOtXAPOj6co/Wck0KWZsGLcopdGRsBB18XkmGa07Qfm1
 2huSH82MJpD+CN1vcP9nvhC8zzsvn3YYohhlrSQkGRQLfiOB6l/x3oiJGwgxTM0kqUrGAVNXs
 DFvCJ2Q8MDS8ozRLl7df4TZDS6feCB1+rxOHNl1LBdjyL4aI7BjU4CLwKGUKMYzUQCuG8KH5P
 5mQIJ/6S28DEVwSaXj3/Ua9K13rj4HDVWIeabsff3Dnu2KRm/29g5MQ7C7ghJNTJmGnyga4wm
 fH5jniJxUAeNegsSSW2GOsCq/EN84QujFSJQNeguAI343RewJLPr8NeUQBKCWKMjKteFAgg1p
 R2zQO45ZTqKabzlEFmT0bR6x3I+1xRc9R4+WVAj9qPL73gqO/QnPdn60UxKqTSaa8kpmsiPLz
 /r2527OPEOoU1/itXiMkoNR+u5oPl/5OWU+KHDs/CGbnOAEwIcDhn7Hye80D2PNCwYoK6s8BX
 rXVbGYQMh39VOInLnn1GKjcdHpyhepEKpItmNwrPdXzGK9KRAheViaRVNnPoxbj/wm1HT/8jr
 yBpUUxe1za2mFxD9Zl5sMzByVWTWAMxzYt60h5Qnoc+Kj6lz039jl5ecq/NSc4R+EeVUoBJ7r
 hs/UPYwp+u1MF/uSbGGNJ7QSm/K+z4rQoxQAcureoFn5U0bxm+uYqyvAuhtEYuUJY5PvMg/xo
 X298J6TYHpK3AYN7Y0akwHhYa7r/z3ePdcEP2AoZs5TkvZszN9bwj0UgO6rQH0ibWITBvjIU+
 anT+FF3bG1qKndclJrFEiDwBOthFnMA/KMx/CZR47UwMQ=



=E5=9C=A8 2024/10/22 22:03, Filipe Manana =E5=86=99=E9=81=93:
> On Sun, Oct 20, 2024 at 3:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> If the sector size is smaller than page size, and we allow btrfs to
>> avoid reading the full page as long as the buffered write range is
>
> as long as -> because
>
> Otherwise it's confusing.
>
>> sector aligned, we can hit a hang with generic/095 runs:
>>
>>    __switch_to+0xf8/0x168
>>    __schedule+0x328/0x8a8
>>    schedule+0x54/0x140
>>    io_schedule+0x44/0x68
>>    folio_wait_bit_common+0x198/0x3f8
>>    __folio_lock+0x24/0x40
>>    extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
>>    btrfs_writepages+0x94/0x158 [btrfs]
>>    do_writepages+0x74/0x190
>>    filemap_fdatawrite_wbc+0x88/0xc8
>>    __filemap_fdatawrite_range+0x6c/0xa8
>>    filemap_fdatawrite_range+0x1c/0x30
>>    btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
>>    btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
>>    __get_extent_map+0xa0/0x220 [btrfs]
>>    btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
>>    btrfs_read_folio+0x50/0xa0 [btrfs]
>>    filemap_read_folio+0x54/0x110
>>    filemap_update_page+0x2e0/0x3b8
>>    filemap_get_pages+0x228/0x4d8
>>    filemap_read+0x11c/0x3b8
>>    btrfs_file_read_iter+0x74/0x90 [btrfs]
>>    new_sync_read+0xd0/0x1d0
>>    vfs_read+0x1a0/0x1f0
>>
>> [CAUSE]
>> The above call trace shows that, during the folio read a writeback is
>> triggered on the same folio.
>> And since during btrfs_do_readpage(), the folio is locked, the writebac=
k
>> will never be able to get the folio, thus it is waiting on itself thus
>> causing the deadlock.
>
> get the folio -> lock the folio
>
>>
>> The root cause is a little complex, the system is 64K page sized, with
>> 4K sector size:
>>
>> 1) The folio has its range [48K, 64K) marked dirty by buffered write
>>
>>     0          16K         32K          48K         64K
>>     |                                   |///////////|
>>                                               \- sector Uptodate|Dirty
>>
>> 2) Writeback finished for [48K, 64K), but ordered extent not yet finish=
ed
>>
>>     0          16K         32K          48K         64K
>>     |                                   |///////////|
>>                                               \- sector Uptodate
>>                                                  extent map PINNED
>>                                                  OE still here
>>
>> 3) Direct IO tries to drop the folio
>
> Drop the folio - what do you mean? Dropping the pages from the page cach=
e?
> That is, the call to kiocb_invalidate_pages() from
> fs/iomap/direct-io.c:__iomap_dio_rw()?

Yes, which eventually triggers btrfs_release_folio().

>
> For such things can you please mention the names of the functions
> involved in order to remove any ambiguities or confusions?
>
>>     Since there is no locked extent map, btrfs allows the folio to be
>
> Locked extent map? What do you mean?
> We don't have locks on the extent maps themselves.
>
> I suppose you mean we don't have the file range locked in the inode's
> io_tree (EXTENT_LOCKED bit), which we
> check at extent_io.c:try_release_extent_state(), and that it is
> triggered through the btrfs_release_folio() callback
> when the iomap code attempts do invalidate the pages from the page
> cache with that function mentioned above.
>
> Please mention all these details, they are important to make it clear.
>
>>     released. Now no sector in the folio has uptodate flag.
>>     But extent map and OE are still here.
>>
>>     0          16K         32K          48K         64K
>>     |                                   |///////////|
>>                                               \- extent map PINNED
>>                                                  OE still here
>>
>> 4) Buffered write dirtied range [0, 16K)
>>     Since it's sector aligned, btrfs didn't read the full folio from di=
sk.
>>
>>     0          16K         32K          48K         64K
>>     |//////////|                        |///////////|
>>         \- sector Uptodate|Dirty              \- extent map PINNED
>>                                                  OE still here
>>
>> 5) Read on the folio is triggered
>>     For the range [0, 16), since it's already uptodate, btrfs skip this
>
> 16 -> 16K
> skip -> skips
>
>>     range.
>>     For the range [16K, 48K), btrfs submit the read from disk.
>>
>>     The problem comes to the range [48K, 64K), the following call chain
>
> to the range -> for the range
>
>>     happens:
>>
>>     btrfs_do_readpage()
>>     \- __get_extent_map()
>>      \- btrfs_lock_and_flush_ordered_range()
>>       \- btrfs_start_ordered_extent()
>>        \- filemap_fdatawrite_range()
>>
>>     Since the folio indeed has dirty sectors in range [0, 16K), the ran=
ge
>>     will be written back.
>>
>>     But the folio is already locked by the folio read, the writeback
>>     will never be able to lock the folio, thus lead to the deadlock.
>>
>> This sequence can only happen if all the following conditions are met:
>>
>> - The sector size is smaller than page size
>
> Missing punctuation at the end of the sentence, since bellow we start
> a new phrase that ends with punctuation.
>
>>    Or we won't have mixed dirty blocks in the same folio we're reading.
>>
>> - We allow the buffered write to skip the folio read if it's sector
>>    aligned
>
> Same here.
>
>>    This is the incoming new optimization for sector size < page size to
>>    pass generic/563.
>
> Ok, so I'm confused after reading this.
> Does it mean that this deadlock only happens with that optimization
> introduced in btrfs? That it's a patch not yet in for-next?
>
> If that's the case please make the changelog more explicit, saying
> this deadlock only happens after the patch (or patches) introducing
> that
> optimization are merged.
>
>>
>>    Or the folio will be fully read from the disk, before marking it
>>    dirty.
>>    Thus will not trigger the deadlock.
>
> Ok so this reinforces the idea that the issue only happens after that
> optimization that is not yet merged.
> However I'm not sure.
>
>>
>> [FIX]
>> - Only lookup for the extent map of the next sector to read
>>    To avoid touching ranges that can be skipped by per-sector uptodate
>>    flag.
>
> What do you mean by touching ranges?
> The extent map lookup at btrfs_do_readpage() uses the extent map for
> reading only.
>
> I'm not seeing why at btrfs_do_readpage() we have now to specify a
> length of blocksize
> instead of "end - cur + 1".
> If an existing map exists for that range
> with an end offset beyond "start + blocksize - 1",
> we'll get the extent map with that end offset (length) unchanged.

Indeed this is no longer needed.

The new btrfs_start_ordered_extent() will skip the writeback for the
locked folio anyway.

>
>>
>> - Break the step 5) of the above case
>
> End with .
>
>>    By passing an optional @locked_folio into btrfs_start_ordered_extent=
()
>>    and btrfs_lock_and_flush_ordered_range().
>>    If we got such locked folio, do extra asserts to make sure the targe=
t
>>    range is already not dirty, then skip writeback for ranges of that
>>    folio.
>>
>>    So far only the call site inside __get_extent_map() is passing the n=
ew
>>    parameter.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> RFC->v1:
>> - Go with extra @locked_folio parameter for btrfs_start_ordered_extent(=
)
>>    This is more straightforward compared to skipping folio releasing.
>>    This also solves some painful slowdown of other test cases.
>> ---
>>   fs/btrfs/defrag.c       |  2 +-
>>   fs/btrfs/direct-io.c    |  2 +-
>>   fs/btrfs/extent_io.c    |  5 +--
>>   fs/btrfs/file.c         |  8 ++---
>>   fs/btrfs/inode.c        |  6 ++--
>>   fs/btrfs/ordered-data.c | 69 ++++++++++++++++++++++++++++++++++++----=
-
>>   fs/btrfs/ordered-data.h |  8 +++--
>>   7 files changed, 78 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
>> index 1644470b9df7..2467990d6ac7 100644
>> --- a/fs/btrfs/defrag.c
>> +++ b/fs/btrfs/defrag.c
>> @@ -902,7 +902,7 @@ static struct folio *defrag_prepare_one_folio(struc=
t btrfs_inode *inode, pgoff_t
>>                          break;
>>
>>                  folio_unlock(folio);
>> -               btrfs_start_ordered_extent(ordered);
>> +               btrfs_start_ordered_extent(ordered, NULL);
>>                  btrfs_put_ordered_extent(ordered);
>>                  folio_lock(folio);
>>                  /*
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index a7c3e221378d..2fb02aa19be0 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -103,7 +103,7 @@ static int lock_extent_direct(struct inode *inode, =
u64 lockstart, u64 lockend,
>>                           */
>>                          if (writing ||
>>                              test_bit(BTRFS_ORDERED_DIRECT, &ordered->f=
lags))
>> -                               btrfs_start_ordered_extent(ordered);
>> +                               btrfs_start_ordered_extent(ordered, NUL=
L);
>>                          else
>>                                  ret =3D nowait ? -EAGAIN : -ENOTBLK;
>>                          btrfs_put_ordered_extent(ordered);
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 7680dd94fddf..765ec965b882 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -922,7 +922,8 @@ static struct extent_map *__get_extent_map(struct i=
node *inode,
>>                  *em_cached =3D NULL;
>>          }
>>
>> -       btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start=
 + len - 1, &cached_state);
>> +       btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), folio, start=
,
>> +                                          start + len - 1, &cached_sta=
te);
>>          em =3D btrfs_get_extent(BTRFS_I(inode), folio, start, len);
>>          if (!IS_ERR(em)) {
>>                  BUG_ON(*em_cached);
>> @@ -986,7 +987,7 @@ static int btrfs_do_readpage(struct folio *folio, s=
truct extent_map **em_cached,
>>                          end_folio_read(folio, true, cur, blocksize);
>>                          continue;
>>                  }
>> -               em =3D __get_extent_map(inode, folio, cur, end - cur + =
1,
>> +               em =3D __get_extent_map(inode, folio, cur, blocksize,
>
> So this is the part I don't understand why it makes any difference.
>
>>                                        em_cached);
>
> If this is indeed necessary, it's a good opportunity to make this more
> readable by putting the function call into a single line, since it's
> below 80 characters.
>
>>                  if (IS_ERR(em)) {
>>                          end_folio_read(folio, false, cur, end + 1 - cu=
r);
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 676eddc9daaf..7521fbefa9fd 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -987,7 +987,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode =
*inode, struct folio *folio,
>>                                        cached_state);
>>                          folio_unlock(folio);
>>                          folio_put(folio);
>> -                       btrfs_start_ordered_extent(ordered);
>> +                       btrfs_start_ordered_extent(ordered, NULL);
>>                          btrfs_put_ordered_extent(ordered);
>>                          return -EAGAIN;
>>                  }
>> @@ -1055,8 +1055,8 @@ int btrfs_check_nocow_lock(struct btrfs_inode *in=
ode, loff_t pos,
>>                          return -EAGAIN;
>>                  }
>>          } else {
>> -               btrfs_lock_and_flush_ordered_range(inode, lockstart, lo=
ckend,
>> -                                                  &cached_state);
>> +               btrfs_lock_and_flush_ordered_range(inode, NULL, locksta=
rt,
>> +                                                  lockend, &cached_sta=
te);
>>          }
>>          ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_by=
tes,
>>                                 NULL, nowait, false);
>> @@ -1895,7 +1895,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
>>                  unlock_extent(io_tree, page_start, page_end, &cached_s=
tate);
>>                  folio_unlock(folio);
>>                  up_read(&BTRFS_I(inode)->i_mmap_lock);
>> -               btrfs_start_ordered_extent(ordered);
>> +               btrfs_start_ordered_extent(ordered, NULL);
>>                  btrfs_put_ordered_extent(ordered);
>>                  goto again;
>>          }
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index a21701571cbb..56bd33cf864b 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -2773,7 +2773,7 @@ static void btrfs_writepage_fixup_worker(struct b=
trfs_work *work)
>>                  unlock_extent(&inode->io_tree, page_start, page_end,
>>                                &cached_state);
>>                  folio_unlock(folio);
>> -               btrfs_start_ordered_extent(ordered);
>> +               btrfs_start_ordered_extent(ordered, NULL);
>>                  btrfs_put_ordered_extent(ordered);
>>                  goto again;
>>          }
>> @@ -4783,7 +4783,7 @@ int btrfs_truncate_block(struct btrfs_inode *inod=
e, loff_t from, loff_t len,
>>                  unlock_extent(io_tree, block_start, block_end, &cached=
_state);
>>                  folio_unlock(folio);
>>                  folio_put(folio);
>> -               btrfs_start_ordered_extent(ordered);
>> +               btrfs_start_ordered_extent(ordered, NULL);
>>                  btrfs_put_ordered_extent(ordered);
>>                  goto again;
>>          }
>> @@ -4918,7 +4918,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, =
loff_t oldsize, loff_t size)
>>          if (size <=3D hole_start)
>>                  return 0;
>>
>> -       btrfs_lock_and_flush_ordered_range(inode, hole_start, block_end=
 - 1,
>> +       btrfs_lock_and_flush_ordered_range(inode, NULL, hole_start, blo=
ck_end - 1,
>>                                             &cached_state);
>>          cur_offset =3D hole_start;
>>          while (1) {
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index 2104d60c2161..29434fab8a06 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct bt=
rfs_work *work)
>>          struct btrfs_ordered_extent *ordered;
>>
>>          ordered =3D container_of(work, struct btrfs_ordered_extent, fl=
ush_work);
>> -       btrfs_start_ordered_extent(ordered);
>> +       btrfs_start_ordered_extent(ordered, NULL);
>>          complete(&ordered->completion);
>>   }
>>
>> @@ -845,12 +845,16 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_inf=
o *fs_info, u64 nr,
>>    * Wait on page writeback for all the pages in the extent and the IO =
completion
>>    * code to insert metadata into the btree corresponding to the extent=
.
>>    */
>> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
>> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
>> +                               struct folio *locked_folio)
>>   {
>>          u64 start =3D entry->file_offset;
>>          u64 end =3D start + entry->num_bytes - 1;
>>          struct btrfs_inode *inode =3D entry->inode;
>> +       u64 skip_start;
>> +       u64 skip_end;
>
> These can be declared instead in the if statement's block below.
>
>>          bool freespace_inode;
>> +       bool skip_writeback =3D false;
>>
>>          trace_btrfs_ordered_extent_start(inode, entry);
>>
>> @@ -860,13 +864,59 @@ void btrfs_start_ordered_extent(struct btrfs_orde=
red_extent *entry)
>>           */
>>          freespace_inode =3D btrfs_is_free_space_inode(inode);
>>
>> +       /*
>> +        * The locked folio covers the ordered extent range and the ful=
l
>> +        * folio is dirty.
>> +        * We can not trigger writeback on it, as we will try to lock
>> +        * the same folio we already hold.
>> +        *
>> +        * This only happens for sector size < page size case, and even
>> +        * that happens we're still safe because this can only happen
>> +        * when the range is submitted and finished, but OE is not yet
>> +        * finished.
>> +        */
>> +       if (locked_folio) {
>> +               skip_start =3D max_t(u64, folio_pos(locked_folio), star=
t);
>> +               skip_end =3D min_t(u64,
>> +                               folio_pos(locked_folio) + folio_size(lo=
cked_folio),
>> +                               end + 1) - 1;
>
> The variables aren't used outside this scope, so they can be declared
> here and made const too.
>
>> +
>> +               ASSERT(folio_test_locked(locked_folio));
>> +
>> +               /* The folio should intersect with the OE range. */
>> +               ASSERT(folio_pos(locked_folio) <=3D end ||
>> +                      folio_pos(locked_folio) + folio_size(locked_foli=
o) > start);
>> +
>> +               /*
>> +                * The range must not be dirty.  The range can be submi=
tted (writeback)
>> +                * or submitted and finished, then the whole folio rele=
ased (no flag).
>> +                *
>> +                * If the folio range is dirty, we will deadlock since =
the OE will never
>> +                * be able to finish.
>
> Why?
> Isn't the problem that we deadlock on the folio lock when starting
> writeback because we have already locked it before in case we are in a
> read path?

Because that will cause another deadlock.

If the blocks are dirty, then the correponsind OE will never finish
since part of it is never submitted.

>
> So I don't see what's the relation of the deadlock with OE completion.
> Especially because btrfs_lock_and_flush_ordered_range() unlocks the
> extent range in the inode's io_tree before calling
> btrfs_start_ordered_extent().
>
>
>> +                */
>> +               btrfs_folio_assert_not_dirty(inode->root->fs_info, lock=
ed_folio,
>> +                                            skip_start, skip_end  + 1 =
- skip_start);
>> +               skip_writeback =3D true;
>
> Since this is only expected for the subpage scenario, maybe make it
> explicit that we only expect a non-NULL folio if we are a subpage fs
> (add an assert or something).

Please drop the assumption that subpage is only for sector size < page siz=
e.

In the long run, we will support larger folios (aka, mixed folio
orders), which means even sector size =3D=3D page size, we will go subpage
routine eventually.

Thanks,
Qu

>
>> +       }
>>          /*
>>           * pages in the range can be dirty, clean or writeback.  We
>>           * start IO on any dirty ones so the wait doesn't stall waitin=
g
>>           * for the flusher thread to find them
>>           */
>> -       if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
>> -               filemap_fdatawrite_range(inode->vfs_inode.i_mapping, st=
art, end);
>> +       if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags)) {
>> +               if (!skip_writeback)
>> +                       filemap_fdatawrite_range(inode->vfs_inode.i_map=
ping, start, end);
>> +               else {
>
> Please put the if branch with { } as well.
>
>> +                       /* Need to skip the locked folio range. */
>> +                       if (start < folio_pos(locked_folio))
>> +                               filemap_fdatawrite_range(inode->vfs_ino=
de.i_mapping,
>> +                                               start, folio_pos(locked=
_folio) - 1);
>> +                       if (end + 1 > folio_pos(locked_folio) + folio_s=
ize(locked_folio))
>> +                               filemap_fdatawrite_range(inode->vfs_ino=
de.i_mapping,
>> +                                               folio_pos(locked_folio)=
 + folio_size(locked_folio),
>> +                                               end);
>> +               }
>> +       }
>>
>>          if (!freespace_inode)
>>                  btrfs_might_wait_for_event(inode->root->fs_info, btrfs=
_ordered_extent);
>> @@ -921,7 +971,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *in=
ode, u64 start, u64 len)
>>                          btrfs_put_ordered_extent(ordered);
>>                          break;
>>                  }
>> -               btrfs_start_ordered_extent(ordered);
>> +               btrfs_start_ordered_extent(ordered, NULL);
>>                  end =3D ordered->file_offset;
>>                  /*
>>                   * If the ordered extent had an error save the error b=
ut don't
>> @@ -1141,6 +1191,8 @@ struct btrfs_ordered_extent *btrfs_lookup_first_o=
rdered_range(
>>    * @inode:        Inode whose ordered tree is to be searched
>>    * @start:        Beginning of range to flush
>>    * @end:          Last byte of range to lock
>> + * @locked_folio: If passed, will not start writeback to avoid locking=
 the same
>> + *               folio already locked by the caller.
>
> Doesn't match what happens - writeback is started except for the range
> covered by the folio - that is, we do it for any range not covered by
> the folio.
>
> Everything else looks good to me.
>
> Thanks.
>
>>    * @cached_state: If passed, will return the extent state responsible=
 for the
>>    *                locked range. It's the caller's responsibility to f=
ree the
>>    *                cached state.
>> @@ -1148,8 +1200,9 @@ struct btrfs_ordered_extent *btrfs_lookup_first_o=
rdered_range(
>>    * Always return with the given range locked, ensuring after it's cal=
led no
>>    * order extent can be pending.
>>    */
>> -void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64=
 start,
>> -                                       u64 end,
>> +void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode,
>> +                                       struct folio *locked_folio,
>> +                                       u64 start, u64 end,
>>                                          struct extent_state **cached_s=
tate)
>>   {
>>          struct btrfs_ordered_extent *ordered;
>> @@ -1174,7 +1227,7 @@ void btrfs_lock_and_flush_ordered_range(struct bt=
rfs_inode *inode, u64 start,
>>                          break;
>>                  }
>>                  unlock_extent(&inode->io_tree, start, end, cachedp);
>> -               btrfs_start_ordered_extent(ordered);
>> +               btrfs_start_ordered_extent(ordered, locked_folio);
>>                  btrfs_put_ordered_extent(ordered);
>>          }
>>   }
>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>> index 4e152736d06c..a4bb24572c73 100644
>> --- a/fs/btrfs/ordered-data.h
>> +++ b/fs/btrfs/ordered-data.h
>> @@ -191,7 +191,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_ext=
ent *entry,
>>                             struct btrfs_ordered_sum *sum);
>>   struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs=
_inode *inode,
>>                                                           u64 file_offs=
et);
>> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
>> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
>> +                               struct folio *locked_folio);
>>   int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u6=
4 len);
>>   struct btrfs_ordered_extent *
>>   btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file=
_offset);
>> @@ -207,8 +208,9 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *r=
oot, u64 nr,
>>                                 const struct btrfs_block_group *bg);
>>   void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
>>                                const struct btrfs_block_group *bg);
>> -void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64=
 start,
>> -                                       u64 end,
>> +void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode,
>> +                                       struct folio *locked_folio,
>> +                                       u64 start, u64 end,
>>                                          struct extent_state **cached_s=
tate);
>>   bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 star=
t, u64 end,
>>                                    struct extent_state **cached_state);
>> --
>> 2.47.0
>>
>>
>


