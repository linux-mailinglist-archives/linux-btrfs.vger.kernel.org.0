Return-Path: <linux-btrfs+bounces-4971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CA8C5907
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446C31F22D5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC217EBAE;
	Tue, 14 May 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OC6u7waN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZ8qmX3I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OC6u7waN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZ8qmX3I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B91292D2
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701620; cv=none; b=KtNTirDq4s4HO9ZDDDgiLryB8Q7EsXcYiubUp2wliDGTrgubQlPAIzJgExVTxBvTOX0ouALg6ydD/Pmp9LVMvgaE8iNQ2bvKQkI3kJ67EZqjwlBeaq8qBAVN12jw0n09l9z44irZfKDnwKOBZeywOltI3sfixVbb1GoKMh/E5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701620; c=relaxed/simple;
	bh=20Esgl1q00khwZI5OuKTLBt0P7AE+c3uDhQgcSZXZMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWjgPOu1lCTbRg/NC/XTIosQ2K9BoEGGqRJO/+CGUQSsTmmCVLlf61ryHURCCmI6hd9SOjJ2KD1waq0rKXOGzrJhgpxt/1c3rsntczbnDCjwFUu0BQtKmyW8rqg447PthRDnGHG0ZYanfwULP/TKavTb3Skt7gO/Mfs55mzM6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OC6u7waN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZ8qmX3I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OC6u7waN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZ8qmX3I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0084E60DB4;
	Tue, 14 May 2024 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715701616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+iWSoGyxv3g+AEhIsfxNPOpLM+KW5bBWDgLYDp/22o=;
	b=OC6u7waNk2ah+br62vAsB/DGVQ8kAT8no8Jws5bV/Y6SE4P944OZ7wMu9OkYbThag4V8qP
	FqoWmR3ieK0M8rIQyQPR8592VdfVKFRCvfTeqJUYzEjqlpHoiqdLXnA2XSXsHn8Jvm2lkw
	+kadPNq4TjsyCmfES6RcW+BEOCbEy4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715701616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+iWSoGyxv3g+AEhIsfxNPOpLM+KW5bBWDgLYDp/22o=;
	b=VZ8qmX3IdoXnI1LBHmiT0ZDRSFvM2yybvwCeXuAG8HPft0Dwra5sm+59SvuUAvNBBhZ2Du
	nLeYJ32o0qM4v3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715701616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+iWSoGyxv3g+AEhIsfxNPOpLM+KW5bBWDgLYDp/22o=;
	b=OC6u7waNk2ah+br62vAsB/DGVQ8kAT8no8Jws5bV/Y6SE4P944OZ7wMu9OkYbThag4V8qP
	FqoWmR3ieK0M8rIQyQPR8592VdfVKFRCvfTeqJUYzEjqlpHoiqdLXnA2XSXsHn8Jvm2lkw
	+kadPNq4TjsyCmfES6RcW+BEOCbEy4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715701616;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+iWSoGyxv3g+AEhIsfxNPOpLM+KW5bBWDgLYDp/22o=;
	b=VZ8qmX3IdoXnI1LBHmiT0ZDRSFvM2yybvwCeXuAG8HPft0Dwra5sm+59SvuUAvNBBhZ2Du
	nLeYJ32o0qM4v3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E20EF137C3;
	Tue, 14 May 2024 15:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xGEEN2+HQ2YxUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 15:46:55 +0000
Date: Tue, 14 May 2024 17:39:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Message-ID: <20240514153938.GE4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514005133.44786-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, May 13, 2024 at 06:51:26PM -0600, Naohiro Aota wrote:
> mkfs.btrfs -b <byte_count> on a zoned device has several issues listed
> below.
> 
> - The FS size needs to be larger than minimal size that can host a btrfs,
>   but its calculation does not consider non-SINGLE profile
> - The calculation also does not ensure tree-log BG and data relocation BG
> - It allows creating a FS not aligned to the zone boundary
> - It resets all device zones beyond the specified length
> 
> This series fixes the issues with some cleanups.
> 
> Patches 1 to 3 are clean up patches, so they should not change the behavior.
> 
> Patches 4 to 6 address the issues and the last patch adds a test case.
> 
> Naohiro Aota (7):
>   btrfs-progs: rename block_count to byte_count
>   btrfs-progs: mkfs: remove duplicated device size check
>   btrfs-progs: mkfs: unify zoned mode minimum size calc into
>     btrfs_min_dev_size()
>   btrfs-progs: mkfs: fix minimum size calculation for zoned
>   btrfs-progs: mkfs: check if byte_count is zone size aligned
>   btrfs-progs: support byte length for zone resetting
>   btrfs-progs: add test for zone resetting

I did a quick CI check, the mkfs tests fails. You can open a pull
request to get your changes tested (it can be just for the testing
purpose, if you note that I'll skip it until the final version).

https://github.com/kdave/btrfs-progs/actions/runs/9081685951

There are also some compatibility build tests on older distros,

https://github.com/kdave/btrfs-progs/actions/runs/9081685969

