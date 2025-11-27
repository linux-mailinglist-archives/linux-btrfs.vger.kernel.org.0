Return-Path: <linux-btrfs+bounces-19380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45224C8FB2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1492C4EB327
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8992ED853;
	Thu, 27 Nov 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFXUX8ga";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/2zGpsv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tq65/nWL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FMw9QUNr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623832E8897
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264601; cv=none; b=TzRCcneQAAdOE3Onk/Z/9oVpDCrBK3YdhR3UbrNsebGst0vd4LfUqrmAVOWdEMBUUilkdYduKOg4tNX4B6ZySwn1KPEwpu3xL81n1UlibqUadFs0mcoG7156wkT3P9zt0Qvw4ALCxV9We8B6Sftbq7CYUGz0SRhk70JHw1499aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264601; c=relaxed/simple;
	bh=QfbR+EE5VYLX4PrknRSxLaUPAYmhW9QeadeKjSV8cbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM+EXkwMGYcLzHdXCisYLuypc7514l7Ob0MP3VXmb8V51/lIkFnV6Gm71QDOEf6SriZdp3u46ytIONC8G6lAIsAPhIpNDKR4EkTfyvcNQjtv5xSfrJ64cJ2BZzXMRZXM4c/o+Fc7Nfs9MmeBm0vvrGPxBnTUgko6MtrDigw9+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFXUX8ga; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/2zGpsv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tq65/nWL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FMw9QUNr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FC615BCCE;
	Thu, 27 Nov 2025 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dv7Er5eKp8o4/p31I0vEXQw0yd0+ikq8MbRyCebNX8w=;
	b=yFXUX8gaFJ/6Y9QqCt6+HJXyO5kJ+P8cz5etH0XOitlFubGu/saoupGqgmL7RGDIg19bza
	4OcEVUQp21glwKvO77qwzhAilQqbicOf44D/geHX7Vsqwr++c95YT/XeoUS4tRuhlUc8cS
	VWpj/zTmFTUHzR1qy5TchO9AsVx99Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dv7Er5eKp8o4/p31I0vEXQw0yd0+ikq8MbRyCebNX8w=;
	b=C/2zGpsvg9Dym4SYOeK0Rgxsv+zpwto87fhVvuP0PFvRU7ti+fDIjWW/xuN2nEUrppL+ED
	W69E1lg8OdQVXUDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dv7Er5eKp8o4/p31I0vEXQw0yd0+ikq8MbRyCebNX8w=;
	b=Tq65/nWLs8tbHraXtNFOFljN3K7wbNWckH0vLE43iAmbMd84Q6MY4WXOiHDrlCSbdnxZtI
	v4c8stm6AHoZ4/UkFEAP8l7LxYzSN5GPcF3GXk3Iuz9uK7LIGYUNIV6Q45/w4EKNpyT6r2
	W39OXfaClqeQ7pneEnszInh5dZg/fYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dv7Er5eKp8o4/p31I0vEXQw0yd0+ikq8MbRyCebNX8w=;
	b=FMw9QUNrvv4y2toUnZuDvnhz2ITLzjF63LcERqTofRklSkzXm+AQxlj+k26fiQX1XLBFC9
	CGkrwmFP6j1/sDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60D043EA63;
	Thu, 27 Nov 2025 17:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I7BrF5OKKGk3PgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Nov 2025 17:29:55 +0000
Date: Thu, 27 Nov 2025 18:29:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sun YangKai <sunk67188@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] btrfs: tests: Fix double free in remove_extent_ref()
Message-ID: <20251127172946.GD13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <aSf6UHCbZrgZCQ1L@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSf6UHCbZrgZCQ1L@stanley.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,suse.com,vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto,linaro.org:email]

On Thu, Nov 27, 2025 at 10:14:24AM +0300, Dan Carpenter wrote:
> We converted this code to use auto free cleanup.h magic but one old
> school free was accidentally left behind which leads to a double free
> bug.
> 
> Fixes: a320476ca8a3 ("btrfs: tests: do trivial BTRFS_PATH_AUTO_FREE conversions")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks, I'll add it to for-next as 6.19 branch is frozen.

