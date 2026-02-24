Return-Path: <linux-btrfs+bounces-21890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PLnDtffnWnaSQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21890-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:28:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D418A879
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 601ED30862F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EAF3A961E;
	Tue, 24 Feb 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDsX07VY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSKXqo/0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDsX07VY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSKXqo/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CC39E6C1
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954120; cv=none; b=VjoTk6Sbe9lOhXyv8HJrWxg0HYK/Jrj00NjkxcPpFORHoKv41YtsWQs0xhDj6+1LG67RS9mSQkOnqtFf3kithLhu1vJQKqw0qVkzwcdNDm+CM/c0+oox2VBQ41B7iMaZnYNBq2b5AXVeqBR3eF/Gay7Pzh7pYNCiH6gX2CdHc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954120; c=relaxed/simple;
	bh=ybY9oxOD2rkYCdORURtwSupm7xDyH4NQxrdfD0rtT4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIzCnKAfMQ+egeNNuHlT5DM4xIvuturu5cTjIqBf4JwlGUlynQMqrupW87xKxRom5D/nT0fw5rvyVL/FtwCLxXz8JggrD7PlglecNy+brC/G2DvoOcST9q442uU0mcJBEFcNZ+k/PIs+0vbW9jj8HkD+MqmE0WsCaVuC71IEX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDsX07VY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSKXqo/0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDsX07VY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSKXqo/0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EA2F3F330;
	Tue, 24 Feb 2026 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771954117;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/R4q3yojJVMVUcSdS7HYY4dVNoIu9X9QZs1KeeRpoE=;
	b=VDsX07VYzYuD8THghUGfcBSM/hc1h9UCfNjJjK/LclZUwNBUgVn8RbNBPbLUnAfoSsRKaB
	t8lXZ0+wftK4D4DGq5gGlofz893wTluhTaZE8A4UZCHbpnkkelY4G2mJZRrdFNGeyx3Tgm
	FprQ3cK+NDpJ+6c8irqJYujkDwQPUVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771954117;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/R4q3yojJVMVUcSdS7HYY4dVNoIu9X9QZs1KeeRpoE=;
	b=lSKXqo/06oEI5k9W6JS4vBVa6+ikFRe+ThN8ascnQAi8/Q6WzP9PaDhALFE9Qj4+9iqGFT
	j9K1/sFoJzYTnXBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771954117;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/R4q3yojJVMVUcSdS7HYY4dVNoIu9X9QZs1KeeRpoE=;
	b=VDsX07VYzYuD8THghUGfcBSM/hc1h9UCfNjJjK/LclZUwNBUgVn8RbNBPbLUnAfoSsRKaB
	t8lXZ0+wftK4D4DGq5gGlofz893wTluhTaZE8A4UZCHbpnkkelY4G2mJZRrdFNGeyx3Tgm
	FprQ3cK+NDpJ+6c8irqJYujkDwQPUVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771954117;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/R4q3yojJVMVUcSdS7HYY4dVNoIu9X9QZs1KeeRpoE=;
	b=lSKXqo/06oEI5k9W6JS4vBVa6+ikFRe+ThN8ascnQAi8/Q6WzP9PaDhALFE9Qj4+9iqGFT
	j9K1/sFoJzYTnXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A863EA68;
	Tue, 24 Feb 2026 17:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /YtRBcXfnWn4DAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 17:28:37 +0000
Date: Tue, 24 Feb 2026 18:28:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Burenchev Evgenii <EBurenchev@orionsoft.ru>
Cc: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"mssola@mssola.com" <mssola@mssola.com>,
	"fdmanana@kernel.org" <fdmanana@kernel.org>
Subject: Re: [PATCH] btrfs: perform a minor cleanup in
 btrfs_search_path_in_tree()
Message-ID: <20260224172835.GB26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5a31d815257543b689373583411428b0@orionsoft.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a31d815257543b689373583411428b0@orionsoft.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-21890-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE4D418A879
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 05:55:32PM +0000, Burenchev Evgenii wrote:
> After the introduction of btrfs_search_backwards(), the directory
> traversal state in btrfs_search_path_in_tree() is fully maintained via
> struct btrfs_key. The local variable 'dirid' is no longer used to control
> the search and the assignment
> 
>     dirid = key.objectid;
> 
> has no observable effect and is dead code.
> 

Can you please split the patch to 1) remove the dirid assignment (v1 of
this patch) and 2) the return cleanup? It's two changes, the dead code
is trivial, but the return code should match some pattern we're using.

Sometimes the explicit 'ret = 0' is there to make it clear there's no
stale error code being propagated out of the function, but in this case
I don't se a reason for it.

Thanks.


