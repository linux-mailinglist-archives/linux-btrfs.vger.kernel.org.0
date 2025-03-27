Return-Path: <linux-btrfs+bounces-12620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A294A73B37
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D718963CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5D215F56;
	Thu, 27 Mar 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXqEkVdM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5G/dcf48";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KauaiJT0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="24to0mBc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969EEEA9
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097106; cv=none; b=gNKUpJoIW1oeMiyJD5sQ2PZCM7BY6xtOxb37lDBUffPTqiq/YX1bcc9bdumSqYmKPQ9y3pUAkHuk/LjUUqZRnVXa2VABIvzQAHIpkr5G5yDQNwYrzrwh9a/IGpP5tMRUiUjxeL4SAX9JCHRA/6xIzZfiNVcVMSysem8omCfXV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097106; c=relaxed/simple;
	bh=O1Ksurn26koCpPZ4pFAbgYVePkNGt8LnRj8s2Hikk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9wJEmsWGteYnHFfjncKRHi/aNfTUhTZ/mRFoqRNi9fqIcw7FtONUBg4HZ/1TyykVV2gDRMsVqLtfL3zwQM/QwZPILlTTxPZXwaKgr4JszmucISub2cKF7kihazBtFaHbhE1DgwhLrJVK4+5L5V50tfih8sc/63KDLEW0twm32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXqEkVdM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5G/dcf48; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KauaiJT0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=24to0mBc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0EB5211A8;
	Thu, 27 Mar 2025 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743097103;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gK7Ti2aU8d7i4+napyZbIJ89TYhJeRvOoB5PEvXivE=;
	b=bXqEkVdMiSHIhIay6I54m1r0+NvRvdD9DnDWRKUtOmZAFN5OPJDXdBQnB+Nm5BLS6j6qTd
	f0j8/rX3aeVteypcKXpvUayue/AwNgFvoWKlN9pT3XmZVB6XBMdt+NkT5Y/ooKbbEyl/Zb
	DeRVm7vVmBIGBdTO3KZRyS/AXaSuQMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743097103;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gK7Ti2aU8d7i4+napyZbIJ89TYhJeRvOoB5PEvXivE=;
	b=5G/dcf48rlGk/lo0lK85QrwL0+JhUwlFaz3m+NjCRLXbekXe5KxntU/MTOKnpXgx/djlnF
	1d3fScnyQ9gQAEBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KauaiJT0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=24to0mBc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743097101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gK7Ti2aU8d7i4+napyZbIJ89TYhJeRvOoB5PEvXivE=;
	b=KauaiJT0eZswJbzoJjN9K4oe5Bs3QFySwiw3OCeILhdgYe8/EBUk7bTo6+wMlScQLQXxcW
	QRj3GufPBWxqN4VJxA9sEEM72ovX8Zky21Yiewd03AXQ1oWtAmoWU5bzXD4uZq3Ppkglds
	kWPTVJYtQQ/TiOwn4ssS5lBpdbTOX/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743097101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gK7Ti2aU8d7i4+napyZbIJ89TYhJeRvOoB5PEvXivE=;
	b=24to0mBceJzmKUqEfQlrmgS++0aHLzuB777umJUtwq35xkLmUcwikv7Op/YCR+8hGBxQDQ
	Jfb/traYXS+vAmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D54FD1376E;
	Thu, 27 Mar 2025 17:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CXjgMw2N5WdfHgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 17:38:21 +0000
Date: Thu, 27 Mar 2025 18:38:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] btrfs: introduce btrfs_space_info sub-group
Message-ID: <20250327173820.GY32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <355f307dca7ea6da7db20038d46b3ef7a2cedd4f.1742364593.git.naohiro.aota@wdc.com>
 <a97c2dc4-f83a-4db3-9655-db353bd44864@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97c2dc4-f83a-4db3-9655-db353bd44864@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F0EB5211A8
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 20, 2025 at 04:11:27PM +0000, Johannes Thumshirn wrote:
> > +		if (flags & BTRFS_BLOCK_GROUP_DATA) {
> > +			struct btrfs_space_info *reloc = kzalloc(sizeof(*reloc), GFP_NOFS);
> > +
> > +			if (!reloc)
> > +				return -ENOMEM;
> 
> I'd prefer:
> 
> 			struct btrfs_space_info *reloc;
> 
> 			reloc = kzalloc(sizeof(*reloc), GFP_NOFS);
> 			if (!reloc)
> 				return -ENOMEM;

Yes, only simple initializations should be in the declaration block,
e.g. integer calculations or pointer operaions. Allocations should be
always separated.

