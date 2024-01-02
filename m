Return-Path: <linux-btrfs+bounces-1191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73B821F74
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71096283AA0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDA154A7;
	Tue,  2 Jan 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AW/E0A4I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r1j/YhHD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AW/E0A4I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r1j/YhHD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD932154A0
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jan 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD5F71F391;
	Tue,  2 Jan 2024 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704212790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+3oH/iPMNT8bmBQskJIGpXoOt3U91w4qjWruS8V3Ko=;
	b=AW/E0A4If4dx2OTElxgbDKLJwhpwlqewuqaE6LoJpKPjCXtW50uG/qnMjAlM+SG8pecLIa
	1xsx8m5ygGDha/eVrVNZjX7/dD8TfvuqRzdoya/7KiFLTHgCGhh17oEYDPddqoh6s6OAoi
	JDjR/YNNEI6Q6l34GQi/j99eK7QOvW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704212790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+3oH/iPMNT8bmBQskJIGpXoOt3U91w4qjWruS8V3Ko=;
	b=r1j/YhHDT/utugSFInrLSWVygnXjma1/M8zLTQLWAtexA1sOPfcxaenTHVkMSFwxDqo6+3
	4VdrN6AKmFjftGCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704212790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+3oH/iPMNT8bmBQskJIGpXoOt3U91w4qjWruS8V3Ko=;
	b=AW/E0A4If4dx2OTElxgbDKLJwhpwlqewuqaE6LoJpKPjCXtW50uG/qnMjAlM+SG8pecLIa
	1xsx8m5ygGDha/eVrVNZjX7/dD8TfvuqRzdoya/7KiFLTHgCGhh17oEYDPddqoh6s6OAoi
	JDjR/YNNEI6Q6l34GQi/j99eK7QOvW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704212790;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+3oH/iPMNT8bmBQskJIGpXoOt3U91w4qjWruS8V3Ko=;
	b=r1j/YhHDT/utugSFInrLSWVygnXjma1/M8zLTQLWAtexA1sOPfcxaenTHVkMSFwxDqo6+3
	4VdrN6AKmFjftGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C210A1340C;
	Tue,  2 Jan 2024 16:26:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tKs7LzY5lGWZfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jan 2024 16:26:30 +0000
Date: Tue, 2 Jan 2024 17:26:20 +0100
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Qu Wenruo <wqu@suse.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [btrfs]  8d99361835:
 stress-ng.link.ops_per_sec -18.0% regression
Message-ID: <20240102162620.GA15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202312221750.571925bd-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312221750.571925bd-oliver.sang@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.16%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.19
X-Spam-Flag: NO

On Fri, Dec 22, 2023 at 05:59:34PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -18.0% regression of stress-ng.link.ops_per_sec on:
> 
> 
> commit: 8d993618350c86da11cb408ba529c13e83d09527 ("btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Unfortunatelly the conversion to folios adds a lot of assembly code and
we can't rely on constants like PAGE_SIZE anymore. The calculations in
extent buffer members are therefore slower, 18% is a lot but within my
expected range for metadta-only operations.

This could be improved by caching some values, like folio_size, so it's
a dereference and not a calculation of "PAGE_SIZE << folio_order" with
conditionals around.

