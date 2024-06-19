Return-Path: <linux-btrfs+bounces-5802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC290E170
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 03:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1545B22561
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70920B0F;
	Wed, 19 Jun 2024 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQSeyqcT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOruRrz8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQSeyqcT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BOruRrz8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB242374E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762010; cv=none; b=gyHFqVE9GfXmSyr0zL0dDN1aBu7CelE9uTpghxR19twXN4fT7fvH5AINzzURw0HvJEeasHMRIRrrZl3E23f+9c8DQLZvJ/PY4muuUo5tsItEGhkBxUEsJhpu4szO1wEk+pdR/yyUlE5qVFBcn9VzCpCXl55XfPj08N+3ei4S8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762010; c=relaxed/simple;
	bh=IQ1uSUG3dT89W5a18oEp1TelO5y2wwPhgdTNukFrxHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDKxZUAp0mImfrPZQHzDpI/gVjTTZA3m3duttGsL70pgNs7TAMV47AmweeCNoAP/nxnRd9QIIUbqWHMttUY7OPVV9WsL1uZn9HlArtxCmDkAz0fOvhvlKr3JiGlFZVH+uv9EoMcdVqpvrEC7SxV2mj1cQ5p8i7Cv1GF4FZGekG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQSeyqcT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOruRrz8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uQSeyqcT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BOruRrz8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBB9A1F7B0;
	Wed, 19 Jun 2024 01:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718762005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X/QdHdNwdETV4EmpZ1AebXp1RKgx8sfqRHVmGEwWi0=;
	b=uQSeyqcTcmC1yvR0aHLlRZ67ro0IKkRqOYJdanHA5uFQMhKVFPjsW27IlFppUR4WGrolhC
	uxNnbpGge/RLui+JJO973FxRc+kGieP0xFEs3MBR8va01sW8RU0yGbM7Oz4LcvSQHav0u4
	8Gc7nBI57UX5Phq2x3z8qDJjPz0+9f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718762005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X/QdHdNwdETV4EmpZ1AebXp1RKgx8sfqRHVmGEwWi0=;
	b=BOruRrz83DggnHo/Toq6T9lCR0V7jKylIgOrAc5F2Qu6Zd5bRoC2OBWuRxyWUBl+YpMj7k
	BcYmLXLIChbwtrDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718762005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X/QdHdNwdETV4EmpZ1AebXp1RKgx8sfqRHVmGEwWi0=;
	b=uQSeyqcTcmC1yvR0aHLlRZ67ro0IKkRqOYJdanHA5uFQMhKVFPjsW27IlFppUR4WGrolhC
	uxNnbpGge/RLui+JJO973FxRc+kGieP0xFEs3MBR8va01sW8RU0yGbM7Oz4LcvSQHav0u4
	8Gc7nBI57UX5Phq2x3z8qDJjPz0+9f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718762005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X/QdHdNwdETV4EmpZ1AebXp1RKgx8sfqRHVmGEwWi0=;
	b=BOruRrz83DggnHo/Toq6T9lCR0V7jKylIgOrAc5F2Qu6Zd5bRoC2OBWuRxyWUBl+YpMj7k
	BcYmLXLIChbwtrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B826613AAF;
	Wed, 19 Jun 2024 01:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p1l7LBU6cmakMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Jun 2024 01:53:25 +0000
Date: Wed, 19 Jun 2024 03:53:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: fix csum metadata reservation and add a
 basic test case for itb
Message-ID: <20240619015324.GK25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718693318.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718693318.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spam-Level: 

On Tue, Jun 18, 2024 at 04:20:47PM +0930, Qu Wenruo wrote:
> The current csum conversion is using an incorrect parameter for
> btrfs_start_transaction(), which is 16K times larger than the expected
> metadata space, thus it always fail with -ENOSPC.
> 
> Fix that first, then add a basic test case using the same populate_fs()
> from convert test cases, and iterate through all the support csum
> algorithms.
> 
> Qu Wenruo (2):
>   btrfs-progs: change-csum: fix the wrong metadata space reservation
>   btrfs-progs: misc-tests: add a test case for basic csum conversion

Added to devel, thanks.

