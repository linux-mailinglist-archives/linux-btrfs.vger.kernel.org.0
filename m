Return-Path: <linux-btrfs+bounces-5180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC468CB350
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F221F2279F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B77C6C0;
	Tue, 21 May 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HkZN//Oj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFHtO5BC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HkZN//Oj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFHtO5BC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF023775
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315008; cv=none; b=EdHzO7N64fh9RV+7ffu6qv2inZSfNzqZld+pYKOOlV4BbiBU7H+oGrUeGTpMgdjx18nuhU1pcP+iftBpFTC3D4P7i1AC/xVf0lAJESfb+eVKc+GfNZCuSg00a7x+Y5EWgqYneQ3V2OaOmExCN4HEZkUOoNhKfienw53MGIKYU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315008; c=relaxed/simple;
	bh=FKsp5eBrcI6dk+0TBvliJEtkf0ObCnyuLM7Hx6dk7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfMmuU/LJmMBb7kSLkppH0rgTPRs2dY+MKGJ6mZ/gh461+KDJNNi6rVqAysfbNz6W0wsEs65aMZVPrmvOu59uCA0jBT5szED/zde85vqdjif0B9TWwboPttQh4FUTX0Dyebr4+4SdNEcm9Z+4TCI8ZF7bjDD9+aTbBhYmpT4hBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HkZN//Oj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFHtO5BC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HkZN//Oj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OFHtO5BC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB525C33D;
	Tue, 21 May 2024 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716315004;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVTicdw0DumwJjyWKQaWYv4nfaPDANqcGgMtQFKkNQ8=;
	b=HkZN//OjwDBrnB5DT9v/AnOHFOm0qYrnaObns3cJk+z4FggJ+t9MvBnOqqE4MR2ZAbrck6
	iF/DpnR+PyL0wHVzBrii5E2GyHnGjFPWXLJJNxAPtFY9mNql2LQMf6T9oZHjgBPXz9Qvre
	4Lx5pK0oyj2WiFUZqzFCx8JBvKo0MkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716315004;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVTicdw0DumwJjyWKQaWYv4nfaPDANqcGgMtQFKkNQ8=;
	b=OFHtO5BC3LZOFvoi0CDhOscR308QYWIrV9tVxGTO1z/hESxnz71++NWBNrKoRl4SyInT9L
	rRFYbFXzPN8qIZBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="HkZN//Oj";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OFHtO5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716315004;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVTicdw0DumwJjyWKQaWYv4nfaPDANqcGgMtQFKkNQ8=;
	b=HkZN//OjwDBrnB5DT9v/AnOHFOm0qYrnaObns3cJk+z4FggJ+t9MvBnOqqE4MR2ZAbrck6
	iF/DpnR+PyL0wHVzBrii5E2GyHnGjFPWXLJJNxAPtFY9mNql2LQMf6T9oZHjgBPXz9Qvre
	4Lx5pK0oyj2WiFUZqzFCx8JBvKo0MkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716315004;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVTicdw0DumwJjyWKQaWYv4nfaPDANqcGgMtQFKkNQ8=;
	b=OFHtO5BC3LZOFvoi0CDhOscR308QYWIrV9tVxGTO1z/hESxnz71++NWBNrKoRl4SyInT9L
	rRFYbFXzPN8qIZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77B3E13A1E;
	Tue, 21 May 2024 18:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d4IXHXzjTGYxagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 18:10:04 +0000
Date: Tue, 21 May 2024 20:10:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/6] part3 trivial adjustments for return variable
 coding style
Message-ID: <20240521181003.GT17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716310365.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8CB525C33D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed, May 22, 2024 at 01:11:06AM +0800, Anand Jain wrote:
> This is v4 of part 3 of the series, containing renaming with optimization of the
> return variable.
> 
> v3 part3:
>   https://lore.kernel.org/linux-btrfs/cover.1715783315.git.anand.jain@oracle.com/
> v2 part2:
>   https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
> v1:
>   https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/
> 
> Anand Jain (6):
>   btrfs: rename err to ret in btrfs_cleanup_fs_roots()
>   btrfs: rename ret to err in btrfs_recover_relocation()
>   btrfs: rename ret to ret2 in btrfs_recover_relocation()
>   btrfs: rename err to ret in btrfs_recover_relocation()
>   btrfs: rename err to ret in btrfs_drop_snapshot()
>   btrfs: rename err to ret in btrfs_find_orphan_roots()

1-5 look ok to me, for patch 6 there's the ret = 0 reset question sent
to v3.

