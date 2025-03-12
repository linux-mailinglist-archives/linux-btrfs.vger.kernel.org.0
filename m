Return-Path: <linux-btrfs+bounces-12239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D007EA5DEBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1162317A207
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582CE24DFE5;
	Wed, 12 Mar 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q0YqbBBv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fpcGShVt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HyUzrE/9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0b8Qtqdw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB38198E8C
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789143; cv=none; b=NYsJ6MDreRhI6NZXxmXJEbXXadN/X4ip7Kk7Vk7Q6jhqICKROCpVZJRP4/gq/CA1HmGx0hdHdzcfcKq1qgUJnTCTT7eqabOyFtuaUcHv3n1UxGwcMFiyFJq9POrMBGXkDFEYok27q4B4ppJd3tsyq1ct8Rg2uP9YAvviIwqU4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789143; c=relaxed/simple;
	bh=fDXhieK0BgNFZBK5KTKMiqc/8o8NsgoRw2IzyDC9Dic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDHU8OtrfWPtFtNXXxKFJhLVnK9Krl7b2wgHy6hfHawsft42SjN2vA7kHdB078A0N+elB0zfu94gORrHNa+vGOaaIY6gDNv+plQyf4/03uzkPXMbqk06eJA2wsLkmB8W0fgM3iilB8VGcEajiTPL4fRJtwke0tnNVy970cvDg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q0YqbBBv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fpcGShVt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HyUzrE/9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0b8Qtqdw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1F9F21189;
	Wed, 12 Mar 2025 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741789140;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSJWKNths2AG6Y//kKRFsHZv2kMzEELxouQExdOPQM=;
	b=q0YqbBBvS+PnkXgZgv/HyDkVM7yWlOfzrgPCwvOliTWA2rnyScLnRpY38cttAeMn8mFzcP
	x6/EOn6r0tdTDLIBdB5Rd5PlIG8YqQOiTNPPz4h+UgWSnPNu637MU3BalBs7j2cKuy7GDt
	8pkG7FTgG71C+W6hez5VL3K54+/qaXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741789140;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSJWKNths2AG6Y//kKRFsHZv2kMzEELxouQExdOPQM=;
	b=fpcGShVtm2zTzO7qNeqkoWJcYgCRJxOxK19+5O6kNX1x46oG66C1UhqgmVamisg81/jVAp
	lwsmPSwV9vBXcdCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741789138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSJWKNths2AG6Y//kKRFsHZv2kMzEELxouQExdOPQM=;
	b=HyUzrE/9jLEA3wmIXp4ZH6BU+rlObpv2/xkWvmT74EE4XP0X01eUHdMnfF8ZMJIiPmlphY
	sE3fFhuFup5SwuyTni1famcgVFrgz3UNjaFmlQrowc0t3aghI03xziqtDPRhlDjlzXxtK7
	TOuGkVsaFqkRcxyfHM/HuafXfQ28gMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741789138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSJWKNths2AG6Y//kKRFsHZv2kMzEELxouQExdOPQM=;
	b=0b8QtqdwPq6PbRFqcXUpmRVbRZ2m7HQL+Dt+MmqUHUIGrwzkbzR/qivZZNDl/HbnxntzK8
	a67ID38YjYZCoeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B101377F;
	Wed, 12 Mar 2025 14:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VPSoLNKX0WerdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Mar 2025 14:18:58 +0000
Date: Wed, 12 Mar 2025 15:18:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
Message-ID: <20250312141857.GP32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250311163931.1021554-1-maharmstone@fb.com>
 <92a9f026-d195-43fd-aade-029f12f4fca8@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92a9f026-d195-43fd-aade-029f12f4fca8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Mar 12, 2025 at 07:40:09AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/12 03:09, Mark Harmstone 写道:
> > Commit 2a9bb78cfd36 introduces a call to validate_sys_chunk_array() in
> > btrfs_validate_super(), which clobbers the value of ret set earlier.
> > This has the effect of negating the validity checks done earlier, making
> > it so btrfs could potentially try to mount invalid filesystems.
> > 
> > Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> > Cc: Qu Wenruo <wqu@suse.com>
> > Fixes: 2a9bb78cfd36 ("btrfs: validate system chunk array at btrfs_validate_super()")
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks for catching this.
> 
> Although I agree with Filipe that it's better to return the error 
> immediately in the future.
> 
> Yes, currently it will report all the errors, but if the first check 
> against magic number fails, the super block can just be garbage and all 
> the remaining checks will be triggered.

We can return immediately when the magic does not match, it's more
likely that the sb would be garbage so the following checks will fail
and be just noise.

However if the magic is correct then I find it better to print which
errors were found, they get all logged to the syslog and it can help
analyzing the problem.

