Return-Path: <linux-btrfs+bounces-5301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC268D0748
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 18:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11236B291F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39461FC9;
	Mon, 27 May 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6n+ZL0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUzpmyax";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6n+ZL0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUzpmyax"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C717E903
	for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823636; cv=none; b=nA0UsiVGpXRfAvvVGLbQn7LkRU7H8oYyIk3S1roXGNP/jRUOEOVB1IKCBg2VP3oa6J7GK7Cb9MPI3H21paLbLF5EWTpd4KRI6vewbwklYJI7+IDXX42VvZvtPGrZtTPU446QSzJ8TcP5JGxhQiuHMjInxcrK66ARByhTgT2ng7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823636; c=relaxed/simple;
	bh=/adaVEE7toPdPeY8C9c/KLMH1KDG94ttNlrbwh1aHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKoxSA5QUKY1l6x4w42C6mmTffa3Znzr6egaRJAPNsYGPKnchaGNbpMbNnqUs2C6Cqnh5i/WE4gIvpmJeWUKkhK+b7NdBMAUGdGtVZ9AJDh0bRifTQ4Kp67XQWRZJFYYC6gTqmNntVJGbHIceYjnEhWvZjqAYPGP6ojrx7aHxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6n+ZL0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUzpmyax; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6n+ZL0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUzpmyax; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EAAE1FE00;
	Mon, 27 May 2024 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716823632;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/adaVEE7toPdPeY8C9c/KLMH1KDG94ttNlrbwh1aHsc=;
	b=V6n+ZL0vsU59oxeGR9OdxX4q2RKj4DmsuO/D7iO2QYd4S36h5rey/bBHGVcd67quBKNmYW
	2xsbPm89tyZBWmfn2HrL1MD7K9MgyngcOQ+J7uOA1iVC1lJ9cYKEXW3VMRQX8vwrTO/3UX
	vIOwGkt9Qjxcjkqk9Pfa4FOuc91Cv6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716823632;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/adaVEE7toPdPeY8C9c/KLMH1KDG94ttNlrbwh1aHsc=;
	b=oUzpmyaxCEvY1SvN7jAX5OZwW3LFI+bwWtjB4KKg2nhIfBduYa1qfIAB0oCAWsyCC/rwLC
	jA4ABA3bSi3w9UAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V6n+ZL0v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oUzpmyax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716823632;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/adaVEE7toPdPeY8C9c/KLMH1KDG94ttNlrbwh1aHsc=;
	b=V6n+ZL0vsU59oxeGR9OdxX4q2RKj4DmsuO/D7iO2QYd4S36h5rey/bBHGVcd67quBKNmYW
	2xsbPm89tyZBWmfn2HrL1MD7K9MgyngcOQ+J7uOA1iVC1lJ9cYKEXW3VMRQX8vwrTO/3UX
	vIOwGkt9Qjxcjkqk9Pfa4FOuc91Cv6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716823632;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/adaVEE7toPdPeY8C9c/KLMH1KDG94ttNlrbwh1aHsc=;
	b=oUzpmyaxCEvY1SvN7jAX5OZwW3LFI+bwWtjB4KKg2nhIfBduYa1qfIAB0oCAWsyCC/rwLC
	jA4ABA3bSi3w9UAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C99A13A88;
	Mon, 27 May 2024 15:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gY86HlCmVGbgXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 May 2024 15:27:12 +0000
Date: Mon, 27 May 2024 17:27:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Subject: Re: [PATCH] btrfs: qgroup: use kmem cache to alloc struct
 btrfs_qgroup_extent_record
Message-ID: <20240527152707.GA8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240527101334.207228-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527101334.207228-1-sunjunchao2870@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.09
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8EAAE1FE00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-2.88)[99.50%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Mon, May 27, 2024 at 06:13:34PM +0800, Junchao Sun wrote:
> Fixes a todo in qgroup code by utilizing kmem cache to accelerate
> the allocation of struct btrfs_qgroup_extent_record.

The TODO is almost 9 years old so it should be evaluated if it's
applicable.

> This patch has passed the check -g qgroup tests using xfstests.

Changing kmalloc to kmem_cache should be justified and explained why
it's done. I'm not sure we need it given that it's been working fine so
far. Also the quotas can be enabled or disabled during a single mount
it's not necessary to create the dedicated kmem cache and leave it
unused if quotas are disabled. Here using the generic slab is
convenient.

If you think there is a reason to use kmem cache please let us know.
Otherwise it would be better to delete the TODO line.

