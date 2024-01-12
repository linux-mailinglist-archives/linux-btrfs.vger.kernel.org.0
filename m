Return-Path: <linux-btrfs+bounces-1413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19082BF90
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 13:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF353287BDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92F6A01F;
	Fri, 12 Jan 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bw0VuYWW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5stQosJo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bw0VuYWW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5stQosJo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387D6A00B
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E1A01FCD7;
	Fri, 12 Jan 2024 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705061072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+12cwVa/ROMg5NR+fIj8ChQ042YSwleolXlwZkgA0=;
	b=bw0VuYWWRn3KBEI1pyTBmhI3z53KGGnWkDLu6biROZCLXZPeWkUFqjONfhpCMnXc0aslJM
	RhD5j5EWcIxPa1zLRZRT8VeyUyYyk8kbP/q3s9ocHk8LWV2Vh35ZEhtbo8L53PYsrw5+sX
	vOxir67Ldt45CNp2d8CmKepB9RmlBvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705061072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+12cwVa/ROMg5NR+fIj8ChQ042YSwleolXlwZkgA0=;
	b=5stQosJouo7jbMbZOONKY+krG35WPAcQFi/BVtv26XQaHzCKZE+3ccPCupUHxHlPDcizlz
	w2qZ2A6sfL7uqGDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705061072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+12cwVa/ROMg5NR+fIj8ChQ042YSwleolXlwZkgA0=;
	b=bw0VuYWWRn3KBEI1pyTBmhI3z53KGGnWkDLu6biROZCLXZPeWkUFqjONfhpCMnXc0aslJM
	RhD5j5EWcIxPa1zLRZRT8VeyUyYyk8kbP/q3s9ocHk8LWV2Vh35ZEhtbo8L53PYsrw5+sX
	vOxir67Ldt45CNp2d8CmKepB9RmlBvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705061072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+12cwVa/ROMg5NR+fIj8ChQ042YSwleolXlwZkgA0=;
	b=5stQosJouo7jbMbZOONKY+krG35WPAcQFi/BVtv26XQaHzCKZE+3ccPCupUHxHlPDcizlz
	w2qZ2A6sfL7uqGDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D331340F;
	Fri, 12 Jan 2024 12:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iH/gBtAqoWWaBQAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Fri, 12 Jan 2024 12:04:32 +0000
Date: Fri, 12 Jan 2024 06:05:42 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Re: [PATCH] btrfs: page to folio conversion in
 btrfs_truncate_block()
Message-ID: <rdvzhdajctrwzyualrppin2hxj2bt6wijgmp3njp74iw6us72y@ry2lxh6wkwtc>
References: <cn7d3gijpqxtmlytcv4ztac3eb7ukd54co4csitaw6czn6bfxr@3wopycxp755q>
 <20240111182516.GM31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111182516.GM31555@twin.jikos.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.58%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.25

On 19:40 11/01, David Sterba wrote:
> On Wed, Jan 10, 2024 at 07:56:13PM -0600, Goldwyn Rodrigues wrote:
> > Convert use of struct page to struct folio inside btrfs_truncate_block().
> > The only page based function is set_page_extent_mapped(). All other
> > functions have folio equivalents.
> > 
> > Had to use __filemap_get_folio() because filemap_grab_folio() does not
> > allow passing allocation mask as a parameter.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
> There are some overly long lines, I can fix that unless you'd like to
> commit the patch yourself.

Yes, you can fix them. I will wait for Josef's docs to start committing
myself.


-- 
Goldwyn

