Return-Path: <linux-btrfs+bounces-158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604987EE7BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020091F2310F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA3A3067B;
	Thu, 16 Nov 2023 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lAzTHXui";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bgrvguq5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA907196
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 11:57:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5821321D89;
	Thu, 16 Nov 2023 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700164672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAYyZoAd+3m5icgDGMKvsHn63+LM2v14uprvsvleon8=;
	b=lAzTHXuiuWn8vZn/uWWtW/HDDVbgKSfITn9ZXh1V3vLl86RcPrRWb4bL7p0pyHBkTg7Ye7
	Pqnkl09WLB+/pJSY2d1g4HUINzC/6W3CvRonGkHuq40a128Q8WYoZ5LB0s66TP5S8FCgVk
	QhAyjj9IhQXz/rBNwY8ty6sPDaBaEKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700164672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAYyZoAd+3m5icgDGMKvsHn63+LM2v14uprvsvleon8=;
	b=Bgrvguq5IBvZDDBEEI7TOhd86dAU9v9dNey8aBWiiJ82/Y+Wu4osoCHqnNdGCXGVMROhIU
	bAGegC8HIDoYJ7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38A571377E;
	Thu, 16 Nov 2023 19:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BIUWDUB0VmWYZQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Thu, 16 Nov 2023 19:57:52 +0000
Date: Thu, 16 Nov 2023 20:50:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: use page alloc/free wrapeprs for compression
 pages
Message-ID: <20231116195045.GJ11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700067287.git.dsterba@suse.com>
 <9f861f8b25f74779dacf17c862b947efd59634a9.1700067287.git.dsterba@suse.com>
 <724779b3-c542-4f9f-842c-cebc8a445843@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724779b3-c542-4f9f-842c-cebc8a445843@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.62
X-Spamd-Result: default: False [-2.62 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.62)[92.60%]

On Thu, Nov 16, 2023 at 09:15:57AM +0000, Johannes Thumshirn wrote:
> On 15.11.23 18:06, David Sterba wrote:
> > +void btrfs_free_compr_page(struct page *page)
> > +{
> > +	ASSERT(page_ref_count(page) == 1);
> > +	put_page(page);
> 
> Out of curiosity, why the ASSERT()?

To verify that it's the last reference and put_page is going to free it
, so we don't put an actually used page into the cache.

