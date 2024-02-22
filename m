Return-Path: <linux-btrfs+bounces-2631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E779585F606
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF4CB24137
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A141238;
	Thu, 22 Feb 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I5bYnMGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IgHcF+9s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I5bYnMGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IgHcF+9s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8C40C0C
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598866; cv=none; b=c/ehmkUFnVRaLVJKSIydcfPEYSLMLSETykMUy9I/NhTLWFAT63PaQqGyHol+G9OXRb3QXuVyNDwiSBM8KxPwpDyuJpXjmXSQriZSGB9WP5r39TZgSP6qs7m7wJ4T2AzCRfHe5Y5H8RRUHcoCdBBT8FHtdXGb/Qe6VYnqSn1sYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598866; c=relaxed/simple;
	bh=T8YIm2TE3ObZQYJIX06Qh6tD8kNcunAAJjNwbFUwf+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufNxRQlNwKW7jm9JA95oJRetdWIDWaNzaU+aFWN7hv/19/gBZs9VUBBTmuIBroLYU7iygq3zwWol+bygDCYdygH1xdiBO7LzTAO90Fdx3/XRjbemmlJMXFAw6i+WZkPSegSKTZr3TOmkHUhk8Ep1sAD/+TwBqymZLyEqk9KGlok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I5bYnMGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IgHcF+9s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I5bYnMGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IgHcF+9s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F90E21F5C;
	Thu, 22 Feb 2024 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708598863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzyBmVpSOMwlXrPBtEWm1RJPYWPL8EZmMpS9M43vkAQ=;
	b=I5bYnMGugHVtmF0C1iA1QmJXD8Zha0/YObLEdg9xshvHTlvshvyx4Gm27o/4L/wt6p0XJA
	xGglTyOhBHJrOvu7Dl+B22tYOpiRYOTnUcdZG/tgKzXUpNPY04/VS6Bqmi02LOlRKBT4Ho
	gQvSjLGD2wiPTUtLzIyTgAn8OSOXqGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708598863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzyBmVpSOMwlXrPBtEWm1RJPYWPL8EZmMpS9M43vkAQ=;
	b=IgHcF+9sHnhavE2QH8248HTkUGxPJvb7xBGRvKzzoQXyYl1Z3B/InylA48ojy6C/Kng0Rx
	0BmisrpowULgSgCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708598863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzyBmVpSOMwlXrPBtEWm1RJPYWPL8EZmMpS9M43vkAQ=;
	b=I5bYnMGugHVtmF0C1iA1QmJXD8Zha0/YObLEdg9xshvHTlvshvyx4Gm27o/4L/wt6p0XJA
	xGglTyOhBHJrOvu7Dl+B22tYOpiRYOTnUcdZG/tgKzXUpNPY04/VS6Bqmi02LOlRKBT4Ho
	gQvSjLGD2wiPTUtLzIyTgAn8OSOXqGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708598863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzyBmVpSOMwlXrPBtEWm1RJPYWPL8EZmMpS9M43vkAQ=;
	b=IgHcF+9sHnhavE2QH8248HTkUGxPJvb7xBGRvKzzoQXyYl1Z3B/InylA48ojy6C/Kng0Rx
	0BmisrpowULgSgCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0162113419;
	Thu, 22 Feb 2024 10:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0W0qAE8m12XNMgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 22 Feb 2024 10:47:43 +0000
Date: Thu, 22 Feb 2024 11:46:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: compression: remove dead comments on
 btrfs_compress_heuristic()
Message-ID: <20240222104656.GM355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6ddea79ce1701adca117880a492a3e08282e318c.1708572619.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ddea79ce1701adca117880a492a3e08282e318c.1708572619.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.16
X-Spamd-Result: default: False [-5.16 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.16)[69.53%]
X-Spam-Flag: NO

On Thu, Feb 22, 2024 at 02:00:25PM +1030, Qu Wenruo wrote:
> Since commit a440d48c7f93 ("Btrfs: heuristic: implement sampling
> logic"), btrfs_compress_heuristic() is no longer a simple "return true",
> but more complex system to determine if we should compress.
> 
> Thus the comment is dead and can be confusing, just remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Reviewed-by: David Sterba <dsterba@suse.com>

> ---
> Furthermore, the current btrfs_compress_heuristic() looks a little too
> conservative, resulting a pretty low compression ratio for some common
> workload, and driving end users to go "compress-force" options.

We'd need the samples of data where the heuristic is too pessimistic but
the compression would work.

