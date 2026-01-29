Return-Path: <linux-btrfs+bounces-21203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xcKrKCO8emnJ+AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21203-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 02:47:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B262AAE02
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 02:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89B373005AA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5A2D7812;
	Thu, 29 Jan 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="deAXRFAj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vj/3v8QD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="deAXRFAj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vj/3v8QD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E891EB9E1
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651229; cv=none; b=SuvnReeVLKtVBYoccRKX7fpryj19vXhF4pZG8wEeyhmZ47YID1ffPiRiMd2Mg2azVdWIFEe76n5vXyo318maTNDRQv26RopgeoIlEsZzL1qBKYDUQGKbqnifuEyMKicX0EYgEpD1ap+fzwTpwmbvtpxjdfhfxqRts03qxhlent8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651229; c=relaxed/simple;
	bh=AS5wYPRBxhfV8kpwOkgGUiGbGocw0cW7+6PZMzB3jEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBIJiLHpQ9zY92lcaPMSjtSuBaBIg+3SWswr/p9gbkWVfKzh+wnlbx6cdywiBSpVyx7D9H52OvmrdjxSM2Vxc5af95KxaZar0LGpZ53n4ZPQynSKb4C/yF/EZj/4DD7d6rCJoJ2S95nmZEZah74I0ghGroAkhnFoyJ2XYuGFJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=deAXRFAj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vj/3v8QD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=deAXRFAj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vj/3v8QD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 563C533EA0;
	Thu, 29 Jan 2026 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769651226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqq/o/PoAQE3/LGsuRBM19muUiD6W7440Z9JDluw6GY=;
	b=deAXRFAj06suuCe94KYAsC+UnnDkBELj70MNkSad+8eXs1ygdngYHULw0v4sGN86DAmAAJ
	FA/Xh69FWTMGzrc3SBjHTY3iHjXCwnD8QzGk2E54oA6FAFi6rqQ0s6yREPf6ESk9Ps8dU6
	9yf0AUq6GTp8N9IDgrtfaDaajsgdnds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769651226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqq/o/PoAQE3/LGsuRBM19muUiD6W7440Z9JDluw6GY=;
	b=Vj/3v8QDtN02CuE9hzSI21LXZcp0Vz5T8U8PxNu0yatBlQC/14XS5N0Zs4ZfD0saW1rCgo
	NB92lbLTHbHl/RDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=deAXRFAj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Vj/3v8QD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769651226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqq/o/PoAQE3/LGsuRBM19muUiD6W7440Z9JDluw6GY=;
	b=deAXRFAj06suuCe94KYAsC+UnnDkBELj70MNkSad+8eXs1ygdngYHULw0v4sGN86DAmAAJ
	FA/Xh69FWTMGzrc3SBjHTY3iHjXCwnD8QzGk2E54oA6FAFi6rqQ0s6yREPf6ESk9Ps8dU6
	9yf0AUq6GTp8N9IDgrtfaDaajsgdnds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769651226;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqq/o/PoAQE3/LGsuRBM19muUiD6W7440Z9JDluw6GY=;
	b=Vj/3v8QDtN02CuE9hzSI21LXZcp0Vz5T8U8PxNu0yatBlQC/14XS5N0Zs4ZfD0saW1rCgo
	NB92lbLTHbHl/RDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3668A3EA61;
	Thu, 29 Jan 2026 01:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BBOYDBq8emm1eAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Jan 2026 01:47:06 +0000
Date: Thu, 29 Jan 2026 02:47:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 8/9] btrfs: get rid of compressed_folios[] usage for
 encoded writes
Message-ID: <20260129014704.GE26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1769482298.git.wqu@suse.com>
 <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
 <20260127202805.GA3504710@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127202805.GA3504710@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21203-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: 3B262AAE02
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:28:05PM -0800, Boris Burkov wrote:
> > +		if (!unlikely(ret)) {
> 
> Should this be unlikely(!ret) instead of !unlikely(ret)?
> 
> While !unlikely(ret) evaluates to the same boolean result as !ret, the
> branch prediction hint is inverted.

Once identified such trivial patterns can be caught by coccinelle
scripts, I've added that one (https://github.com/btrfs/workflow), though
it does not seem to be 100% reliable. A "grep '!unlikely'" works.

