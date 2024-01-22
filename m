Return-Path: <linux-btrfs+bounces-1618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A88374C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF8C1C26D2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E047A74;
	Mon, 22 Jan 2024 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YcKPkqCM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bUSNt8sK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YcKPkqCM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bUSNt8sK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9932CA8
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957215; cv=none; b=Fv7M4Sp92Frjr5QvJIO+CseOCKmWx/0P3GlWmv+L1ycSwFmbxP31gjzR0G0RPYfvzMQloG9BR8MgeI82uq5DcRRlpUoOE+dxFHUY5w6PjiYu23R5DdJS2cmuU1aZ+4O16QD9JT9aQsL4wU5fFBUbjIFQg3QyaaymWEulPtyFpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957215; c=relaxed/simple;
	bh=F9zU68Rv3zNbL6oI6O1mdL2vU4rO83ojvb6P6eUrN44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgkPMAbLYeHi0sx5U0dNSUKHA95ykFgPPFl+i2uYStuQ7+1cM9jVklXtNoJfauzJjg6zQsHE9rFRYXTOMM5uO1081Nspspx5rGUk/XAye7k3hpeNwYehQvMl2IKyh5Pyi+GT/6MLgB4UC9A2JJgT3OdHKR7hHeIjtQLu33Hyg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YcKPkqCM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bUSNt8sK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YcKPkqCM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bUSNt8sK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C6211FCE2;
	Mon, 22 Jan 2024 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705957212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3zUNnTxQIboJ6VC7od3xhGm54akwsU0Pfe/n5MYIjs=;
	b=YcKPkqCMO7d5Ox6926D9PM0/vKIfiTvVjg9kpwAIz8e/IOn+reEBkD7pwv70vHqRRKj89P
	NJzeyzl9yUYB7mMrURmrY5zz8xZgOnKorfQlHJOKZqlIxnXrmJo3nEx4fVBQCfLN6HmFWW
	h0Jpotxoot3xpH8syOAFARCRSFjQ9SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705957212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3zUNnTxQIboJ6VC7od3xhGm54akwsU0Pfe/n5MYIjs=;
	b=bUSNt8sK2S8c6NmXxQV63mjIcfwbJXaKUoHxWXwHfeN/6UmgKHaCFXH2PM2z4EXSrSTBBl
	95ozUNKSLN5oFwDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705957212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3zUNnTxQIboJ6VC7od3xhGm54akwsU0Pfe/n5MYIjs=;
	b=YcKPkqCMO7d5Ox6926D9PM0/vKIfiTvVjg9kpwAIz8e/IOn+reEBkD7pwv70vHqRRKj89P
	NJzeyzl9yUYB7mMrURmrY5zz8xZgOnKorfQlHJOKZqlIxnXrmJo3nEx4fVBQCfLN6HmFWW
	h0Jpotxoot3xpH8syOAFARCRSFjQ9SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705957212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3zUNnTxQIboJ6VC7od3xhGm54akwsU0Pfe/n5MYIjs=;
	b=bUSNt8sK2S8c6NmXxQV63mjIcfwbJXaKUoHxWXwHfeN/6UmgKHaCFXH2PM2z4EXSrSTBBl
	95ozUNKSLN5oFwDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 305B613310;
	Mon, 22 Jan 2024 21:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 28tjC1zXrmUYfQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 21:00:12 +0000
Date: Mon, 22 Jan 2024 21:59:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Klara Modin <klarasmodin@gmail.com>
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org, terrelln@fb.com,
	dsterba@suse.com, josef@toxicpanda.com, clm@fb.com
Subject: Re: [PATCH 3/3] btrfs: zstd: fix and simplify the inline extent
 decompression
Message-ID: <20240122205947.GB31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu_xDvUG-6-5zPRXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu_xDvUG-6-5zPRXg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YcKPkqCM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bUSNt8sK
X-Spamd-Result: default: False [-0.04 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.96%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.04
X-Rspamd-Queue-Id: 4C6211FCE2
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Jan 22, 2024 at 09:45:42PM +0100, Klara Modin wrote:
> Hi,
> 
> With this patch [1], small zstd compressed files on btrfs return
> garbage when read on my x86_64 system. Reverting this on top of
> next-20240122 resolves the issue for me.

Thanks for the report, this is serious. The patches have been in testing
for some time but haven't uncovered the problems you mention.

