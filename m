Return-Path: <linux-btrfs+bounces-19214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F28C73CAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 12:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B91084E6002
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C92F60A1;
	Thu, 20 Nov 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aopyeYRL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mopBhOGs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aopyeYRL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mopBhOGs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4721F37A1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638904; cv=none; b=qT7MSO0y83Tju81Gqtx8SNyWV9hxfDZ1PXA6EWrKmkCzzjaK57eicvUk7o4SZodpPtRl5BbNZqQk2HFzIfISGzUCJCuw9wTsHKNRyLq5PlicXRC2wrcOGb+fvMMeVoDBF7AILBcCxSqLGo6zmG5nieohNTlPJkT7+7p/7a5PiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638904; c=relaxed/simple;
	bh=DvzAHJ52kF6qI8IU7SKrVRXbqKOeeTNXcvDeKx56ErY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwMGQSE2Uiy3jk1/+Z9f6lEUAN2O380lLlpDrm1Uz+cUf/j+GMFQfGB6vsoXKHlaBF7W8JV0KrTHyIEuOk60LoUZkAzRGRF9JPl5bc43XT0FVC/e4bqcSHEYNDO0ZTwFAVKhCelKcJo9AEjk+tin6E/SxFKKCptZ89wkntgg0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aopyeYRL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mopBhOGs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aopyeYRL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mopBhOGs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 787A2209E0;
	Thu, 20 Nov 2025 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763638900;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjZ47sO4xmCYx+frlL1zZ1scpyBe/qRMN0z9So1quBQ=;
	b=aopyeYRLcuCwlXG0ezYmxjSMcTVETGRoUX/7cY0llaDA/fFwciM65jZ7CcMEQaBPjP8rlS
	tocrZcV2zOckUIIRDTBQxd8M6BodQZRhVBCF4RndjZF2uIyH4FbdsuraR29vs6lfj50Sob
	KdQkfprmUD57H/7jy+8kjv4v/acnEUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763638900;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjZ47sO4xmCYx+frlL1zZ1scpyBe/qRMN0z9So1quBQ=;
	b=mopBhOGsJpZ6vGgGCTAgxGoVhHixhn+ZbpDSN/tDB2JV3ORk/2MJvEUxeY9MxVQtGM4YWv
	qt/2U/Qb0rGwMRDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aopyeYRL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mopBhOGs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763638900;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjZ47sO4xmCYx+frlL1zZ1scpyBe/qRMN0z9So1quBQ=;
	b=aopyeYRLcuCwlXG0ezYmxjSMcTVETGRoUX/7cY0llaDA/fFwciM65jZ7CcMEQaBPjP8rlS
	tocrZcV2zOckUIIRDTBQxd8M6BodQZRhVBCF4RndjZF2uIyH4FbdsuraR29vs6lfj50Sob
	KdQkfprmUD57H/7jy+8kjv4v/acnEUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763638900;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjZ47sO4xmCYx+frlL1zZ1scpyBe/qRMN0z9So1quBQ=;
	b=mopBhOGsJpZ6vGgGCTAgxGoVhHixhn+ZbpDSN/tDB2JV3ORk/2MJvEUxeY9MxVQtGM4YWv
	qt/2U/Qb0rGwMRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DB513EA61;
	Thu, 20 Nov 2025 11:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCuoGnT+HmluIwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Nov 2025 11:41:40 +0000
Date: Thu, 20 Nov 2025 12:41:39 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: do not allocate memory for xattr data when
 checking it exists
Message-ID: <20251120114139.GJ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d95e088ffbc10bc6b5db30846e31970e347b0a3a.1763575479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95e088ffbc10bc6b5db30846e31970e347b0a3a.1763575479.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 787A2209E0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Nov 19, 2025 at 06:09:23PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When checking if xattrs were deleted we don't care about their data, but
> we are allocating memory for the data and copying it, which only wastes
> time and can result in an unncessary error in case the allocation fails.
> So stop allocating memory and copying data by making find_xattr() and
> __find_xattr() skip those steps if the given data buffer is NULL.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

