Return-Path: <linux-btrfs+bounces-12289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12FA620FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B17A949B
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9221EEA59;
	Fri, 14 Mar 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dydEwDS5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DIlnz32M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dydEwDS5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DIlnz32M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD651B0F2C
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993088; cv=none; b=Ri84eiAGhLSi2KmE6eGsnEp11o6hxc43NZEczlBRgTVhTkszE14wY/6GwGw9eBTJFjweQE8Q7Gu48vsAplZYqfb9CP+Ot9xKSxd9COfvCaMOf8/e+K8eKxwiP614k7dyo76g9hXcfcARyntE1KfZhkeRJt0VRuqT9CG7YF3cd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993088; c=relaxed/simple;
	bh=UoiZHk+Tq2g9j3DFxZfh7MhZRbhbyjg/fyyUFgvKRdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZH6/EJ+eJ6vgBTEewAa1Px3osZ6JB+ulpdz6w+sRasJFBLP+tTspDehkg8y6DRTOzMc7+BmhSiv5eZPhedSvCunJJkS3NTS7oPFsFhvZ3pkwklwtYHhagq6jegaAZbI4GGd+JHN6IWqKMdGpImLW1+12YQ7CUmh/D3Z2Zvw6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dydEwDS5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DIlnz32M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dydEwDS5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DIlnz32M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DC821F388;
	Fri, 14 Mar 2025 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741993085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRx3uAr6lov8PcWpeC1rUhe24vk9F6Cvn7aHX6Im6zU=;
	b=dydEwDS55w6OnIw1l6u81kTS/aDGCRIis0VhL1jiAO9wil0EelHgegss78p557jb7otUYj
	S5D2SdC9fkrP+FcoYm/3WwuXuo8hx1XXsH2vA1yefnLZHXLirDURgUmnRDxzZ5Ew5ysFLu
	jD3NLCBAZYoFtIqok/an128D+CxWQL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741993085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRx3uAr6lov8PcWpeC1rUhe24vk9F6Cvn7aHX6Im6zU=;
	b=DIlnz32MuuQYlykl+tLXWQzdFlOIc5/bLxeqS0jlqZE3esx/aYuMuRyJ50Cim9yC3MGmfl
	kQUY+Nf49UeCv6Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dydEwDS5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DIlnz32M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741993085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRx3uAr6lov8PcWpeC1rUhe24vk9F6Cvn7aHX6Im6zU=;
	b=dydEwDS55w6OnIw1l6u81kTS/aDGCRIis0VhL1jiAO9wil0EelHgegss78p557jb7otUYj
	S5D2SdC9fkrP+FcoYm/3WwuXuo8hx1XXsH2vA1yefnLZHXLirDURgUmnRDxzZ5Ew5ysFLu
	jD3NLCBAZYoFtIqok/an128D+CxWQL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741993085;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRx3uAr6lov8PcWpeC1rUhe24vk9F6Cvn7aHX6Im6zU=;
	b=DIlnz32MuuQYlykl+tLXWQzdFlOIc5/bLxeqS0jlqZE3esx/aYuMuRyJ50Cim9yC3MGmfl
	kQUY+Nf49UeCv6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F03E132DD;
	Fri, 14 Mar 2025 22:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DHLcDn201GdrQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 14 Mar 2025 22:58:05 +0000
Date: Fri, 14 Mar 2025 23:58:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: send: remove the again label inside
 put_file_data()
Message-ID: <20250314225803.GT32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741839616.git.wqu@suse.com>
 <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
 <20250314165253.GR32661@twin.jikos.cz>
 <78d2f543-1ffc-4454-830c-e52a6eae024c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78d2f543-1ffc-4454-830c-e52a6eae024c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5DC821F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sat, Mar 15, 2025 at 08:20:43AM +1030, Qu Wenruo wrote:
> 在 2025/3/15 03:22, David Sterba 写道:
> > On Thu, Mar 13, 2025 at 02:50:43PM +1030, Qu Wenruo wrote:
> >> The again label is not really necessary and can be replaced by a simple
> >> continue.
> >
> > This should also say why it's needed.
> 
> Do you mean why we need to continue, or why the old label was needed?

Something about that old and new code is equivalent and what implies
that (no changes in the variables). Changes in the control flow could
change invariants.

