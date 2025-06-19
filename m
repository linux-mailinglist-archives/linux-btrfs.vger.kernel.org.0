Return-Path: <linux-btrfs+bounces-14784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FEAE0667
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 15:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738E85A0F8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816042417F2;
	Thu, 19 Jun 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a7pFG0JK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dg4ZIBXY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a7pFG0JK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dg4ZIBXY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DB241CB2
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337991; cv=none; b=fh0uAFX3eF10qzCwYYC242RAp49wH7poNwRKB2MfcTs/HAChh03pK3shZZ0G7AI2gCYfBZEicPsMxc4yNq0JOIS45B2C/+CJngnnTf/mrGoTGpww2sxEHowXR/zRlt6Y0uDOt7wo11DWvuyxYkEmsPzx7e8NwuQw1hk80TYjkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337991; c=relaxed/simple;
	bh=hzUwxanX9FkaxmnBz6ieL27U5CQ3U+3fFh7ugzU4ymg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/wmeAhOlwE99jZ4UcgFMuLhOL1ihi3353wELkCUb2o4BG19hKU/El5Pdu2/drff7HoCRxOCv5ZOR3DMdzzKLN9idf+bAjTg1krp3jJr8WzqzXDkxI1jxJrG3WED7Om4wfDQ2RXdnvNoFP/XycxubojaQDoMgdSCx997LhhodTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a7pFG0JK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dg4ZIBXY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a7pFG0JK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dg4ZIBXY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68F2F211CF;
	Thu, 19 Jun 2025 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750337988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JG4f7NdtHK71JxKn5KK2TZ5uLvejWI4rHxqgPbNhPFo=;
	b=a7pFG0JKoS/RamkB8c+lYWRY6y60He2zTYbjRBZDHW6nnhBa4rPI80S3fBqxoAy8M+rotM
	Sc5bMfzjG9RbDZ1LLVLlNSLQaXIHRUM4UBMsDvSDlN6ZttW3xJgO+ndb0XxJUY/mYZKvck
	x2llTCQaH2jRyyUuLLXO24VOPPlNbQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750337988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JG4f7NdtHK71JxKn5KK2TZ5uLvejWI4rHxqgPbNhPFo=;
	b=Dg4ZIBXY6n2RO9iJ67FWxk51JnmXZ148Ok2UKpD4/yWwkrttD3hLHGD3Ef33ctkusqtfZl
	C4ifcAUBC9ruaRDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a7pFG0JK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dg4ZIBXY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750337988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JG4f7NdtHK71JxKn5KK2TZ5uLvejWI4rHxqgPbNhPFo=;
	b=a7pFG0JKoS/RamkB8c+lYWRY6y60He2zTYbjRBZDHW6nnhBa4rPI80S3fBqxoAy8M+rotM
	Sc5bMfzjG9RbDZ1LLVLlNSLQaXIHRUM4UBMsDvSDlN6ZttW3xJgO+ndb0XxJUY/mYZKvck
	x2llTCQaH2jRyyUuLLXO24VOPPlNbQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750337988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JG4f7NdtHK71JxKn5KK2TZ5uLvejWI4rHxqgPbNhPFo=;
	b=Dg4ZIBXY6n2RO9iJ67FWxk51JnmXZ148Ok2UKpD4/yWwkrttD3hLHGD3Ef33ctkusqtfZl
	C4ifcAUBC9ruaRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C6C913721;
	Thu, 19 Jun 2025 12:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S90uEsQJVGiMBwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Jun 2025 12:59:48 +0000
Date: Thu, 19 Jun 2025 14:59:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/2] crypto/crc32[c]: register only "-lib" drivers
Message-ID: <20250619125944.GJ4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250613183753.31864-1-ebiggers@kernel.org>
 <20250613183753.31864-3-ebiggers@kernel.org>
 <20250617201748.GE4037@suse.cz>
 <20250617202050.GB1288@sol>
 <20250617204756.GD1288@sol>
 <CAPjX3Ff-A+M9Ad7iJFTDGAs=M1d6zOqDq48i1GmRn967a_GDsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Ff-A+M9Ad7iJFTDGAs=M1d6zOqDq48i1GmRn967a_GDsw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 68F2F211CF
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jun 19, 2025 at 12:27:13PM +0200, Daniel Vacek wrote:
> > I revised it to:
> >
> > btrfs does export the checksum name and checksum driver name in
> > /sys/fs/btrfs/$uuid/checksum.  This commit makes the driver name portion
> > of that file contain "crc32c-lib" instead of "crc32c-generic" or
> > "crc32c-$(ARCH)".  This should be fine, since in practice the purpose of
> > the driver name portion of this file seems to have been just to allow
> > users to manually check whether they needed to enable the optimized
> > CRC32C code.  This was needed only because of the bug in old kernels
> > where the optimized CRC32C code defaulted to off and even needed to be
> > explicitly added to the ramdisk to be used.  Now that it just works in
> > Linux 6.14 and later, there's no need for users to take any action and
> > the driver name portion of this is basically obsolete.  (Also, note that
> > the crc32c driver name already changed in 6.14.)
> 
> How about instead removing that part since it's useless now?

There's no best answer, removing it makes sense but could break
somebody's scripts parsing that file. The information put to "(...)"
might be useful in the future again. It's less harm to leave it there
than to deal with potential fallout if it's removed.

