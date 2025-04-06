Return-Path: <linux-btrfs+bounces-12817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE408A7D10C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 00:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5417016CA25
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Apr 2025 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24621767A;
	Sun,  6 Apr 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1qb3te3z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wd2SGLmr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1qb3te3z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wd2SGLmr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A761B4156
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Apr 2025 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977878; cv=none; b=TletBP2d8ssJbOcrLT8+1CdNzzS1aYbzelJ1t1l8kdLXuYSwTymtpTY0/btuTc+exdqolYXnVhEoxbOJNQ7fJQc8RLoTFmvMhmBoaxZtlEMzJEzVF97SWWWwvU11TJA9RwxYyR3xp3JFdIUlOO2H9nSkYBl88SOwGbNJFn4Tass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977878; c=relaxed/simple;
	bh=mpNAXk1YoAtn59nXDWgAouZjkPyZjNGFpv+DY4D0MSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC47MwblCt8kUBILT4q6/uyVOyxdvMeckYdfXWr/oPI8ZPlRkJ9LDsVYeVYUXFmY6y0gi4meg2QN587i3ugz34C2eo4AAXjB9AnHU8DFNqc8Li39VwiihKUV6q3ovj48Xj7PksW/UWNGz8BzI0cLKPg0J1h4Lqc7HmLA9/dwqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1qb3te3z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wd2SGLmr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1qb3te3z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wd2SGLmr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F40E821166;
	Sun,  6 Apr 2025 22:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743977869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSuKkdH2wGXPE3EIiDvwaqD+wqh1AWwmYRrPsB9wlM=;
	b=1qb3te3zssAwnbKzQ4NyAP/FIlZXqiFR8NVm/87QsH83XTyn0xgfXbJaQVlp/3SckhWKBq
	XQhhhDiT1kyO7V1avBQ6zcmIqyxr03hiC9eGm6QVk2h/Uk8uuBEgbM7brRI1JQh0g5BtlD
	wRuIoesDkYyX4RA/yxH3faHME30rRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743977869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSuKkdH2wGXPE3EIiDvwaqD+wqh1AWwmYRrPsB9wlM=;
	b=wd2SGLmrDZ8cSq8hYqfzWHIDNjT8QO7FmKWQrw4FfQCnzkIgoXoRCyPUqq9/kqRV2L8p8j
	/lU6hcXaPXhP+dCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743977869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSuKkdH2wGXPE3EIiDvwaqD+wqh1AWwmYRrPsB9wlM=;
	b=1qb3te3zssAwnbKzQ4NyAP/FIlZXqiFR8NVm/87QsH83XTyn0xgfXbJaQVlp/3SckhWKBq
	XQhhhDiT1kyO7V1avBQ6zcmIqyxr03hiC9eGm6QVk2h/Uk8uuBEgbM7brRI1JQh0g5BtlD
	wRuIoesDkYyX4RA/yxH3faHME30rRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743977869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tqSuKkdH2wGXPE3EIiDvwaqD+wqh1AWwmYRrPsB9wlM=;
	b=wd2SGLmrDZ8cSq8hYqfzWHIDNjT8QO7FmKWQrw4FfQCnzkIgoXoRCyPUqq9/kqRV2L8p8j
	/lU6hcXaPXhP+dCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D570D13A50;
	Sun,  6 Apr 2025 22:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E4XTM4z98mdDDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sun, 06 Apr 2025 22:17:48 +0000
Date: Mon, 7 Apr 2025 00:17:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] More btrfs_path auto cleaning
Message-ID: <20250406221747.GY32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743549291.git.dsterba@suse.com>
 <6162303.lOV4Wx5bFT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6162303.lOV4Wx5bFT@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Apr 05, 2025 at 12:13:58PM +0800, Sun YangKai wrote:
> I'm new in lore, not having many experience in kernel development. I'm 
> currently learning by read the code and patches. I'm just wondering why we 
> cannot just make these `btrfs_path` become local variables so they can get 
> freed automatically? Is it because the size of `btrfs_path` is too large to 
> put them on stack?

Yes, this is the reason. The size of the structure is 112 bytes, stack
size is fixed to 16K and is considered a scarce resource. It's not that
the filesystem would use the whole 16K of the stack but in connection
with other internal subsystems like memory management, block layer,
drivers and with other layers like device mapper or NFS, the overall
stack consumption matters and each layer should not waste it.

In some known cases like ioctl handlers that run from the process
context it's known that there's more stack left, basically only the
layers below, so there are on-stack structures that do not need to be
allocated.

> Sorry for bothering here. I'm glad to move to else where if it is not prorate 
> to discuss here.

No problem, it's a valid question and keeping a structure on stack may
simplify some things so it's something to look for, but as can be
demonstrated on this example it's not always safe. The btrfs_path cannot
be made smaller, the first member 'nodes' is already 64 bytes, the
remaining members can be possibly squeezed when smaller int types would
be used but this generates worse code and it's one of most frequently
used structures.

