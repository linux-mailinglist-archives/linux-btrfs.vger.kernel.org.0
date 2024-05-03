Return-Path: <linux-btrfs+bounces-4730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667BF8BADD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213D9283A71
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A3153BDB;
	Fri,  3 May 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yCt4GkKz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x/6xGbw7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z8iWpYwY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N7trIzRw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E0153BCA
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743424; cv=none; b=SuQjqOKM9vcvaw1vXCQJg9Vvtc3gD2LUUnzetKybeGWwz6nu/qVMRRpksfTBYGAmJo3yVW80UGuWjmrAOiQNBykpL4Y4jLajevISNbKuPBMhkIOn1xRsrhq4i3JBkgKniWsDADpNKny3BFYcFyDobWOeHVs9SIhsQOo92r5q+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743424; c=relaxed/simple;
	bh=5toa31DryPBeda2ly3NxG72zdpYz8jsD71AgG4yiPWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKDqh87sOXhOVitB0zjIj55SmIfWMVEznBl6YrPJfDU45CpnTeVuMmGNwH53OL8bq1TIBtxI2vBlsJYJomTuO5FPViqlE8jHJxjIEeKFau3qqTIFkS5ftJdLqOY/T2bmsaqRtS+PjXx4RYOSDa9dFFwzrrbKJyxCvzZqVMhkEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yCt4GkKz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x/6xGbw7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z8iWpYwY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N7trIzRw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AC76204FD;
	Fri,  3 May 2024 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714743420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXVI4W1ouizWXzx1YeAhSEVUMnJ4hQHl3P6v/czKd4=;
	b=yCt4GkKzh+be3w7jZjEWGWOEltHtC/WPhymf9audrh8+1wOrNz8NkzLtwNb9ZVinljFWEC
	JBh8P8T8svFpFNP+hEbSP92GBLEkkUCo81OiQ4bCaJG6pcjovCbf5bw73Dx822JFjz2+yD
	nDpaek7yFnqUSTMUN+/m6/jRjLXQNvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714743420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXVI4W1ouizWXzx1YeAhSEVUMnJ4hQHl3P6v/czKd4=;
	b=x/6xGbw7T+1qM1QuoEPKCnFxdYoVc8GysDoDWdRKcpVhdEZ/Y4AzQgExI2MRCubKifZnRD
	yrx9eC3zFQ4ODMDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714743419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXVI4W1ouizWXzx1YeAhSEVUMnJ4hQHl3P6v/czKd4=;
	b=Z8iWpYwYVWg/lVGfjs6tJn/4Kq90WwbUXjZzQf2B/gARKWTW7EKkPliHC91svf+TqPd9Qt
	iS3HyEV/LwvCv/CVE8PAEM5rg4Ji+61eHiX9ohH7ORmdiTsC/chAuIOUb9HtIu0CEUKOrs
	KQ9WE72qYoEkyKA6rrtqigOkCHhiTHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714743419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXVI4W1ouizWXzx1YeAhSEVUMnJ4hQHl3P6v/czKd4=;
	b=N7trIzRwMIP3WJfhK6tmYCZ1d41kXOafAovptMij6nJl1VzjO+bQVoQW5cblPuW3d+9/00
	RIaX9JzoTHwNT6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4C2139CB;
	Fri,  3 May 2024 13:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kX5lFnvoNGaNBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 May 2024 13:36:59 +0000
Date: Fri, 3 May 2024 15:29:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: check: detect and repair ram_bytes
 mismatch for non-compressed data extents
Message-ID: <20240503132939.GA2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714640642.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714640642.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, May 02, 2024 at 06:37:52PM +0930, Qu Wenruo wrote:
> There are at least one kernel bug that makes on-disk
> btrfs_file_extent_item::ram_bytes incorrect for non-compressed non-hole
> data extents.
> 
> Thankfully kernel just doesn't care ram_bytes for non-compressed extents
> at all, so it doesn't lead to any data corruption or whatever, and this
> is really just a minor problem.
> 
> But for the sake of consistency and to follow the on-disk format, we
> should still detect and repair such problems.
> 
> This patchset would implement detection and repair for both lowmem and
> original mode, and a new hand crafted test case for it.
> 
> The reason why the test case is still handle crafted is, we do not have
> the btrfs-corrupt-block support for corrupting ram_bytes to a specific
> value yet.
> 
> I'd prefer to do the binary image migration to script in a dedicated
> patchset in the future.

The crafted binary images are ok for now, I've verified it by restoring,
did tree dump and check.

There's an issue tracking the other images audit,
https://github.com/kdave/btrfs-progs/issues/772, I did only a quick pass
but a tool that will do the restore/check and maybe some other steps
will be added to the repository.

Patches added to devel, thanks.

