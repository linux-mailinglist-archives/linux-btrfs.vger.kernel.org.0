Return-Path: <linux-btrfs+bounces-14288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B1AC748B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 01:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAE7500463
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C729218585;
	Wed, 28 May 2025 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N3f5Raev";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+NJxu23";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0TqVeOIC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O2imVHEe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BC1C8638
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748475690; cv=none; b=aYXynk5JFZytdcjUZ9kcryGUiDvOvhtvvRMixXDN/jeQjM9UmgsQYSczVm9fCfoTgUQQjRvOgPzV/cC4y7IpeAaF9t6kGPgQR2E2CaitDDg+qAtpUJsFUrdWvsb/TRizT6YZU+m/sKocbpVZiSAz+uEdkLSupyrq5WMVCDrhd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748475690; c=relaxed/simple;
	bh=AD4bFAxDiBIanEnuZVlDINvnEIvzgfU4JQLMl/xborA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOADz+6AwilM4K66JG3o7VYrLOAGssVnhsXez2Mi944ZRLoMT5II0P+yuAHLt2Ne9iYdnorkll+srHUQAHZqatcvuQ8l0CaN9C1FQqb5ibiHGbyT/C2mtOGdPOXePy1mzmZ688I63ThvictIRJkRUu+31QeIKCEIOYITMpO4xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N3f5Raev; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+NJxu23; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0TqVeOIC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O2imVHEe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E87BC219A7;
	Wed, 28 May 2025 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748475687;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=409Qbq7ZMaUh5YEWj8ZxaQSL8+Othp11wSHAEskLPA4=;
	b=N3f5RaevmU+s/FAErOxlRu5cF8es4zBF+4ytBCirOnSFtrD7ouQJVKE3MzTOPHrjfvcx9u
	KJUlrfmZFWhdHjiFa9qc4/qVliyUdAwh628FTJMXnXQKRgDRPFkiv2A/rmtO0akt5/ScOE
	C4JBmz2aeWDZ9ZtjojidUxWWb3e2aBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748475687;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=409Qbq7ZMaUh5YEWj8ZxaQSL8+Othp11wSHAEskLPA4=;
	b=J+NJxu233hAnTqm+alPePX+0/zO6V996rbW6IvP50if7pMeHzbS3kccRXBPHaxfJCD7rmV
	Btkzylea3dLQx8Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748475686;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=409Qbq7ZMaUh5YEWj8ZxaQSL8+Othp11wSHAEskLPA4=;
	b=0TqVeOICJZ9+grDdQWTAUqBd5yiTeUA8+YsVG5LPFwBXchLfnYIhtODGK42lkTQT2/cten
	YCLyn1TvWkzJgQezXMkmLVWLsHzrEsQChpQgsDBKWWQjQc9sj05zcoHF69mzkS4pffPg9v
	WZmUzzkEo58PtD1mmlEh5FKF7zdVgF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748475686;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=409Qbq7ZMaUh5YEWj8ZxaQSL8+Othp11wSHAEskLPA4=;
	b=O2imVHEezNUOC5Hxe2BqKDRoJl2uK5QLk2g5JwkDkdZnMFR4+xp7KGd1TPIUiINMiZcfYw
	qZSOYQR0jACTbTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D77BD136E3;
	Wed, 28 May 2025 23:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oSZhNCafN2gjYQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 23:41:26 +0000
Date: Thu, 29 May 2025 01:41:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Dan Johnson <computerdruid@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix comment in reserved space warning
Message-ID: <20250528234125.GN4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250415002552.7208-1-ComputerDruid@gmail.com>
 <CAPBPrnvFkhWQcu-9YTgER879SA+_FBYY9PH2+WO8Px1-=Babzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBPrnvFkhWQcu-9YTgER879SA+_FBYY9PH2+WO8Px1-=Babzw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Sat, May 24, 2025 at 10:31:51AM -0700, Dan Johnson wrote:
> Gentle bump here, it looks like this got missed? I did a bunch of
> digging to figure that out and wanted to make sure to share it with
> others.

Not missed, but the timing near release and start of merge window can
cause delays for patches that are not urgent fixes or such.  Patch now
added to for-next, thanks.

