Return-Path: <linux-btrfs+bounces-13035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65292A8A37C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A896A190017D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334092147EF;
	Tue, 15 Apr 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2i/TBdd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C2f+NnRO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWbIkYKG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7L6YSKO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFA1EEA59
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732602; cv=none; b=q26sKFiZX5+UAo/X+7XniZFS03I6R7T8qzeYu99/xvUNY+lEKUDdNTG8wKdWIvPfuQCiFA+SY+lXokzNGy1UsShLegZhC8K/0XFUSMaSPC/FHct9vWJ8XbUEryPZIIcmO229Tz2jyD2SNQ0xzzGurrvIOcJu1IrdQuX97N9oQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732602; c=relaxed/simple;
	bh=IZ+U8v9rh1hLgRUp5I0URlNU7myOqdEtMAr85kLKEKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm8RS/tLzIChxyOukE7raUVlSFa/j298EizuwCxzuH5OpviIfyFqugOA24bo0Xss0rNxuGDPEQKKQz0oUVGabJ24s3Mudi3a+htHMKYdEnOZx+u6g+Z8Kvy5PooPyxPNoDd2PmGp7mE0mbMDnksxdZMUvdQjo45a7w+KD/T/AmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2i/TBdd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C2f+NnRO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWbIkYKG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7L6YSKO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3CDE21165;
	Tue, 15 Apr 2025 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744732599;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGx2bdN5tK18FYIfsjgGTSlWmkMNkeVuZmn5qCwFEVg=;
	b=e2i/TBddCK35wityNMN4yC45osvBCWkKX6qN+V9E22T7oTMecoZOxV1E34kUgXqnnRf7l0
	S+C09oE82MgFOri5w6RmUgRt+3dk8Pzs/ZixSPyCjrNdkNBLmELpDST3mX5w3tOJINb0tE
	UTqv8L9ahZmIBeKprrOIgGymCy6LdNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744732599;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGx2bdN5tK18FYIfsjgGTSlWmkMNkeVuZmn5qCwFEVg=;
	b=C2f+NnRO2nVnO6rky6FqTc5p4GDvnSD5T9jLstgW2xMuqamxFApu9puE0nul81JUH2X7Ki
	nlCi/fTX4A9RDxAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jWbIkYKG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g7L6YSKO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744732598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGx2bdN5tK18FYIfsjgGTSlWmkMNkeVuZmn5qCwFEVg=;
	b=jWbIkYKG95PS1zauBxcuaXWIjdKN97n/mHWbRXwXi1Q3lg2YsmxEj6uueMuuZ/kMhq5QEs
	ZJtPBNnKraLAl37VsGLape7TgkYoVun3iBak6dubwZPIOoDFZG6aXfBd6zdELFkr+LHHd9
	43CSjdWfTSn7kBMm55VcYoZEVtKPLQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744732598;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mGx2bdN5tK18FYIfsjgGTSlWmkMNkeVuZmn5qCwFEVg=;
	b=g7L6YSKOpHRiQJ7ATmO6SMDupYNGzTEyKnmLtYTFKjiM1Xt0q+KFqzsA2pZjajA5AfU+Vx
	ozcr9ZwuKBPGfiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBB46139A1;
	Tue, 15 Apr 2025 15:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nCieLbaB/me8WAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 15:56:38 +0000
Date: Tue, 15 Apr 2025 17:56:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: frank.li@vivo.com, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	neelx@suse.com
Subject: Re: [PATCH 1/3] btrfs: get rid of path allocation in
 btrfs_del_inode_extref()
Message-ID: <20250415155637.GG16750@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250415033854.848776-1-frank.li@vivo.com>
 <3353953.aeNJFYEL58@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3353953.aeNJFYEL58@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D3CDE21165
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Apr 15, 2025 at 10:45:06PM +0800, Sun YangKai wrote:
> It seems a nice try to reduce path allocation and improve performance.
> 
> But it also seems make the code less maintainable. I would prefer to  have a 
> comment saying something like the @path argument is just for reuse the 
> btrfs_path allocation and only a released or empty btrfs_path should be used 
> here.

Yes, this should be there, though we use the pattern of passing existing
path to functions so this within what'd consider OK.

> Also, although the path passed is released, it seems the bit flags are still 
> passed, which makes the behavior of the functions a little different. But it 
> seems fine since those bit flags are never set in this code path.

Also a good point, the path should be in a pristine state, as if it were
just allocated. Releasing paths in other functions may want to keep the
bits but in this case we're crossing a function boundary and the same
assumptions may not be the same.

Release resets the ->nodes, so what's left is from ->slots until the the
end of the structure. And a helper for that would be desirable rather
than opencoding that.

