Return-Path: <linux-btrfs+bounces-5155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8274E8CAEBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47E81C217A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1AC77105;
	Tue, 21 May 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYHtzynz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Smz+YKmv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYHtzynz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Smz+YKmv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EE770EA;
	Tue, 21 May 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296311; cv=none; b=bEY70RGcTncZ0s6V1OLOYRYEerZ4QN3+Zmvhz3c08UtxqczVIBhfuIAZgP4bZ0FOtbGCIcAvV2po5n1qwjixAanMUXT9qbZRxlzD81VY26VK1uDHvH2GiZ4ARaYWcg5SoFuMNvxvevJR1worvJFAb7uCDSokQTV60JoX41rS0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296311; c=relaxed/simple;
	bh=HHypZsZ2gude7se7wb6RdQ4cek06b+OMtcgXTaUrFDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijLgUquwp3+L+/oXuXz+soAm5CGOS+yCzK/oACW1m6KB1tCPnwBD5rueQW+HTTgk04w+QqF3ZiXo+FZoWv3uGaLDbOaulVG8YCsFDM2uikojok5YBOhqArQw0FyQsPUumYiZBjguPBJfa1gs266SBDxqG7d2zVW0mxRBfqjc4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYHtzynz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Smz+YKmv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYHtzynz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Smz+YKmv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 054015C15B;
	Tue, 21 May 2024 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716296307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH70FHQzDa0nL4mkvouw/yu/6DVP0Lo0xDpFiuRDdQk=;
	b=lYHtzynzPrf//VH1k2hLJAyAYZkxwLzVlDZQAawzK3IEWsk0WPmOPLOrS/1JuWh0jNzNcH
	iZO9f4UQlO64bnAL1SAyTq9uofk7Hkp3mwPqbO5xnzrvwEyKc0cWsCaYULFcptcd+endMJ
	KR1RfXSnqOv7fMlkVnQvQzp5DeBZsVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716296307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH70FHQzDa0nL4mkvouw/yu/6DVP0Lo0xDpFiuRDdQk=;
	b=Smz+YKmvZcO4ZOGvLU0Um2qNR+BIVj0eKOEsD0NCW/Gxh/Y18KS/W+WraRt73omX09He8T
	FcaUAET16s4ptaDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716296307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH70FHQzDa0nL4mkvouw/yu/6DVP0Lo0xDpFiuRDdQk=;
	b=lYHtzynzPrf//VH1k2hLJAyAYZkxwLzVlDZQAawzK3IEWsk0WPmOPLOrS/1JuWh0jNzNcH
	iZO9f4UQlO64bnAL1SAyTq9uofk7Hkp3mwPqbO5xnzrvwEyKc0cWsCaYULFcptcd+endMJ
	KR1RfXSnqOv7fMlkVnQvQzp5DeBZsVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716296307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH70FHQzDa0nL4mkvouw/yu/6DVP0Lo0xDpFiuRDdQk=;
	b=Smz+YKmvZcO4ZOGvLU0Um2qNR+BIVj0eKOEsD0NCW/Gxh/Y18KS/W+WraRt73omX09He8T
	FcaUAET16s4ptaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB63313A1E;
	Tue, 21 May 2024 12:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llVJOXKaTGYkdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 12:58:26 +0000
Date: Tue, 21 May 2024 14:58:25 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/733: add commit ID for btrfs
Message-ID: <20240521125825.GJ17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, May 21, 2024 at 01:01:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> As of commit 5d6f0e9890ed ("btrfs: stop locking the source extent range
> during reflink"), btrfs now does reflink operations without locking the
> source file's range, allowing concurrent reads in the whole source file.
> So update the test to annotate that commit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

