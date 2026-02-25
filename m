Return-Path: <linux-btrfs+bounces-21935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOuUHvVan2lRagQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21935-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 21:26:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B565B19D2ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CE95305BFCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41130CD81;
	Wed, 25 Feb 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LnVgAOOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="th40U7UU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F830C361
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051151; cv=none; b=GpaS7FVUwPnaokhWVJCxmC0Rtj3D0EEEeHn5P/qdIZDOXl6t/6+Ltd36Gb8NafqddrthgTPik9vntAacp4KyOzQVW0CIZ9V1IqrsD4fL6MF2GncTSdh6qVLt/faKw0Kq9JP9EstW9I3/T2OSFiyaq/x14udzlD9k81yUBVaQwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051151; c=relaxed/simple;
	bh=I8pZVeOw92m5xT3RlbtVFhe+lDgkGkFwE+M1oqgxZm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZfbUAR1y2d9kmJEkHdqJ4MVD61ity9zDQGk9CHtn7CNn3mxhK/oFAmsXtUFtXQLyI2Q0KqDXfirS5XvI/JSMm+NYTasHBcCqxg6dn0BVjbZIl3Burk/Sm7mweIxJzVWyqXbmPCtxGYMjm13/2gt+/0r9nns4RyPlvjxPlN6mfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LnVgAOOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=th40U7UU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A55D140018D;
	Wed, 25 Feb 2026 15:25:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 25 Feb 2026 15:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772051149; x=1772137549; bh=2jntmNQoe2
	1PUYDpWxkRgOz1q6oFAVthlmx+TD+Pmx0=; b=LnVgAOOQPTLlUmohq9Xsv+yORd
	5h6db7e2ODsz9BjmZPcIJeHlhU+RzpLcMKgeL6rnj0/dVf6Ih5ACQo3pOjTzkDp6
	AGkKtljlcDGpzctJqmY+QiQdaBEnT+URjfUB+8WXNM+SWnnauibTOyras0LZFIQH
	veyW/DFdT6FWkovq1BcY7LTecBAVDFGKM9bDDofY0hVptYcaMG06oVY7+/DzQD20
	S+ayWcSuAzXE1r0gZjLtmuC86Epl9Y/ZPxn+ARaO0JYMTNOXzxFNMbxfzJdAutst
	JhPpwqc/SKjoWZSHMDrK91BeNH2DfLTuUTVRKVbkXci8HdWgFkNs8NpMi2nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772051149; x=1772137549; bh=2jntmNQoe21PUYDpWxkRgOz1q6oFAVthlmx
	+TD+Pmx0=; b=th40U7UUWtZao4OqFWNrXM/9xFTkCNXucETxESoDsEYKrzZlXUY
	3vYui0mJyDuMNnIOr3ZgBbfupYYm4ZRLXWGoRogmUIV1r1meZLKnLz4glmZd6KbW
	+XZXGnE1keaq9JsSxpKJIfCUVdwVpOFyxnoGYJhYBRZ+5q7H5tsYt2WDH1lxJ0PJ
	1wwyxAfv8/CFxUDdihdwxoT99pxD45oY3u/1McYKpcMaOVgfWRYFozpWiEgJiU7+
	tiaqDisNjM9QkV4Y3uSQUjVA+sfZpmr1PUdiI9o0xmOwxwqXbz2uJz3ddlPz9EW7
	juHf5yelp6yE3aKGt7ocWaL8/aH/M8zgNGw==
X-ME-Sender: <xms:zFqfabQJdA0QBhTPg5Kkhb0pnqXv1G0XGl5rsP6K4hk4lwca3AcKsw>
    <xme:zFqfaQcbgfxmv03uJCeaUR2WJZTwMzuqd4QGhNwTJvoqJxLDlZIHp5WZZocJDGv8S
    gmU_QoBQ-w4vMcHIzzD71qSu4LGvBANtAC1OYtJygoqFv_7ZJdX-_4>
X-ME-Received: <xmr:zFqfaaomeMY_8RhV8Z5vhjXJ2UlKLl2MKm70BwmlkLZD7TH9exd-ALYi75B-YtO1qMISDHG_C0iEkI1siQ3J1Maaj58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsghvrghnrghsshgthhgvsegrtghmrdhorhhgpdhrtghpthhtoheptghlmhesfhgsrd
    gtohhmpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:zFqfaR-iimi7FnJ2NZSqfo5amja4Z8bGpdj3rBBYIR056mFolkPkHg>
    <xmx:zFqfaWewuM1-PuAADI3Zm5i0oXxCYTRo7pD-j5a8bvV3OCZU2smbeg>
    <xmx:zFqfabLEQwYi-hyhw_-Nr09CVQgNDQ94KWg5Tn7UdqNNAeB-4MgdqQ>
    <xmx:zFqfaWgis0ugRzabTzt1UYZIF0ofUPwI8TKqTXqLsplWVl8uKTlViw>
    <xmx:zVqfadvBRo3WzLWEsExQ3z4yUCirQ1cIkDPoc8bmSqhTkwGDGCwfnXKq>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 15:25:48 -0500 (EST)
Date: Wed, 25 Feb 2026 12:26:42 -0800
From: Boris Burkov <boris@bur.io>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
	Leo Martins <loemra.dev@gmail.com>
Subject: Re: [PATCH] btrfs: Fix a bug in try_release_subpage_extent_buffer()
Message-ID: <20260225202642.GA3307145@zen.localdomain>
References: <20260225195958.309047-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225195958.309047-1-bvanassche@acm.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21935-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,suse.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: B565B19D2ED
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:59:58AM -0800, Bart Van Assche wrote:
> Call rcu_read_lock() before exiting the loop in
> try_release_subpage_extent_buffer() because there is a rcu_read_unlock()
> call past the loop. This has been detected by the Clang thread-safety
> analyzer. Compile-tested only.
> 
> Cc: Boris Burkov <boris@bur.io>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Leo Martins <loemra.dev@gmail.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org

LGTM, thank you.
Reviewed-by: Boris Burkov <boris@bur.io>

> Fixes: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/btrfs/extent_io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 744a1fff6eef..5f97a3d2a8d7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4507,6 +4507,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  		 */
>  		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
>  			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>  			break;
>  		}
>  

