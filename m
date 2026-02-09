Return-Path: <linux-btrfs+bounces-21567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A2yDoJViml9JgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21567-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 22:45:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C444114EC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 22:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7298A301ECDE
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABC30FC11;
	Mon,  9 Feb 2026 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="k8bcRd2y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JU7xv91d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87334303CAB
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673526; cv=none; b=fMdEb7tNfgUu6XdRYVr4i+UusrditMRRHq+QNpPUEY0K8KkuKnW9NUN0m1wcL2PLw6IQkcj8jYmoWJvWv/GTFT5FqXyhcZiYSm2xV1ErZs8FTD0hRqAZ5KwI5wEcF5cle/KdyJ6mm4NtQE8Wc8kN/jYDRWY2naXiyj0AHWAYYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673526; c=relaxed/simple;
	bh=kgVLSCg8QOnRdmWh8i6wJDNnxgx/Kfex6tDmZ46/rlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecHOJFGTL0Zg8Sydfg+5clxdRX8S7ETJKFQ8JyjkziJo+UUdjF1cBtn8CUDQB8YiR8Bqm5KKcgfRrPASvaIBgrOvw43cX6C7pDqTaaO9Xge5xKQBbJda69Jj9Z0CO3anVWIrz8ueYsLkdSrhVdVRvSdnhmhzjPJkpE2yAKTSa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=k8bcRd2y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JU7xv91d; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id D239C1D001A4;
	Mon,  9 Feb 2026 16:45:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 16:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770673524; x=1770759924; bh=xEyRV2Bifk
	LrTI6HcwpbXId4x+h0LmgerrcW7qV8Sjk=; b=k8bcRd2yI9I+1tmEcH3EJPcft+
	V2k/9pYv11WSSMuQnna7p6gljVT0VeWcglDi2AW5FptZfbKXgIYlWxpNPFjXZOgd
	i9EMJ82sf85VuT4mPtJtVUSqzzUojT0juTUhfyyRac/1eTifq/jk4zf7yhkz4paZ
	0TjUkpBjiD7fGuxybGjzDNCeP5M8iWYqpw4emtruSAv4/2Y3inoqaAYjVGDPWLao
	oMFbEpInammUpCXGboIYQMYRCeDRH9Yb3dY6Do4gJVL8zMJ+e20ZH0Jt3LxuCEti
	UNiOnwwibe3aZLTqMZbomJrkYahwqJzTR3Z41ZOgGfPlr/ug9OkJgdlotBqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770673524; x=1770759924; bh=xEyRV2BifkLrTI6HcwpbXId4x+h0Lmgerrc
	W7qV8Sjk=; b=JU7xv91daUcN5VPhTPvEmTd4Lj0xaFkkaDKjP/2YzI1FG6bqQbf
	scEWZrrbv/BjJBJfibkrgxRwIYnxQF/FXMjY0psv1KDMB/eieoea9udG4WIBUfRx
	jWzyhmD+dvbR4dzlIqxH0ib5SeIfI+Cv4BBentmhaBz+tsymZB1oiZBqOZkfDgEV
	m13uUrdBxRWfVqY/83NJ72f3ie7JxhMmfAQu3q0t8wq0hTyspmukxYNppjoarlvt
	zAGxkWcoNUJ+FA2to9N7M/2PAspUfVvkRw0jCoSug9P53bGdq5vBCoW4mIHMpim1
	B1rubCvegAbH2IcOWDuM6PGMrCylOCUdm8w==
X-ME-Sender: <xms:dFWKaTQ7Fj4kbmkYswhOXt9V26CbgQasBBDO9jCXBTsfplqfhNZV0w>
    <xme:dFWKaayMK-0YUhnU1rgyq9zvccsVcYIL60C7ADyo4ZIWluj9HH5QAaEm-9Ht_yuFF
    UCZrnW5gh0qHQFwl-xygQmb1Op8LNiC2edFdhpfSjt-Etm2As9BT9I>
X-ME-Received: <xmr:dFWKaWdjxiZM49du7ePCd0vAMeLwuzVOqEJ16OOl5RxtgXIgEjktwMycUQpC4CUI07hpjJoAHYkrys9WxW2G_3LzAfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhgohhlugifhihnsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dFWKaeIlldw0vssS8R1h5LDEfEg_vNP-eprWU1P6ddA90JXCDzVSMg>
    <xmx:dFWKafGqqL1XY6HO5t7Sk3f5fdppGwyWxKoicAQLFeX0TZVfLK1DXw>
    <xmx:dFWKaQo6KXyU2Mg3YJiFTU9a7IDepEgUq63HKoV3jdJMSjasba-SNg>
    <xmx:dFWKaQRlf_A55yEeO3W1JBWt1kuj8fie-ed58HXyHm0Tl2l0MpMgZw>
    <xmx:dFWKaWrzTIN5gAlTZO849O64oKaagSKs1PQ_UfktlKb5tNi4LvoRcwpV>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 16:45:24 -0500 (EST)
Date: Mon, 9 Feb 2026 13:44:37 -0800
From: Boris Burkov <boris@bur.io>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use inode->i_sb to calculate fs_info
Message-ID: <20260209214437.GB379757@zen.localdomain>
References: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	TAGGED_FROM(0.00)[bounces-21567-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,bur.io:email,bur.io:dkim]
X-Rspamd-Queue-Id: 8C444114EC7
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:11:37PM -0500, Goldwyn Rodrigues wrote:
> If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
> super block and fsid assignment will lead to a crash.
> 
> Use inode->i_sb to calculate btrfs_sb.
> 

I'd prefer the commit title to note the fact that its a tracepoint, but
that's fully a nit.

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  include/trace/events/btrfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 125bdc166bfe..94a197557382 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -772,7 +772,7 @@ TRACE_EVENT(btrfs_sync_file,
>  		const struct dentry *dentry = file->f_path.dentry;
>  		const struct inode *inode = d_inode(dentry);
>  
> -		TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
> +		TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
>  		__entry->ino		= btrfs_ino(BTRFS_I(inode));
>  		__entry->parent		= btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
>  		__entry->datasync	= datasync;
> -- 
> 2.53.0

