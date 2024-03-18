Return-Path: <linux-btrfs+bounces-3362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5C87EFFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D591C20CBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB856442;
	Mon, 18 Mar 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTnrDA2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mdm88Clk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTnrDA2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mdm88Clk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2855E4E
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787967; cv=none; b=bbjquchM3vbLretbjgmLbW2mjM8mM3LgGoLo1MN/Yq3jCJtDDVlYYeH+/2ZcyDsKjTP9qCHfGzwgGrq9oCy9AzhW8RXFnfs4tw4UAhxRxAz22D34AONPNxg4MHDkQuMFVpabO2ZmHMvOvbphw0rLlh/kmsGNlrx4zkrocNn+s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787967; c=relaxed/simple;
	bh=e3Sdpy1rTJa+pt5IWC1AB9QzQbhfeV7JClaeKtkMX6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiEqyAVQasH0uD5WM+nAuGbuyBijHUlZNijSlDwrpbSSyAMVWC8OkoTIyBOjXdYauJGUD3Wgm6qoFhewk6FO3J+GHSgLrkDavT6imowrOQsCcOcpXNcZbpAnXmO8mG9sCs8AuW9ujF/ouGJSiW6vNYe/exzhEX3N5gKEGvfQ1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTnrDA2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mdm88Clk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTnrDA2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mdm88Clk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03AF25C908;
	Mon, 18 Mar 2024 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710787964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJvAyd5gr0HIgg2UanHSKh6fzpqYAJgq48QtDJI41Hg=;
	b=aTnrDA2JFneenPfHcvCiN7TUhoDpdkMGYeaDerfQJzrrDxzhxDgOALllDEfVp3YhM/NVSq
	WqQqV1cIC3wCFcfP38iyl81zVJWbrx/7a8TZiRcrfn1L3TVIMfTnlUoBqt1t74wYK6n9d8
	YqwThVBP63PeRPFT+2xI3usTPMDhP+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710787964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJvAyd5gr0HIgg2UanHSKh6fzpqYAJgq48QtDJI41Hg=;
	b=Mdm88ClkinjYWwtEyi/JMh6nZdRpb0DvSplS7DhnT9hoaIreDHql7EV+1QMxYY2l/M1u77
	0eajagHQr2+xHcCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710787964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJvAyd5gr0HIgg2UanHSKh6fzpqYAJgq48QtDJI41Hg=;
	b=aTnrDA2JFneenPfHcvCiN7TUhoDpdkMGYeaDerfQJzrrDxzhxDgOALllDEfVp3YhM/NVSq
	WqQqV1cIC3wCFcfP38iyl81zVJWbrx/7a8TZiRcrfn1L3TVIMfTnlUoBqt1t74wYK6n9d8
	YqwThVBP63PeRPFT+2xI3usTPMDhP+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710787964;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJvAyd5gr0HIgg2UanHSKh6fzpqYAJgq48QtDJI41Hg=;
	b=Mdm88ClkinjYWwtEyi/JMh6nZdRpb0DvSplS7DhnT9hoaIreDHql7EV+1QMxYY2l/M1u77
	0eajagHQr2+xHcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D57136A5;
	Mon, 18 Mar 2024 18:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jWtN3uN+GXdFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 18:52:43 +0000
Date: Mon, 18 Mar 2024 19:45:26 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: remove a couple pointless callback wrappers
Message-ID: <20240318184526.GF16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710763611.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710763611.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.06)[-0.293];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.15)[95.93%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 12:14:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Trivial stuff, details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: remove pointless readahead callback wrapper
>   btrfs: remove pointless writepages callback wrapper

Reviewed-by: David Sterba <dsterba@suse.com>

