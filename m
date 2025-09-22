Return-Path: <linux-btrfs+bounces-17074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C2B90411
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B859B3A7B7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A730102A;
	Mon, 22 Sep 2025 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EtvDE1cN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5pkW3Ubw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EtvDE1cN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5pkW3Ubw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D552472B1
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537752; cv=none; b=UIolYUV2Uhn4NOmsXzUxvsZFLU92FyfAOVAqqh3Gv+Ehoem1idDLtAM8x2IAwI7pbXKnuQLnINY7YZP7oC/vNFZrqyX20EzQY2UtGYhbMbpGlD0MRWTDqlNeK/SLEuJ0tFXJFw2a54Ccwa+4kqSAYd4f8IqIQ5+c1rUcf0OOkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537752; c=relaxed/simple;
	bh=cBsoy96xz2B3wJyW0MukLGvInNhgQfJMw9KZt5h35P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/WeKNyeNWOXxGlke4OvBJShtB4x/NI4fq0nln9wFkknPoctDZStb5EDhX+8mQc+J0whzHV9LASuLIMQqHZRc4Xx9OYNZhW7js2H7MpPdjJ5tqdS5eSHmCWjTocX/D+mhO04pukrzG4kavg3wGt8SF4d20OCgVXykyV0fbzVe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EtvDE1cN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5pkW3Ubw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EtvDE1cN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5pkW3Ubw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88B5C1FD87;
	Mon, 22 Sep 2025 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758537749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hXF+3hhKJkdmm3+p5giupuNBAcStxKiCEvWL0cHJOI=;
	b=EtvDE1cN0Tr6uHHUPDbTeQ30U/pRFnz9hZSbXwA/joItScVi34Jo3L9oR/nqZ6PL+/JzQq
	nWkaWqA9GUQXJyOMCMnvneFGIatRk9fMmPxZQzbediGpeOLC4zLKjK/lwDJpwACZ5clHPo
	gb+yvR9N+UUO571iRJCiwknu04ow25Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758537749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hXF+3hhKJkdmm3+p5giupuNBAcStxKiCEvWL0cHJOI=;
	b=5pkW3UbwS29F3CQX7PyPur+/lXs9bOCXD1ClcpWF7egzopUWvFKdUJS4h315hL5za7PMLk
	/fGGG6CfqhHDbIDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EtvDE1cN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5pkW3Ubw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758537749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hXF+3hhKJkdmm3+p5giupuNBAcStxKiCEvWL0cHJOI=;
	b=EtvDE1cN0Tr6uHHUPDbTeQ30U/pRFnz9hZSbXwA/joItScVi34Jo3L9oR/nqZ6PL+/JzQq
	nWkaWqA9GUQXJyOMCMnvneFGIatRk9fMmPxZQzbediGpeOLC4zLKjK/lwDJpwACZ5clHPo
	gb+yvR9N+UUO571iRJCiwknu04ow25Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758537749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hXF+3hhKJkdmm3+p5giupuNBAcStxKiCEvWL0cHJOI=;
	b=5pkW3UbwS29F3CQX7PyPur+/lXs9bOCXD1ClcpWF7egzopUWvFKdUJS4h315hL5za7PMLk
	/fGGG6CfqhHDbIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7650013A76;
	Mon, 22 Sep 2025 10:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ubG1HBUo0Wj6QQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 10:42:29 +0000
Date: Mon, 22 Sep 2025 12:42:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 9/9] btrfs: enable experimental bs > ps support
Message-ID: <20250922104224.GN5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1758494326.git.wqu@suse.com>
 <018a9a3216ac9a4d79562105ea10727cec23e8ed.1758494327.git.wqu@suse.com>
 <20250922102124.GK5333@twin.jikos.cz>
 <1f4c903b-9a7a-49c7-ac5a-76511c514ebb@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f4c903b-9a7a-49c7-ac5a-76511c514ebb@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 88B5C1FD87
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Mon, Sep 22, 2025 at 07:57:40PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/9/22 19:51, David Sterba 写道:
> > On Mon, Sep 22, 2025 at 08:10:51AM +0930, Qu Wenruo wrote:
> >> +	if (fs_info->sectorsize > PAGE_SIZE) {
> >> +		ret = -ENOTTY;
> > 
> > I did a minor fixup of the error code to -EOPNOTSUPP,
> 
> Please don't.
> 
> The error code is to co-operate with btrfs-progs, which doesn't check 
> EOPNOTSUPP.

Well then we should fix btrfs-progs because this breaks the informal
error code protocol

> And the encoded receive only falls back to regular one when got a ENOTTY.

But this is still only for the bs > ps case, right? So it may be
temporarily broken until we sync the kernel code and progs but would not
otherwise break the other cases.

