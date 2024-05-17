Return-Path: <linux-btrfs+bounces-5073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E48C8A1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2711C21721
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB512FB3C;
	Fri, 17 May 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NkdCAHFD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGCconfT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NkdCAHFD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGCconfT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A512CDB6
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963343; cv=none; b=uMyIXbn3Mm/vfytaUeULHeHaqDDnstTgjIx8fRjO7uwPl+q3qKyp+rsj7C6/wKGS7JmANKA0DbibrFh4UkRFsd08bbRkphOStRlA264mOh4jyHsoR+RojJjam2L5OLbMiCFQ+mzMyNJQIxjfDWaugMvn4SF/oxbc7eVHlsM+ALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963343; c=relaxed/simple;
	bh=lZHM87geJr6lZ6FRE/H4Bh3LaaezccN6mqxh9ule4c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4qiVwENliBqPC4kwAKzXo7SIrxQut13zpudlX0cjClwII6iXm3OigtwKG1gXGyM6ljhGBDbm4UGV1Jxc9TnM32xe+lwxJKnNMZ7gtEt3UTGvGH09wUWGki0QznegkmZqVLRJxlf27+ok/wRf5KnRIElVdivthYgmvg+UVt5Wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NkdCAHFD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGCconfT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NkdCAHFD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGCconfT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42BF85D595;
	Fri, 17 May 2024 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715963340;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oY4Tdk7WpVW2P9XH73jtxIp8SXLfSKgEsA9elPTejts=;
	b=NkdCAHFDrQHbrEv4JgG/tDxW275Z1Z9BtCBHBCjOkz3qCAWym0sokBJMknuLSHvhfiKH4S
	B1xQn1tSWl3Bw4B+KZeJ1UguheIXy3sinmx+BhfCrZ6ojdxYov/pXQ5DbEam/QVpd5AZep
	hthkSk0nzE0FVX3nBVZ6cPR8xPtP3Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715963340;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oY4Tdk7WpVW2P9XH73jtxIp8SXLfSKgEsA9elPTejts=;
	b=JGCconfTfGrFlk3iUHDd4+g0hgBeTXN6ou4N+Mb6crY+DshmUc45bwY6hbGm8voGIFrRfm
	U7GFcHeKcSLCi5Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715963340;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oY4Tdk7WpVW2P9XH73jtxIp8SXLfSKgEsA9elPTejts=;
	b=NkdCAHFDrQHbrEv4JgG/tDxW275Z1Z9BtCBHBCjOkz3qCAWym0sokBJMknuLSHvhfiKH4S
	B1xQn1tSWl3Bw4B+KZeJ1UguheIXy3sinmx+BhfCrZ6ojdxYov/pXQ5DbEam/QVpd5AZep
	hthkSk0nzE0FVX3nBVZ6cPR8xPtP3Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715963340;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oY4Tdk7WpVW2P9XH73jtxIp8SXLfSKgEsA9elPTejts=;
	b=JGCconfTfGrFlk3iUHDd4+g0hgBeTXN6ou4N+Mb6crY+DshmUc45bwY6hbGm8voGIFrRfm
	U7GFcHeKcSLCi5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 343C713942;
	Fri, 17 May 2024 16:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cw+IDMyFR2YwcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 May 2024 16:29:00 +0000
Date: Fri, 17 May 2024 18:28:55 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix a bug in the direct IO write path for
 COW writes
Message-ID: <20240517162854.GE17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715798440.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715798440.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.935];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto]
X-Spam-Score: -3.99
X-Spam-Flag: NO

On Wed, May 15, 2024 at 07:51:45PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a bug in an error path for direct IO writes in COW mode, which can make
> a subsequent fsync log invalid extent items (pointing to unwritten data).
> The second patch is just a cleanup. Details in the change logs.
> 
> V2: Rework solution since other error paths caused the same problem, make
>     it more generic.
>     Added more details to change log and comment about what's going on,
>     and why reads aren't affected.
> 
> Filipe Manana (2):
>   btrfs: immediately drop extent maps after failed COW write
>   btrfs: make btrfs_finish_ordered_extent() return void

For the record, patches have been removed from for-next as the new code
does NOFS allocation in irq context (reproduced by btrfs/146 and
btrfs/160).

