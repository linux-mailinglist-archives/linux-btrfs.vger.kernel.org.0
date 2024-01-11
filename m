Return-Path: <linux-btrfs+bounces-1401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5CE82B45C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4F01C23B66
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267E537F3;
	Thu, 11 Jan 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKd3ps6i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zd/7lne1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKd3ps6i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zd/7lne1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A9537E3
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1D141F8AF;
	Thu, 11 Jan 2024 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704995685;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFZLlgqN3/oXYZznDnlDsHBUjyN651Oc8dD6gdR57A=;
	b=kKd3ps6i496RhKRqbVOCWMkukbw8o3JQZ5s0rpi5Rou044aDtnvsG+gFur1RIaVDROLYuS
	gahf57sstGS+Kmcgn54M50TkABu+EEHQsCcSGzt5MaDbuFwzyNDh/5E4yTWjeUG5c/sBQa
	AK/Bho9+Mh2WPKWg6iqSk9d9GnAVDG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704995685;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFZLlgqN3/oXYZznDnlDsHBUjyN651Oc8dD6gdR57A=;
	b=zd/7lne1Zcw7LyXTtGtoQ5Pm/T6NOu6hPu9csYadGAWUypiXM3BeaRIVvNMRFePW8XIESb
	MpjUJPaOOp54nWBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704995685;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFZLlgqN3/oXYZznDnlDsHBUjyN651Oc8dD6gdR57A=;
	b=kKd3ps6i496RhKRqbVOCWMkukbw8o3JQZ5s0rpi5Rou044aDtnvsG+gFur1RIaVDROLYuS
	gahf57sstGS+Kmcgn54M50TkABu+EEHQsCcSGzt5MaDbuFwzyNDh/5E4yTWjeUG5c/sBQa
	AK/Bho9+Mh2WPKWg6iqSk9d9GnAVDG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704995685;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwFZLlgqN3/oXYZznDnlDsHBUjyN651Oc8dD6gdR57A=;
	b=zd/7lne1Zcw7LyXTtGtoQ5Pm/T6NOu6hPu9csYadGAWUypiXM3BeaRIVvNMRFePW8XIESb
	MpjUJPaOOp54nWBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D0619138E5;
	Thu, 11 Jan 2024 17:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ycYuMmQroGXxDgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 17:54:44 +0000
Date: Thu, 11 Jan 2024 18:54:25 +0100
From: David Sterba <dsterba@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Convert btrfs defrag to use folios
Message-ID: <20240111175146.GL31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231214161331.2022416-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214161331.2022416-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kKd3ps6i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="zd/7lne1"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmx.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.42%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: F1D141F8AF
X-Spam-Flag: NO

On Thu, Dec 14, 2023 at 04:13:28PM +0000, Matthew Wilcox (Oracle) wrote:
> Use the folio APIs throughout the defrag process.
> 
> v2:
>  - Add set_folio_extent_mapped()
>  - Rebase to next-20231214
> 
> Matthew Wilcox (Oracle) (3):
>   btrfs; Add set_folio_extent_mapped()
>   btrfs: Convert defrag_prepare_one_page() to use a folio
>   btrfs: Use a folio array throughout the defrag process

Added to misc-next, thanks.

