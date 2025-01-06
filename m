Return-Path: <linux-btrfs+bounces-10735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E7A02497
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 12:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACAD18839E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A31DCB3F;
	Mon,  6 Jan 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z2I0tbx+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBQkhZs3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oOXxwyxN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQ8bLAc5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51091F9D6;
	Mon,  6 Jan 2025 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164485; cv=none; b=sCRs4TB99vUKVEVemCuFvJjUFGbsjaIMKkllk5CXh/KeW939uqf+gWTbJO1mSGkHG3UisraZs7pP0FMkWes5DoVMVjrHoiSGoHEUMQNg69M/4fbfY4GTV6YgPC3f1IEJ7QuNj2xtg27CWtO1/JByZwdtJyK8O0gKTaavhqK9Wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164485; c=relaxed/simple;
	bh=SQwjDTWlSK662prJcJDZp9PPRL/9qgWUMQ4clsiprPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY4HcgHlDmyV6jDEG5Quiv6b5RS0TI3PErBLIDW9iEV3yic/Ylk8f45qINv7uCGnyfU3IQy0yAe+OMeTsXQ3+vkUW1hnGKQw8pSKNg/z+Nkb24AcuuuMVB2EX7L6oO13WL/KXk2ecpLgNMzSY2WxW74n62o8TnA5wrmjkAmCtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z2I0tbx+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBQkhZs3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oOXxwyxN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQ8bLAc5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73FE91F441;
	Mon,  6 Jan 2025 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736164480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drarDzD7kms09VWCCsDAPG3R2WgniJs1kpoq9zXFHKk=;
	b=Z2I0tbx+j5hZH5TJ9OP5h9N5WxgQD8Nhgbkt7dx1KJf8JENuVUBFBxvG4zZLDRbMhWSIfD
	ZPXXOnFEc1RR9XWBl/4jLTJEZG4KTO2RuarMAVXmjtSe5WJCd4HalUjpMqTxfULSYdVIJ1
	KC4xszQLwikW8NRtodB7kb+G1XYQJws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736164480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drarDzD7kms09VWCCsDAPG3R2WgniJs1kpoq9zXFHKk=;
	b=VBQkhZs3WdwYg3vqrfLUrOCIcpSjBSGnnrmmdl1ZGppE+nnEyatqwCv5xWLzJ4nHDLU13W
	61+s6icC5D5XDvCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736164479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drarDzD7kms09VWCCsDAPG3R2WgniJs1kpoq9zXFHKk=;
	b=oOXxwyxNwuuvCjoV/B0nTssTNHkjkf1a8wMmIudy/YsreCht3FfOLM8KWahWyE7NkaTjZB
	FY5WgHSmbUP/fj/IhOSTmYx0wDcL3p0CU/vo8B1gGlXSciWkY8IcfgLH3zGvxSrls29K32
	Axfiw51rfpaZQjISJXtSFqa7XeyLkKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736164479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drarDzD7kms09VWCCsDAPG3R2WgniJs1kpoq9zXFHKk=;
	b=FQ8bLAc5y7+mjF5SUVzq6n84StCJ4tZx6JCoBjXcIAaqxEgboq4bt9vU19XMymN/3lrzyK
	oi2kfyGXReZ8W/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6442F137DA;
	Mon,  6 Jan 2025 11:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFlCGH/Ee2fGFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 11:54:39 +0000
Date: Mon, 6 Jan 2025 12:54:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] btrfs/326: update _fixed_by_kernel_commit
Message-ID: <20250106115434.GT31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <74d9b2816beb6ef245718331ebcbc1a7cdab5919.1736042456.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d9b2816beb6ef245718331ebcbc1a7cdab5919.1736042456.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sun, Jan 05, 2025 at 12:31:01PM +1030, Qu Wenruo wrote:
> The original fix is already in the upstream, meanwhile a new but much
> harder to hit bug is also exposed by this test case.
> 
> Add a new _fixed_by_kernel_commit for that bug, and special thanks to
> Christian for pointing out the fix.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

