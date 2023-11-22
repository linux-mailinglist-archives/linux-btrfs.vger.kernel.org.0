Return-Path: <linux-btrfs+bounces-287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F997F493A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D741F21C47
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801D2BAFF;
	Wed, 22 Nov 2023 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xYwinXrr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EAw0Ipn6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C3D40
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 06:45:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E07B2186F;
	Wed, 22 Nov 2023 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700664325;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebD8EJnMRyyBLVI1M4ubcM24d8x+2uO2R1w7qP6OA8c=;
	b=xYwinXrrSgeUa76l9AWsI6+sZQbsNf14EA+j03aWSVqN5mml7Vknfv9lkCHTCfTpor+Y9e
	ckw39qA49060XHHeMvGmQfrprqjGsYfYAuJn13dlsWWuC8mCLc9ZmwHJjpDP2qH7y39JVs
	Yfaclp6InoieSuqaFY2u7KBbZ0MoQPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700664325;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebD8EJnMRyyBLVI1M4ubcM24d8x+2uO2R1w7qP6OA8c=;
	b=EAw0Ipn6N1EWLViGRagXANTKqQj9k590MG3Ow0M3UfGw5oTIbuedp6PWEp0nEd3iIz5DT1
	Clo7iRk8YlBzqZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CE1313461;
	Wed, 22 Nov 2023 14:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ty9LCgUUXmWdEAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 14:45:25 +0000
Date: Wed, 22 Nov 2023 15:38:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Message-ID: <20231122143815.GD11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.04
X-Spamd-Result: default: False [-5.04 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.77%]

On Wed, Nov 22, 2023 at 10:05:04AM +1030, Qu Wenruo wrote:
> -	for (i = 0; i < num_pages; i++, index++) {
> -		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
> -		if (!p) {
> -			exists = ERR_PTR(-ENOMEM);
> -			btrfs_free_subpage(prealloc);
> -			goto free_eb;
> +	/* Alloc all pages. */
> +	ret = btrfs_alloc_page_array(num_pages, eb->pages);

This looks promising.  Assuming everything else works, this can be
changed to do:

- alloc_pages(order), the optimistic fast path, contig pages right from
  the allocator, can fail
- fall back to btrfs_alloc_page_array(), this fills the array with
  order-0 pages, similar what we have now, they could be contiguous

I wonder if we still can keep the __GFP_NOFAIL for the fallback
allocation, it's there right now and seems to work on sysmtems under
stress and does not cause random failures due to ENOMEM.

