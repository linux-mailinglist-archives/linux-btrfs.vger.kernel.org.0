Return-Path: <linux-btrfs+bounces-11734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BECA4196F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F994165EC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01612475D0;
	Mon, 24 Feb 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUhI3ofY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQuuiImj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUhI3ofY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQuuiImj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62211241CA6
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390316; cv=none; b=l+9e80zHr/AUd7XdZWPlq8RI+0MPWIdDj+AFmARe6AgB2U2BxMoI1ZXS4gdodpjYoMEr+9Epsgtm5ep4GoZR4iZKliBCC85XC5w9tZ6lG5sl8HJfjG4ngmn0emFsVXFGj4afKNyaeuFLvCFouTzADLlfmJaBISlNbd7MEDmxKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390316; c=relaxed/simple;
	bh=/y4a2t2D0Vi5lomJPcZZ9442t54hDvF7SExTVfrLLhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Mqf9OMRgsyRv05NS0IKWHKFOaEmquDXRwUa+iCdt4RP8mwwnX19cfTY/y/7LTddC+QQ5lD3fVNPa7idUEizSWNUkVfJfFsEL9qRimP5QpOvayG8RzuxlZ4EZlwX+m1GsO887EBD+53LhhPSMk5+GEUDaaU7i49O/V/KmWfWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUhI3ofY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQuuiImj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUhI3ofY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQuuiImj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65A8D1F385;
	Mon, 24 Feb 2025 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740390312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBLSS1gkJN060FTnQnccFnH/9i68QNBPjHnK3RxjUak=;
	b=zUhI3ofYGISKLOqUBTksCS/SnsBs5FdUWUu9lDueZpSX6N4eu3qxJ/UbFYmldjd7rB26Nh
	2UWXfNxfLQhhfBeTX835VJ837hRPAG1hMrxx0CxlunhNCKNnqpMmz7F5FH3Xg2TdTJERet
	dj8WeOvireMhrX0Y8sIbU2j+BnWiFDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740390312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBLSS1gkJN060FTnQnccFnH/9i68QNBPjHnK3RxjUak=;
	b=qQuuiImjeepAYxUfzPrJissfvHFFycbxZOlxMcX439tvRooAKzev+NU6o41TByAy08gJQt
	IHdBfDBBTxd9vMBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zUhI3ofY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qQuuiImj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740390312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBLSS1gkJN060FTnQnccFnH/9i68QNBPjHnK3RxjUak=;
	b=zUhI3ofYGISKLOqUBTksCS/SnsBs5FdUWUu9lDueZpSX6N4eu3qxJ/UbFYmldjd7rB26Nh
	2UWXfNxfLQhhfBeTX835VJ837hRPAG1hMrxx0CxlunhNCKNnqpMmz7F5FH3Xg2TdTJERet
	dj8WeOvireMhrX0Y8sIbU2j+BnWiFDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740390312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBLSS1gkJN060FTnQnccFnH/9i68QNBPjHnK3RxjUak=;
	b=qQuuiImjeepAYxUfzPrJissfvHFFycbxZOlxMcX439tvRooAKzev+NU6o41TByAy08gJQt
	IHdBfDBBTxd9vMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42C8B13707;
	Mon, 24 Feb 2025 09:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id avoYEKg/vGeGagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Feb 2025 09:45:12 +0000
Date: Mon, 24 Feb 2025 10:45:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Ma Ke <make24@iscas.ac.cn>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, fdmanana@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root in
 btrfs_next_old_leaf()
Message-ID: <20250224094511.GK5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250224075937.2959546-1-make24@iscas.ac.cn>
 <0d9f6477-04c2-486a-ae72-c39b6d235891@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d9f6477-04c2-486a-ae72-c39b6d235891@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 65A8D1F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Feb 24, 2025 at 06:48:19PM +1030, Qu Wenruo wrote:
> 在 2025/2/24 18:29, Ma Ke 写道:
> > btrfs_next_old_leaf() doesn't check if the target root is NULL or not,
> > resulting the null-ptr-deref. Add sanity check for btrfs root before
> > using it in btrfs_next_old_leaf().
> 
> Please provide a real world call trace when this is triggered.
> 
> There is a prerequisite, the extent tree can only be NULL if
> rescue=ibadroots is provided and the extent root is corrupted.
> 
> And "rescue=" mount options can only be specified for a fully read-only
> fs (no internal log replay or any other thing to write even a bit into
> the fs).
> 
> Previously read-only scrub can still be triggered on such fs, but
> 6aecd91a5c5b ("btrfs: avoid NULL pointer dereference if no valid extent
> tree") fixed that.
> 
> And if you hit such a case in real world, please provide the call trace
> so that we know we're not missing some critical situations that extent
> tree is accessed for read-only operations.

Agreed, this needs a real way to trigger it. Some pointers do not have
to be checked for NULL because it's guaranteed by some of the caller
higher up in the call chain.

Before we added the rescue options, the invariants were that the extent,
checksum, fs_tree etc always exist when passed as pointers. The example
fix 6aecd91a5c5b show it could be possible under some circumstances. So
if a fix is needed btrfs_next_old_leaf() we also need to see how it
could happen.

