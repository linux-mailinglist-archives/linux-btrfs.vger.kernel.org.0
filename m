Return-Path: <linux-btrfs+bounces-14341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F4AC965A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 22:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798963B408E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABD5280CE5;
	Fri, 30 May 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ki10m+UO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVMbYQ/1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2roUrlgT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecmANkgv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6142367CA
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635678; cv=none; b=SBU3RIAB8COlwMckKS7sqMhb762XHCtqszgGn3rC5Wb7SbQkQCq5veCf88+hch8fohcPh7GTk54u7UVYpHsEGDzU8x1/EEgaI5xX+D2cC+dUxFVAsMKu9xOQJFwMcAB60ss72aVxi0OTrZoVbP1X3B0Bu1+Wa49Ty5eci7HaXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635678; c=relaxed/simple;
	bh=p+da9L8oykvz2EClzTkerZNsMeSS1I3D4FTbrRjkZkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xdf71LdN6FD+Ftr17IwBZ8Kd5+pOcorm++8ZcYzl3JTW+FNxkNzYfFaxHQIPhx1InKazni4Wk4nmXC9b/1/LbdNDM2u3ZCXLZ284zUufiVSX6d6kmKtec7sDed7oP9+vJqRTMXqwGNkJUcyUhG0UCsIGw/n/lt3sqcbFhD7R5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ki10m+UO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVMbYQ/1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2roUrlgT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecmANkgv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F6F91F46E;
	Fri, 30 May 2025 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748635673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mFQKx+WuP5uz1EoCQYWZziS7JLdZh6u4Lx2TfYE/c8=;
	b=Ki10m+UObHLk7qHko28i3eMuyuxGl0iqlkAdnoar67lYL9AbcxxSfsB+lz9ucV4OISe2Ch
	V6hpbjOFnT7buoJ4iD0XRZpQLVJwDCnUcpT1TB3b36JWwiTeUwPG6akwhRkNz/hlwOnBGy
	a3F2GWh3x13/nCLroGQEhdumpASnJ10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748635673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mFQKx+WuP5uz1EoCQYWZziS7JLdZh6u4Lx2TfYE/c8=;
	b=XVMbYQ/1cNld1bS4Ce0CGOoyZj+2ntE/089tbFm+Xqb4AxmPM5GkrdFEDDvaqwSTBqyfMz
	AhGb6M2v7SgQ9cCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2roUrlgT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ecmANkgv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748635672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mFQKx+WuP5uz1EoCQYWZziS7JLdZh6u4Lx2TfYE/c8=;
	b=2roUrlgTs70ayLL0Fnul1LIKIohuRu1GI82TiSdJOOt710kfdmv/a4cWAxSm6POgDS2jRP
	EW97ZzEq6CRZIdICcMeukZvS3sseCTvtBWIvMY+HEZFHIC8K9fuIiur1R1P77vhb2SjwSj
	JscdkCTJRmNzDo+xuAHSuF6AEFkQs9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748635672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mFQKx+WuP5uz1EoCQYWZziS7JLdZh6u4Lx2TfYE/c8=;
	b=ecmANkgvkhClMAoOPJutOvurQLoafp95h7QS97hN9fFsG/sTKSbfI2g8nzxftgy5rYays/
	AmAWF1orfeCRR+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CEED13889;
	Fri, 30 May 2025 20:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vp0VGhgQOmjkJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 20:07:52 +0000
Date: Fri, 30 May 2025 22:07:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs-progs: convert: fix a long bug that bgt
 feature never works
Message-ID: <20250530200746.GB4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F6F91F46E
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21
X-Spam-Level: 

On Sat, May 24, 2025 at 11:38:05AM +0930, Qu Wenruo wrote:
> There is a long bug that, "btrfs-convert -O bgt" doesn't create a fs
> with bgt feature at all.
> 
> In fact "mkfs.btrfs -O bgt" is no different than "mkfs.btrfs -O ^bgt".
> 
> The root cause is explained and fixed in the second last patch.
> 
> The first 7 patches are mostly preparation and cleanup for properly
> intorduce block group tree at temprory fs creation time.

Thanks for fixing it, this escaped everybody. The cleanups done along
the way are good.

