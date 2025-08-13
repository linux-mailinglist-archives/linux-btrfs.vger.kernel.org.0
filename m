Return-Path: <linux-btrfs+bounces-16048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F3B24974
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D1B722E18
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A5187332;
	Wed, 13 Aug 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X11e4/qM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2D8fwVR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X11e4/qM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2D8fwVR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FC17D2
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087740; cv=none; b=J4ilSRju71roaG7JNiq/Xu8TMBjsyf+ItBSZJnDzPWdyR2SFkiz2HK7bzspUICN6ufXSjMJtg91Rh5NrBapwifKbvs+Ssals11ylgbinl1WpX3oLPoUpEIJWUMiAqcgKethPN6Q37Fl7zkBJDMpT7eF7k1kM7QEFxNuc15K6gC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087740; c=relaxed/simple;
	bh=XXA8x9gZvmILffZSu2CYCoNjscu4qPZlhCra8ab9ApU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX6OvZmEZVyg1V25Z0fKaoqAzF1//4biiGYVF8FiHfxDPo+taTJlX/O1iL82uqlQTRS7HrTI7xftz0lwYY3WiGP/U+9J5ot3MlGU9YEzQbSVIxkB/LQVlUicV9VJ7Rnk8/iP9LFPyOrgsYCsSEdxVViEYk5c9MrKFo6oHIEepDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X11e4/qM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2D8fwVR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X11e4/qM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2D8fwVR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6E5D21AB2;
	Wed, 13 Aug 2025 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755087737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXA8x9gZvmILffZSu2CYCoNjscu4qPZlhCra8ab9ApU=;
	b=X11e4/qMmQTEVXI7oCWSShNoSaqzMoLUoTqYWibDtU2wlF4f3TC5O9Yu53kuY2kAT5O/sn
	QyTGik89eKCn8FWzzbNPUAAeqn8FO2drKdTkDnCADPJECtznVz1/JQ0ercB0j82VJ164Yr
	OsmGxIJXDAEbun3avIQxMATaIgvBeJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755087737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXA8x9gZvmILffZSu2CYCoNjscu4qPZlhCra8ab9ApU=;
	b=G2D8fwVRvoIkLc9Xz0pCCswwqPWWjPln2AKbBgSmNc6DkKHiTB1vrwWpOG+UnJZ7DRbijK
	mVmwkWTsHP2sN7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755087737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXA8x9gZvmILffZSu2CYCoNjscu4qPZlhCra8ab9ApU=;
	b=X11e4/qMmQTEVXI7oCWSShNoSaqzMoLUoTqYWibDtU2wlF4f3TC5O9Yu53kuY2kAT5O/sn
	QyTGik89eKCn8FWzzbNPUAAeqn8FO2drKdTkDnCADPJECtznVz1/JQ0ercB0j82VJ164Yr
	OsmGxIJXDAEbun3avIQxMATaIgvBeJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755087737;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXA8x9gZvmILffZSu2CYCoNjscu4qPZlhCra8ab9ApU=;
	b=G2D8fwVRvoIkLc9Xz0pCCswwqPWWjPln2AKbBgSmNc6DkKHiTB1vrwWpOG+UnJZ7DRbijK
	mVmwkWTsHP2sN7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C82E13929;
	Wed, 13 Aug 2025 12:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RFAKJnmDnGgJSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 13 Aug 2025 12:22:17 +0000
Date: Wed, 13 Aug 2025 14:22:12 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/1] btrfs: remove ref-verify kconfig
Message-ID: <20250813122212.GB22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755040815.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755040815.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Aug 12, 2025 at 04:28:26PM -0700, Leo Martins wrote:
> Requested by David Sterba to unify debug things under
> CONFIG_BTRFS_DEBUG Kconfig. This touches similar code to my
> ref_tracker patch linked below, if it's easier I can send out a
> new patch set with this patch on top of my ref_tracker patches to
> resolve any merge conflicts.

I think it's better to take this patch first, the ref tracker might have
some changes. Added to for-next, thanks.

