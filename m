Return-Path: <linux-btrfs+bounces-14815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AAAE1AD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86A2165628
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173B257AF2;
	Fri, 20 Jun 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQjjHk2x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldaA/6Nq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBB6Gak9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0lBjmTQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADD221557
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421943; cv=none; b=SmW6AHOTdaxCl/UrkINEnFeWux2IUimSMyt93d8w5blz4oTSBOWnBUmTsA2A2ce0xKyagaTeAt4VH8MO+FUfbW9zSdZdTz+9MIDXWWGVC14lEdxkcghgnI+Whmh3y9X8kDj5Vqx9PBl1I3+I6T0bJI8cFBzq8cWnDv3BRMUvrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421943; c=relaxed/simple;
	bh=3qGzflmyvPoeLTG3PjAccF37fbSKpAe4/6XRUUxgX7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQonZ5jafedZx+8uC+XBfhQxojPrnMyU31JTdWrquwlq+4Z2VpU6Ashz64ojW/pAyUDCvBPFnVesPkmXo22misky7tmxfSQjwcDpWNFDs/o4DjSHkk33vD7Sb4ek00lfvziEFPxN3lnyLrmwbsfXNbq1eh/ONIu15AZkdGfC4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQjjHk2x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldaA/6Nq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBB6Gak9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0lBjmTQK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 911EE211C6;
	Fri, 20 Jun 2025 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750421939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfXyrbd+34KNSoNCCJM1TToftGyu0G5fjE2Rf9JOfCI=;
	b=fQjjHk2x+b3w5s63GMK/vNqiheVCS4jds2rRZEMSIMc3FcBOuZRao85j6Fz7wHyUspFuAw
	4XyczHa44XFhZkz6v9+6mig4ytIpZ4E1t9SNbYm04Ik1+JsydIeZFVv8jFk4ulHAWaahDT
	I/Qkxz3wkWGr5333j+y0yt5LjPV0xwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750421939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfXyrbd+34KNSoNCCJM1TToftGyu0G5fjE2Rf9JOfCI=;
	b=ldaA/6Nq1NgmK+iFsx0DEjE1y9vgChbNt9Urk7QAmoXgCQVA3Hng+ioHl4VHlWDHY1IDKp
	SjBX+/M00XJ0THCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FBB6Gak9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0lBjmTQK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750421938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfXyrbd+34KNSoNCCJM1TToftGyu0G5fjE2Rf9JOfCI=;
	b=FBB6Gak9YeJzqMluNa3SE545bF0Gg69UWRn1CKNxTRNwvGqlCpOsap3JLIhvAnQlQKo8mJ
	r9E5uYbgTZIt6qe2Tv9mZnfY8c6mtzkDHssOuzjfpgiD8RSFB084aLSeF4LnxJyWxySYzP
	RgfDD3bbuu9fPVMx9OcP/ZplR4vzfFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750421938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfXyrbd+34KNSoNCCJM1TToftGyu0G5fjE2Rf9JOfCI=;
	b=0lBjmTQK8Plg5sVTRzjdujIwp6IRCaU8G4VQzKpKyi+gtm6/Y1BNNTyJEttIdkp6bwDdrT
	pNzf9UDNZpDu/aCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79970136BA;
	Fri, 20 Jun 2025 12:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zjAwHbJRVWifJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 12:18:58 +0000
Date: Fri, 20 Jun 2025 14:18:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/6] btrfs: use the super_block as bdev holder
Message-ID: <20250620121856.GP4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750137547.git.wqu@suse.com>
 <20250619132918.GK4037@twin.jikos.cz>
 <37d284c5-36d5-4613-8722-e8fe34fb0705@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37d284c5-36d5-4613-8722-e8fe34fb0705@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 911EE211C6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Fri, Jun 20, 2025 at 08:34:05AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/19 22:59, David Sterba 写道:
> > On Tue, Jun 17, 2025 at 02:49:33PM +0930, Qu Wenruo wrote:
> >> [CHANGELOG]
> >> v3:
> >> - Drop the btrfs_fs_devices::opened split
> >>    It turns out to cause problems during tests.
> >>
> >> - Extra cleanup related to the btrfs_get_tree_*()
> >>    Now the re-entry through vfs_get_tree() is completely dropped.
> >>
> >> - Extra comments explaining the sget_fc() behavior
> >>
> >> - Call bdev_fput() instead of fput()
> >>    This alignes us to all the other fses.
> >>
> >> - Updated patch to delay btrfs_open_devices() until sget_fc()
> >>    Instead of relying on the previous solution (split
> >>    btrfs_open_devices::opened), just expand the uuid_mutex critical
> >>    section.
> > 
> > I've added the patches to linux-next for testing.
> 
> Thanks, although I have a 3-lines small patch to pass &fs_holder_ops 
> into all the bdev_file_open_by_path() calls, to enable bdev freeze/thaw 
> support.
> 
> That has already passed several rounds of tests here, and I believe it 
> may solve the problem of btrfs corruption during hibernation/suspension.
> 
> Should I just send it right now for extra tests, or stick to my original 
> plan to submit that along with the full shutdown support?

Please send it seaparately for more tests, thanks.

