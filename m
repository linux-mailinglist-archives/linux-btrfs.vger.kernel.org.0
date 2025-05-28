Return-Path: <linux-btrfs+bounces-14285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB743AC7474
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 01:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD28BA43EA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE651F37D3;
	Wed, 28 May 2025 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7FgeKJC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEZ6rMUi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7FgeKJC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEZ6rMUi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24152221FCB
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474341; cv=none; b=DXgZj/JwJDVIThVabkQHXPzPDm0/blzyLrT3tXz1g2+yykLhqgSpMWhz9SVnMcOek+4xsYowWQ61k/69GYLWO+tJbY3OHgoXV/GBPti+Bc7M9f2ES+ZBvFKTuuxvFIyAiY506zcMeKcOf9NcZYSdd/CO/7QjeE7+tJqQNTtSPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474341; c=relaxed/simple;
	bh=O7L3fLy+QaTyix+eKylq/aIqGwtqBPG8+wkD5igJ/MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd3DBNwRqmDo5QpgkoBJgCQbBB/+HbtUMb9GeSSIyBRV4IUGA7PHwHkf3g3qcYCd1w6NzZwp4duzBuq3AucEk5q+y+TGEOwq3qaolDdWvl1+kFg9oJni//woEbjG/yPgN/okUQqPkZpwYlIP3qLiQVoVI9p6FBpd2mzsZihrvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7FgeKJC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEZ6rMUi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7FgeKJC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEZ6rMUi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14B6521A44;
	Wed, 28 May 2025 23:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748474338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCXvysN7+NzyL6KlTscHZe37ZnGxUoud6K9PjSrxwcU=;
	b=f7FgeKJCaP8udS5flaQ/XDRjskpOz2ZxTXVGwNXS/KkL8KFyFvj4DxYcoRROZeZCoXkLNV
	2DGoK2j7kdB0hP74poS+L9J5uVb+KdS8qJV+jf1TflZLZDHUtKoJyEBgcItAOwVmaJmRLI
	jBTc/j7a5cDoOKgpoWgo3N9CQBScroc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748474338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCXvysN7+NzyL6KlTscHZe37ZnGxUoud6K9PjSrxwcU=;
	b=gEZ6rMUiWmu8DVQXlo2Vx0ZGW1JSo9oU6RNcCYmQQ3UpXuFz9yD9mmhiXPPQ4oHukpYjND
	LjbtXOC5LJkYsGBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748474338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCXvysN7+NzyL6KlTscHZe37ZnGxUoud6K9PjSrxwcU=;
	b=f7FgeKJCaP8udS5flaQ/XDRjskpOz2ZxTXVGwNXS/KkL8KFyFvj4DxYcoRROZeZCoXkLNV
	2DGoK2j7kdB0hP74poS+L9J5uVb+KdS8qJV+jf1TflZLZDHUtKoJyEBgcItAOwVmaJmRLI
	jBTc/j7a5cDoOKgpoWgo3N9CQBScroc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748474338;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCXvysN7+NzyL6KlTscHZe37ZnGxUoud6K9PjSrxwcU=;
	b=gEZ6rMUiWmu8DVQXlo2Vx0ZGW1JSo9oU6RNcCYmQQ3UpXuFz9yD9mmhiXPPQ4oHukpYjND
	LjbtXOC5LJkYsGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF4C6136E0;
	Wed, 28 May 2025 23:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z/4wOuGZN2ibWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 23:18:57 +0000
Date: Thu, 29 May 2025 01:18:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
Message-ID: <20250528231856.GK4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250514131240.3343747-1-neelx@suse.com>
 <20250515144742.GH9140@twin.jikos.cz>
 <CAPjX3FcSigbx4siWMvxUFyeQk3u-WwnWTgqikcDB0vxwwZHFjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FcSigbx4siWMvxUFyeQk3u-WwnWTgqikcDB0vxwwZHFjw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email]
X-Spam-Level: 

On Mon, May 19, 2025 at 12:38:14PM +0200, Daniel Vacek wrote:
> On Thu, 15 May 2025 at 16:47, David Sterba <dsterba@suse.cz> wrote:
> >
> > Please write more descriptive subject lines, related to what is being
> > cleaned up, and not just a generic "function() cleanup".
> >
> > On Wed, May 14, 2025 at 03:12:39PM +0200, Daniel Vacek wrote:
> > > This function is always called with the LINK_LOWER argument. Thus we can
> > > simplify it and remove the LINK_LOWER and LINK_UPPER macros.
> > >
> > > The last call with LINK_UPPER was removed with commit
> > > 0097422c0dfe0a ("btrfs: remove clone_backref_node() from relocation")
> >
> > While removing the code is ok, looking to the git history I think
> > there's probably more, related to the node linking. Here it's removing
> > one half (LINK_UPPER).
> 
> I'm not sure what you mean here. I mentioned the commit you suggested.
> Checking the rest of edge linking I don't see how it could be
> trivially simplified further.

The idea is to look around if there's possibly more code to be removed,
not trivially but based on the logic related to the removed code for the
LOWER part. The relocation code is complicated so this is beyond the
cleanup and don't have a specific suggestion, so let's take what we have
now.

