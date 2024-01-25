Return-Path: <linux-btrfs+bounces-1800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE683C81E
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD1B223CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA4130E3F;
	Thu, 25 Jan 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhZ8AJXl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7Ko2MoE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhZ8AJXl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7Ko2MoE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42C7CF13
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200509; cv=none; b=rjQcj/CxyyDLqKVb9g21iWg7uBtyg8SZwrUygW1NYqvsql+NIS26lROM3jvd1uyozoQOdowYHLq0FKMIHu99IhH5p/SD/EUG+ea+8SP3PiOd6vfm/ZkMqsEYbGzSM3XCruWTv6DtE3Zf+0fQiqQg9h0xNb//looD/V7hyqfFz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200509; c=relaxed/simple;
	bh=SoHnyYtKLUc+8k94WumQTSUyfOXBUP7r0tIAg8pg/FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKDc842BSzZFe5K3yRi6P3UqnBnDAk00J/hqIrpsJdhDQvx4QW9lypgjeHlFiO0j/czTpJY45mLorKUCu8yWG225f/8h6fJCmH9p4ulJU+Zebq7xxbYVnjU4kEuLDER+T578sNA2Z4lbCKQxWyi25d1KKqBlOXvFPhQILWj3Ick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhZ8AJXl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7Ko2MoE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhZ8AJXl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7Ko2MoE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 160F81F88D;
	Thu, 25 Jan 2024 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706200505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIvuNdVuseqcvTxbc5Lhpf5HDgB0g1XbTrzdqeAVBWQ=;
	b=JhZ8AJXlNWdl7h3KDhvuguZKqaGK2xIHmzrWX1bI2ZQkPhyH+oB3tmJ1AdyqnudCFa33G9
	D6UxGx+IMN6sm1igOqbL1R8HzbL6QCjx7pxCm1k/W9bP6MW3Ma2VPr227U8jyPX1sMKqg+
	LKgbGUhZkvpfNdTWGrIleATtLZ3pnRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706200505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIvuNdVuseqcvTxbc5Lhpf5HDgB0g1XbTrzdqeAVBWQ=;
	b=X7Ko2MoEOpGxq2sT8UcUH7oqaw5w2c6t6L6YLzdfLiciUBku0o5zC5Ad+PwM1xaPjUFh31
	YGz2y8gxEo/IZpDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706200505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIvuNdVuseqcvTxbc5Lhpf5HDgB0g1XbTrzdqeAVBWQ=;
	b=JhZ8AJXlNWdl7h3KDhvuguZKqaGK2xIHmzrWX1bI2ZQkPhyH+oB3tmJ1AdyqnudCFa33G9
	D6UxGx+IMN6sm1igOqbL1R8HzbL6QCjx7pxCm1k/W9bP6MW3Ma2VPr227U8jyPX1sMKqg+
	LKgbGUhZkvpfNdTWGrIleATtLZ3pnRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706200505;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIvuNdVuseqcvTxbc5Lhpf5HDgB0g1XbTrzdqeAVBWQ=;
	b=X7Ko2MoEOpGxq2sT8UcUH7oqaw5w2c6t6L6YLzdfLiciUBku0o5zC5Ad+PwM1xaPjUFh31
	YGz2y8gxEo/IZpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2984134C3;
	Thu, 25 Jan 2024 16:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vzcUO7iNsmXAfAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 16:35:04 +0000
Date: Thu, 25 Jan 2024 17:34:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/20] Error handling fixes
Message-ID: <20240125163438.GR31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <5186824d-3d1a-42ac-9b6b-6773105ad560@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5186824d-3d1a-42ac-9b6b-6773105ad560@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JhZ8AJXl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X7Ko2MoE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[36.10%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 160F81F88D
X-Spam-Flag: NO

On Thu, Jan 25, 2024 at 02:51:34PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/25 07:47, David Sterba wrote:
> > Get rid of some easy BUG_ONs, there are a few groups fixing the same
> > pattern. At the end there are three patches that move transaction abort
> > to the right place. I have tested it on my setups only, not the CI, but
> > given the type of fix we'd never hit any of them without special
> > instrumentation.
> 
> Sorry, I bombarded the mailing list again...
> 
> So there is the summary of my comments here:

I've replied to the patches and readin this mail I don't see any
unanswered questions or points. The main problem with the error handling
is that it's not done consistently everywhere, I'm going to spend more
time on that and the discussion we had helped me to clear some points so
I'll drop it to the documentation for further reference. Also it's not
set in stone so we may refine it as needed. Thanks.

