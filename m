Return-Path: <linux-btrfs+bounces-6791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B093DAE1
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 00:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFE41C21E7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB314F118;
	Fri, 26 Jul 2024 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Eptziik+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF342AAA
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034686; cv=none; b=qAKDeomVfrM0tAOl9hPd5I0uRoZvyARn6o4i2h333Mmzrt4I4B4juHm0zdGCAvGomFpRuyOhLbxAplQ0FEjkmTZQ8Zmi75vVjknP5oauofLd2hwttdU4azDldrpK4WQPn8RMWqmEJmw3yvtUhQj/yh1E1jwf7ZoYsGhErfU9NsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034686; c=relaxed/simple;
	bh=xvOQoXB2DDeywnN5D8xXWh3iQwLGKz4WEVfU/CvJxSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=stJxiOQ45AAPGYQqcb3LtI1BJDODkQuBKIpLQvBtjRZ0jiZD4wGLsSVHX+TkmNDd+B8x+CHJQXdxz8+I8PwSOsKW/xZrMx0d/J8K9NXgP601ZKMOYCAzXEedFbjqwNnvZqXqMOBtT8OW5fKccjo05IfAOEzv7QvNEOE7n2KwJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Eptziik+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722034677; x=1722639477; i=quwenruo.btrfs@gmx.com;
	bh=h+XkBCrI2sJNSJRb3gMiQyV5wziXFupoGZ2AiwU8FI0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Eptziik+PcF4+tW6hlbkZUtvHxL/kqZfUmKwq0aWOhl6Z7yD8Gdxm7uEHYQ8cm6O
	 jSnIkrwBpNGYBYnLrdDhgOeLkjPW69Or9JBsauW9UI2mPYVVxlvWhUBrnM+wg5Iqz
	 bNEZEMAh/os9SnUOu7WC2inHVYRX0AWb9IC5sxqtI+nv38yyngKUp9bQJQ2/kYMJ2
	 plj+klR4M9G+W4wdaikuXykcpc8L+CSaZnev2q0boBy+oYMDZoMfQxaSb/LDVrqVE
	 xEvg5fYuM9qBRlSSz1gCpFr56uMLr0b2RBiteOhexL9IQVouZOGsTa5yCukXsXvH4
	 pKhN0CJWDzH2oh5VxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1sB7vn0LZe-00whnB; Sat, 27
 Jul 2024 00:57:57 +0200
Message-ID: <b98b2b61-8b56-4a92-8de8-a75a645c3dc3@gmx.com>
Date: Sat, 27 Jul 2024 08:27:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] btrfs: convert most of the data path to use folios
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1722022376.git.josef@toxicpanda.com>
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
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzgJHeg+9na8GKUWgtvUPESKlzcVPYBZaCFVOJ6QHcPICNAI535
 X4+LiRdqk/1QNCa0Zq22h7kjaQxMb2F5DmEILF8+ro/Gv4XGIIGlhH36QW0l5k2fQM4DmR1
 2pH7dJO9SAU1ZGyPhdAj6AaKRLa+HhXe/Pg8woLnMaEr6C3P1zd+TQ/lU/Du7eM3o0grS80
 H4lYX7LwqCkwvqdYfvtyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PBv7lSutCxI=;+suJfcmmrw+tItU07Q/AfGBFBpC
 11DGk3eWOr8Cqi4QqdcjfDqzSxFSIpXaR5/MNhv+90fmfksntKkWwEIbWYdKKKmMptJQi9cl1
 BpicnBnTZSsW4njz5bQyrYYBEu1V+4CVIBbgLaLW5dl2qN9cXYZuBaDg2R/bJmheUXIhYmShC
 l25rKbY6v9qSalN+u9Ga1mq/AwikSjKqdBsnlQbXzbWo4h9t02dOzJAF1badvSPs7htRXA8T7
 nHLGQyJjUP5GYnXl/No/ZhBnE9ViOra1ZPE8xPJcUoJuwMnUaOXsCwXr5xfO8Bp0pYgo6aCwi
 Fj6SHY1pULvrvmqwVklqUqONKoS24kc6qpW6oEsDFn4L+ZotGqD9r+edy2YEk+Sg/VNFXsQ1h
 +gDRD4WmylBOQAeu/Jc2WtWra3binfKqj3B4q8ifoK7/US49n071bqzNsbJTI2ZyHWDcQ4tyD
 gvuypjW+A6B17Vs6JHXI/w4gBSflcCEZJq5i1OLWkOimrfZSyAddpzEsN+NnduiHlYU13Aofk
 Aro7xzveq3riGjuBmrVHm28YVELB3sQHzmyA3cN0ndMVVAgYAXVpgfrwoIzC206KIoq6hvsmF
 udUWZU0unhGKmGp2OhGfZPqjrSmW9zxkZ9LpgxD74WHli6T4BjLIzXjaZb/ZIVF6SGFLFwafx
 sJvQrhVdn+i23dDUHleMYzfFAV1j+DGexrqZXD37Qb+idsI9wnE/ayYgtag8iZXK6OCBxCn1c
 DpzqsjpmMasUq8a169ngK2y5ARV7/qXzC+HFoY0out2uBrktFXexauPdj3rjhaJIyZMDjAnO1
 xTIZs5a2PMF6W1nIOX+g69kQ==



=E5=9C=A8 2024/7/27 05:05, Josef Bacik =E5=86=99=E9=81=93:
> Hello,
>
> Willy indicated that he wants to get rid of page->index in the next merg=
e
> window, so I went to look at what that would entail for btrfs, and I got=
 a
> little carried away.
>
> This patch series does in fact accomplish that, but it takes almost the =
entirety
> of the data write path and makes it work with only folios.  I was going =
to
> convert everything, but there's some weird gaps that need to be handled =
in their
> own chunk.
>
> 1. Scrub.  We're still passing around page pointers.  Not a huge deal, i=
t was
>     just another 10ish patches just for that work, so I decided against =
it.
>
> 2. Buffered writes.  Again, I did most of this work and it wasn't bad, b=
ut then
>     I realized that the free space cache uses some of this code, and I r=
eally
>     don't want to convert that code, I want to delete it, so I'll do tha=
t first.

Totally agree, v1 is better to be deprecated.

>
> 3. Metadata.  Qu has been doing this consistently and I didn't want to g=
et in
>     the way of his work so I just left most of that.

I guess there are still metadata codes switching between page and folios.

I'm totally fine if you feel like to convert them to use folios.
The only focus for me is to enable larger folios.
So the conversion part is totally fine.

>
> This has run through the CI and didn't cause any issues.  I've made ever=
ything
> as easy to review as possible and as small as possible.  My eyes started=
 to
> glaze over a little bit with the changelogs, so let me know if there's a=
nything
> you want changed.  Thanks,

Just give us some time to review the whole series though, the pure
amount of patches is already making my eyes glazing.

Thanks,
Qu

>
> Josef
>
> Josef Bacik (46):
>    btrfs: convert btrfs_readahead to only use folio
>    btrfs: convert btrfs_read_folio to only use a folio
>    btrfs: convert end_page_read to take a folio
>    btrfs: convert begin_page_folio to take a folio instead
>    btrfs: convert submit_extent_page to use a folio
>    btrfs: convert btrfs_do_readpage to only use a folio
>    btrfs: update the writepage tracepoint to take a folio
>    btrfs: convert __extent_writepage_io to take a folio
>    btrfs: convert extent_write_locked_range to use folios
>    btrfs: convert __extent_writepage to be completely folio based
>    btrfs: convert add_ra_bio_pages to use only folios
>    btrfs: utilize folio more in btrfs_page_mkwrite
>    btrfs: convert can_finish_ordered_extent to use a folio
>    btrfs: convert btrfs_finish_ordered_extent to take a folio
>    btrfs: convert btrfs_mark_ordered_io_finished to take a folio
>    btrfs: convert writepage_delalloc to take a folio
>    btrfs: convert find_lock_delalloc_range to use a folio
>    btrfs: convert lock_delalloc_pages to take a folio
>    btrfs: convert __unlock_for_delalloc to take a folio
>    btrfs: convert __process_pages_contig to take a folio
>    btrfs: convert process_one_page to operate only on folios
>    btrfs: convert extent_clear_unlock_delalloc to take a folio
>    btrfs: convert extent_write_locked_range to take a folio
>    btrfs: convert run_delalloc_cow to take a folio
>    btrfs: convert cow_file_range_inline to take a folio
>    btrfs: convert cow_file_range to take a folio
>    btrfs: convert fallback_to_cow to take a folio
>    btrfs: convert run_delalloc_nocow to take a folio
>    btrfs: convert btrfs_cleanup_ordered_extents to use folios
>    btrfs: convert btrfs_cleanup_ordered_extents to take a folio
>    btrfs: convert run_delalloc_compressed to take a folio
>    btrfs: convert btrfs_run_delalloc_range to take a folio
>    btrfs: convert async_chunk to hold a folio
>    btrfs: convert submit_uncompressed_range to take a folio
>    btrfs: convert btrfs_writepage_fixup_worker to use a folio
>    btrfs: convert btrfs_writepage_cow_fixup to use folio
>    btrfs: convert btrfs_writepage_fixup to use a folio
>    btrfs: convert uncompress_inline to take a folio
>    btrfs: convert read_inline_extent to use a folio
>    btrfs: convert btrfs_get_extent to take a folio
>    btrfs: convert __get_extent_map to take a folio
>    btrfs: convert find_next_dirty_byte to take a folio
>    btrfs: convert wait_subpage_spinlock to only use a folio
>    btrfs: convert btrfs_set_range_writeback to use a folio
>    btrfs: convert insert_inline_extent to use a folio
>    btrfs: convert extent_range_clear_dirty_for_io to use a folio
>
>   fs/btrfs/btrfs_inode.h           |   6 +-
>   fs/btrfs/compression.c           |  62 +++--
>   fs/btrfs/extent_io.c             | 436 +++++++++++++++----------------
>   fs/btrfs/extent_io.h             |   6 +-
>   fs/btrfs/file.c                  |  24 +-
>   fs/btrfs/inode.c                 | 342 ++++++++++++------------
>   fs/btrfs/ordered-data.c          |  28 +-
>   fs/btrfs/ordered-data.h          |   6 +-
>   fs/btrfs/tests/extent-io-tests.c |  10 +-
>   include/trace/events/btrfs.h     |  10 +-
>   10 files changed, 467 insertions(+), 463 deletions(-)
>

