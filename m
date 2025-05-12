Return-Path: <linux-btrfs+bounces-13900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D65AB3F2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BBA189D14C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0F253920;
	Mon, 12 May 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMgtExqA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0SAw4HhQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMgtExqA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0SAw4HhQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AD14658D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071116; cv=none; b=jNOM+HVmFojwTVQuTl+pp9BaVSEjDCHCNzP21CY21fbSNNLTPsCsFrATeSh8cLUNU94/Zv/mibD90eHg4MNv0gCXbeAD7hz6Ajb9VslaH3mCiUDUTurk9fJx7POv75oasWu20czRNSzHhEJw/dnREdgFYOA0yI0fwaXi9ymcwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071116; c=relaxed/simple;
	bh=dHlhFJH/scmc/mE8MHyfplpmnZNL1ZnRQyUMSjf69Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQAZOam9vfXDTJ3vT378rBkg5xglGGmWif2szGlZ7xA4baiCcrH35DdeAV3wbPjNHi37oK3U/mQMtprvIaBIcQxx7iy/0XMa6jtGQ3ArWgtJtP/x8REFFG/Q7ZET9zmBLjcn3ZTyVijIBxgWXv/51YOO9zaMe5SS4R/3FtX+/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMgtExqA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0SAw4HhQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMgtExqA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0SAw4HhQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BF191F387;
	Mon, 12 May 2025 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747071113;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=my9vuGXf+vUnVFWBddXzaPM8gtevO2g2FMhpH1bwD7M=;
	b=xMgtExqA+Ox7/QguJvguRoiY49YGvdQdZLPwGzsun3T5H6a91n6R51GJOXBa46WaKvLlCK
	gqKK9UHcngq5IYFZuypokdHW9bj89y3yppMyNTwV+rWj73+y4gEYWH4QNoQ584BNBj20hN
	EluXEwmopQfOBpXkQHBcyWCaO/fs5WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747071113;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=my9vuGXf+vUnVFWBddXzaPM8gtevO2g2FMhpH1bwD7M=;
	b=0SAw4HhQNHMg5cjW8cHPNMH9CtVIuWSJdk+I0oAm1c/Q8ilFUlYuEFZk/F1G6pfalt+bt7
	Z/lvjDWbE+Eab4Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xMgtExqA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0SAw4HhQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747071113;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=my9vuGXf+vUnVFWBddXzaPM8gtevO2g2FMhpH1bwD7M=;
	b=xMgtExqA+Ox7/QguJvguRoiY49YGvdQdZLPwGzsun3T5H6a91n6R51GJOXBa46WaKvLlCK
	gqKK9UHcngq5IYFZuypokdHW9bj89y3yppMyNTwV+rWj73+y4gEYWH4QNoQ584BNBj20hN
	EluXEwmopQfOBpXkQHBcyWCaO/fs5WY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747071113;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=my9vuGXf+vUnVFWBddXzaPM8gtevO2g2FMhpH1bwD7M=;
	b=0SAw4HhQNHMg5cjW8cHPNMH9CtVIuWSJdk+I0oAm1c/Q8ilFUlYuEFZk/F1G6pfalt+bt7
	Z/lvjDWbE+Eab4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E661C137D2;
	Mon, 12 May 2025 17:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TUn8N4gwImhJdQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:31:52 +0000
Date: Mon, 12 May 2025 19:31:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fdmanana@kernel.org
Subject: Re: [PATCH v2] btrfs: fix folio leak in submit_one_async_extent()
Message-ID: <20250512173143.GU9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <88fe9938eed8a7ca2dc9f4fe3a49b565b8441c1f.1746733876.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe9938eed8a7ca2dc9f4fe3a49b565b8441c1f.1746733876.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0BF191F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -4.21

On Thu, May 08, 2025 at 12:53:56PM -0700, Boris Burkov wrote:
> If btrfs_reserve_extent() fails while submitting an async_extent for a
> compressed write, then we fail to call free_async_extent_pages() on the
> async_extent and leak its folios. A likely cause for such a failure
> would be btrfs_reserve_extent() failing to find a large enough
> contiguous free extent for the compressed extent.
> 
> I was able to reproduce this by:
> 1. mount with compress-force=zstd:3
> 2. fallocating most of a filesystem to a big file
> 3. fragmenting the remaining free space
> 4. trying to copy in a file which zstd would generate large compressed
> extents for (vmlinux worked well for this)
> 
> Step 4. hits the memory leak and can be repeated ad nauseam to
> eventually exhaust the system memory.
> 
> Fix this by detecting the case where we fallback to uncompressed
> submission for a compressed async_extent and ensuring that we call
> free_async_extent_pages().
> 
> Fixes: 131a821a243f ("btrfs: fallback if compressed IO fails for ENOSPC")
> Reviewed-by: Filipe Manana <fdmanana@kernel.org>
> Co-authored-by: Josef Bacik <josef@toxicpanda.com>

The documented tag name is Co-developed-by.

