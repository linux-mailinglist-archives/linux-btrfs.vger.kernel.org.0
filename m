Return-Path: <linux-btrfs+bounces-13521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8EAA11B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 18:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FFC171C8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82032459EE;
	Tue, 29 Apr 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ysh2QXF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5kD0T9o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUDm2XRi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4b4OAVl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D05221719
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944712; cv=none; b=j/4QIM8ewpGDynPKuSIm3iz1uKIkFImTFFio53eCfuCnfcMwMkoVNeeCb7xz9s7IDArnUyFqHBpIsYxpUl9zIm4RP8ov13imGV679/DiE5o5KjBq3iIo3v1qIFHstVjDv2GgDNG3MEsGRzqdFaPe/+bHSMYZ1hVGy2IYLiVnUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944712; c=relaxed/simple;
	bh=nEGzAf3xlnNUOzIrozANefXaQtztId5Jho+8cusXuPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYlc1DDqpKpalTZwgWwfWfrAe9HfVVCRAZqNM33Qjx/pz97hF7dQM4R3Pn0aLjYkjq5lJgPuTpGekiF2PAsBHkfWbxuvQjnzC83xXsN9kvLK48dWMo11IXcZRVY0GPnUrZvFgzVNJNiNveF7/S3FmqtJDh2Kf7/LGz1BzMF3JSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ysh2QXF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M5kD0T9o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUDm2XRi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o4b4OAVl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4F661F791;
	Tue, 29 Apr 2025 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745944708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHnZBJ3YZXI7bhZlfq3uZS/BsUojys+7NiMbqSeWpEA=;
	b=1ysh2QXFwkeDwmoKySA0yH8P9GPyFww1Xvmt1u624C6Z1T2eKpXtj7PFr5C5K9/I43jLb7
	VWJQM80kVympLyFHWpnNycfbwdIpiFMhcMHL47M2zm/yJwm9CrSgMrQLBUwVwZSoc3iY+c
	FPiMwvvVRiNP7O291RIhudjw5f1LwpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745944708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHnZBJ3YZXI7bhZlfq3uZS/BsUojys+7NiMbqSeWpEA=;
	b=M5kD0T9oYRn/wwHb/ch72olcpVvpZZovt6HbYgBXhuW5pqkKO5FacmVlBQCbJtrfX/wYvh
	VToyGb0F5iRUfzAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oUDm2XRi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o4b4OAVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745944707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHnZBJ3YZXI7bhZlfq3uZS/BsUojys+7NiMbqSeWpEA=;
	b=oUDm2XRi9dNPLAppEGILSIY2B6DdVLRxXvX0C/82x1+Pa3nzYG2I4Iyr8EmCaYvLPcfxP3
	Tmd1to1r8/oD5XQ4+ZviLQ1HDXBZIfoYU83uiIl6AsujSAS0VlVgweUvKpHJFEyQJWoMbJ
	KCw/Brd8Lizcdnf5GkxhYrfPI02WNS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745944707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHnZBJ3YZXI7bhZlfq3uZS/BsUojys+7NiMbqSeWpEA=;
	b=o4b4OAVl+ay0LJWHoEMNIhvsJWzul3S5zT6lSFOP4I/yM3NhOAy3YzmtZ2JWnf73d8U7ye
	tXKQb9+Wy1OhitDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6C7713931;
	Tue, 29 Apr 2025 16:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wVtXMIMAEWhWJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 16:38:27 +0000
Date: Tue, 29 Apr 2025 18:38:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] Revert "btrfs: canonicalize the device path before
 adding it"
Message-ID: <20250429163822.GE9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d944d52aa8635cb860dd68adaf30a64e116294d9.1745920244.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d944d52aa8635cb860dd68adaf30a64e116294d9.1745920244.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E4F661F791
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 29, 2025 at 07:20:48PM +0930, Qu Wenruo wrote:
> This reverts commit 7e06de7c83a746e58d4701e013182af133395188.
> 
> Commit 7e06de7c83a7 ("btrfs: canonicalize the device path before adding
> it") tries to make btrfs to use "/dev/mapper/*" name first, then any
> filename inside "/dev/" as the device path.
> 
> This is mostly fine when there is only the root namespace involved, but
> when multiple namespace are involved, things can easily go wrong for the
> d_path() usage.
> 
> As d_path() returns a file path that is namespace dependent, the
> resulted string may not make any sense in another namespace.
> 
> Furthermore, the "/dev/" prefix checks itself is not reliable, one can
> still make a valid initramfs without devtmpfs, and fill all needed
> device nodes manually.
> 
> Overall the userspace has all its might to pass whatever device path for
> mount, and we are not going to win the war trying to cover every corner
> case.
> 
> So just revert that commit, and do no extra d_path() based file path
> sanity check.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20250115185608.GA2223535@zen.localdomain/
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

No objection to revert this, I agree that we can't handle every path
format from user space, with the only exception which is device mapper
and the known prefix /dev/mapper.

With the information that Boris got at LSF we're sure this cannot work
for containers, I don't see anything about that in the changelog and
this would be good to add.

Also I think the reverted patch is in some stable tree (6.12) so we also
want to revert it there.

