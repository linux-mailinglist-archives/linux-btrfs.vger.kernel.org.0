Return-Path: <linux-btrfs+bounces-5959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30616916CBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FCB27593
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F417A92C;
	Tue, 25 Jun 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jPsGzWAI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbRHFM10";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jPsGzWAI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbRHFM10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAC17107C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328396; cv=none; b=afufTkceMYjLOFVsKAkWEBfxEfzl9NJ/1EvwzTMR2JaQl2WudwWc8k5lvZ0AcRlR0GtpV9CiNzTmtE3BPJjtXmz8LWvhPVHq/vsheGcylNQs0PeN8Fav13S7+bHZQ9W+Ctwnhx8ExYH0myA876dmgDP179cdiHaDdCKpAiSdIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328396; c=relaxed/simple;
	bh=hE7oEkiJfQjNOUHTHv99RbqLVNkUOmNIrr7EWtsuNuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vrn0E7GX3JjV/zMvCeDiwEiyqhFyUKarVQUP7ENY7St0Qg0o2y2FZVh7kBuFLHRVCropG9PSuNj+i2Uk1Ey9HpMHAoGuRY84Bc46O1RIc/Un5jb7algRZY5bHaMHYMAcRXPCFullvBDk6k+N5SVJdIjDe5AP97WF5xr9fQA67Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jPsGzWAI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbRHFM10; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jPsGzWAI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbRHFM10; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B3711F889;
	Tue, 25 Jun 2024 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719328393;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvzNMbY5M7dMo3Q1Y6Y6VTBcoU/vcwY0cKw6lS0wero=;
	b=jPsGzWAIcTSD2F8T0nxGUQF9Kj/PGv84D+IFSGL4ovFm7+h77jE0R0UtMy+MhwDV9KWryb
	Tfsp4PcwUWCfV8o4OlPTdUlJjb+hlYiqTPx78M0Rwc2rRZ3yUtSFJMHlVs0EVcqsD1XoBP
	LDsEqaz3Ci9OyKozJKMDf67y9Rx/PaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719328393;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvzNMbY5M7dMo3Q1Y6Y6VTBcoU/vcwY0cKw6lS0wero=;
	b=fbRHFM10H7KdHgDHuWNKLK+N7d+6Ao6exiyVGY6LIycGZ1kEjBBZAdpmrNjUsl5gRViTK9
	4xY8tvTHenDj9MCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719328393;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvzNMbY5M7dMo3Q1Y6Y6VTBcoU/vcwY0cKw6lS0wero=;
	b=jPsGzWAIcTSD2F8T0nxGUQF9Kj/PGv84D+IFSGL4ovFm7+h77jE0R0UtMy+MhwDV9KWryb
	Tfsp4PcwUWCfV8o4OlPTdUlJjb+hlYiqTPx78M0Rwc2rRZ3yUtSFJMHlVs0EVcqsD1XoBP
	LDsEqaz3Ci9OyKozJKMDf67y9Rx/PaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719328393;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvzNMbY5M7dMo3Q1Y6Y6VTBcoU/vcwY0cKw6lS0wero=;
	b=fbRHFM10H7KdHgDHuWNKLK+N7d+6Ao6exiyVGY6LIycGZ1kEjBBZAdpmrNjUsl5gRViTK9
	4xY8tvTHenDj9MCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF2881384C;
	Tue, 25 Jun 2024 15:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MY01OojeembAOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Jun 2024 15:13:12 +0000
Date: Tue, 25 Jun 2024 17:13:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not check ram_bytes for non-compressed
 data extents
Message-ID: <20240625151307.GV25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4ba45162892b90a9a7e9603df9705080e5292f47.1718965319.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba45162892b90a9a7e9603df9705080e5292f47.1718965319.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.963];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]

On Fri, Jun 21, 2024 at 07:52:06PM +0930, Qu Wenruo wrote:
> This patch reverts the following 3 commits:
> d0cc40d23aa0 ("btrfs-progs: tests: add test case for ram_bytes detection and repair")
> 7313573c1942 ("btrfs-progs: check: original, detect and repair ram_bytes mismatch")
> 97bf7a596900 ("btrfs-progs: check: lowmem, detect and repair mismatched ram_bytes")
> 
> The problem with the ram_bytes check is, kernel can handle it without
> any problem, and the original objective for this is to detect such
> problem as I immaturelly believe the problem is fixed.
> 
> But it turns out to be incorrect and this check is already causing
> problems.
> 
> Fix it by doing a full revert for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

