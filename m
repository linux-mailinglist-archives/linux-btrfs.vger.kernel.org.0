Return-Path: <linux-btrfs+bounces-3561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D330088B3F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920E8BA0B5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E25D8E4;
	Mon, 25 Mar 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDmtultU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pajNRA8D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDmtultU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pajNRA8D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E955732C;
	Mon, 25 Mar 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392081; cv=none; b=q4rwcK3AUewMlc8JXA/NM/3mMbUMNcgCgr+zoLgu0+f1UgvLnKwIF/DpXDofWXk3o0vGVODV51GJ7uBGKTGWEh/JnA/G6nk3knUNkn336w/YLd88Hx7OItmAKr3y+4H6DIh1KfQBuFBA929mcCzWJPMkMhq3p1ejrYTzRp1aseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392081; c=relaxed/simple;
	bh=u5gD4ZQeV3t4IcBYj/PRnzyoByAZznXkR0dNjEvDP8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0+COBbqA9is1ub3jLlzHetrkWHSD7yYpa0B5Tw22W8AZNTYgSOJt6zuT5YrgIaw/BD5X7qVqILyzUgQUcg8rbwB6bBLZmBf+TNS07BfD1XA2GCQK2BA6MXSyrYPCL4XQK5Zeyp8kMjCUnGMFu+YxFKOfqZg3eHJyCGVuluCKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDmtultU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pajNRA8D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDmtultU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pajNRA8D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD4315CA5C;
	Mon, 25 Mar 2024 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711392076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri/DpzN+Z3ys5Xh1rrQ2Y5e66wVy3WieRlnJZNZFLRQ=;
	b=eDmtultUiqjtOtEwWEcomTHrY0AEyeZiNkkYshbfwM8ktGFeL7LepktsgzPPZKTfKX4u7o
	s8CZ4uC3LJjzzC1lZVcC5v/TSCQlEgpeFOXWd25BBPr+elF8XRkAjmJ6pR1zn4tcGJUIKN
	JDu6zl7h3mdJrt8XSuVczd1b88xImXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711392076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri/DpzN+Z3ys5Xh1rrQ2Y5e66wVy3WieRlnJZNZFLRQ=;
	b=pajNRA8DVUv/y7LRQ8YldD4SpEzCYc6G7p6gY9Esz7mRcA/zPjHtWKXxRQrSYryA018Bwv
	XLQtsRsI3dacHHCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711392076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri/DpzN+Z3ys5Xh1rrQ2Y5e66wVy3WieRlnJZNZFLRQ=;
	b=eDmtultUiqjtOtEwWEcomTHrY0AEyeZiNkkYshbfwM8ktGFeL7LepktsgzPPZKTfKX4u7o
	s8CZ4uC3LJjzzC1lZVcC5v/TSCQlEgpeFOXWd25BBPr+elF8XRkAjmJ6pR1zn4tcGJUIKN
	JDu6zl7h3mdJrt8XSuVczd1b88xImXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711392076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri/DpzN+Z3ys5Xh1rrQ2Y5e66wVy3WieRlnJZNZFLRQ=;
	b=pajNRA8DVUv/y7LRQ8YldD4SpEzCYc6G7p6gY9Esz7mRcA/zPjHtWKXxRQrSYryA018Bwv
	XLQtsRsI3dacHHCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 912BA13A2E;
	Mon, 25 Mar 2024 18:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id y9BBI0zFAWYMYQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 25 Mar 2024 18:41:16 +0000
Date: Mon, 25 Mar 2024 19:33:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 15/26] range: Add range_overlaps()
Message-ID: <20240325183351.GP14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eDmtultU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pajNRA8D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.77 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.56)[80.99%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,intel.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.77
X-Rspamd-Queue-Id: AD4315CA5C
X-Spam-Flag: NO

On Sun, Mar 24, 2024 at 04:18:18PM -0700, Ira Weiny wrote:
> Code to support CXL Dynamic Capacity devices will have extent ranges
> which need to be compared for intersection not a subset as is being
> checked in range_contains().
> 
> range_overlaps() is defined in btrfs with a different meaning from what
> is required in the standard range code.  Dan Williams pointed this out
> in [1].  Adjust the btrfs call according to his suggestion there.
> 
> Then add a generic range_overlaps().
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> [1] https://lore.kernel.org/all/65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch/
> ---

>  fs/btrfs/ordered-data.c | 10 +++++-----

Acked-by: David Sterba <dsterba@suse.com>

