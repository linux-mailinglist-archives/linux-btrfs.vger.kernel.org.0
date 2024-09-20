Return-Path: <linux-btrfs+bounces-8145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06997D6D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 16:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6731C22C4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4917C222;
	Fri, 20 Sep 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jlZdyQif";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NiqlARk3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jlZdyQif";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NiqlARk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F817838C
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842366; cv=none; b=QK6kYeqIteRKR+kjcf6t+LFO9MMFmkQo3LqBwgCcNgRRpDrLiI94w63GmQXZbE5O3tlqv/Wghhk0Hpvay2Ph07if9SvmXLo5K7KFo3M2YLa0/8EBEEHjrwlKdejzeF8LxMz5adHcECCYQAxATBzxyjo7Qb/P/r0K9sQoJiNhzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842366; c=relaxed/simple;
	bh=jIBGet4X8ZWYEUpiuKEg5emKRaqOQa5m5pJXxXzJ99s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al3h3KXCMSYcxEezoYK3Igu95lZLOcVDicJ9BV6sAXkHDPSEO5/zb89U2Jx7cuX+m98kqgbcvtQ3ExXmE65fkJz7Xyvk9Te/A+ngZq77tJXYEqy5hCAHnnKlkXEo3/LyEDz5VzkVAWZyMvMi5axxmHX1hJnUB1XIOuPK2xt8Jkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jlZdyQif; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NiqlARk3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jlZdyQif; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NiqlARk3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B86EA33A2D;
	Fri, 20 Sep 2024 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726842362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HydvNCfFxI+3JthgjlMugstRS4KCGK5tPFwuTBfHls8=;
	b=jlZdyQify03uk1anu/4p8FifBTdG5O/+/YFzDTNO3Gt8gMIBGpgcxs/4qNs2lVZYRcIDOR
	sGWTWtr0N52xZwGZuuxMxTjM7OBjMCgZuWuOBSeixcwwdCtC9wCQN4dNRB72nhWN99bOs6
	70rQOUH7vga4wNYPDRvNGnG495lWoN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726842362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HydvNCfFxI+3JthgjlMugstRS4KCGK5tPFwuTBfHls8=;
	b=NiqlARk38Bk1CFF+2zW8EA/jjiJKF3GmI+D9nvYqmNB/mG3hfrAhfg1L9apoxLCoCeZG+8
	O68Y1hzEm/5KvoCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726842362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HydvNCfFxI+3JthgjlMugstRS4KCGK5tPFwuTBfHls8=;
	b=jlZdyQify03uk1anu/4p8FifBTdG5O/+/YFzDTNO3Gt8gMIBGpgcxs/4qNs2lVZYRcIDOR
	sGWTWtr0N52xZwGZuuxMxTjM7OBjMCgZuWuOBSeixcwwdCtC9wCQN4dNRB72nhWN99bOs6
	70rQOUH7vga4wNYPDRvNGnG495lWoN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726842362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HydvNCfFxI+3JthgjlMugstRS4KCGK5tPFwuTBfHls8=;
	b=NiqlARk38Bk1CFF+2zW8EA/jjiJKF3GmI+D9nvYqmNB/mG3hfrAhfg1L9apoxLCoCeZG+8
	O68Y1hzEm/5KvoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A72D913AA7;
	Fri, 20 Sep 2024 14:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3yHKPqF7WZkTAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Sep 2024 14:26:02 +0000
Date: Fri, 20 Sep 2024 16:25:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: libbtrfsutil: use package_data member for
 header files
Message-ID: <20240920142557.GC13599@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b46c1f567043f90aeda59a65dc3f826914e85f51.1726792949.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b46c1f567043f90aeda59a65dc3f826914e85f51.1726792949.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Sep 20, 2024 at 10:12:32AM +0930, Qu Wenruo wrote:
> [BUG]
> Currently with python3.12, the python bindding will always result the
> following warning:
> 
>     [PY]     libbtrfsutil
> /usr/lib/python3.12/site-packages/setuptools/_distutils/extension.py:134: UserWarning: Unknown Extension options: 'headers'
>   warnings.warn(msg)
> 
> [CAUSE]
> In the setup.py which specifies the files to be included into the
> package, we use setuptools::Extension to specify the file lists and
> include paths.
> 
> But there is no handling of Extension::headers member, thus resulting
> the above warning.
> 
> [FIX]
> Not an expert in python, but other packages like cffi are all using
> `package_data` to include the headers, so just follow them to use
> `package_data` member for headers.

Me neither, I haven't found a good documentation for the packaging so
it's more trial and error. Patch added to devel, thanks.

