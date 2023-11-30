Return-Path: <linux-btrfs+bounces-464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A527FFF74
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 00:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C641D281879
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16525953B;
	Thu, 30 Nov 2023 23:30:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADBBBC
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 15:30:36 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9519F21BA8;
	Thu, 30 Nov 2023 23:30:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 809E8138E5;
	Thu, 30 Nov 2023 23:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id m+QYHxobaWUmcQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 30 Nov 2023 23:30:34 +0000
Date: Fri, 1 Dec 2023 00:23:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Message-ID: <20231130232316.GY18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cf7b0e83150d2c91bb4234fcf3552e86a8bd1a92.1701297048.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7b0e83150d2c91bb4234fcf3552e86a8bd1a92.1701297048.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++++++
X-Spam-Score: 14.79
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 9519F21BA8
X-Spamd-Result: default: False [14.79 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(2.96)[0.988];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 BAYES_SPAM(0.14)[63.68%];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

On Thu, Nov 30, 2023 at 09:02:08AM +1030, Qu Wenruo wrote:
> Currently alloc_extent_buffer() utilizes find_or_create_page() to
> allocate one page a time for an extent buffer.
> 
> This method has the following disadvantages:
> 
> - find_or_create_page() is the legacy way of allocating new pages
>   With the new folio infrastructure, find_or_create_page() is just
>   redirected to filemap_get_folio().
> 
> - Lacks the way to support higher order (order >= 1) folios
>   As we can not yet let filemap to give us a higher order folio (yet).
> 
> This patch would change the workflow by the following way:
> 
> 		Old		   |		new
> -----------------------------------+-------------------------------------
>                                    | ret = btrfs_alloc_page_array();
> for (i = 0; i < num_pages; i++) {  | for (i = 0; i < num_pages; i++) {
>     p = find_or_create_page();     |     ret = filemap_add_folio();
>     /* Attach page private */      |     /* Reuse page cache if needed */
>     /* Reused eb if needed */      |
> 				   |     /* Attach page private and
> 				   |        reuse eb if needed */
> 				   | }
> 
> By this we split the page allocation and private attaching into two
> parts, allowing future updates to each part more easily, and migrate to
> folio interfaces (especially for possible higher order folios).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use the old "GFP_NOFS | __GFP_NOFAIL" flag for metadata page
>   allocation
> 
> v3:
> - Fix a missing "attached++" line
>   Which affects the error handling path.
> 
> v4:
> - Remove the internal helper alloc_page_array()
>   The naming is too generic and can be confused with public mm
>   functions.
>   Just append an @extra_gfp parameter for btrfs_alloc_page_array()
> 
> - Detach the attached page before error out
>   Previously we rely btrfs_release_extent_buffer() to handle
>   half-attached ebs, this makes the detach_extent_buffer_page() more
>   complex.
>   Here we detach all the half attached pages first, then set
>   EXTENT_BUFFER_UNMAPPED flag for the eb, so we won't need to bother
>   those half attached extent buffers.

Added to misc-next, thanks.

