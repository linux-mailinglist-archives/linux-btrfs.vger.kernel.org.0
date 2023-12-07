Return-Path: <linux-btrfs+bounces-747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76854808859
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 13:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759871C21F4B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2413D0D4;
	Thu,  7 Dec 2023 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LrW55+dJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ga9UDSgC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4410D9
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 04:49:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7860721D62;
	Thu,  7 Dec 2023 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701953366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrodfVN81dfJtGTw2VrKb1EO1PsgicmGVbpEJlQ1xoc=;
	b=LrW55+dJF1fcm1/2lw1ZUTNi0mAmW72M2UyxZ5GvUidcMXspYXYCXuf3lNDu4ICzKKT/s4
	49JCKM7Du+BBiHfGhzsiheV2ZQTcvHXKOcyNAYvwREqISoujcHjbv/NKhBlAI+zt+v3nPj
	zN4jy8jOIKVgK7uD+mRx+XnxYl9q33s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701953366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrodfVN81dfJtGTw2VrKb1EO1PsgicmGVbpEJlQ1xoc=;
	b=Ga9UDSgC6DPeenUBi0G5pkVfq595YYPkV5qsVH1vpq0XhPPkZwOD+SMryUxgy4VeENWamQ
	C9061kVG7IBLGnCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5339C139E3;
	Thu,  7 Dec 2023 12:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VdQcFFa/cWVcBwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 07 Dec 2023 12:49:26 +0000
Date: Thu, 7 Dec 2023 13:42:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: migrate extent_buffer::pages[] to folio
 and more cleanups
Message-ID: <20231207124235.GV2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701902977.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701902977.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.31
X-Spamd-Result: default: False [-6.31 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.31)[90.19%]

On Thu, Dec 07, 2023 at 09:39:26AM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add a new patch to do more cleanups for metadata page pointers usage
> 
> v3:
> - Fix a bug in alloc_eb_folio_array() which accesses uninitialized stack
>   It turns out that I have CONFIG_INIT_STACK_ALL_ZERO, which prevents me
>   from exposing the bug. Now changed to CONFIG_INIT_STACK_ALL_PATTERN.

Seems to be fixed, thanks. I had CONFIG_INIT_STACK_NONE=y so it got
caught due to random data on the stack but with
CONFIG_INIT_STACK_ALL_PATTERN the pattern makes it clear that it's due
to that.

Added to misc-next, thanks.

