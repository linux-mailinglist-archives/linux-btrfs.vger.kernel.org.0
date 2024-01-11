Return-Path: <linux-btrfs+bounces-1397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B182B231
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 16:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CC01C24646
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C464F1E6;
	Thu, 11 Jan 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="10HGB+/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHc6NNPK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="10HGB+/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHc6NNPK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547AB495FB
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52A122222C;
	Thu, 11 Jan 2024 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704988481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqZmuRHNLH8ljUZ73NF1g7UqL/gzabV5Zv9AS/q9joM=;
	b=10HGB+/89WtdNUOUiL9MaXVBkSA2HVdckoX/lRrCbAJxTzPfcByB2xRvkKbuiSYjlGvrI7
	BP1GUDsbVDxW2nrTjCxRB8Is4q2apaz/ZzNsvv9baaTGgGo3XoWkoaLhogjviaaY9m3G2q
	Gz0H+DIV9Dm5xcRKObmvHNSAkZmI5f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704988481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqZmuRHNLH8ljUZ73NF1g7UqL/gzabV5Zv9AS/q9joM=;
	b=YHc6NNPKY1mD1M6NY3ji2sw4yMHsi1LcgfSbapKxHHUNKbhC/BbWL/+OcAlSajMZUUQMbR
	JTSPVReeg/gKctCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704988481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqZmuRHNLH8ljUZ73NF1g7UqL/gzabV5Zv9AS/q9joM=;
	b=10HGB+/89WtdNUOUiL9MaXVBkSA2HVdckoX/lRrCbAJxTzPfcByB2xRvkKbuiSYjlGvrI7
	BP1GUDsbVDxW2nrTjCxRB8Is4q2apaz/ZzNsvv9baaTGgGo3XoWkoaLhogjviaaY9m3G2q
	Gz0H+DIV9Dm5xcRKObmvHNSAkZmI5f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704988481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqZmuRHNLH8ljUZ73NF1g7UqL/gzabV5Zv9AS/q9joM=;
	b=YHc6NNPKY1mD1M6NY3ji2sw4yMHsi1LcgfSbapKxHHUNKbhC/BbWL/+OcAlSajMZUUQMbR
	JTSPVReeg/gKctCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 36371138E5;
	Thu, 11 Jan 2024 15:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NBT9DEEPoGWaegAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 15:54:41 +0000
Date: Thu, 11 Jan 2024 16:54:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't unconditionally call folio_start_writeback
 in subpage
Message-ID: <20240111155425.GH31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
 <755c30fa-a601-4ba6-8263-601439f1bceb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755c30fa-a601-4ba6-8263-601439f1bceb@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="10HGB+/8";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YHc6NNPK
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.59%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 52A122222C
X-Spam-Level: 
X-Spam-Score: -1.52
X-Spam-Flag: NO

On Thu, Jan 11, 2024 at 01:57:13PM +0800, Anand Jain wrote:
> On 1/11/24 06:14, Josef Bacik wrote:
> > In the normal case we check if a page is under writeback and skip it
> > before we attempt to begin writeback.
> > 
> > The exception is subpage metadata writes, where we know we don't have an
> > eb under writeback and we're doing it one eb at a time.  Since
> > b5612c368648 ("mm: return void from folio_start_writeback() and related
> > functions") we now will BUG_ON() if we call folio_start_writeback()
> > on a folio that's already under writeback.  Previously
> > folio_start_writeback() would bail if writeback was already started.
> > 
> 
> > Fix this in the subpage code by checking if we have writeback set and
> > skipping it if we do.  This fixes the panic we were seeing on subpage.
> 
> The panic stack trace in the git commit log will add more clarity.
> 
> Can we fold this into the commit 55151ea9ec1b ("btrfs: migrate subpage 
> code to folio interfaces")

No we can't fold that it's been already merged to master branch, besides
the fact that the whole patch queue was frozen a month ago.

