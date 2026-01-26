Return-Path: <linux-btrfs+bounces-21080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNOfIz7Ed2nckgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21080-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 20:45:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F838CB7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D031D304C0BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602CD2868A9;
	Mon, 26 Jan 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JwWfk6cJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLvFsyqb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF12853F7
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456518; cv=none; b=ApYJmCpP7pit/08l0ghpuG5n4MY9hpi8BWIwnK65fJu6lFzbJCGb7M4X/01cKxJ2zwgW4ZeDnetHma7umMqBc8Q9M2RiUBxQZlajEbJzMP7c7f3mp246mloNzoVHjo9uoBtpfai/ncwqGypIt8aOyV+ce81iPAASutJDxvh/ZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456518; c=relaxed/simple;
	bh=F1UWb4qwhnRrzHLA0DbgumZ49r2Dx64hPP+h2va54HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u32TYA92ICQc7NSavuRFVbRicNFKVXsIRGRKpmA02KjEBOu7SdEHd05GdgnBhPEp47fmoAMUgz9dia5RAeOJH5N/OEi1k9deWqw0zSDAXSISRrgrkD7aZQxwamZ8Z+vAZr5MA+beTV3bkbt0LZfsUYyODkBg+Mc1Pa/ELQi+Va8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JwWfk6cJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLvFsyqb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56B8F7A02AE;
	Mon, 26 Jan 2026 14:41:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 14:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769456516; x=1769542916; bh=Zt5nQh5lO9
	nxwYFMEFhe5i88n3BksBjsKL3UyjoZRYQ=; b=JwWfk6cJGycI1FZp06GQBKCKGY
	EnoNcf3erHj+z1iOwfncSUI1M+UM5Q0yMN8VltG6cU9ASfBplJRRzR1gABnw7Z33
	9W7yBnCGs41YGyN/iMR4AUB17ZJOXSuMGIdVOrwtOHA47Qu8D5hxSEnGmpfdskMI
	6+FzsfZAFBh5jQucuzwqrrIqGdZcBOt4XEqZUyPXbWjAbuqWS9Nj/pQYSO32G3r2
	RMJhqawvu/KVvyQN79AufxUjahBsYEoMjH/Kaee4dankgfuXZ5OesrRrJFGD8D5w
	iBwNu2NBWVGJOw+8GKBxI67r/eLiCOj4xJqqhytidMPdFymtEcaXDktkaHow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769456516; x=1769542916; bh=Zt5nQh5lO9nxwYFMEFhe5i88n3BksBjsKL3
	UyjoZRYQ=; b=OLvFsyqb5UwwwFmLnkwuttK0wxZuBTCQDkf2QYSDA3RlYmu0fEI
	4WOgOH7Wh7QW0GCBnrxa7GGCE8ikqjUxi/iB+tgYFxJfjAD0qzitqF76JyDgNGSn
	BZiZ44flZhzpw3x1dCBPPp1fj2KyALNnJB4nSxsCdLbYAOluPZPDRY3f7gCratWP
	r5t8LByl2jTbRUWaxGdWDb5fjgr/Mq6Tc8Q7xdPk/uYJIbKNIXjMOzoCOmCCvrDP
	M4E2i9dYhhFZuXp6ThhBrcOvbfpLZRgGeIaLmPW3euEPb/HJ/kSkXHO+ot9xqJwW
	Agl4Z3CaLvRM+Jo0Qbxr6T+/GZtX1/WgHQw==
X-ME-Sender: <xms:hMN3aShEUZe50nCs01bNrrb67x6_UUPcV59pf23XzxoGUDrbrgacMg>
    <xme:hMN3aZCUSc7y_Og0P0swhOZA1y4tx_MaJDRHPOxNKDVmrVfnf9euPdAFzVfRWWAAu
    oaebSfqw8gLf3ZAGRReCVzjhNcaUo7SCJpjHjXDP0wi61yRHSy_L2o>
X-ME-Received: <xmr:hMN3aXuX1vkheMCL81D0kVzIgTJ7ifeHITgqGJyWad6O30CjCybdj5RMj4AxaR_BMxbhtie6_UbCzYdccc7rbU4zyOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hMN3aWZKtaPX6HuNWnKftV2S6MdIHMZDlKreRrhMUVy9kMsHYNB0XQ>
    <xmx:hMN3aSXP1ojXbFmVg5PExuaL4OPGCBTvnNnsQaSrpnIzG9RzeWcvpw>
    <xmx:hMN3aS5cRes7llwmo8aBnCExX5trkEsvViOqFa2t17oNlqh210kuDg>
    <xmx:hMN3aVhGVjfvAy4CVWE82FFjnU6D4rfNVcihaLpbwe5fWIaNKzf65Q>
    <xmx:hMN3aQvDzprSzc_Oaha8I3mUBw3DwfNp6KgZTuF19z5cDX6IMY5We4Fd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 14:41:55 -0500 (EST)
Date: Mon, 26 Jan 2026 11:41:33 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] btrfs: used compressed_bio structure for read and
 write
Message-ID: <20260126194133.GD1066493@zen.localdomain>
References: <cover.1769397502.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769397502.git.wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21080-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: E4F838CB7E
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 01:54:07PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
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

I really like your new design! I am a little worried about making sure
all the cleanup happens accurately across the change but I think this
will be really nice. Storing the folios directly on the bio and using
that to track them is indeed much cleaner, in my opinion.

I previously tried to send a patch to track compr_folio leaks, so maybe
resurrecting that could be helpful (in CONFIG_BTRFS_DEBUG?) to make sure
we do this safely?

Please feel free to lift/borrow/steal/be-inspired-by/whatever:
https://lore.kernel.org/linux-btrfs/95f5c89f52556f69decc7f18a6fd1f2c09d711c9.1747095560.git.boris@bur.io/

Also, the patch series did not successfully apply for me on
btrfs/for-next and since it is a pretty large change that made it
harder to do a really thorough review.

Thanks,
Boris

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
>  fs/btrfs/compression.c | 205 +++++++++++++++++--------------------
>  fs/btrfs/compression.h |  40 ++++----
>  fs/btrfs/inode.c       | 219 ++++++++++++++++++++--------------------
>  fs/btrfs/lzo.c         | 223 +++++++++++++++++++++++++++--------------
>  fs/btrfs/zlib.c        |  64 ++++++------
>  fs/btrfs/zstd.c        |  98 +++++++++---------
>  6 files changed, 450 insertions(+), 399 deletions(-)
> 
> -- 
> 2.52.0
> 

