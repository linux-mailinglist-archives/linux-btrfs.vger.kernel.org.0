Return-Path: <linux-btrfs+bounces-11878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C9A46464
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BC33A114C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4B224885;
	Wed, 26 Feb 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIri6j3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8RQkyZr1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIri6j3G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8RQkyZr1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EA223321
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583031; cv=none; b=ee+K0iVIt8JyEvR5pdX0yhbHn+ZWVeR9AMx3AGku3pzblIamMPJ+XEXv2h+zwsylNDHKwt0SEnyrx0SKDbC4+N9YqEWXZqgVsqtNu8CcrNdqI+Yih5xbn8Bgw81u0sfOyx4zqs3PIYRxRaNieiIaZNO2bahH6EefSHbBrZ7ERGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583031; c=relaxed/simple;
	bh=l7yHFPPoOgal+Yc54uYR3mBqBlXEvXOC892IuK0go7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYYp7wySuJr1kJ66I0uJiTKLiHehVz4YyUJs1ZEOtsLlol60MWuwOysRhD65ytDz4qR+P1VmxMNNtvZNsFJjKv+70N6Zms5nJofL4/gQ+AtgPxois8XnjbdGw7/9f1r1ahOiL0Cms4VR+2BidxrR+BLbVMTHlcRapvWdi+fG2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIri6j3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8RQkyZr1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIri6j3G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8RQkyZr1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BD1A211E8;
	Wed, 26 Feb 2025 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740583028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDyNOS/8wMQ7S59MstZZpLRteCW9oDCA3n/NBjot8Jk=;
	b=UIri6j3GtL0Xo8FVNqFR40Dv09pUcuyBoo5quFojmZP86ejizdxrnrxinqIaVBfPRPx+L3
	0HPh9rJo3C1AZJz1cOdPqdMCRTSbxJ+PFHooZj3leKlrqlZrdJqwgxl5pNdNfBxx5ZAqXV
	tQXC0qm3FszNnFn+qtbLENalq8Sa6NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740583028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDyNOS/8wMQ7S59MstZZpLRteCW9oDCA3n/NBjot8Jk=;
	b=8RQkyZr1EMwKLiL4ssqcC95ni/0hMHlOfhfNTBUASHiqtOqEJZ7uOsJeAjtHZvhn8uzcAL
	jCcjXDvDsMrcFjAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740583028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDyNOS/8wMQ7S59MstZZpLRteCW9oDCA3n/NBjot8Jk=;
	b=UIri6j3GtL0Xo8FVNqFR40Dv09pUcuyBoo5quFojmZP86ejizdxrnrxinqIaVBfPRPx+L3
	0HPh9rJo3C1AZJz1cOdPqdMCRTSbxJ+PFHooZj3leKlrqlZrdJqwgxl5pNdNfBxx5ZAqXV
	tQXC0qm3FszNnFn+qtbLENalq8Sa6NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740583028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDyNOS/8wMQ7S59MstZZpLRteCW9oDCA3n/NBjot8Jk=;
	b=8RQkyZr1EMwKLiL4ssqcC95ni/0hMHlOfhfNTBUASHiqtOqEJZ7uOsJeAjtHZvhn8uzcAL
	jCcjXDvDsMrcFjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CC041377F;
	Wed, 26 Feb 2025 15:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y394EnQwv2dIVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Feb 2025 15:17:08 +0000
Date: Wed, 26 Feb 2025 16:17:07 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: some fixes around automatic block group
 reclaim
Message-ID: <20250226151707.GW5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740427964.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740427964.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Feb 25, 2025 at 10:57:06AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a couple races that should be mostly harmless but trigger KCSAN warnings
> and fix the accounting of reclaimed bytes. More details in the change logs.
> 
> Filipe Manana (3):
>   btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
>   btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
>   btrfs: fix reclaimed bytes accounting after automatic block group reclaim

Reviewed-by: David Sterba <dsterba@suse.com>

