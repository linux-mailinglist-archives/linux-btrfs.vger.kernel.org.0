Return-Path: <linux-btrfs+bounces-9894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE1B9D899C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF0169566
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595718C345;
	Mon, 25 Nov 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYnBSpL0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzYobTE/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYnBSpL0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzYobTE/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44613291E
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549568; cv=none; b=kqDt/rHUPdEiOCBznV4VjmizTInXeUzFI9GOCdmcxcqVyOgh9Kxdrd+2VnkowigpApPunJYzuzWf5D01Mbz4Ui3hCIRhmNDBKINJ0GnyoHefMnwyQxR6w30yoMJKVLHpz+iWLKuzZJwcv3cqeBKMlzN5zinuYf5M16QP5EWSIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549568; c=relaxed/simple;
	bh=sxA+fKHOK236poNihUTqHjIXZBo6sE9hTMW3xIZtEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZRMHY3yIS4ylqmEUybQQiuNfbGFjGXnBoLW94DTmWtirUiu8q1FPiw1kCiDxiEbGDyJhwMQVuQaQ7zlu7eIRu1eSzIp28jkrA69C6vR0NotmzgeVcTWyyh2IOUZRByNGNgid8zb0rPNlsyxsKJRZSA0TvXpHCsPRoZVTLFG2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYnBSpL0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uzYobTE/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYnBSpL0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uzYobTE/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 402BD21153;
	Mon, 25 Nov 2024 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732549564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIDybjoi+Z0yISIDSch9op0gNuOYkVV5O3iZOQXpfh8=;
	b=oYnBSpL04Chxq7baYngB6UmXrnfFcz8Oz0xnm5o6ONyp/sZQPRkm7dMdQ7z0kb9EbhZZfo
	AAaqwAjceCG0lMrDJU3A6tmn0aXD9lopWMl32W9VGdlyOiRorexmzf6EclHYE729vZwvRX
	7CoIPVMsUMzkJh2FdMjufk2VXmHsUzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732549564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIDybjoi+Z0yISIDSch9op0gNuOYkVV5O3iZOQXpfh8=;
	b=uzYobTE/06KgDq+NQ+iKsUc85L4jyF5fKEEbJbWVQ1YbcHTxuZmmEqrJM7+Y11ncPJMGs1
	y4Bp4MtKbOWNp6BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732549564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIDybjoi+Z0yISIDSch9op0gNuOYkVV5O3iZOQXpfh8=;
	b=oYnBSpL04Chxq7baYngB6UmXrnfFcz8Oz0xnm5o6ONyp/sZQPRkm7dMdQ7z0kb9EbhZZfo
	AAaqwAjceCG0lMrDJU3A6tmn0aXD9lopWMl32W9VGdlyOiRorexmzf6EclHYE729vZwvRX
	7CoIPVMsUMzkJh2FdMjufk2VXmHsUzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732549564;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIDybjoi+Z0yISIDSch9op0gNuOYkVV5O3iZOQXpfh8=;
	b=uzYobTE/06KgDq+NQ+iKsUc85L4jyF5fKEEbJbWVQ1YbcHTxuZmmEqrJM7+Y11ncPJMGs1
	y4Bp4MtKbOWNp6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FFAF13890;
	Mon, 25 Nov 2024 15:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QB4aB7ybRGetYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 15:46:04 +0000
Date: Mon, 25 Nov 2024 16:45:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: use kmemdup in btrfs_uring_encoded_read
Message-ID: <20241125154558.GA31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241111190619.164853-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111190619.164853-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Nov 11, 2024 at 07:06:06PM +0000, Mark Harmstone wrote:
> Use kmemdup in btrfs_uring_encoded_read rather than kmalloc followed by
> memcpy.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411050846.GI8oh5IK-lkp@intel.com/

Added to for-next, thanks.

