Return-Path: <linux-btrfs+bounces-15264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79222AFA00D
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jul 2025 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB91C4A3097
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jul 2025 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B662561D4;
	Sat,  5 Jul 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HIF5auqv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyDjAZuP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r2zjw91l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXT6RgRj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD121A444
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Jul 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751718378; cv=none; b=lDbjnu/GDfMhxoQJH4z+xsf6hAwc30iaKjxCLWaPJw0y9ggnycZnxf/NAXtEl1eNZ19aIq6/Rl5hdVwgkwD+Hfc/fCpmaSXg6FqPDJ9NHdZKW5Ipx6nTmen6ezUKYSZGw9jPXMjMwl9tx4AmnyhvRa76DI4E5IaUs7zqLrLO96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751718378; c=relaxed/simple;
	bh=/Ea9gLOydxWyMdDAA6gRhTqRpMxnf3GpNOmO3mD6HcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdAjfif85PlF737+hypKTokdp3ZDfpKXvX79YaPp8zYHSMOwE6oWPY1XAe7tWnhJHUbR9QAty8NMZ5WCsb8J6PV+GwpEx++aT3AfO9p6vywOJ920NF4nzEg24lgBz+2HbOY1vY+QrN/T/RI7WVfmVRTBBN75k69JVKjzVgnit58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HIF5auqv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyDjAZuP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r2zjw91l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXT6RgRj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 443641F797;
	Sat,  5 Jul 2025 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751718368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TllSNrMbqkjjtjBtLV4irTsHpwaaZKQ5b0B0Lrqj0vM=;
	b=HIF5auqvp/81pVkn/RGpdVhJgYGtlUD8uFP3F/cNAWoPaK6mf2NUMSTMWMHqE+FDvRnGwM
	Kg0wnGIydeG9pKBno6TyP8GZ7q9VqKQjKMVX86R1S0ENv34Y3Pq0vRhrw9l84K8eLDMDDk
	CrPbHqqP59JY3A/e2PVQfyhNtBwnc5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751718368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TllSNrMbqkjjtjBtLV4irTsHpwaaZKQ5b0B0Lrqj0vM=;
	b=dyDjAZuPxiJkG/NytpyFUMrudGP3hHs4nQtDizapsq6LKDeROh5q9vm/6it7AUN26uqFYh
	hVXjQup4iUloz8Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r2zjw91l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GXT6RgRj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751718367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TllSNrMbqkjjtjBtLV4irTsHpwaaZKQ5b0B0Lrqj0vM=;
	b=r2zjw91lWpl8kMFtZx2aweY30nqP2qetBZIaPyOIwvuNX6/vnJOOOvt4wt39vXOOiAsnUc
	mNTFKwkO/RDrmjLzZ1nQF7wgO4vg2y/DM9eWbADjlvOHaFjj/YhbmVUqOG9cUbOXEe7fhz
	IQ18h+BhrpHE3xJYI2iUxiNvb8ebj6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751718367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TllSNrMbqkjjtjBtLV4irTsHpwaaZKQ5b0B0Lrqj0vM=;
	b=GXT6RgRjWIegKM+aP97+NFrt3KvFdqzMAsnwFDX17IrDIOqcKwLBOmrQc2VGc41dbRA4U+
	onKo9v+3YqMAr1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B3F2136A2;
	Sat,  5 Jul 2025 12:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4dohBt8ZaWihRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 05 Jul 2025 12:26:07 +0000
Date: Sat, 5 Jul 2025 14:26:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: index buffer_tree using node size
Message-ID: <20250705122605.GA4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250704160704.3353446-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704160704.3353446-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 443641F797
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21

On Fri, Jul 04, 2025 at 06:07:02PM +0200, Daniel Vacek wrote:
> So far we are deriving the buffer tree index using the sector size. But each
> extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> 
> For example the typical and quite common configuration uses sector size of 4KiB
> and node size of 16KiB. In this case it means the buffer tree is using up to
> the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> slots are wasted as never used.
> 
> We can score significant memory savings on the required tree nodes by indexing
> the tree using the node size instead. As a result far less slots are wasted
> and the tree can now use up to all 100% of it's slots this way.
> 
> Note: This works even with unaligned tree blocks as we can still get unique
>       index by doing eb->start >> nodesize_shift.
> 
> Getting some stats from running fio write test, there is a bit of variance.
> The values presented in the table below are medians from 5 test runs.
> The numbers are (# of allocated ebs in the tree / # of leaf tree nodes /
> / highest index in the tree (radix tree width)):
> 
> ebs / leaves / Index |   bare for-next    |      with fix
> ---------------------+--------------------+-------------------
> 	post mount   |   16 /  11 / 10e5c |   16 /  10 / 4240
> 	post test    | 5810 / 891 / 11cfc | 4420 / 252 / 473a
> 	post rm	     |  574 / 300 / 10ef0 |  540 / 163 / 46e9
> 
> In this case (10 gig FS) the height of the tree is still 3 levels but the
> 4x width reduction is clearly visible as expected. But since the tree is
> more dense we can see the 54-72% reduction of leaf nodes. That's very
> close to ideal with this test. It means the tree is getting really dense
> with this kind of workload.
> 
> Also, the fio results show no performance change.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> V3 changes: Mentioned stats diff in the commit message and rebased.

Added to for-next, thanks. Please also format the changelog lines to 72
or 74 chars.

