Return-Path: <linux-btrfs+bounces-4061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32EA89DC5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B33FB251D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8474F8A0;
	Tue,  9 Apr 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUE2jjnc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eVGNSa7/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FcPYy30U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+CN149Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E5C139;
	Tue,  9 Apr 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673237; cv=none; b=UbW9gr2yCFFNY3Y3Nwe+HUKt1LMrsnU8+H85hpJ7BoWldYF600qwyXZj7mfFeHrBvPc5eZDGpT38s48DxLlx4dzmGCalII57QpEjBloqgwiuwRG4V+pWlkEhZfezQTZ+oOIZxcOP5Anar1Gm1sFK43jodqew31UIwCjJzkJFvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673237; c=relaxed/simple;
	bh=YvLt7Z8HYdrP5PsGP0g9BPQ3g8H3itB4a/ZAw3xGFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVsMMBTrCbGrMk5uyQzEoRmKU+x7nDDJo7754qhBEXTX3qi7hLuaCKVqfuyvP6nlSbCMJbJGSKUF3ZLV/JC196h1y9TaFQVOLrculC3DnkxltO0WkjMtMZGWrxFka3WvMftnG9pUMyuI10iBrIsRaLDy27WKSE7Fsqye5mUb+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUE2jjnc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eVGNSa7/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FcPYy30U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+CN149Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0EE820A55;
	Tue,  9 Apr 2024 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712673233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9kSqKqpvFrnQ4oMPmEm2ramRB8CC/w/qkCYwWSe9H4=;
	b=vUE2jjncy0tiEADZCXZgYeyNrm66qmnOxZVMqAoWa98gyVm0G99B7Fdz8p5uqgIxWg9QAF
	L3QVUo3qBQ0+g33zgEFWYGQ208xcy/OlnToDMbHXJ/UyO+zFawEclu/K9vvzrTdCcYx2MP
	53qGMmgOU3fgbzNoocEI2ew33u0qrOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712673233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9kSqKqpvFrnQ4oMPmEm2ramRB8CC/w/qkCYwWSe9H4=;
	b=eVGNSa7/6ibZUTM7tZGCbI6spfcgVbMq8wIuZTNVpp697KSMGXDktKsVVVIOO2t0tPreRj
	IYPGcsRc5uOpcRAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712673232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9kSqKqpvFrnQ4oMPmEm2ramRB8CC/w/qkCYwWSe9H4=;
	b=FcPYy30UroD3AtK+8Ndv5UK9SH1ZwgSTg1P++ZnEMqg9lJdfQoILKMQTBcIO4kYxHUK0aY
	3W7U/DB8iOXOxO7NiPXs5jNTBN+G80CoisUkmPJPOUWJmRkfd+UgDlE9qFdNRX0LouMzUE
	bNPTvuh0OOrnBANbcjxsgmcJwKjD/6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712673232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9kSqKqpvFrnQ4oMPmEm2ramRB8CC/w/qkCYwWSe9H4=;
	b=a+CN149QwNPsp/XgpDiOIXFzJf0riikVYeNzaclcDImJIVyk01Uo9XcSYYb//rCbeMuYIM
	bzhayX3Hj7J9ipAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A500213253;
	Tue,  9 Apr 2024 14:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n9DbJ9BRFWZpDQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 14:33:52 +0000
Date: Tue, 9 Apr 2024 16:26:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.04.03
Message-ID: <20240409142627.GE3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240403072417.7034-1-anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403072417.7034-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.40 / 50.00];
	BAYES_HAM(-1.40)[90.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.40
X-Spam-Flag: NO

On Wed, Apr 03, 2024 at 03:24:14PM +0800, Anand Jain wrote:
> Zorro,
> 
> Please pull this branch, which includes cleanups for background processes
> initiated by the testcase upon its exit.

What is the ETA for a pull request to be merged? Not just this one but
in general for fstests. I don't see the patches in any of for-next or
queued.

