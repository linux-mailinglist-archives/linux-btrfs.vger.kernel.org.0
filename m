Return-Path: <linux-btrfs+bounces-6873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E3941346
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29A8B273A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407211A01BF;
	Tue, 30 Jul 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t7Q5T2lk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+QjVZvRF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t7Q5T2lk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+QjVZvRF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B01A01AE
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346570; cv=none; b=k/C0kIeoR958wFxAvvdSKqQMc4ZBerFW1X2Clgs+OCD+tMzKAMApb4SQbe5A6m+9azJQ2nfURTvPUPsvUylEP0mbQdssktbKS3Vfx3/DfJl5I5M8iEI9WWiHoSz1+nNbjarjfSdZLQMimUl+FRaYU/u/oNx9IYnu3yPF1HeuzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346570; c=relaxed/simple;
	bh=NZtgaBSRV+wyqdvy+k81bDfStItl7tmUbji3km4SVhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP7yUOp5S2ljow7cFXcj6g0LK1bQj0MAceNFQ9aHP/1Kd9rU6qoMovhopLFPHMi0FCwoggUjZNcCqGfCXStlt0jSf+R37ly8+w3Im+6EIPmkLgPsdPO5VuT0tUzbVyWe0+oGHlygSnyxpuwvrI1jQtCN63ereKL+F2WPx6k/ONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t7Q5T2lk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+QjVZvRF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t7Q5T2lk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+QjVZvRF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E15201F7EB;
	Tue, 30 Jul 2024 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJAg5Tme5YrdxlXOoiXCXsaMaMyM1mZHYU8f3gImffQ=;
	b=t7Q5T2lkP1SspN62eHm+epjEWj9D6dsgyyPKn1YECosRlD6iJ0bmRWkmmIsmo87T7goGwO
	JLjgdIgznFn16hTxR+ArWeL96i4l+GUv/N8TB9zF0o9rurIQ66z+x7gayuG7N9FeZTcmGx
	YwbjlFpYIqnSZjLQ4+SGiHjFD/zLQi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJAg5Tme5YrdxlXOoiXCXsaMaMyM1mZHYU8f3gImffQ=;
	b=+QjVZvRF33W9FZpF8396r2kyLeBLZ66kKddAncryTsMGEUc8hkYois4WJJMo1WEkw+SOZw
	VbGj5lCiNonzQWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJAg5Tme5YrdxlXOoiXCXsaMaMyM1mZHYU8f3gImffQ=;
	b=t7Q5T2lkP1SspN62eHm+epjEWj9D6dsgyyPKn1YECosRlD6iJ0bmRWkmmIsmo87T7goGwO
	JLjgdIgznFn16hTxR+ArWeL96i4l+GUv/N8TB9zF0o9rurIQ66z+x7gayuG7N9FeZTcmGx
	YwbjlFpYIqnSZjLQ4+SGiHjFD/zLQi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJAg5Tme5YrdxlXOoiXCXsaMaMyM1mZHYU8f3gImffQ=;
	b=+QjVZvRF33W9FZpF8396r2kyLeBLZ66kKddAncryTsMGEUc8hkYois4WJJMo1WEkw+SOZw
	VbGj5lCiNonzQWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C29EE13983;
	Tue, 30 Jul 2024 13:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M0QAL0bsqGbiXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 13:36:06 +0000
Date: Tue, 30 Jul 2024 15:36:05 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some updates to the dev replace finishing
 parting
Message-ID: <20240730133605.GY17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1722264391.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722264391.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Mon, Jul 29, 2024 at 03:51:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Trivial changes, details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: reschedule when updating chunk maps at the end of a device replace
>   btrfs: more efficient chunk map iteration when device replace finishes

Reviewed-by: David Sterba <dsterba@suse.com>

