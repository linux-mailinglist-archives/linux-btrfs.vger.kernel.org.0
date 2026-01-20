Return-Path: <linux-btrfs+bounces-20785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMIRAYAGcGmUUgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20785-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 23:49:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62B4D3F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 23:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9643F56E99D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291732ED2E;
	Tue, 20 Jan 2026 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qfwzyvJw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWnuRdub"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB83D332B
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947445; cv=none; b=P0X2SUJpnnmJlJtKqzEoGzwgDxgnW/bPalVIi25VoE2lNJzztK6yGTx/3+PQMYR1GNulsVRH7E+eY5XPAUNCQzl2vCNDBe1rZEADIfhGSFvzmqWKKzeRJ4j6uGj3vML8P1t0a6b+uAyoHWQiQ720rMESBMTGiHnpLFxEZWXCK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947445; c=relaxed/simple;
	bh=9/g6kyFtzOcBJEsP47Oh67nJyQ6DDFyKCwFiIJ7S5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4OVaLLDczjorNXO4ePcQIMkQU+vANnA+iA3yxOerM342HdkVAqNi1kRpbA4RYppldJFdLg5oWukStkbsZJVuCUjoM87q4c/6/to15TK/+7UknWeQwDdzCt/lzWrWW/VK4Eg2A7lwGMpqN8hx25ozL1jxwHCg/FFpLC2gxqoI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qfwzyvJw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWnuRdub; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13C7C14000BE;
	Tue, 20 Jan 2026 17:17:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 17:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768947433; x=1769033833; bh=XCmU4gD5Ky
	S2jmDeJFLuK7MyKFuEeZzn7RoN5IVYd+s=; b=qfwzyvJwTAIoweWac8bWG6WDKn
	m3Q0HrQhUuX8+29i3oCejbIkeq+yq4IIHgGQNxAgXODR7s4UoUOQS4H97a7+9hgL
	d2CpQvA/s8064MfZ2RZQ8swgfwQ3eLLczsXjoXrSZSkbDbGtxp3Rnh3wpu8bIWEF
	klUX9PR/dNxhc0WYoGcCcZagw1pMrN+3UOmXLiQUB8KMreMA2EIqVxYUrA73IPzp
	xAv/WyReHvSNOuwvLajK8hJ8FvMwlgy3XfIYneFJ1qpSsjpxfBH7O6QMXSRAC91e
	pabUclaU0kTQ2DQpFZ0XPZSurFGcrtbYhpSA+WEMd8u5pVWvo/eXEFnOrtdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768947433; x=1769033833; bh=XCmU4gD5KyS2jmDeJFLuK7MyKFuEeZzn7Ro
	N5IVYd+s=; b=NWnuRdubZtEszYsMvuauwEenL7dBnQFLliz8zAhNTrcCGtcb+Lk
	1GkoqqvzV0PEBXt4adp5CNfEXrkVSpuk+9RoiNESzKUkDFuwf9zznhlz3JuqRtvy
	BZPAqNRT6pxYvKRmCfZMv1XoXkz0S7gEpwIiZcDv4wrLs5EJGijlkqzJrQreKbhp
	T2SzjO3NBGiR+yDouYANZzV/lmkylEKJYFT8+3/YQoC4XDTYKAKY+Kg6IJySTc/K
	Z7uk2GHd3q6zjCDVqfe98mlb8/QnTQ75OZWIrl2qwvBlKcjQAMnm+N+o1sPM+umX
	JLhg4mA8Yd6Evaax+fRcXwK/kLzqEzowHxQ==
X-ME-Sender: <xms:6P5vaTNYGh2dgyoOVTg3Hm6pt41Ok1MqUd8QrclaamJKFo6lJQGzeA>
    <xme:6P5vaVvjQ4EojlqIv9I3UHnsX-g-I6lJarMjKAd6b3P_KsFX3PtWP-HDpmNZTEQy2
    _2WQMKeTh-nr5JdwsRp7LZp_eHGUZS2rvdFsGF6LIYOAm4_i9pOZ4I>
X-ME-Received: <xmr:6P5vaVULcfTDZf8NO5GKEjXKcthni1r1YgTQWZrzapqTkRTTT6apHnJx9ag5bWqJt6TyQ7-RF0HekHWcjKeFAz1BGKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvhhg
    vghrrdhkvghrnhgvlhdrohhrghgrrgeitdhfvgduvdgsgehfgeelfheglehftgejfegvhe
    dtvdeffhekieejhegvvdgufhdufhejkedthe
X-ME-Proxy: <xmx:6P5vaVuyPddXbrFi2lvy60fHF3Wh0OArPa2LdguH9X6YONHD0d4k1g>
    <xmx:6P5vaZW8OdcFYAPC0s6M4CqT_l-AeNj1KiccXGMEr349l-C1TqtnUw>
    <xmx:6P5vaQnqjfU-SjxPfh-e93832GajAMNxvcI9gmp1AcKMMBIYM2xqeg>
    <xmx:6P5vaabJ5gleBs5D47VaPQiI4ZmBr8eioqP7uaFlNlXw_7Q-EzqyMA>
    <xmx:6f5vaSf6J2NRcQNZebawZZJXYSD4XxrHqS6AW9jFhCFpxQ49WO8-aAgt>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 17:17:12 -0500 (EST)
Date: Tue, 20 Jan 2026 14:17:00 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
Subject: Re: [PATCH] btrfs: fix the folio leak on S390 hardware acceleration
Message-ID: <20260120221639.GA779478@zen.localdomain>
References: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-20785-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 9C62B4D3F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 04:24:04PM +1030, Qu Wenruo wrote:
> [BUG]
> After commit aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration
> buffer preparation"), we no longer release the folio of the page cache
> of folio returned by btrfs_compress_filemap_get_folio() for S390
> hardware accerlation path.
> 
> [CAUSE]
> Before that commit, we call kumap_local() and folio_put() after handling
> each folio.
> 
> Although the timing is not ideal (it release previous folio at the
> beginning of the loop, and rely on some extra cleanup out of the loop),
> it at least handles the folio release correctly.
> 
> Meanwhile the refactored code is easier to read, it lacks the call to
> release the filemap folio.
> 
> [FIX]
> Add the missing folio_put() for copy_data_into_buffer().
> 
> Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
> Fixes: aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration buffer preparation")

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/zlib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 6caba8be7c84..10ed48d4a846 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -139,6 +139,7 @@ static int copy_data_into_buffer(struct address_space *mapping,
>  		data_in = kmap_local_folio(folio, offset);
>  		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
>  		kunmap_local(data_in);
> +		folio_put(folio);
>  		cur += copy_length;
>  	}
>  	return 0;
> -- 
> 2.52.0
> 

