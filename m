Return-Path: <linux-btrfs+bounces-8969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114D9A0F37
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FAE1C22F64
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90D20F5A2;
	Wed, 16 Oct 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXR0RtMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmOtkaTC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHfKKpqe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3ETsu7A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973E54F95
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094438; cv=none; b=ID75mL3zkvwWbovG/FdVLq0iV0d1X5eU4ASVHiTme73Hp1bxBJFObXNpFd/uZ69j+aRP/CxEovyluOK+wFztB2wdNOHi5rj5eAi1OGIVhSMB46ixGKUa3YrSDN5dZn3wWroQhjj6KVZxQVT1JBqVRl4qTjrAoFsFrOm5E78NoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094438; c=relaxed/simple;
	bh=uq4THHwD6CzecyDSM8ZyDzbhh7j1YEomMpKw4xMvVtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l73gcTX3JGcPBD6k1ChaCZYCLEJr45IMxp8rFRXWLAXaTnkiNRXgtGM22dCovmjYii0UcikQ9wdX468Pjx63JHK6Xw6Bt39vTZc2C7pxzG2oVRg0Z++Vxh2ajToyyAJ7ykZ9Zku2Q4oUCxiC0wU88ZP1Nsr8dQ5M6qTdwMYqyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yXR0RtMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmOtkaTC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHfKKpqe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3ETsu7A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1DB121EC4;
	Wed, 16 Oct 2024 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729094435;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfDmTFrOkwOYz66ohTC3ZFmyBpX17S5Vj56Uz+arv4I=;
	b=yXR0RtMvm9O3UhctXPYEDg9QzVu2ObhXTcoiqH4bwoM53Xsjwm3UYPH2O1Ima1ZYZcWk0S
	wjaaHvPKgkwrbLQ+hqosnJ/Rofa6b83A5cKaNwpRCc01yvI4o3+NYoT9K32iV5aXysRiI+
	6PWFwPZ9NNNFyr2IDN14FPJcdX84of0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729094435;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfDmTFrOkwOYz66ohTC3ZFmyBpX17S5Vj56Uz+arv4I=;
	b=GmOtkaTCrVy3K7qEPtn8FiA63pjOZZJdxdme84x2yu4ttXBps2LPqNT4IToLcqpYhaxWif
	b9ZUIZMLrgQSyFAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729094434;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfDmTFrOkwOYz66ohTC3ZFmyBpX17S5Vj56Uz+arv4I=;
	b=HHfKKpqeaWqcInMo8dpqq4juzM8bkPCkyDsi05yZEkLTE6USmOU8GHoTaqiuBaQ5QnniNf
	MCAxToYE6xT0zpO/cXOmW9w0Xz2iW3L6QZdTYuKJd4uowhfjxU1He5sjpVsSy1CxJUGfoZ
	5ZxI8iEngud7goNYy17yPElQgXizkMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729094434;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfDmTFrOkwOYz66ohTC3ZFmyBpX17S5Vj56Uz+arv4I=;
	b=d3ETsu7AenLfHKxBqbJJo7FZV18pL/KJqxSzldS7fTwL9TcMKVaGP6SKcXNMHL0IZM6Aig
	oNivV/0UWR6e8pAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE0921376C;
	Wed, 16 Oct 2024 16:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1q/IMSLjD2coOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 16:00:34 +0000
Date: Wed, 16 Oct 2024 18:00:33 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some cleanups around read_block_for_search()
Message-ID: <20241016160033.GS1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1729075703.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729075703.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 16, 2024 at 03:20:19PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A set of cleanups around read_block_for_search() and btrfs_verify_level_key(),
> mostly simplify arguments and remove redundant arguments and variables.
> 
> Filipe Manana (4):
>   btrfs: remove redundant level argument from read_block_for_search()
>   btrfs: simplify arguments for btrfs_verify_level_key()
>   btrfs: remove redundant initialization from btrfs_readahead_tree_block()
>   btrfs: remove local generation variable from read_block_for_search()

Reviewed-by: David Sterba <dsterba@suse.com>

