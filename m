Return-Path: <linux-btrfs+bounces-9371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA79BF545
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74921C2368B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B9208214;
	Wed,  6 Nov 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHy3hCj2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6vCPqi6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHy3hCj2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x6vCPqi6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A936D
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917898; cv=none; b=mugkAw+FJXhqsFG0tSh5vOUPhxMXJecLp8eyoifjG8lsKtS0IhehhPXgXOL3Hkxy3GJEMpGFpSkXKYbFNiYZ9UAwMK6oKsNQEc89x5bDCvTKqMZxi6Q3a4FgbiA+gn2ghEJY+eLIdhtbAGzTFMBCcrCRWJuQdbFEJcVk+nikNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917898; c=relaxed/simple;
	bh=34atIJWZq8qzdNcc2CKmYQKJ2qUb+Eqk7OrCRlqof1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbZ6E9arH21yUlF4No9JH0lUsjL4CmtR4uYserjx/AEUtL/duydgT9hVHkLzFBFZJRt70ei7cy3Ku2TCscjjIY2vj8keNbhAsPwE7omwRNLEkO3aIZ1Dall5Mq6akrt3d/l1YoQwWfM85BE/FG4QL9dw66JKRD4xl5rTNtJV058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHy3hCj2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x6vCPqi6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHy3hCj2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x6vCPqi6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB4221B2F;
	Wed,  6 Nov 2024 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730917894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fe7zKTm2mFOyStcZ7twWtWVR+J3sdVut6r8QN0Cfboo=;
	b=jHy3hCj2w6EDmSQNTB2bYC+BhH0qCBjQlaIPPndmnd/Pvr6QApuKQAAGDLv7LttGq96Avp
	YwbLPfWaOA9GFJrbvorfgkziPc63KHA/OtMTxleFJa2/oZlkoiMpPFjkz5Ufk21XpAVZhV
	Gbb64XhiNeMv4bfyVs3MjnTpAw2fMdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730917894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fe7zKTm2mFOyStcZ7twWtWVR+J3sdVut6r8QN0Cfboo=;
	b=x6vCPqi6btZ5v4gT6OfuzVciGthQqu9oeTr83Q3jrnNJGFVakQobopjpY33++ufl5Wt9gR
	UfghpOsRzX12lrAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jHy3hCj2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x6vCPqi6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730917894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fe7zKTm2mFOyStcZ7twWtWVR+J3sdVut6r8QN0Cfboo=;
	b=jHy3hCj2w6EDmSQNTB2bYC+BhH0qCBjQlaIPPndmnd/Pvr6QApuKQAAGDLv7LttGq96Avp
	YwbLPfWaOA9GFJrbvorfgkziPc63KHA/OtMTxleFJa2/oZlkoiMpPFjkz5Ufk21XpAVZhV
	Gbb64XhiNeMv4bfyVs3MjnTpAw2fMdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730917894;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fe7zKTm2mFOyStcZ7twWtWVR+J3sdVut6r8QN0Cfboo=;
	b=x6vCPqi6btZ5v4gT6OfuzVciGthQqu9oeTr83Q3jrnNJGFVakQobopjpY33++ufl5Wt9gR
	UfghpOsRzX12lrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F94D137C4;
	Wed,  6 Nov 2024 18:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wmDUIga2K2f/BwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 06 Nov 2024 18:31:34 +0000
Date: Wed, 6 Nov 2024 19:31:33 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some fixes around check send root flags
Message-ID: <20241106183133.GH31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1730892925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730892925.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9EB4221B2F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Nov 06, 2024 at 11:50:44AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Do proper checks for dead and read-only send roots while under the
> protection of the necessary lock. More details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: send: check for dead send root under critical section
>   btrfs: send: check for read-only send root under critical section

Reviewed-by: David Sterba <dsterba@suse.com>

