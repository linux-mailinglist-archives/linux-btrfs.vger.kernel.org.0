Return-Path: <linux-btrfs+bounces-10741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3FA0268B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5887A158F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892351DB95E;
	Mon,  6 Jan 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="njIreYOY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="57l8lrPj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3CqY8jV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="InA/eMhD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4B482EB
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170024; cv=none; b=TGMawmVCENDaTCQEN3GrBjgwOXP1B1NCENftfaLrUPVtqnWIbyhQPqBfjvDwixROnaz7/vcfysNfA6WDsHFY/bQn1jjntlDkwZ8P2C2/47raTXPbtv8D+zMavXRPPrmRVI56U4KQePv51lMOYUdVSxKYAc3T/TT6xAg4Ha/mcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170024; c=relaxed/simple;
	bh=Ai8QxqbxqcmA/2aJwFbWbpZVw8cKao4F71tb6RrD9no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImzPPALNsRlp8iY5Jyo8l3Tue41K8tPZcagY4T/x5FpRMFpJ+fLxB2/BA6yLompZeD5ZYXT5NCY4H41n/3HYvCY1yNKkcTQvNShZWmJ03i4htv6D2542djCCD+nfl3oV++90ExaBORpY2ttZbmIdWAXiE4+uFCgNG5GxeZCoNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=njIreYOY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=57l8lrPj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3CqY8jV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=InA/eMhD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2D421161;
	Mon,  6 Jan 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736170021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1FeCIBoMkfQKqROtW+yXy+t2zg29kX2inqzNbpteRA=;
	b=njIreYOYtMRRexina12MlWHkguPnCZp3X+f9GtS9NzKYWfbI4WHg39+Lhd7JWG7OEUbcrA
	jmS52a/THoufiBHrwnkpRcp9GQcI2o/50MHdYC/0mJdrkRx6i907TBGdQQpNJwMGEZNVsi
	pArTEH8Wa/jpt7Ku6sMeyYbx/E1SAHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736170021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1FeCIBoMkfQKqROtW+yXy+t2zg29kX2inqzNbpteRA=;
	b=57l8lrPjhYCSiYlYq/l20QGkUTTaJ3FTVWTuiQE61i1sLM1JPF5TS5sN0UyS7i/JYOkwCQ
	gXBpfgl4+fsytJAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736170020;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1FeCIBoMkfQKqROtW+yXy+t2zg29kX2inqzNbpteRA=;
	b=d3CqY8jV3+9glaA8KFgkvUrmak8T6eVskjbuMERgLnkkCxVT1l4vbaPLxST89uXtyN0667
	L15Gu+Gz1UvWM6TUrI9s78uVNJWiNy/nZZOuOpRHUxJbkbhNREtgv77mMGrFpeMz5r6c3L
	xq43kYYNw+nbARUpwrfOU9DTyLelC/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736170020;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1FeCIBoMkfQKqROtW+yXy+t2zg29kX2inqzNbpteRA=;
	b=InA/eMhDuni5/LAvQFSbFmF1nc5gVAOMY/AGTXzoeQc2H8MPTMn46OmreGBuTUkpdR10OR
	DFvkFZ4bKo56V+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0004F139AB;
	Mon,  6 Jan 2025 13:26:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C941OyPae2cAKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 13:26:59 +0000
Date: Mon, 6 Jan 2025 14:26:58 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: uncollapse transaction aborts during renames
Message-ID: <20250106132658.GV31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <056d1f47ac66212fc97565d873f29213fb86d13f.1736165787.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056d1f47ac66212fc97565d873f29213fb86d13f.1736165787.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Jan 06, 2025 at 12:28:59PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During renames we are grouping transaction aborts that can be due to a
> failure of one of several function calls. While this makes the code less
> verbose, it makes it harder to debug as we end up not knowing from which
> function call we got an error.
> 
> So change this to trigger a transaction abort after each function call
> failure, so that when we get a transaction abort message we know exactly
> which function call failed, helping us to debug issues.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

