Return-Path: <linux-btrfs+bounces-14826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD73AE2025
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161101C21EF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2992E6123;
	Fri, 20 Jun 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EqFONSNM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rDyklLB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BgFkSb/b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WE2+55lV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87A283FE1
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437272; cv=none; b=PVeRaiWFQ3fptteHO6NyvaCz/+J5nN5U/8+hwG2tVdjVT5Sjj2EsEA3ARzSnska7zgGhua09CEdhslRZahLKoNQcrGE6gOQxqWJFzqJbAYxXmDaGvaiGmkal7C1hXj/CNAlmkyBgcbf/VORFVOGOfXOcr1r7Egu4lP+lmtZpobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437272; c=relaxed/simple;
	bh=NXotkGIWtKDVUpUpRfyvTXdYYi2cUpPkJ5p3OTHh87E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCjfJuWjIrFilmkrbpw2Br11oTG4QwqEEvJE9d1i9noFugC5U/fPOHDdIrFAtmDkgvWjRAcotvt3ByaoCSbZsrouFyr/BF9BytHdsoQqD0xseZ4vTlMTq6gKCOicPTVvdOJxV/WYuf9Hz4A8kg7qznp5MO0/BS2KrGj4sm3cda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EqFONSNM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rDyklLB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BgFkSb/b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WE2+55lV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F14D01F7C7;
	Fri, 20 Jun 2025 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750437269;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1wesOlAWomuBGtYZ8pA9jaL2XSjy8UrXwFwwR3dfcM=;
	b=EqFONSNMqCgaFhUlWBJvIUHZmhFEu7fioui/Etf7EDmvZcprZ8wxoS1V9MT+LFMuCxcvWD
	ivaEKERR6V2x7xQTFEK6GBuPaB8WetHteNwXmxmJZ5/YQjurjlStBVQq49m6tbuwQnavV4
	2oYJCAuNnUzW25XUQrkaLSW1naTjIGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750437269;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1wesOlAWomuBGtYZ8pA9jaL2XSjy8UrXwFwwR3dfcM=;
	b=8rDyklLBe0YOarXcuzs/igdOmrwwSWa3Ups7oK15igo4mLOywuyc26Kx6AEM1zoo6nEK1C
	2G18w0cFZ9rzrhDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750437268;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1wesOlAWomuBGtYZ8pA9jaL2XSjy8UrXwFwwR3dfcM=;
	b=BgFkSb/bvM2TZyFNaVd2MNU1zxmtF8DgRUJ0mDAz33itUasaVJ+o3cRR8oR3K+2nfObulh
	WsIBSZNfjempVqWWg+64b/CA8aWFgNetDWB8k8vXOusBA28SbLiM27fcVLP6Pe3C5dvkiD
	3Iwd0G0aaaoirAjowAtxnNTZvTh0JbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750437268;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1wesOlAWomuBGtYZ8pA9jaL2XSjy8UrXwFwwR3dfcM=;
	b=WE2+55lVgEugdq67qy496yK1M8XugR2gf47dBG95OHzjbq6lZx2Dy/EE8av7yD1i/TZsTA
	9IGYQlSQDlR4G+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C9B136BA;
	Fri, 20 Jun 2025 16:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UeLdM5SNVWivcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 16:34:28 +0000
Date: Fri, 20 Jun 2025 18:34:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com,
	anand.jain@oracle.com
Subject: Re: [PATCH] btrfs-progs: restore: Remove stale debug message
Message-ID: <20250620163412.GZ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250612002244.381346-1-mpdesouza@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612002244.381346-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Wed, Jun 11, 2025 at 09:22:44PM -0300, Marcos Paulo de Souza wrote:
> The message was introduced on 502d2872
> ("btrfs-progs: restore: add global verbose option"), and it was never
> changed. The debug message shows the offset of one  EXTENT_DATA from
> the file being restore, but it's only shown when it's not zero.
> 
> This field is non zero when the extent was first snapshoted (or a
> subvolume was created), and later changed partially, so the extent was
> split in the part that remained the same and the one that changed.
> 
> It's not useful to have this message being printed without proper
> context to the end user. The message itself isn't very useful in
> debugging sessions, since it would be necessary more data about a
> problematic file/extent. And given that the message is here for
> more than 5 years being unnecessary printed, it's better to remove it
> since it can annoy the users.
> 
> If a problem appears at this point in the code, a more appropriate debug
> code could be introduced instead.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/920
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to devel, thanks.

