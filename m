Return-Path: <linux-btrfs+bounces-12778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2D2A7AFCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 23:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BC87A72ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE82254AE5;
	Thu,  3 Apr 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1DgFDkp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wo0ERvEd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1DgFDkp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wo0ERvEd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00865254AE9
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710627; cv=none; b=adp41i7ZSiqwpspHR8VgjwlOVPfhotvCilk7aENZNO/rCOZ+5My394WxqsN6xrEacUHUKModYpuoBYaaIYhQoIGdEnSxPfmGVc1Frw87GW1ucKWouPP0f98dAiyYnMGh8fc1IUGN4168gGhnv8Mf4aO5aXIARskIyQtd5AOrdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710627; c=relaxed/simple;
	bh=571wgAHHNZchY9Pr4Krv2wdR7SYrBWPKkBv+I2tjHsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOlUTRTw2X3UefkTBYdjSzp/uhqTTh1R4d4IgSZhJnjZvQo16yrUZl2UNYmv05U00fiRWe+0/NDc3SMj/1TBxIxmZEItKLUpkUYBGZSfYfF2nDXoWM/662xjMfROXdUH0a4BXml+s0CjKY7KRKSThGQtt+VxUcX0xZrHTb4yJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1DgFDkp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wo0ERvEd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1DgFDkp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wo0ERvEd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39BBB2116A;
	Thu,  3 Apr 2025 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743710624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w10ti+zJK+h6hE8dcgW/UYVoQjAr4Y8jdxl/Rh833Sg=;
	b=S1DgFDkp1+EWFQPDwRK2ZBM5X06AqAjrrGL5blQlM8BN+BACIRkOykAIH2yajrKrq8psRP
	/pF5Y6xyRLpwia54rCrFCSAcfuzw2i18caOplWAGQ5+6ePFyByYhqtk0yw09vDEohp38vR
	ecLgjwWm1tDegMYMVKaZfACRaFnaoNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743710624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w10ti+zJK+h6hE8dcgW/UYVoQjAr4Y8jdxl/Rh833Sg=;
	b=wo0ERvEdLqM7jHeBDxD256MHiDpHK6HRCTJc1KVCJceqnildgWAB5Kg6otETLeXqPge0jV
	ea25pbqjHfVfUvCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743710624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w10ti+zJK+h6hE8dcgW/UYVoQjAr4Y8jdxl/Rh833Sg=;
	b=S1DgFDkp1+EWFQPDwRK2ZBM5X06AqAjrrGL5blQlM8BN+BACIRkOykAIH2yajrKrq8psRP
	/pF5Y6xyRLpwia54rCrFCSAcfuzw2i18caOplWAGQ5+6ePFyByYhqtk0yw09vDEohp38vR
	ecLgjwWm1tDegMYMVKaZfACRaFnaoNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743710624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w10ti+zJK+h6hE8dcgW/UYVoQjAr4Y8jdxl/Rh833Sg=;
	b=wo0ERvEdLqM7jHeBDxD256MHiDpHK6HRCTJc1KVCJceqnildgWAB5Kg6otETLeXqPge0jV
	ea25pbqjHfVfUvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DBA913A2C;
	Thu,  3 Apr 2025 20:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UTLZAqDp7meFOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Apr 2025 20:03:44 +0000
Date: Thu, 3 Apr 2025 22:03:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v3 0/2] btrfs: zoned: skip reporting zone for new block
 group
Message-ID: <20250403200338.GV32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742348826.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742348826.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
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
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 19, 2025 at 10:49:15AM +0900, Naohiro Aota wrote:
> Newly created block group should reside on empty zones, whose write pointer
> should always be 0. Also, we can load the zone capacity from the block
> layer. So, we don't need to REPORT_ZONE to load the info.
> 
> The reporting zone on a new block group is not only unnecessary, but also
> can cause a deadlock. When one process do a report zones and another
> process freezes the block device, the report zones side cannot allocate
> a tag because the freeze is already started. This can thus result in new
> block group creation to hang forever, blocking the write path.
> 
> v1: https://patch.msgid.link/cover.1741596325.git.naohiro.aota@wdc.com
> v2: https://patch.msgid.link/cover.1742259006.git.naohiro.aota@wdc.com
>   - Move other zone related functions into the same #ifdef block.
> v3:
>   - Rename argument variable and fix the kerneldoc.
> 
> Naohiro Aota (2):
>   block: introduce zone capacity helper
>   btrfs: zoned: skip reporting zone for new block group

There seem to be no further comments. I'll add the patches to for-next
and queue it for merge in 6.15-rc2. Thanks.

