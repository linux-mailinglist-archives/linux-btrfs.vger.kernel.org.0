Return-Path: <linux-btrfs+bounces-8146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CFB97D6E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC42C288504
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E117BB3E;
	Fri, 20 Sep 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpj2d5ML";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQOvrzaR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpj2d5ML";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQOvrzaR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8342224F0
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842491; cv=none; b=fkV/sa1/9RysczgAOcpe426vnteO+OS4PKMIXmmODY1YFoNc7pAzUhMflJ70nKIFcfc9Z/xx5w/53fESevljqOLwAuYf6gYwreQOiEPi8FUPl6QU4jhXmpsFSK0x4qyRdVTOM7r8hHH5qmFxCreOBpg/O9u1JzCJNccZbRE2SDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842491; c=relaxed/simple;
	bh=cxsJBvy/Wp3j0V0gyXIUy1a5uHsW9eRiGLrfwTPzLqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtyyKmbI66tJdtBu7CgqzVpJsmmGv0/gLRC7aHIayYWG80frZ6jadqmb+qnvmy7hPdP4e3r3g4122kPiZOIKHZ3BfmafdVCJJu4xjMbxj8v+Pvis5ahTIbBzNbqMubkmeymsR5jj692qXG8vqQjBi72VOgL3SblniM2ijypBahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qpj2d5ML; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQOvrzaR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qpj2d5ML; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQOvrzaR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1A5833A2F;
	Fri, 20 Sep 2024 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726842487;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UalFLgoLtJuwU6Zfv8Ao+P+YWr0W8gVDzLVMyU5bP9M=;
	b=qpj2d5MLBb7EkiHC4sJ61ixkP4FrJvfgmVXJLvYELcSGGiFpkYck4DEVuzq0fi4GxYOT9i
	9fTmKEbOr6ICLmn/QmYghzMb8jkPZW8dsypLSkHQsn5/MFqmK9PAaZz+RhsPyD3R01xhW4
	Tx5EPDO21qNAGU9haupdvFDaycA5i/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726842487;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UalFLgoLtJuwU6Zfv8Ao+P+YWr0W8gVDzLVMyU5bP9M=;
	b=pQOvrzaRA59MXKo/vyLE8jpNHvBMUxC1amEgftoGT6qZ41u+y+RSeaM+mMarNhbNLdMD6u
	DOlh99Q2/4Ur0OCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qpj2d5ML;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pQOvrzaR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726842487;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UalFLgoLtJuwU6Zfv8Ao+P+YWr0W8gVDzLVMyU5bP9M=;
	b=qpj2d5MLBb7EkiHC4sJ61ixkP4FrJvfgmVXJLvYELcSGGiFpkYck4DEVuzq0fi4GxYOT9i
	9fTmKEbOr6ICLmn/QmYghzMb8jkPZW8dsypLSkHQsn5/MFqmK9PAaZz+RhsPyD3R01xhW4
	Tx5EPDO21qNAGU9haupdvFDaycA5i/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726842487;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UalFLgoLtJuwU6Zfv8Ao+P+YWr0W8gVDzLVMyU5bP9M=;
	b=pQOvrzaRA59MXKo/vyLE8jpNHvBMUxC1amEgftoGT6qZ41u+y+RSeaM+mMarNhbNLdMD6u
	DOlh99Q2/4Ur0OCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A863113AA7;
	Fri, 20 Sep 2024 14:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id khzoKHeG7Wb3TAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Sep 2024 14:28:07 +0000
Date: Fri, 20 Sep 2024 16:28:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: libbtrfsutil: fix the CI build failure
 which requires manual intervention
Message-ID: <20240920142802.GD13599@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d148df614aef86dd6244dad3e0726750a3176b34.1726793990.git.wqu@suse.com>
 <cac5a710-63ab-469c-bfcc-327da82fa036@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cac5a710-63ab-469c-bfcc-327da82fa036@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C1A5833A2F
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Sep 20, 2024 at 02:04:50PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/9/20 10:29, Qu Wenruo 写道:
> > Currently the libbtrfsutil python binding requires `pypi-README.md` as a
> > temporary file to act as the longer description.
> > 
> > But it requires the build to be run twice to generate the temporary
> > file, preventing CI to properly build the package.
> > 
> > Fix it by removing the exception raising, after copy_readme().
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Please discard this one.
> 
> The offending patch shouldn't even be pushed to devel, introducing too 
> much hassles but doesn't even bother to resolve the self-introduced problem.

I've removed the patch from devel again, the long description is for
pypi.org so not critical right now, the versions can't be resubmitted so
next opportunity is 6.11.1. Until then some solution will emerge.

