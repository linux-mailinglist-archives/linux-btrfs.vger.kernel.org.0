Return-Path: <linux-btrfs+bounces-18148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43437BFA469
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 08:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E785855C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE22EF664;
	Wed, 22 Oct 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l1f3sTTX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sU9rf7EQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+uPBK15";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqnnAslh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DB2ECD33
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115379; cv=none; b=GuPuhH+yxm7toxtwIyty6NziyWw3HF/1yjr/Kds8fsSFjM10BWcgu5yFxIpFLc/HqbSdXfEzPAjC6VNcZZUUWJKkHu/wOIAm8j+VkHk1E3hPrGcO0ofbIOgYX0WDmGAt7DhdSr1+oeiB4+RhKCbkDMCFU+v3e79zHt6W9QKwAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115379; c=relaxed/simple;
	bh=PSjb9SXnAnQ+5qCDJu5Cjt0spbBbyTXc+2FMRP0QYJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTOqJ0a0OylZxkII8maJ/Lz55zQsNE+AmJ6QNXZW6g6xehTrgooDE4WnfA2QmSq4GXaztV6I+zZscRuEvpZAOFHDELTezoI4UybrfsYQP8Nkk4TfcTxoREMOf053+BWmWJnWLV6LkOZkBajpQUcEzt50vqVCnGxYPPYU/gYPa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l1f3sTTX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sU9rf7EQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+uPBK15; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqnnAslh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C2901F395;
	Wed, 22 Oct 2025 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761115366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6qSQLagbQSqT63TDs+MS0HdKgOH05xXMt/Me3/lqgI=;
	b=l1f3sTTXEjuBmBtxF4PEyDc1ldFXyYWFmJmHXQb0kjgVexPHRWQuLJ79GyP52zVMVtFdBd
	h+y4q3Eo2nH1ZphAOTmEiIs9TyP21bCGzlUwUkSe0KRPIVCncj985lOTHPolEnuTUDbhAn
	96GRPx+VvCFGV+vcNUmsCz/A1P51rT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761115366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6qSQLagbQSqT63TDs+MS0HdKgOH05xXMt/Me3/lqgI=;
	b=sU9rf7EQD8eB3t5Q+SPKjGwHC7HZq0OBLsfqY21y21zHY3xHbnpviVhpzydZFZUi1vrizd
	RV7gOWIkYbR/35DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761115362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6qSQLagbQSqT63TDs+MS0HdKgOH05xXMt/Me3/lqgI=;
	b=z+uPBK15nDNvDLMB4oeuCAUWUCzXOM9qeG1cjkS3ve/dxPVWkFFqNo3Y08VdjAn0sqMRRV
	ONwuDFBTZY+QmToVsSmlhOMZ88O/s68WDO8hdWkknm1VX4jYyvkFOd0l+HAbl4622OEBFR
	ISY0y16Cxt21NSd1Y+j/VF22F5Ou6hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761115362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D6qSQLagbQSqT63TDs+MS0HdKgOH05xXMt/Me3/lqgI=;
	b=lqnnAslhlXNH++NJIdVCs0p4aXqimpwWF+OLNFp+rPkyzh61ahfVSosLjo2bd5zpLoRhvs
	1GjZS1M/XxVf+gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2590D13A29;
	Wed, 22 Oct 2025 06:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f6z6COJ8+GhwaAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 06:42:42 +0000
Date: Wed, 22 Oct 2025 08:42:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix delayed_node ref_tracker use after free
Message-ID: <20251022064240.GT13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e5d6dd45f720f2543ca4ea7ee3e66454ef55f639.1761001854.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d6dd45f720f2543ca4ea7ee3e66454ef55f639.1761001854.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Oct 20, 2025 at 04:16:15PM -0700, Leo Martins wrote:
> Move the print before releasing the delayed node.
> 
> In my initial testing there was a bug that was causing delayed_nodes
> to not get freed which is why I put the print after the release. This
> obviously neglects the case where the delayed node is properly freed.
> 
> Add condition to make sure we only print if we have more than one
> reference to the delayed_node to prevent printing when we only have
> the reference taken in btrfs_kill_all_delayed_nodes().
> 
> Fixes: b767a28d6154 ("btrfs: print leaked references in kill_all_delayed_nodes()")
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Added to for-next, thanks.

