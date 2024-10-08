Return-Path: <linux-btrfs+bounces-8652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90778995591
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D6FB27ED8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C041FA262;
	Tue,  8 Oct 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0e1d1VjU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZI/fXF2e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0e1d1VjU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZI/fXF2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE621E0DEB
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408222; cv=none; b=ucxfT/uNRaZbYq9ji9sL2yI51GPId1sIDjoyUdK0YJl0s+xaUNbxoAPcN6rgDoZDt9Puv5JqNY6/nAZICqwm9O/AXCwkLc2qpgjqd98l/LsQT+wXj06OY/BRARMhS40H1ItlrQ/0Bnj/G6YWwhk+xzQECS0bvlY0XEoHCIqcDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408222; c=relaxed/simple;
	bh=jmMpT2PTsQob2lTYFPQEe9aIvcNHsQQmd7LTPzzXy40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCKcr5j56NKi/V3e2VnXngrj53vZnjn2TT3BiRktfnnLP/BO87QIErf2Wmdz7gTrVPM/bTc6W2xN4K7eH7uWisHE1pgsiEW/Rn8YYoqdZQYNzkEA9EKbM5ELwC8Pl5CTX3aSBKIYLn77ExKPmsn40ymR5/oaso2uRXEe2ECkJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0e1d1VjU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZI/fXF2e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0e1d1VjU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZI/fXF2e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C1F521CF4;
	Tue,  8 Oct 2024 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728408219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFqkGyOW2kSTvC7Wk0zvaq92P4oLWyoN7Moorr2Q+SI=;
	b=0e1d1VjUeJwdNfwm6pgGIe86E4X4GzBALUzKmXS4P6fRExxWnCLAQliSICbk9E1Zuxpa+Y
	Z6m6u51ba8ZtG/tVABthy1yUBDR4H1R2a1fKwJK5ZSj7ZKp9mPuR+ZkoVgIAlksSNb+l8H
	zbWMAwEIIovadMceULogUp/b0PjTGlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728408219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFqkGyOW2kSTvC7Wk0zvaq92P4oLWyoN7Moorr2Q+SI=;
	b=ZI/fXF2et58eLxOnnraZW2C/PNG0hBDEdBhglrl0iKx8Eo9vRyPOTdPv+AdsKfuxEzEBOi
	O//0hntSfXonv0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728408219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFqkGyOW2kSTvC7Wk0zvaq92P4oLWyoN7Moorr2Q+SI=;
	b=0e1d1VjUeJwdNfwm6pgGIe86E4X4GzBALUzKmXS4P6fRExxWnCLAQliSICbk9E1Zuxpa+Y
	Z6m6u51ba8ZtG/tVABthy1yUBDR4H1R2a1fKwJK5ZSj7ZKp9mPuR+ZkoVgIAlksSNb+l8H
	zbWMAwEIIovadMceULogUp/b0PjTGlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728408219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFqkGyOW2kSTvC7Wk0zvaq92P4oLWyoN7Moorr2Q+SI=;
	b=ZI/fXF2et58eLxOnnraZW2C/PNG0hBDEdBhglrl0iKx8Eo9vRyPOTdPv+AdsKfuxEzEBOi
	O//0hntSfXonv0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E020B137CF;
	Tue,  8 Oct 2024 17:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGzWNZpqBWdrWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 17:23:38 +0000
Date: Tue, 8 Oct 2024 19:23:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: fix the sleep inside RCU lock bug of
 is_same_device()
Message-ID: <20241008172337.GG1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acb0e85c483ea5ee6d761583fcaa6efa3e92f01.1728037316.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Oct 04, 2024 at 07:52:00PM +0930, Qu Wenruo wrote:
> Previous fix of the RCU lock is causing another bug, that kern_path()
> can sleep and cause the sleep inside RCU bug.
> 
> This time fix the bug by pre-allocating a string buffer, and copy the
> rcu string into that buffer to solve the problem.
> 
> Unfortunately this means every time a device scan will trigger a page
> allocation and free.

I don't think this is a big issue, the memory is allocated for a very
short period of time. A sequence of device scan requests can even be
handed the same page from allocator (assuming that it's a device scan
that does not need to add new devices).

