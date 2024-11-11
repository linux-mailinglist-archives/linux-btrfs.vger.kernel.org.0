Return-Path: <linux-btrfs+bounces-9427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E939C4070
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 15:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B41F226A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E481A00D6;
	Mon, 11 Nov 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vcgFjor4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="onw0QQxh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vcgFjor4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="onw0QQxh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15B19F115
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334363; cv=none; b=ClSYJyAD+izCsPECf+hgMK+taPq0RsLief5iKgnTDustOkGTRNyWDjIP/bYzgzdJQXQTDCpsDvFja3ar4PfG5tNONoGbsTVg/ks5KyE9QNbjmsTuXEbVisidV9oXJHPXgJjbTfUW0W4Rm6yOINmAeCMcTD6mU3hqDrOmHBobnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334363; c=relaxed/simple;
	bh=6Z6H1oGCAeC9Gz9BREB2CSWgWpWcyVScZlrJPY10IIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTuQEeqjcyfsOwuMcMzp2zwHSZrTMViWNuPGpbAHd5hAJ9K0TotsYdzAlBu3V2NgpHAnuGzVxPwQURxHquTAJcqzUxAKCvhQKWVyjBVR2Lxj+xBtf+GMOLR24pwdIdEyebGjcLY+KFXhTAiaYsQFlm9UYr7Jol6xslj2BmX6O38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vcgFjor4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=onw0QQxh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vcgFjor4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=onw0QQxh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A562221990;
	Mon, 11 Nov 2024 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731334359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZk3LGBy+bJeWPDmHj69F+0ILxt5wfs37gQfczOTrrA=;
	b=vcgFjor4Ow5Oaj+JMPTWax8cak4a57WkoN2VrN50nLlJoKyI9WpRcyHl4gf7pI21Cms0FZ
	47mW6sUSY7Xsa1pIjJrsSPtNnfzPyBrPBfjp4lM8vHwRK25YMtPhHwK8XPB1+lLf2zJ4La
	hyTgW82vpu0AqEqhFbEAJJleJUIy6lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731334359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZk3LGBy+bJeWPDmHj69F+0ILxt5wfs37gQfczOTrrA=;
	b=onw0QQxhfykpS851+cgzwhBAd5RJrxm9tRNU71vPXhVCFlxaZqXNcGUTCkP5JVzwuaa/Sk
	ho6Cyc8FICpzuEDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vcgFjor4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=onw0QQxh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731334359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZk3LGBy+bJeWPDmHj69F+0ILxt5wfs37gQfczOTrrA=;
	b=vcgFjor4Ow5Oaj+JMPTWax8cak4a57WkoN2VrN50nLlJoKyI9WpRcyHl4gf7pI21Cms0FZ
	47mW6sUSY7Xsa1pIjJrsSPtNnfzPyBrPBfjp4lM8vHwRK25YMtPhHwK8XPB1+lLf2zJ4La
	hyTgW82vpu0AqEqhFbEAJJleJUIy6lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731334359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oZk3LGBy+bJeWPDmHj69F+0ILxt5wfs37gQfczOTrrA=;
	b=onw0QQxhfykpS851+cgzwhBAd5RJrxm9tRNU71vPXhVCFlxaZqXNcGUTCkP5JVzwuaa/Sk
	ho6Cyc8FICpzuEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BDBD13301;
	Mon, 11 Nov 2024 14:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cfTmIdcQMmdsYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Nov 2024 14:12:39 +0000
Date: Mon, 11 Nov 2024 15:12:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Message-ID: <20241111141234.GO31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731310741.git.naohiro.aota@wdc.com>
 <72946446ca8eda4477e0a11ea0b9d15cb05aa1e1.1731310741.git.naohiro.aota@wdc.com>
 <a419cf9f-7fa3-4f75-b459-23c1fe014c14@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a419cf9f-7fa3-4f75-b459-23c1fe014c14@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A562221990
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Nov 11, 2024 at 09:04:39AM +0000, Johannes Thumshirn wrote:
> > +		/*
> > +		 * Here, we choose a fully zone_unusable block group. It's
> > +		 * technically possible to reset a partly zone_unusable block
> > +		 * group, which still has some free space left. However,
> > +		 * handling that needs to cope with the allocation side, which
> > +		 * makes the logic more complex. So, let's handle the easy case
> > +		 * for now.
> > +		 */
> > +		scoped_guard(spinlock, &fs_info->unused_bgs_lock) {
> 
> Again, not a fan of the scoped_guard() macro...

Yeah, we may use the scoped locking for something in the future but so
far it would be quite confusing to mix explicit locking with scoped for
current data structures. Subjectively speaking I don't want to use that
at all.

