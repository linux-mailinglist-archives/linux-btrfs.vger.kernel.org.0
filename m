Return-Path: <linux-btrfs+bounces-10749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653AEA028D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 16:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF51885251
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808EA145A03;
	Mon,  6 Jan 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ge7Y7qjT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9I1mHhvH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWPzN/qU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ot2ssBNM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124969D2B
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176367; cv=none; b=ClBMofCJDYf8+EsMpfP8oWavMmq4PSbMfUlgYJYGW1FGdhVA6+FWokawT2x6UTVRXZtHw7Dbh72S3RZmKgIT77cqcfNaUJSUPLjjz4vBTG0P1jgKgzswUP/e6MUkhLrd9N8emLqKQsvUKKkjZuIVUCnFbZyaIil2L7P8bTIdu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176367; c=relaxed/simple;
	bh=0hclbxMISCpdZ5JSEfpLy2tnbiq77BxjQs2x1yRZ6Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scmhOYif/XJUYrCw2pGrTOFAPnFXbQfoyk5mfhP6+kEd/36unRUJc5geeQlU38qRUMBJZQwlMMBz3y+TdTYce6g3WwfRfoLgy3uLrETuOv748NGUYQ6s/GdcLi6xKZZEN4yzADPCaycdLnl97pLUCGoUj336Mqqkkrk7DouoODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ge7Y7qjT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9I1mHhvH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWPzN/qU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ot2ssBNM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB6F91F392;
	Mon,  6 Jan 2025 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736176364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgSDpBmkK5/gC1QXx1jnB0YfG56xk8IiVnlHSQFhI14=;
	b=Ge7Y7qjTLXlFTXxuMG4oBj7GHnmgXp++MNw3BrH2OV2EiNjbejltcqusrGYjqXyxsaiZE2
	AyEY/+eM8v2SxTGC+qgGDrquOprIBPIvym/adIPbIdQCLgON0L8bQy807SZHEniRCDzFZd
	eoO8FpXljCcXBQSVuSUVaimprA13HWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736176364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgSDpBmkK5/gC1QXx1jnB0YfG56xk8IiVnlHSQFhI14=;
	b=9I1mHhvH+NICXzUeo+KjmIU1iS66cHSjOwiwySfO9iYeqOjxo25lAG9cXjh//duvKUwwzs
	nc1lriThjV6DbfCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736176363;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgSDpBmkK5/gC1QXx1jnB0YfG56xk8IiVnlHSQFhI14=;
	b=MWPzN/qUHmz121MUsH1QnV0taTl678v16aYApUmUhPO+WWG17mLPUkFLkirFEAvKgdaOt7
	REXHQRg5kMIuJtPzNpQVYpWxRyPaRjkfhQPDL3nEpAz61m/UDLaspp+ggKl1ZDAaSiiJKA
	NfYnYgJ23FHSQqpCOZVXNQO6Q7dKgdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736176363;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgSDpBmkK5/gC1QXx1jnB0YfG56xk8IiVnlHSQFhI14=;
	b=Ot2ssBNMnDhGOs0InBW2Caq++ihh91y8M6K1/gGbDgxXGDEpxpG2sriBdsGEtvPX3DHd7a
	ixh5IZ8T27H0BSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBFC4139AB;
	Mon,  6 Jan 2025 15:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AQpkLevye2c3RgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 15:12:43 +0000
Date: Mon, 6 Jan 2025 16:12:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: calculate max_extent_size properly on
 non-zoned setup
Message-ID: <20250106151238.GA31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241213064343.1498094-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213064343.1498094-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Dec 13, 2024 at 07:43:43AM +0100, Christoph Hellwig wrote:
> Since commit 559218d43ec9 ("block: pre-calculate max_zone_append_sectors"),
> queue_limits's max_zone_append_sectors is default to be 0 and it is only
> updated when there is a zoned device. So, we have
> lim->max_zone_append_sectors = 0 when there is no zoned device in the
> filesystem.
> 
> That leads to fs_info->max_zone_append_size and thus
> fs_info->max_extent_size to be 0, which is wrong and can for example
> lead to a divide by zero in count_max_extents().
> 
> Fix this by only capping fs_info->max_extent_size to
> fs_info->max_zone_append_size when it is non-zero.
> 
> Based on a patch from Naohiro Aota <naohiro.aota@wdc.com>, from which
> much of this commit message is stolen as well.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
> Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to for-next, thanks.

