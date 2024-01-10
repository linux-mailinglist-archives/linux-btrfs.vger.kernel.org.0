Return-Path: <linux-btrfs+bounces-1351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376F48292C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 04:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCCD1C25534
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30B4689;
	Wed, 10 Jan 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsyJVf2s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="prgEM6Ok";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsyJVf2s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="prgEM6Ok"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B123D0
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A789922116;
	Wed, 10 Jan 2024 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704856823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf41CG9o1bH5fkDg+qmC3R0vdTM8X9nHGZXheeQpi5c=;
	b=wsyJVf2sfqk6bs+489P52pnhYXWGSWXGNPfFGVwUoBXt2ZhST2y9P9E6f+d7pAXEO3RuPC
	kbPjpwttmCA0sCM8xwyaRiSMIIHiIJ6Py8nFNJlJCVo23Y2DlLUuGzeU3UmbbBMiVp5DO8
	8ruDQ4/Z+b57mFmMlsWjQj2qdGMlEtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704856823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf41CG9o1bH5fkDg+qmC3R0vdTM8X9nHGZXheeQpi5c=;
	b=prgEM6OkHLag+8PSBEfs6DCTM/wJTX3dtEwpZXz/pb4VqOR6NHyxJFArEVN5sBGsR8a6Td
	IxiQvN+Bmv2G1RDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704856823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf41CG9o1bH5fkDg+qmC3R0vdTM8X9nHGZXheeQpi5c=;
	b=wsyJVf2sfqk6bs+489P52pnhYXWGSWXGNPfFGVwUoBXt2ZhST2y9P9E6f+d7pAXEO3RuPC
	kbPjpwttmCA0sCM8xwyaRiSMIIHiIJ6Py8nFNJlJCVo23Y2DlLUuGzeU3UmbbBMiVp5DO8
	8ruDQ4/Z+b57mFmMlsWjQj2qdGMlEtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704856823;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf41CG9o1bH5fkDg+qmC3R0vdTM8X9nHGZXheeQpi5c=;
	b=prgEM6OkHLag+8PSBEfs6DCTM/wJTX3dtEwpZXz/pb4VqOR6NHyxJFArEVN5sBGsR8a6Td
	IxiQvN+Bmv2G1RDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5CB13C94;
	Wed, 10 Jan 2024 03:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iifQIvcMnmVNOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 03:20:23 +0000
Date: Wed, 10 Jan 2024 04:20:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: fix the return value of "btrfs
Message-ID: <20240110032009.GS28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704855097.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704855097.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A789922116
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wsyJVf2s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=prgEM6Ok
X-Spam-Score: -2.64
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.64 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.43)[91.15%]

On Wed, Jan 10, 2024 at 01:23:30PM +1030, Qu Wenruo wrote:
> There is a bug report ("https://github.com/kdave/btrfs-progs/issues/730")
> that after commit 5aa959fb3440 ("btrfs-progs: subvolume create: accept
> multiple arguments"), "btrfs subvolume create" no longer properly return
> 1 for error cases.
> 
> It turns out that the offending commit changed how we determine the
> return code, thus for several error cases, we still return 0 for
> create_one_subvolume().
> 
> Fix it and add a test case for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: cmd/subvolume: ix return value when the target exists
>   btrfs-progs: cli-tests: add test case for return value of "btrfs
>     subvlume create"

Added to devel, thanks.

