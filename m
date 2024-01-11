Return-Path: <linux-btrfs+bounces-1404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FF82B4D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 19:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D8F1C2475E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550B53E14;
	Thu, 11 Jan 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uLlRj5V8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83nPaYq/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uLlRj5V8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83nPaYq/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5D1F60F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F73C1F8B2;
	Thu, 11 Jan 2024 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704998579;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8F6CMmpvtMbcQLKRZR1ZipB344zI52WdCuv9g7g9Ws=;
	b=uLlRj5V8QMYFe5PHh49v8gA00zFv951rqI0Hg5ngg2d8SK8c363pb7qgCc6KqFXC+LlqXQ
	PF9WsUUGmDn0dWivAYp059g3TC2mT7tOjZIFHk/YJH65NLs7/xfe0W9t+JBDLTfPm/4p6/
	A+2XkGY8EUU7TeuN6cyVCBmM6rvd+n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704998579;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8F6CMmpvtMbcQLKRZR1ZipB344zI52WdCuv9g7g9Ws=;
	b=83nPaYq/aHwqho4ysgTiZq0zm12SmMLAoIQLETLA/zwSG6AA4yLJ64EcLYkeyS2gYgEVTV
	dvIQSL1YUPFZMpAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704998579;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8F6CMmpvtMbcQLKRZR1ZipB344zI52WdCuv9g7g9Ws=;
	b=uLlRj5V8QMYFe5PHh49v8gA00zFv951rqI0Hg5ngg2d8SK8c363pb7qgCc6KqFXC+LlqXQ
	PF9WsUUGmDn0dWivAYp059g3TC2mT7tOjZIFHk/YJH65NLs7/xfe0W9t+JBDLTfPm/4p6/
	A+2XkGY8EUU7TeuN6cyVCBmM6rvd+n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704998579;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8F6CMmpvtMbcQLKRZR1ZipB344zI52WdCuv9g7g9Ws=;
	b=83nPaYq/aHwqho4ysgTiZq0zm12SmMLAoIQLETLA/zwSG6AA4yLJ64EcLYkeyS2gYgEVTV
	dvIQSL1YUPFZMpAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA8F132FA;
	Thu, 11 Jan 2024 18:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ThiXDrM2oGWEEwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 18:42:59 +0000
Date: Thu, 11 Jan 2024 19:42:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't unconditionally call folio_start_writeback
 in subpage
Message-ID: <20240111184243.GN31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uLlRj5V8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="83nPaYq/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.24 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.19)[-0.958];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.05%]
X-Spam-Score: -1.24
X-Rspamd-Queue-Id: 4F73C1F8B2
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 05:14:21PM -0500, Josef Bacik wrote:
> In the normal case we check if a page is under writeback and skip it
> before we attempt to begin writeback.
> 
> The exception is subpage metadata writes, where we know we don't have an
> eb under writeback and we're doing it one eb at a time.  Since
> b5612c368648 ("mm: return void from folio_start_writeback() and related
> functions") we now will BUG_ON() if we call folio_start_writeback()
> on a folio that's already under writeback.  Previously
> folio_start_writeback() would bail if writeback was already started.
> 
> Fix this in the subpage code by checking if we have writeback set and
> skipping it if we do.  This fixes the panic we were seeing on subpage.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: David Sterba <dsterba@suse.com>

