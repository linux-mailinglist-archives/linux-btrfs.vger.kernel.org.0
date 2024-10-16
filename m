Return-Path: <linux-btrfs+bounces-8964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7539A0DE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5079B1C204F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C320CCEA;
	Wed, 16 Oct 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBJw6a5P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZREtcgD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIPcNRp1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DuitmBMf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF820E035
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091824; cv=none; b=dHnLGx+BBWXhEqLZfSkQnuRNaYZHPhniRcC18oxyAG6tmgEvcVwIOw5ABBm+SwatGi6wGj/ihXPBbAcKwk5ciGTfDytWHUmC6/ZCSo2AJP4WKNcXYGbcmb0sh6Tdyk2Eq2OPh8qh8ZkkGBU8zoiQV6dDr7ENTV6yHMPMcIt/YMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091824; c=relaxed/simple;
	bh=8cN6ksYcbhA+JTCwogXsEtMSj+8KoeU9hUF3VgblIjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRcqKnWFkpQW7MqG+D3sA7s5cRZG1eF3oxIIp8k5RCTtvajaextAOQsyf8LVsDCiflvVUjlII4mP/lDyRT9cOQ+qlb5MrkR2ScwTvFGWNlh120WcOB1isFL9gx4QEahnYraJj81IIWGifVCbRgN5zuv8XBkM+N2ZcUTmdQy1L0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBJw6a5P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZREtcgD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIPcNRp1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DuitmBMf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC95D21E3D;
	Wed, 16 Oct 2024 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729091821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REVYJGSyFWMCAN0c8mDWoUC2FwWZSzhsD82FCYtvS38=;
	b=XBJw6a5PSyzNfN3lOdoEHnlTtvQHx1T83q3uzIkEP8/LqqO9doNC1H/YeEetTA8PcYwoYz
	J7kZH2eaMWs6r08v2OtqhQNyLgi+pSKi9MBljpuT3iHKVYHeW0U9iQ18kXHk9V5o74emJQ
	4RZSKNfe+ICeyDgSyb2uTwjF14+X+Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729091821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REVYJGSyFWMCAN0c8mDWoUC2FwWZSzhsD82FCYtvS38=;
	b=lZREtcgDBuRTo8RX9N5s40kCQWSXUHEAWMsaWAb9OpqpReUycjtkdz5tVYAsHuy020xiHr
	Ib7vDmC3h6PUc4BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729091820;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REVYJGSyFWMCAN0c8mDWoUC2FwWZSzhsD82FCYtvS38=;
	b=AIPcNRp1G8261hQvpUilnQ2K8Dzw2LmLX1jWQZU16PuxTr3Pqd4FrHkgQcyr0oBreIFQeD
	frw2kOt1otWHa9O4JTG4OMlq2yg57crHg7qy6j1PMj6W2I5u3RQcWs8pmeCC0+d56KFF4x
	aQPdtYgl16aBs5JSZNEpYnfngZ2qAmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729091820;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REVYJGSyFWMCAN0c8mDWoUC2FwWZSzhsD82FCYtvS38=;
	b=DuitmBMfSnjKe01VXdhWNxy/+NmHELINdfK9QncYiP/5pIIQgpcd5v5ZbpTKiy+UqeZ9wY
	vNgJnI77/SpvGCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6B71376C;
	Wed, 16 Oct 2024 15:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zFN2MezYD2efLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 15:17:00 +0000
Date: Wed, 16 Oct 2024 17:16:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: fixes related to
 btrfs_folio_start_writer_lock()
Message-ID: <20241016151659.GP1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728428503.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728428503.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 09, 2024 at 09:37:02AM +1030, Qu Wenruo wrote:
> [Changelog]
> v2:
> - Remove the unused btrfs_folio_start_writer_lock()
> 
> v3:
> - Split out the btrfs_folio_start_writer_lock() removal
>   As the initial fix needs to go backported to 5.15+, keeps the
>   modification as small as possible
> 
> The function lacks the proper folio->mapping check, thus we can even get
> a folio not belonging to btrfs, and cause unexpeceted folio->private
> updates.
> 
> Fix the only caller of btrfs_folio_start_writer_lock() inside
> lock_delalloc_folios() and other sector size < page size handling of
> lock_delalloc_folios().
> 
> Then finally remove btrfs_folio_start_writer_lock()
> 
> Qu Wenruo (2):
>   btrfs: fix the delalloc range locking if sector size < page size
>   btrfs: remove unused btrfs_folio_start_writer_lock()

Reviewed-by: David Sterba <dsterba@suse.com>

