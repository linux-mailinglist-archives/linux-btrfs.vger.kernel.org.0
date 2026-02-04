Return-Path: <linux-btrfs+bounces-21362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHj0NYxag2mJlQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21362-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 15:41:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A454E73CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0499A302E931
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9060B41B352;
	Wed,  4 Feb 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SnDQn9tu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u08NVjXt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SnDQn9tu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u08NVjXt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4312459C6
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216010; cv=none; b=OaMSVtMAlxhTbqSqno4dKoiwgKdSqc2Y/MZFzeZTCGiDhpQm1ukTsecRZ24egEm+okqJk3VanscYNYAWN4UMYIEKV8l5AVb2LYTH1kn5jk15W5Zc29yKpXdUxea6j0Vi/h7ogAy6nmkmT7x8dek0QUF4JmI4zWEO62nfrUKbijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216010; c=relaxed/simple;
	bh=ASIU25GiiX+wnCxHbKUApUSAy+LAjIuMGR0n3OCqZWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTeD6eEf1JOIyKiGQkpj9F1I/F1Q18l64CwS95Y138/LqbE6Dia6831LCgzqxI99BxahtwUkx9EoqTpxB826C98k18iCyW+tglY3Cl6JDgqPJff6VnG609rafouFb/m/WZEfg17SjIJwduazcE4gxOH6V4qXbcrwFEzHzhIM5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SnDQn9tu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u08NVjXt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SnDQn9tu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u08NVjXt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB26E5BCE8;
	Wed,  4 Feb 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770216007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaqO2nRy8RCtP7aeIIMb34Nhyk8V5UA6bkEU4t4xEFs=;
	b=SnDQn9tuJwHRDKhectCcEl34xXa9cUgN9A3FH+LOqAZw0NjI1/AB9Z/QwowvROdtrrGGEU
	I3Gf9hQqWNSsMAQLYaaq9nlH7K0vyuDrLa9X/j0Z1yXfulaeeNAkjarMhfpGx0CI2RBRWM
	/m18nhD0sKKjIzplefzxrxlSFQygbxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770216007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaqO2nRy8RCtP7aeIIMb34Nhyk8V5UA6bkEU4t4xEFs=;
	b=u08NVjXtJoVvlOFbv0lXxdG8o9gdxgsUKSygveTTX598q4dSw6TVB8Wf2Bx+MaTSZMTowX
	GZLqLmAOU8CA7UAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SnDQn9tu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u08NVjXt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770216007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaqO2nRy8RCtP7aeIIMb34Nhyk8V5UA6bkEU4t4xEFs=;
	b=SnDQn9tuJwHRDKhectCcEl34xXa9cUgN9A3FH+LOqAZw0NjI1/AB9Z/QwowvROdtrrGGEU
	I3Gf9hQqWNSsMAQLYaaq9nlH7K0vyuDrLa9X/j0Z1yXfulaeeNAkjarMhfpGx0CI2RBRWM
	/m18nhD0sKKjIzplefzxrxlSFQygbxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770216007;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaqO2nRy8RCtP7aeIIMb34Nhyk8V5UA6bkEU4t4xEFs=;
	b=u08NVjXtJoVvlOFbv0lXxdG8o9gdxgsUKSygveTTX598q4dSw6TVB8Wf2Bx+MaTSZMTowX
	GZLqLmAOU8CA7UAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943F43EA63;
	Wed,  4 Feb 2026 14:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8YIHJEdag2n5dgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Feb 2026 14:40:07 +0000
Date: Wed, 4 Feb 2026 15:40:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: naohiro.aota@wdc.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Message-ID: <20260204144006.GT26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <DFOC3S5F0LN3.158CDRO798GJ8@wdc.com>
 <20260114144450.48776-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114144450.48776-1-jiashengjiangcool@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-21362-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A454E73CA
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 02:44:50PM +0000, Jiasheng Jiang wrote:
> In do_allocation_zoned(), the code acquires space_info->lock before
> block_group->lock. However, the critical section does not access or
> modify any members of the space_info structure. Thus, the lock is
> redundant as it provides no necessary synchronization here.
> 
> This change simplifies the locking logic and aligns the function with
> other zoned paths, such as __btrfs_add_free_space_zoned(), which only
> rely on block_group->lock. Since the 'space_info' local variable is
> no longer used after removing the lock calls, it is also removed.
> 
> Removing this unnecessary lock reduces contention on the global
> space_info lock, improving concurrency in the zoned allocation path.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Added to for-next, thanks.

