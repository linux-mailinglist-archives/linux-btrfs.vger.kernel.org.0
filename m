Return-Path: <linux-btrfs+bounces-13894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77FAB3EEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9D189936A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B55296D1D;
	Mon, 12 May 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjU7t0t4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dy72FvZU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjU7t0t4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dy72FvZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D59248F71
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070548; cv=none; b=lqoxsK7sL/uoypVl6NmsNHqsTOB1v8MzXnU79bqrNFeaT/fOmtPDKztYqAWRMHJX6DUDTWiYyakvKLehhd5MackbE0VWjh0xa5QFBFrki8iApaoUr4STWwaHLUHwaVF0kLgZEqq4A+B5V/ia8MYKTwd/niIGh99WI1NBsRRSzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070548; c=relaxed/simple;
	bh=pPcvDI+L8MflbhaWpMbzfm1mDQ0RfYJPR6FhwlBj0EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiCREFn1aiQsXdYb6LgBuX7cKXIhOd800zcrfmq66N4WX0wUHqNQuCg+xYM2pye7j8PT8qdTj1OhknUDntjSiIcJ7oMpqH7l53pgGYjYpsfJ/yBm0b7ghrx+H+xFq4I+1SqwWt7NLBfBfr9t68XhuwIHkOyLr7+CsKPA5aJCdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qjU7t0t4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dy72FvZU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qjU7t0t4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dy72FvZU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBA722117F;
	Mon, 12 May 2025 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/46GpqcSr2ujm+wvXksbBHc+wEIwMRNydgrz1a2mnM0=;
	b=qjU7t0t4OVobftCcHwv+m2732WvKRM48T+v9mOp+hKhsXFL4p/zZnZEQj/eM+R2dEFs8h7
	1OCIoZFpB57lR7zO3BO+lLCdcleVjQDLIX9ug/pRGMfw5fVJF4cBvNFUP9obYbcWGHWMTA
	+9GvK0YIcdzzyaNRl5ZVOoPTx3+AMuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/46GpqcSr2ujm+wvXksbBHc+wEIwMRNydgrz1a2mnM0=;
	b=Dy72FvZU6Cis8BBoZSN8YmYRgGPqLOc8Hq9TuV94iPGM/1QAIm3KXaBmpOkM23qvxgE0fn
	ouPQ3ZFzmwjAXlDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qjU7t0t4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dy72FvZU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/46GpqcSr2ujm+wvXksbBHc+wEIwMRNydgrz1a2mnM0=;
	b=qjU7t0t4OVobftCcHwv+m2732WvKRM48T+v9mOp+hKhsXFL4p/zZnZEQj/eM+R2dEFs8h7
	1OCIoZFpB57lR7zO3BO+lLCdcleVjQDLIX9ug/pRGMfw5fVJF4cBvNFUP9obYbcWGHWMTA
	+9GvK0YIcdzzyaNRl5ZVOoPTx3+AMuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/46GpqcSr2ujm+wvXksbBHc+wEIwMRNydgrz1a2mnM0=;
	b=Dy72FvZU6Cis8BBoZSN8YmYRgGPqLOc8Hq9TuV94iPGM/1QAIm3KXaBmpOkM23qvxgE0fn
	ouPQ3ZFzmwjAXlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B33F9137D2;
	Mon, 12 May 2025 17:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /xOMK1AuImiLcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:22:24 +0000
Date: Mon, 12 May 2025 19:22:23 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: log error codes during failures when writing
 super blocks
Message-ID: <20250512172223.GP9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bb1c6b0212c4e60ef4a6b08be741f1c50ace6afb.1747035917.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1c6b0212c4e60ef4a6b08be741f1c50ace6afb.1747035917.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CBA722117F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, May 12, 2025 at 08:48:35AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When writing super blocks, at write_dev_supers(), we log an error message
> when we get some error but we don't show which error we got and we have
> that information. So enchance the error messages with the error codes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

