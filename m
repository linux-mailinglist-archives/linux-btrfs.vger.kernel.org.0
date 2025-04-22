Return-Path: <linux-btrfs+bounces-13221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB0A96761
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0140F3AEDF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198527BF8A;
	Tue, 22 Apr 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnmYKxOa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3+WT80e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnmYKxOa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3+WT80e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136B27C14B
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321522; cv=none; b=ZTOhYYbS3tMCJNzyePkU4cVQDMRpHIfFBsSQnSFMy5TxPvlYJdwvUMhMn4aNIQ8RN8LTd4Ui2/T97tXLcZu6YoTyDVmyUcR8E2sPPpugCZrxRAcW9NyQyls7AqsAm+J2Nt+vmEqM/c7rGMuvCkBt2cojPqaY60XvSLVq2hg+JhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321522; c=relaxed/simple;
	bh=B8sN7UNPWZgbsFVLtvXFdjOCRU2SCn4Rlhg2vx+Qxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVdZE6XFypO01IAxF1qzV5UmZp8zcuZWhIWjgRVEFcMpsiLayZ3g+cKZieQ4keaN1OKuMhbyOhWVDS3L9UovcVzuEhvuKYAV+VY+3CT5QWHITool7hHMg+YP8THAr/A0q4QU2KTScdSRVQREDHW94GLboxnxS2VMZyGMELwljOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnmYKxOa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3+WT80e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnmYKxOa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3+WT80e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 846791F38D;
	Tue, 22 Apr 2025 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745321518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/nK6cKy3307rm0aUSsXL5OynB3y4/jFUEyl42C9oUg=;
	b=ZnmYKxOaq3pNIUGCRhPn6xKBPf7ei4t24eEjFkBsgv7Z1oFmitZA8e3GNEUq4k665h/gQw
	NhYSe+xcVtUbXczcpyi1mijMLK5PEW2KBOR1njpo6Q2QdUM6pRo4xKb5dObxpenkE/5hnZ
	7fGNI/a2y/h+Bt/CFRez3t3CtZTvkoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745321518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/nK6cKy3307rm0aUSsXL5OynB3y4/jFUEyl42C9oUg=;
	b=b3+WT80eFQ1kj2whuEykjfpt7hhQZ3LuFA9gUV9F2p+MmtbLeSzSyoMvaTKtxjHVY4KDj/
	Z4p9G6IxMTvXz+Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZnmYKxOa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b3+WT80e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745321518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/nK6cKy3307rm0aUSsXL5OynB3y4/jFUEyl42C9oUg=;
	b=ZnmYKxOaq3pNIUGCRhPn6xKBPf7ei4t24eEjFkBsgv7Z1oFmitZA8e3GNEUq4k665h/gQw
	NhYSe+xcVtUbXczcpyi1mijMLK5PEW2KBOR1njpo6Q2QdUM6pRo4xKb5dObxpenkE/5hnZ
	7fGNI/a2y/h+Bt/CFRez3t3CtZTvkoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745321518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/nK6cKy3307rm0aUSsXL5OynB3y4/jFUEyl42C9oUg=;
	b=b3+WT80eFQ1kj2whuEykjfpt7hhQZ3LuFA9gUV9F2p+MmtbLeSzSyoMvaTKtxjHVY4KDj/
	Z4p9G6IxMTvXz+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 689F1139D5;
	Tue, 22 Apr 2025 11:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nlJaGS5+B2hDDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Apr 2025 11:31:58 +0000
Date: Tue, 22 Apr 2025 13:31:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 6/8] btrfs: raid56: store a physical address in
 structure sector_ptr
Message-ID: <20250422113157.GC3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745024799.git.wqu@suse.com>
 <03dbeaa8ac424885402a6590e393a15d5ae67c82.1745024799.git.wqu@suse.com>
 <20250421114416.GA23431@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421114416.GA23431@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 846791F38D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 21, 2025 at 01:44:16PM +0200, Christoph Hellwig wrote:
> On Sat, Apr 19, 2025 at 04:47:13PM +0930, Qu Wenruo wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > [ Use physical addresses instead to handle highmem. ]
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> I think you should take full credit and authorship here as this is quite
> different from what I posted.
> 
> The changes look good to me, though:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

For the record, Qu added the patches to for-next with you as the author,
so I'll change it and mention it's based on your patches instead.

