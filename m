Return-Path: <linux-btrfs+bounces-4197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D18A3430
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6231F23229
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF214B097;
	Fri, 12 Apr 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XacsC2qZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hi03yxP/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XacsC2qZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hi03yxP/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33B38DC8
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941052; cv=none; b=KFORWCgKAUmV+Qxf7Y6zx12ooSoooqT9JzWnbF703nXCx4EY4wSl0JJ63Ld0jj2JCVMITrkpV+zwZezatOlDXqSzexGKRnxFN+PPSS3lJ80lbhfKtHZJIL1v0mdeMaYN4nHpQMHTs9SPz+5rgTDr7UKaTfAntGEis78zFsrb7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941052; c=relaxed/simple;
	bh=Zzmbs1UnNhc7araKJ9/mwASDGaJ2zsqz7BH3FISiJ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkXnslRtifDH/c60lSGAJlmbapr43l3Z5od7/WF1MHufLnOmQyi408K9u/+j8il93uKG4kf3CM8SaeEwj72ZpHfMOe9VHEqvTMX2/VQuFYk7yATNVyZddwIXopZkxjK9k7MFXXMJs+8sk1vNaTXBJNDwfZe+mlxq5O1Xrbg2f/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XacsC2qZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hi03yxP/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XacsC2qZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hi03yxP/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21BA01F45F;
	Fri, 12 Apr 2024 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712941049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PX1DmbgOZlf9DDLj1yJpAHB6e7Q3fI4j192HlSH95Q=;
	b=XacsC2qZFEmz3oSGvd/E4FuxyYvwYn0DM6uj0shvXk9ocVHXJdJWhnbIiqELpStYwyAyj+
	mQDd9qNHsctvXt87klbt56KrdJtIxie1MmQgSBwULnO8+D7aOHJs63DCc8MbVrp2uFMzwI
	bw3QFE2/qtTIo9go/pzpe6vixjk3HdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712941049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PX1DmbgOZlf9DDLj1yJpAHB6e7Q3fI4j192HlSH95Q=;
	b=hi03yxP/tauci0XRqwjUtncnnQ5y7HY32nNN7lCNokY26Bf2v8oEHY2tlGy+/UBHpH6GJz
	7oC18JyQlrfLygDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712941049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PX1DmbgOZlf9DDLj1yJpAHB6e7Q3fI4j192HlSH95Q=;
	b=XacsC2qZFEmz3oSGvd/E4FuxyYvwYn0DM6uj0shvXk9ocVHXJdJWhnbIiqELpStYwyAyj+
	mQDd9qNHsctvXt87klbt56KrdJtIxie1MmQgSBwULnO8+D7aOHJs63DCc8MbVrp2uFMzwI
	bw3QFE2/qtTIo9go/pzpe6vixjk3HdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712941049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0PX1DmbgOZlf9DDLj1yJpAHB6e7Q3fI4j192HlSH95Q=;
	b=hi03yxP/tauci0XRqwjUtncnnQ5y7HY32nNN7lCNokY26Bf2v8oEHY2tlGy+/UBHpH6GJz
	7oC18JyQlrfLygDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 168E81368B;
	Fri, 12 Apr 2024 16:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWFaBflnGWY0IgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 12 Apr 2024 16:57:29 +0000
Date: Fri, 12 Apr 2024 18:50:02 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: some speedup for NOCOW write path and cleanups
Message-ID: <20240412165002.GQ3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712933003.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712933003.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.97
X-Spam-Level: 
X-Spamd-Result: default: False [-3.97 / 50.00];
	BAYES_HAM(-2.97)[99.86%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.com:email]

On Fri, Apr 12, 2024 at 04:03:14PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These are some cleanups in the NOCOW write path and making the check for
> the existence of checksums in a range more efficient. More details in the
> changelogs.
> 
> Filipe Manana (6):
>   btrfs: add function comment to btrfs_lookup_csums_list()
>   btrfs: remove search_commit parameter from btrfs_lookup_csums_list()
>   btrfs: remove use of a temporary list at btrfs_lookup_csums_list()
>   btrfs: simplify error path for btrfs_lookup_csums_list()
>   btrfs: make NOCOW checks for existence of checksums in a range more efficient
>   btrfs: open code csum_exist_in_range()

Reviewed-by: David Sterba <dsterba@suse.com>

