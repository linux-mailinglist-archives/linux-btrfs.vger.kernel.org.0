Return-Path: <linux-btrfs+bounces-19125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345FC6D574
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 05DE023EF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 08:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F3C312801;
	Wed, 19 Nov 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CXMMemIK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17rxa3QM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AMfB2uBx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BwpSWKhd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7B2E7F1E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540029; cv=none; b=G9Wd18aDzWpHcN1zVl6AWjhpjQoap+XoPKiYISyFtNg4yBVfPNbGVLGJGRmj3wybS8icHoj/DJlXOLEwIFC53WhFbHgFMOawJ60AYQnYEQ6QnFPRhiLXz35+G9HmlMD5FgeRntAx94N6Ksp0uUzOFE/5yjlxGEh0sUkcxv2cTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540029; c=relaxed/simple;
	bh=Jwft+xQj77Y8Yb3OCHRfOocZIFttLJ0VBLLzGUKsgLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6KiPYy3/gRHKA3biLsVgnG5UiAGzTIQQo4/8enGgptAhql54Kbzk6wuFfqI9r8vVq0qwemt6vQKj8xyCngm6Nx4HUiHl44xt6JqTjqQkPw/V9T6SjjrW36fG8pY5ODaNdrjmY1nUGad5WudvDg2wKue/J0pAVidhmoxSMoRYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CXMMemIK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=17rxa3QM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AMfB2uBx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BwpSWKhd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA62720320;
	Wed, 19 Nov 2025 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763540026;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qczyc9c8qkfsToCJ6e12YbnxdnJHVEAHIP4DmP03mLs=;
	b=CXMMemIKUCAG2iDMcW0Y9aNm2BfI2HG1M7lSWQEYWV7xaCqvvf10jkLBPrYg68rY/hu3mo
	gjSg3qCX55W/Wbh57FqRJNu9DaiQgTEByBjDXYFngLUvmzbd6A2a69vbO+XkhKX79hpShG
	0tqLaOS7LBpbBIIKvVgLozRTiv40ciQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763540026;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qczyc9c8qkfsToCJ6e12YbnxdnJHVEAHIP4DmP03mLs=;
	b=17rxa3QMyWjF/f/QDkUqoLEiyOaeoDBuN+jt+5d8oLS1WGPY1Feveq5BdaOH/YJnQUAYyH
	/vcGT5Xz7YXD8LCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AMfB2uBx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BwpSWKhd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763540025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qczyc9c8qkfsToCJ6e12YbnxdnJHVEAHIP4DmP03mLs=;
	b=AMfB2uBxPXQBi2wYwvpNgfm0z7vX+U31H7nyffKraqt02icuZMpLvJsXP7g38iM3hmwlKm
	4hVER9HBhZLPC0hLTJ1kJ0rkX7Eg48aYoCIL6rNWTfJL5Ylxb83eTAkSBuVBRgZmgJrvUA
	EfYaouOYPOzOHUHgUbn3snKko0mMrqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763540025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qczyc9c8qkfsToCJ6e12YbnxdnJHVEAHIP4DmP03mLs=;
	b=BwpSWKhdJdiDW3bSV9X3tQzSvKNik5+1gqHlG3W1Fht/g7VEpgHit9r2zWkvPR043b80Cq
	AMO4duzYPGfkx6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D86CA3EA61;
	Wed, 19 Nov 2025 08:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wgGwNDl8HWnMCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 08:13:45 +0000
Date: Wed, 19 Nov 2025 09:13:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: add raid56 support for bs > ps cases
Message-ID: <20251119081336.GB13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763361991.git.wqu@suse.com>
 <20251118151533.GX13846@twin.jikos.cz>
 <d381f2e2-ee08-4055-b91e-e1e0362d18d6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d381f2e2-ee08-4055-b91e-e1e0362d18d6@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EA62720320
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Wed, Nov 19, 2025 at 07:40:50AM +1030, Qu Wenruo wrote:
> 在 2025/11/19 01:45, David Sterba 写道:
> [...]
> >>
> >> The long term plan is to test bs=4k ps=4k, bs=4k ps=64k, bs=8k ps=4k
> >> cases only.
> > 
> > Yes the number of combinations increases, I'd recommend to test those
> > that make sense. The idea is to match what could on one side exist as a
> > native combination and could be used on another host where it would have
> > to be emulated by the bs>ps code. E.g. 16K page and sectorsize on ARM
> > and then used on x86_64. The other size to consider is 64K, e.g. on
> > powerpc.
> > 
> > In your list the bs=8K and ps=4K exercises the code but the only harware
> > taht may still be in use (I know of) and has 8K pages is SPARC. I'd
> > rather pick numbers that still have some contemporary hardware relevance.
> 
> The bs > ps support has a hidden problem, a much higher chance of memory 
> allocation failure for page cache, thus can lead to false alerts.
> 
> E.g. ps = 4k bs = 64k, the order is 4, beyond the costly order 3, thus 
> it can fail without retry.
> 
> Maybe that can help us exposing more bugs, but for now I'm sticking to 
> the safest tests without extra -ENOMEM possibilities.

I see, this could make the testing pointless.

> It can be expanded to 16K (order 2) and be more realistic though.

Yes 16K sounds as a good compromise.

> Although bs > ps support will be utilized for possible RAIDZ like 
> profiles to solve RAID56 write-holes problems, in that case bs > ps 
> support may see more widely usage, and we may get more adventurous users 
> to help testing.

In such case we'd have to increase the reliability of allocations by
some sort of caching or emergency pool for the requests. The memory
management people maybe have some generic solution as the large folios
usage is on the rise and I don't think the allocation problems are left
to everybody as a problem to solve.

