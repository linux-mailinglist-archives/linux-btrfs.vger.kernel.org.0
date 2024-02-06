Return-Path: <linux-btrfs+bounces-2156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989584B592
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D72328A0C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF112F5B4;
	Tue,  6 Feb 2024 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="weoZG96t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="293JW4ZB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="weoZG96t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="293JW4ZB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8085677B
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223906; cv=none; b=sHMathitji/DVUEclRxY2lysCZ/TKznZsTHK7bxpVQ88RDYM0K/WvSwB3Y3k1Myq2C0ZDqlqDWdH2Kfp3V2nuZHsWkQR1a8rzDXKz/uGe6KCV2JJFLMRvePMrIuUay/7w5CcJTgC8aWkOPs0zCJ4KkSxOib/pNWeSFPL84TtXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223906; c=relaxed/simple;
	bh=F6VynuzvU0+n9R4B7NjiSXqwyQHHSDrY6/S+wJKDEHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/F7n8eRsjA4WUYHoS3xt0UjF0E9t0qJ/cvy0gWUhKRqC4Q2gEHzKoQnQqjyrPYLhHhOQoykgy8jBmFS3rO4v9rYc9MnnxhQ5PHOFB3atOauiWUlW6lYQ9meb0LR2rODooq/LypVeidOKVFWNX6zuJEriL8dPi3iwdAKEe6ci4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=weoZG96t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=293JW4ZB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=weoZG96t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=293JW4ZB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AD8821F0D;
	Tue,  6 Feb 2024 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707223903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T6s55vGjLi1+fyhJbPitg4LFSAdhGbe9gna8TdUUJs=;
	b=weoZG96tTCaijhVvuXLP6TEsrIrS7GiXpTBoty0eaXcb915wqsFIcybecwitUUDzeJGVPe
	/A1Ky2jI/BU1GCHQTG1GoUMyTrri0K0pamyDamPfBIdZz/H67ihOL15jq0rJJKkPhY3qyP
	f03e1eWQKebfqVqAsRUi2ih0m60X4gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707223903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T6s55vGjLi1+fyhJbPitg4LFSAdhGbe9gna8TdUUJs=;
	b=293JW4ZBJyusxStxBU/vitENSD6HlAvv0CUMvW/sRvfO+Y1EdbJpm5beSUoQ9rUgGGtMwF
	y0oigTcp5XUP7lDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707223903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T6s55vGjLi1+fyhJbPitg4LFSAdhGbe9gna8TdUUJs=;
	b=weoZG96tTCaijhVvuXLP6TEsrIrS7GiXpTBoty0eaXcb915wqsFIcybecwitUUDzeJGVPe
	/A1Ky2jI/BU1GCHQTG1GoUMyTrri0K0pamyDamPfBIdZz/H67ihOL15jq0rJJKkPhY3qyP
	f03e1eWQKebfqVqAsRUi2ih0m60X4gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707223903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8T6s55vGjLi1+fyhJbPitg4LFSAdhGbe9gna8TdUUJs=;
	b=293JW4ZBJyusxStxBU/vitENSD6HlAvv0CUMvW/sRvfO+Y1EdbJpm5beSUoQ9rUgGGtMwF
	y0oigTcp5XUP7lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D7DA139D8;
	Tue,  6 Feb 2024 12:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OpGLGl8rwmU6MgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 12:51:43 +0000
Date: Tue, 6 Feb 2024 13:51:14 +0100
From: David Sterba <dsterba@suse.cz>
To: tavianator@tavianator.com
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Message-ID: <20240206125114.GN355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
 <20240206033807.15498-1-tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206033807.15498-1-tavianator@tavianator.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.21)[71.53%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.01

On Mon, Feb 05, 2024 at 10:38:07PM -0500, tavianator@tavianator.com wrote:
> On Sat, 27 Jan 2024 10:18:36 +1030, Qu Wenruo wrote:

> Here's my reproducer if you want to try it yourself.  It uses bfs, a
> find(1) clone I wrote with multi-threading and io_uring support.  I'm

Do you use other fancy tech like io_uring? This itself can be a
significant factor, other than config, host etc.

