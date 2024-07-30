Return-Path: <linux-btrfs+bounces-6875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC0A941374
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3855B28904
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870081A01CB;
	Tue, 30 Jul 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="icpX4SLO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r2cTC7uF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="icpX4SLO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r2cTC7uF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493B190041
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347109; cv=none; b=cyYkMfUp9MixBRMgqHmO2XjZ0X5uE4SG1IVclIVfrzMr0fbpvYc+GGqNUgeeTLTQ0eIQjUnBtHhtYB9VMCtjxybugyhFM2c+7ajgY2mH31OdONbypXPzmTqGGHUwCam0VsB5igS6k5N3km7M63mrelBFnTDZg1r+xbrElTYycVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347109; c=relaxed/simple;
	bh=4lEGQ9DQWDkwr+OibQ97nWkzyf1lH1EIY4oeAstpeYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ijv6ndV7/2X0Vn8Npl3v//fwLrMTdbLiGdEHderpjiQeGdt4jjq4UDUa7+0iqHEqhQYRaTUn04mZNndHwjAFaBJqI/CMqYt4bp4WrE7wZsaakFuj3AcTQlFZEgxB5JT8jGjhxaZYZWrquNXbagSPFTdTuol7DiHyiObQ4vLTcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=icpX4SLO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r2cTC7uF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=icpX4SLO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r2cTC7uF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548B11F7EB;
	Tue, 30 Jul 2024 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347106;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sje9mgwZw/Gs0mHTQKJ4YXAF3sCNdX9Gah2vipqrTtM=;
	b=icpX4SLO0M6NAgcwrkImCq/eJATHG4zLzq2YLhZV40cYYbLK3MivY1BcARhWrBSKeaIfwH
	1BEtWLs/7sHkT3tyy3kpaqdiNXL+A66tEVZJpsp3PzHKIj+XGQyKH3PYhgkQEiMv2TyAAt
	7Jo23bqMuNhNe1x69vvvFiXrRaa7rhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347106;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sje9mgwZw/Gs0mHTQKJ4YXAF3sCNdX9Gah2vipqrTtM=;
	b=r2cTC7uFP4LVtG7xApdKOaWj10X1CBFJo4IuRm99J3RHTKJgj2uXUNXki+MEKz/t6DibYY
	q1VNMV8PHYmdWFAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347106;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sje9mgwZw/Gs0mHTQKJ4YXAF3sCNdX9Gah2vipqrTtM=;
	b=icpX4SLO0M6NAgcwrkImCq/eJATHG4zLzq2YLhZV40cYYbLK3MivY1BcARhWrBSKeaIfwH
	1BEtWLs/7sHkT3tyy3kpaqdiNXL+A66tEVZJpsp3PzHKIj+XGQyKH3PYhgkQEiMv2TyAAt
	7Jo23bqMuNhNe1x69vvvFiXrRaa7rhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347106;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sje9mgwZw/Gs0mHTQKJ4YXAF3sCNdX9Gah2vipqrTtM=;
	b=r2cTC7uFP4LVtG7xApdKOaWj10X1CBFJo4IuRm99J3RHTKJgj2uXUNXki+MEKz/t6DibYY
	q1VNMV8PHYmdWFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3941813983;
	Tue, 30 Jul 2024 13:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k77DDWLuqGanXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 13:45:06 +0000
Date: Tue, 30 Jul 2024 15:45:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: fixes for buffered write qgroup rsv leaks
Message-ID: <20240730134504.GA17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1721775142.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721775142.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Tue, Jul 23, 2024 at 03:55:55PM -0700, Boris Burkov wrote:
> generic/475 exposes qgroup rsv leaks under EIO errors. These are fixes
> for two classes of buffered write errors we are still hitting:
> 1. dirty pages leaked during an aborted transaction
> 2. dirty pages getting un-dirtied and leaked by cow_file_range when it
>    doesn't make an ordered extent for a range.
> 
> After these two fixes, I was able to run generic/475 with squota enabled
> at mkfs 100 times in a row without an error, and a modified generic/475
> that always sleeps for 0 seconds 500 times.
> 
> Boris Burkov (2):
>   btrfs: implement launder_folio for clearing dirty page rsv
>   btrfs: fix qgroup rsv leaks in cow_file_range

Thanks for the fixes. Please don't use abbreviations in subjects for
things like reserve ot block group if possible (e.g. only to avoid
overly long lines). I've fixed it in for-next.

