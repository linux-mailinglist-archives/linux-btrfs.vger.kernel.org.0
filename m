Return-Path: <linux-btrfs+bounces-8827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4102C999438
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 23:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A59CB225E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4881E47BB;
	Thu, 10 Oct 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UYojw4t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3JjpXWV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UYojw4t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3JjpXWV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC71E47B2;
	Thu, 10 Oct 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594074; cv=none; b=EUsYh1OdSvrLTvVtvsqHlIGkpoaAwEyHoY0htwnrpYMkPWqzQj0pJoh2oCYSj0AJbsHQOTC+p3U5hA8LRrC0/KY6bwIzaDoxuBrlfI5WrbYiaM33Xw7rY83YgqgUUYUzpQJMb3rwRnnP9i8Wow0tJP97WZNkRygryAS+q+8PlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594074; c=relaxed/simple;
	bh=uZQMggaIxy8CCnDm5xdWoPaUigRQhT/5wH01RD5xGFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQxz+Q5LFdAyh018sqQk203knoWClcsplWlaS+kiUgTJ7L+KcxEgc55VJu7St7vTa7BoQf+75JYutOxRgUXAi2VseguL7m3S7htg0/ugHe1BvPd8+BHxqcA9dJeJ6mydWFwGBs1prmgbr/7tlibXVFVu19i+cjpDaapoX/r/ZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UYojw4t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3JjpXWV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UYojw4t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3JjpXWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F3A31FE32;
	Thu, 10 Oct 2024 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728594070;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Z4FGYfr4d2bPEU1XlM517eMKG6WFV8nzzl6AI/lvoQ=;
	b=0UYojw4tppuc02A5CPbA1p/HFgkUxbdbCzMwaSXA6CTKA1oWOBZJrFJJ7I3BIi+VjvGeuO
	QWkPp5HZF+APOSNfUTfzKvI/lkTfPdlzuXCfKBDXYYxlcTd201XV9vIeY9WIENBnAT3DBM
	wr+LaXnik9zUS7+LtSiedi+O0GU+TUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728594070;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Z4FGYfr4d2bPEU1XlM517eMKG6WFV8nzzl6AI/lvoQ=;
	b=z3JjpXWV8caeTQy0xJangrDXtGItAHIjhIx1t2KxzGrEOikYvprn5+lksBmAAhWA/l8HFC
	smKtc7xcvwfPKLDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0UYojw4t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z3JjpXWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728594070;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Z4FGYfr4d2bPEU1XlM517eMKG6WFV8nzzl6AI/lvoQ=;
	b=0UYojw4tppuc02A5CPbA1p/HFgkUxbdbCzMwaSXA6CTKA1oWOBZJrFJJ7I3BIi+VjvGeuO
	QWkPp5HZF+APOSNfUTfzKvI/lkTfPdlzuXCfKBDXYYxlcTd201XV9vIeY9WIENBnAT3DBM
	wr+LaXnik9zUS7+LtSiedi+O0GU+TUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728594070;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Z4FGYfr4d2bPEU1XlM517eMKG6WFV8nzzl6AI/lvoQ=;
	b=z3JjpXWV8caeTQy0xJangrDXtGItAHIjhIx1t2KxzGrEOikYvprn5+lksBmAAhWA/l8HFC
	smKtc7xcvwfPKLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70F741370C;
	Thu, 10 Oct 2024 21:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XIOwGpZACGc0XAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 21:01:10 +0000
Date: Thu, 10 Oct 2024 23:01:04 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: update some tests to be able to run with
 btrfs-progs v6.11
Message-ID: <20241010210104.GV1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
 <e75725e3d3c50922892ca07cd2b0965340c228be.1728300476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75725e3d3c50922892ca07cd2b0965340c228be.1728300476.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9F3A31FE32
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 07, 2024 at 12:32:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs-progs v6.11 the output of the "filesystem show" command changed
> so that it no longers prints blank lines. This happened with commit
> 4331bfb011bd ("btrfs-progs: fi show: remove stray newline in filesystem
> show").
> 
> We have some tests that expect the blank lines in their golden output,
> and therefore they fail with btrfs-progs v6.11.
> 
> So update the filter _filter_btrfs_filesystem_show to remove blank lines
> and change the golden output of the tests to not expect the blank lines,
> making the tests work with btrfs-progs v6.11 and older versions.
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>

