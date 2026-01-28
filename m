Return-Path: <linux-btrfs+bounces-21188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HGuI6xqemkm6AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21188-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 20:59:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E64A8588
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EEFE301C12B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916137472D;
	Wed, 28 Jan 2026 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TjjII4QO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3tupk0T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092123D281
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630368; cv=none; b=sFWhmFrjI6lpj/CJ7htIfFpiFBa9Uh8typZ1gX5u/5X+9KBeSGT09mIvAv7Zyi22oqKWwYSXpuaiWG1Mgz/AleE+8rqUgrJSE8ZYYmvRBBymZZAT1PBSKwOVQBvNzD9Rtp8j2fU0FTpLYLbowCGo/YwNehEBRS+8aKtTtmPgKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630368; c=relaxed/simple;
	bh=swSyJSVUfN76s4DEugAb4iGl05JIaZeH58L/zFRl1Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUdnCq7thYD0DUshufCkXNHd7Oaoy1wg8wfd6z6w7hkcTBQKqqGhm15KINSUX5fVI9xT6ykjRyVt6RPEcLdzKNZoDb4tWFoavQlr2/3PjH7l9GOUaLSq0k/aku29q8DV8G1NA1CU/OOXb0N4l8eoFS8X468bvshn42J/xI5r/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TjjII4QO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3tupk0T; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F2FB2EC0563;
	Wed, 28 Jan 2026 14:59:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 14:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769630365; x=1769716765; bh=fn9NorpUJN
	5ITPXyZKo2LuLiGI6cHaV4cBycFUzlOIc=; b=TjjII4QOhq0E9f++1i4ha8xxMn
	g5Pzf2kfhd2lPWum73JbEScinmYSeuwQ9B4sRZAw3KeqzM9kDTKaRM40cbPA8vOy
	5MyT0D7ugI54QQ9ebSfrDPyAfW8PUhEnDwwAsfjdXJD9dWSIhVPkwoO7NoHgt0FA
	aFFZyzWm39ZCRq74vJ01GO6ZomyEJrXCuwTtEFHuvaRh+Jfpe/My0kKLPRP/J94p
	8gic270nKWEYADdglLPzZZR+5bVKrDZoEQ43sgQ0o+B013nZGbS12gwISO2FeJxH
	6fmNrDgW5mB0pNoCKJPNmANRyXfSaduq1HQVR6Smdj1iK99wM0tf4+7SW3Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769630365; x=1769716765; bh=fn9NorpUJN5ITPXyZKo2LuLiGI6cHaV4cBy
	cFUzlOIc=; b=G3tupk0TKYVauQ+U1r+IWqVrvr5AV4ea0Wf7jiAPlIHrtW/nc7w
	c8byHx6vXBshH/epDAu2uZEYMegZCzcelGjldouTwwpjNLs9yXgzT5oyWCBfhf0q
	Jf0P6ulqnkrMFEt/ZfhGvE4gK/uGBPAj6AKfFupQYl8RblbpBF4HaxMwC0UbIF5z
	SlBawrz/zGnrYVmXEcPaaViLk3AMmnX2USHiv85mqJEcRFR50JAx7HfKIFONGmc2
	lLR7yRcQsAw8/nNGWCM9dfLsn4+K22HfkX1PZXqdb+h1d88qTblixEv0R7Pb9q4C
	IAkC6A5tzz5wTfcT5epCo72pSd8dMHQqRPw==
X-ME-Sender: <xms:nWp6aREJewqqBMCd48XtNio6Eimp95-zTujOou7-cqXQtVu1RIil7A>
    <xme:nWp6aWgYfU4xY1m2iMH0JxWEB4YQbfP7GYjm7_HBYEqDWwfxDW1bDlDe9DLOhmqFR
    YMSs9I7ykTkoEHFGmlJ_RCdNKndIvmxPL5eVLeVS3IOC0xrsquABQ>
X-ME-Received: <xmr:nWp6aU8d66YaTMZml-K-qlahO3UG47-lQHgJDkv22_3zyQYV4nhGD_RJC6t_Id3hW2J8Is25XECxZtJBwRfG0ZH9Kb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nWp6aVryCr92KE2MJ4T3ZnCYFSa3DRAs9LPK1PDGygzgtYNHlCO9xw>
    <xmx:nWp6ab_39UGq4onBV3UotHRdoYSFlbTlxGPsvhNsd6tTrKZcTOl8Vw>
    <xmx:nWp6aRXJ-PNcIezNlF--GAQDnGjzIMd9X-N_AoZK_6WYaQgSgY075w>
    <xmx:nWp6aZBzxKyU9qDfLld-umShl0BhDuDQtmgpdcvQOPM2EZ25wcHxYQ>
    <xmx:nWp6abUYzuKq2QV5qUncZ7afStcSQC19x4QocujADn32qx6devoT8FNc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 14:59:25 -0500 (EST)
Date: Wed, 28 Jan 2026 11:59:00 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: used compressed_bio structure for read and
 write
Message-ID: <20260128195900.GB4101846@zen.localdomain>
References: <cover.1769566870.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769566870.git.wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21188-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zen.localdomain:mid,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: 16E64A8588
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:06:59PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v4:
> - Fix a missing kunmap_local() introduced in encoded write changes
>   Which only affects 32bit systems.
> 
> - Fix an incorrect unlikely() usage introduced in encoded write changes
>   Which will not cause any observable problem but completely flips the
>   intention.
> 
> - Fix an allocation loop bug for bs > ps cases in encoded write changes
>   The encoded write has migrated to use btrfs_alloc_compr_folio() which
>   respects the minimal folio size.
>   This means the old PAGE_SIZE based loop condition must also be
>   changed.
> 
> v3:
> - Rebased to the latest for-next branch
>   There is a minor conflict with the format of parameter list of
>   get_current_folio().
> 
> - Call btrfs_free_compr_folio() during cleanup_compressed_bio()
> 
> - Make it more consistent regarding using btrfs_alloc/free_compr_folio()
>   The old compressed read path is using btrfs_alloc_folio_array() but
>   freeing them using btrfs_free_compr_folio().
> 
>   This is fine but never consistent, unify it to use
>   btrfs_free_compr_folio() for all compressed_bio.
> 
> v2:
> - Fix an error in error path of of compress_file_range()
>   If btrfs_compress_bio() returned an error, we should reset @cb to NULL
>   before doing error handling, or cleanup_compressed_bio() can be called
>   on an error pointer.
> 
> - Fix several bugs in zstd_compress_bio() which causes compression
>   failure
>   There are several different bugs in the mostly copy-n-pasted code:
> 
>   * Uncommon @start and @len usage
>     The old code allows @start and @len to be modified, which is against
>     the more common practice nowadays.
> 
>   * Fix a incorrect input buffer check
>     Which cause us to incorrectly end the compression early and fallback
>     to uncompressed write.
> 
> I was never a huge fan of the current btrfs_compress_folios() interface:
> 
> - Complex and duplicated parameter list
> 
>   * A folio array to hold all folios
>     Which means extra error handling.
> 
>   * A @nr_folios pointer
>     That pointer is both input and output, representing the number of max
>     folios, but also the number of compressed folios.
> 
>     The number of input folios is not really necessary, it's always no
>     larger than DIV_ROUND_UP(len, PAGE_SIZE) in the first place.
> 
>   * A @total_in pointer
>     Again an pointer as both input and output, representing the filemap
>     range length, and how many bytes are compressed in this run.
> 
>     However if we failed to compress the full range, all supported
>     algorithms will return an error, thus fallback to uncompressed path.
> 
>     Thus there is no need to use it as an output pointer.
> 
>   * A @total_compressed point
>     Again an pointer as both input and output, representing the max
>     number of compressed size, and the final compressed size.
> 
>     However we do not need it as an input at all, we always error out
>     if the compressed size is larger than the original size.
> 
> - Extra error cleanup handling
> 
>   We need to cleanup the compressed_folios[] array during error
>   handling.
> 
> Replace the old btrfs_compress_folios() interface with
> btrfs_compress_bio(), which has the following benefits:
> 
> - Simplified parameter list
> 
>   * inode
>   * start
>   * len
>   * compress_type
>   * compress_level 
>   * write_flags
> 
>     No parameter is sharing input and output members, and all are very
>     straightforward (except the last write_flags, which is just an extra
>     bio flag).
> 
> - Directly return a compressed_bio structure
> 
>   With minor modifications, that pointer can be passed to
>   btrfs_submit_bio().
> 
>   The caller still needs to do proper round up and fill the proper
>   disk_bytenr/num_bytes before submission.
> 
>   And for error handling, simply call cleanup_compressed_bio() then
>   everything is cleaned up properly (at least I hope so).
> 
> - No more extra folios array passing and error handling

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> 
> Qu Wenruo (9):
>   btrfs: introduce lzo_compress_bio() helper
>   btrfs: introduce zstd_compress_bio() helper
>   btrfs: introduce zlib_compress_bio() helper
>   btrfs: introduce btrfs_compress_bio() helper
>   btrfs: switch to btrfs_compress_bio() interface for compressed writes
>   btrfs: remove the old btrfs_compress_folios() infrastructures
>   btrfs: get rid of compressed_folios[] usage for compressed read
>   btrfs: get rid of compressed_folios[] usage for encoded writes
>   btrfs: get rid of compressed_bio::compressed_folios[]
> 
>  fs/btrfs/compression.c | 208 ++++++++++++++++++-------------------
>  fs/btrfs/compression.h |  40 ++++----
>  fs/btrfs/inode.c       | 226 ++++++++++++++++++++---------------------
>  fs/btrfs/lzo.c         | 223 ++++++++++++++++++++++++++--------------
>  fs/btrfs/zlib.c        |  64 ++++++------
>  fs/btrfs/zstd.c        |  98 +++++++++---------
>  6 files changed, 457 insertions(+), 402 deletions(-)
> 
> -- 
> 2.52.0
> 

