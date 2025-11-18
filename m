Return-Path: <linux-btrfs+bounces-19081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E811CC69527
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 13:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A552354934
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD73353885;
	Tue, 18 Nov 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOaf6v0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrHmpdvR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lmwu3/k3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vnaoc+Ij"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98499350D41
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467812; cv=none; b=k88wv/q+ETa0YoQdsx2pE9pG44Gfy+Q2ZxM5Pl79qrL2OOA/Udvqm85O/b4tkYlQD8jISh0DI7n9mua2znbGte+/tDRGrmKdK0zT8sv7CnALhpcb7FkqnqpfAJm81MUhtxQ6X09kq/jvtWcDZXl0VjeRmDNAScZsnq6gVUPYIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467812; c=relaxed/simple;
	bh=iVX1FxE4F0DD8TRppLqkJRy/gpEDc2EGv1HKO/EFj/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKo/zzFOalAUK+UsAXwyGGRiyhQkXJqdkBTdlLNArCP9e+e/oZT5AcNHyQLWOQ1ssUNIzoUPwXyi576esPWGMPaw0RyD0IIuN5H7Vp8rbMZ1cV50fbU6pvGMPHS5rzVVEaNp88GVBbQ0JvlJe3AWK+9xbhta/r9FyDWufmW7j7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOaf6v0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrHmpdvR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lmwu3/k3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vnaoc+Ij; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C8A32119A;
	Tue, 18 Nov 2025 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763467807;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im7pCNIIeFMqgY5F2+TNLQHX/xix3XZ6H11IHO/HDK0=;
	b=YOaf6v0vmnyP7cD6FhDQAWN6tK7IzrTz1AdR40Xj+hGaycnKZrcRZqX+KXCE3M9JunLVVY
	tf+G1uF+pETIXmTczY9SvhnNJkpL+BlPEfPVRbwiTH1h+OjouCoa8s5wT10K42V1Y1yrac
	L7can5YNhx9yzvXmi/V7diuMzgKjJdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763467807;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im7pCNIIeFMqgY5F2+TNLQHX/xix3XZ6H11IHO/HDK0=;
	b=lrHmpdvRSxzw5XEEjgdI+LQXK5dr1KuE/ZpbTfkddNgW6oPjAwCZrlZAYFI/TjBdArk9YQ
	VDtYk+P8WrYrw4Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Lmwu3/k3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Vnaoc+Ij
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763467806;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im7pCNIIeFMqgY5F2+TNLQHX/xix3XZ6H11IHO/HDK0=;
	b=Lmwu3/k34sTT/6T9vOhR28t8jUJRAlULve7A/vOhqyH+mT7p4OHJA+PpnhjqieD6m3Vn+I
	PtZ4+hf45P2HyCmLSD/2kTnFaCyvEv6pzEQT23jsduFHu/MRf9yowIJuq4qmV/ECDKhVer
	qJ0M3WqnoKEKxaHvfSctLVBSgOGrTMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763467806;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im7pCNIIeFMqgY5F2+TNLQHX/xix3XZ6H11IHO/HDK0=;
	b=Vnaoc+IjBRMaDJeEBo9Uvxa3Jju0+kEIUHb754jZDpBkspi/fgZ+G7/CoXY7dOqKvKNjqv
	LPnzgqQHbFPfxuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 476A73EA61;
	Tue, 18 Nov 2025 12:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yKtFER5iHGm6dwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 12:10:06 +0000
Date: Tue, 18 Nov 2025 13:10:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] btrfs: set the appropriate free space settings in
 reconfigure
Message-ID: <20251118121005.GU13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-9-neelx@suse.com>
 <20251113103222.GL13846@twin.jikos.cz>
 <CAPjX3FcKLCB877RZr=NdGK62i01ufGJvfJzGQ-v2+i-kfzEnBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FcKLCB877RZr=NdGK62i01ufGJvfJzGQ-v2+i-kfzEnBg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6C8A32119A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Thu, Nov 13, 2025 at 12:24:33PM +0100, Daniel Vacek wrote:
> On Thu, 13 Nov 2025 at 11:32, David Sterba <dsterba@suse.cz> wrote:
> > On Wed, Nov 12, 2025 at 08:36:08PM +0100, Daniel Vacek wrote:
> > > From: Josef Bacik <josef@toxicpanda.com>
> > >
> > > btrfs/330 uncovered a problem where we were accidentally turning off the
> > > free space tree when we do the transition from ro->rw.  This happens
> > > because we don't update
> >
> > Missing text.
> 
> Hmm, this patch is new to v5. It doesn't even look encryption related.
> I have no idea what Josef really means here.
> 
> The whole idea seems to be to call
> btrfs_set_free_space_cache_settings() from btrfs_reconfigure() and to
> update the ctx->mount_opt instead of fs_info->mount_opt while
> remounting.
> 
> And btrfs/330 is not failing even with the full patchset applied
> without this patch. I'm wondering if it is still needed after those
> years?

Maybe it it's not, as all the patches are somehow independent you can
drop it for now. We can add it later if need be.

