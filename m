Return-Path: <linux-btrfs+bounces-1904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4B840B0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773321F24456
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C7155A48;
	Mon, 29 Jan 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ctw+/hEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dlrlq+Vt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ctw+/hEL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dlrlq+Vt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BA156972
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544819; cv=none; b=pc1yQHX/KcP/AycdfLmtZmBt/oaUDKGlsqdLgrOaSyINHpCvKUCK1j2tPJ9tpsRGO9XU5KykXOVjzmMaGN5gp6+5NSTXzI9VYJve3dg7rTZW4mQXBKBtzmCbGnonovc7Ypd1VI/NN0X7/R2w1CPeFV134HTydFqjWSeq0xkZXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544819; c=relaxed/simple;
	bh=xa9Mix0YK78DJQmzWxI6U5y+CcssK+y168Hag4uAawo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl/AUGolLPM7Fm6wVYjsfDLgXvYSa6WDDfcNehJJKjDqZby88D2mNyJB9IgMA8hh+KifmmqUYlA7RY1yYm96pOvfH62wXY3JEOaOoYxGr5OUo8w/iuTF4Qf2L24VGiy2F/s/xAMOgUhOgcsjXKc15mOg485c5rd+pkU0sAFWkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ctw+/hEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dlrlq+Vt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ctw+/hEL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dlrlq+Vt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 745611FCFA;
	Mon, 29 Jan 2024 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706544814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNvoLUFthC4Z+IbDIv3yrwnE603CbeG3JgZzeAm3PbE=;
	b=ctw+/hELGC8KldCeFH0GPK2K+0LlRsgiyimcOUFWXfgW5MlH+qYh9JrVKcxeZfnUjR5qVu
	SPuoo+n+dBsuLXjmcD8yc/UDjOXFxzsqdRTWH+kOBFJFvJF8XDGUHiTowidhuVMZ/cvK9s
	1SACbog3C9q7gACA6WvWS4wy6mzcMg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706544814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNvoLUFthC4Z+IbDIv3yrwnE603CbeG3JgZzeAm3PbE=;
	b=dlrlq+Vtfaml+e1VAq6oC/jxQMsxna8O7WQyo3Je9S1ThGkOmPz8iuoAdj4IeMlLVa+g9J
	rOU4xdXBz6kVPQAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706544814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNvoLUFthC4Z+IbDIv3yrwnE603CbeG3JgZzeAm3PbE=;
	b=ctw+/hELGC8KldCeFH0GPK2K+0LlRsgiyimcOUFWXfgW5MlH+qYh9JrVKcxeZfnUjR5qVu
	SPuoo+n+dBsuLXjmcD8yc/UDjOXFxzsqdRTWH+kOBFJFvJF8XDGUHiTowidhuVMZ/cvK9s
	1SACbog3C9q7gACA6WvWS4wy6mzcMg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706544814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNvoLUFthC4Z+IbDIv3yrwnE603CbeG3JgZzeAm3PbE=;
	b=dlrlq+Vtfaml+e1VAq6oC/jxQMsxna8O7WQyo3Je9S1ThGkOmPz8iuoAdj4IeMlLVa+g9J
	rOU4xdXBz6kVPQAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5981B132FA;
	Mon, 29 Jan 2024 16:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JYGsFa7Ot2WLJQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jan 2024 16:13:34 +0000
Date: Mon, 29 Jan 2024 17:13:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/20] Error handling fixes
Message-ID: <20240129161309.GA31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <76160d68-d3bd-409f-88d9-7723a1e4e9d8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76160d68-d3bd-409f-88d9-7723a1e4e9d8@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ctw+/hEL";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dlrlq+Vt
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 745611FCFA
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Fri, Jan 26, 2024 at 08:28:12PM +0800, Anand Jain wrote:
> On 1/25/24 05:17, David Sterba wrote:
> > Get rid of some easy BUG_ONs, there are a few groups fixing the same
> > pattern. At the end there are three patches that move transaction abort
> > to the right place. I have tested it on my setups only, not the CI, but
> > given the type of fix we'd never hit any of them without special
> > instrumentation.
> > 
> 
> What is our guideline for the error message location in the function
> stack, leaf function or at the root function? IMO, it should be
> in the leaf functions(), so that in the event of a serious error,
> we have substantial logs to pinpoint the issue. Here, despite -EUCLEAN
> we have no errors logged, in some of the patches. Why not also add
> error message where it wont' endup with abort(). Otherwise, debugging
> becomes too difficult when looking at the errors due to corruption.


I'll try to sum up suggestions from the whole thread, the proposed end
result of the error handling should follow this:

- critical errors should be followed by a message at the place where
  they happen, typically next to an EUCLEAN
  - an exception could be something that is called frequently and the
    messages would flood the logs

- transaction abort should be at the place where an error is detected,
  assuming that it's clear from the context that it's unrecoverable and
  no rollback is possible (ie. free structures, undo changes and only
  return an error)
  - this also needs inspection for special cases and exceptions

- tree-checker verifies data at the time of reading from disk, we can
  make some assumptions about structure consistency

- error handling should cover all possible returned values, as an
  example search slot can return < 0, 0 or 1, although some of them
  might not be possible on a consistent filesystem, all should be
  handled and return EUCLEAN + message for the "impossible" ones

There are already examples that can be followed and copied elsewhere,
however we still lack some helpers for the EUCLEAN and messages
pattern.

