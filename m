Return-Path: <linux-btrfs+bounces-14817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224BAE1AE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 14:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6833B83FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B828B412;
	Fri, 20 Jun 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XTKisOjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1VXfJZv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XTKisOjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1VXfJZv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171302080E8
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422441; cv=none; b=oxE2pf2nwkRGZHv3tkbZp4FzvWGgMc7sk4a3QdYJgwM+timS0I/lvfLEeM0aNHyYp7khfp18JNFPULJCkRxbtGg41r7O1Pw5wBJg5HEQGkrIy4xbOtdz7qapNW687kTHlv+0B9lzv00y/WYZqr0BsjOX61/FPBLXSPP92t128Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422441; c=relaxed/simple;
	bh=tX37v4gyoxennChCQjy16+67csIbio+cpP+xJt9Rkwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL/1fpZymbgFyboyxCrWaMHDO/xENw2TN+yj5ziALfxaZb6MajJqNrC8DB6sGiMfKaPhQ1y0kcz7QXO5tlxwnPlqX0mOQfRrm1h3+0gobI5EG8Mz2aBDS64X3RUC46uVQ5Kc5PSyvwoq/DWjsr6+QkyqecDdk1rRGTYJysOSIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XTKisOjD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1VXfJZv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XTKisOjD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1VXfJZv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32E1B1F38D;
	Fri, 20 Jun 2025 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750422437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/Yy654QcQTRuj4MwSbC85PZYTXBTs5gVtteaaVNdCM=;
	b=XTKisOjDYkQx7syjKIyWZ6Gug3DIHwnmqRO3mZ3V90hSA951elbcdNHd4I9GjOfTJjKC88
	wkZBFYf0JHpn6XktUOU9u21qt/lJg5cBAMmhxRMLH4istfL6hPYJ4v0wx2zBt4DJncy6+D
	CVw+ubMhRZCBDN+CgujzY3D9/AknvCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750422437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/Yy654QcQTRuj4MwSbC85PZYTXBTs5gVtteaaVNdCM=;
	b=x1VXfJZvbm/mvW4K1jPVQA2PhFlatnIlRiFi2Xb7YLFpsO/BKP8xvfLntSPV5e/wEp5c5D
	vyfJy1YIyjMN4CBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XTKisOjD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x1VXfJZv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750422437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/Yy654QcQTRuj4MwSbC85PZYTXBTs5gVtteaaVNdCM=;
	b=XTKisOjDYkQx7syjKIyWZ6Gug3DIHwnmqRO3mZ3V90hSA951elbcdNHd4I9GjOfTJjKC88
	wkZBFYf0JHpn6XktUOU9u21qt/lJg5cBAMmhxRMLH4istfL6hPYJ4v0wx2zBt4DJncy6+D
	CVw+ubMhRZCBDN+CgujzY3D9/AknvCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750422437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/Yy654QcQTRuj4MwSbC85PZYTXBTs5gVtteaaVNdCM=;
	b=x1VXfJZvbm/mvW4K1jPVQA2PhFlatnIlRiFi2Xb7YLFpsO/BKP8xvfLntSPV5e/wEp5c5D
	vyfJy1YIyjMN4CBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 130BF136BA;
	Fri, 20 Jun 2025 12:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PoZwBKVTVWjXJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 12:27:17 +0000
Date: Fri, 20 Jun 2025 14:27:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, kees@kernel.org, ailiop@suse.com,
	Mark Harmstone <mark@harmstone.com>
Subject: Re: [PATCH v3] btrfs: replace deprecated strcpy with strscpy
Message-ID: <20250620122715.GR4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250619153904.25889-1-listout@listout.xyz>
 <20250620014344.27589-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620014344.27589-1-listout@listout.xyz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 32E1B1F38D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Jun 20, 2025 at 07:13:44AM +0530, Brahmajit Das wrote:
> strcpy is deprecated due to lack of bounds checking. This patch replaces
> strcpy with strscpy, the recommended alternative for null terminated
> strings, to follow best practices.
> 
> There are instances where strscpy cannot be used such as where both the
> source and destination are character pointers. In that instance we can
> use sysfs_emit or a memcpy.
> 
> Update in v2: using sysfs_emit instead of scnprintf
> Update in v3: Removed string.h in xattr, since we are not using any
> fucntions from string.h and fixed length in memcpy in volumes.c

This should be placed under the "---" marker. If it's a new information
relevant for the patch then it should be a normal part of the changelog.

> No functional changes intended.

No need to write this.

> 
> Link: https://github.com/KSPP/linux/issues/88

No newline here.

> Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
> Suggested-by: Mark Harmstone <mark@harmstone.com>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>

Otherwise it looks good, thanks.

