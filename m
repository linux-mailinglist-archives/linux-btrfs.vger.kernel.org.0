Return-Path: <linux-btrfs+bounces-5321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C9D8D2087
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5038284B6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 15:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB53171E43;
	Tue, 28 May 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r6vtSlcw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHUteXcC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r6vtSlcw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHUteXcC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C788171656
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910536; cv=none; b=mg5NjqaVUkDCDDjdK5I+PY7QA5cHgt6HLGH89uD8YowWE0pHVGDVER6QF28UtLCnWTRBcdLP0PT8wnmMvSzrYztK8yOirOhkc0xh64frezqRNVCYEX6uO1vTPZelMF8RbvBVA6e3QzCgM5JwAdLjqBKcYDODcaMq5DacsUio12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910536; c=relaxed/simple;
	bh=XvseK6f4ZMNljjYq9cE7gWVm8rJmAVK9/7AopRDCcS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtvF2WUf81KMpdDtYw9AF9rozh91XhYRX+GWNU0VwxADLCFTnpE4+psCcercMHN84egB4Yt2qJKAAba5177GHt0o1ZRZj7UE/LlCGD2ezG1MmJiUwrs7USXp0QNMHmdSab65BenJfWo08r5G04ij+MbOZoXD1fpkRjNr/x/iSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r6vtSlcw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHUteXcC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r6vtSlcw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHUteXcC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 865F722981;
	Tue, 28 May 2024 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716910532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDqgxO/RZELnPduNHGdZrvoCoQH0Tqlshe6vZRv/5+0=;
	b=r6vtSlcwJmgdleFlVCUyXq/v3yl1PO5RrzZXH/b6gLa31kmCwLAdiqt9sA1EBKXChOvWTj
	tptpqYMqLAUa1AIO+VHsC50NKMAw7QF61qDFzQ1cmEXDoJnTX2yavwPIU44WeHf8SCZSxU
	GMH0RMY/3vc0N7NZVPdwW2PXcmW4jMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716910532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDqgxO/RZELnPduNHGdZrvoCoQH0Tqlshe6vZRv/5+0=;
	b=jHUteXcC06k0KZeq1kdK92wXewTnQRodXx1esZ+WVXC2yvhJP+m8zMJer1cM5UJq8Slw2M
	0Uy01hoaToqXAUBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716910532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDqgxO/RZELnPduNHGdZrvoCoQH0Tqlshe6vZRv/5+0=;
	b=r6vtSlcwJmgdleFlVCUyXq/v3yl1PO5RrzZXH/b6gLa31kmCwLAdiqt9sA1EBKXChOvWTj
	tptpqYMqLAUa1AIO+VHsC50NKMAw7QF61qDFzQ1cmEXDoJnTX2yavwPIU44WeHf8SCZSxU
	GMH0RMY/3vc0N7NZVPdwW2PXcmW4jMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716910532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDqgxO/RZELnPduNHGdZrvoCoQH0Tqlshe6vZRv/5+0=;
	b=jHUteXcC06k0KZeq1kdK92wXewTnQRodXx1esZ+WVXC2yvhJP+m8zMJer1cM5UJq8Slw2M
	0Uy01hoaToqXAUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73D5713A5D;
	Tue, 28 May 2024 15:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5nW2G8T5VWabOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 May 2024 15:35:32 +0000
Date: Tue, 28 May 2024 17:35:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
Message-ID: <20240528153523.GE8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240528062343.795139-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528062343.795139-1-sunjunchao2870@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.98
X-Spam-Level: 
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.98)[99.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Tue, May 28, 2024 at 02:23:43PM +0800, Junchao Sun wrote:
> Generic slub works fine so far. And it's not necessary to create a
> dedicated kmem cache and leave it unused if quotas are disabled.
> So let's delete the todo line.
> 
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>

Reviewed-by: David Sterba <dsterba@suse.com>

