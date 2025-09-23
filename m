Return-Path: <linux-btrfs+bounces-17109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C02DB94AB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 09:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D38B7A5464
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231753101DF;
	Tue, 23 Sep 2025 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AFhKP3lv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ik9UoiK6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzJIfg3A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w61iBXI6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41030FF1D
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610856; cv=none; b=pMlnxpFPQFTegvZovYnWORXXqD9M/fYdUlVBmK3dy97Kr9bKuHRIG9IIsSUVjlSRmnZYeBzht5kNqkRfozI6Cv2gNz7J5igVdgGJuTRpDhSGwBIDLVGnIQ0Dx/xPgvv7ScuvWE1odJeju7wNO/ok7KJ5tcqZ5rdX+7085pTMzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610856; c=relaxed/simple;
	bh=AURb2/KdbkDqT0hqbAeKgrdQJAKGmX4edR0qFVa4fQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbeDY54olc0P0z42vf72kgYNrBZ0Z5YPjDtPCwy0JuEng0QEk5GWjpSg1JztTvWoyfKJzfq291n9CKTp37vCwnxEOA8bUNPZZCuuXE+vBKqxrvt4Cz0evnfv01rA5tVK7sg7eEBKn1eaF/7rcdVPwSGr9IXJGZXAZSjApZhVY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AFhKP3lv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ik9UoiK6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzJIfg3A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w61iBXI6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABCD422091;
	Tue, 23 Sep 2025 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758610852;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fS5CPlGQIx2nd+oD6afmoL7xZjRr/TZ1BNhf+ak9sg8=;
	b=AFhKP3lvzcEkDHXwNSiIJKEGiHTpsYGAXlfF+Ymcho2ccFrNoqnSvWR4J3iuyJy0LKsg9c
	lT+adhSEysqsGEeV5Q64M3/BPrdUwzc1xdIMadOpKpfCBkch6QVXDLpoIxHGOPa7bwY9OO
	3VwZ8aNinGeFPK01eIPZFMq0jIe5ZeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758610852;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fS5CPlGQIx2nd+oD6afmoL7xZjRr/TZ1BNhf+ak9sg8=;
	b=Ik9UoiK68Oo/x4UxKxw5IWu/CZdcoEkCYq2zf4yq14EpDgmLLnEqx3QIUZhUkiRJHFJv5k
	LlxTcS0BHAheXKAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OzJIfg3A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w61iBXI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758610851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fS5CPlGQIx2nd+oD6afmoL7xZjRr/TZ1BNhf+ak9sg8=;
	b=OzJIfg3AYF35YUKJ/ZUpJyQucNHQ8m3sYUUKdME3H17Fy9AByHmjZ3nrK+fXkwpCVmBOaC
	lEP1FrlErSDBYaUVwqDULrhJ4HDIWZpH4aco1F7P+Y+GL0LusXdTwydgeHctXwLcb4dD9W
	REGfYxE8WX6PjVjtAWIfQ2rHBlF/8LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758610851;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fS5CPlGQIx2nd+oD6afmoL7xZjRr/TZ1BNhf+ak9sg8=;
	b=w61iBXI6HPMUhmDFh972wIZAhD4Iw93UgPC4lAmTTGb6oFx44EGyKM02gcBlM2zmjtHh3c
	BenSMMfg48Dj/BDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2CB1388C;
	Tue, 23 Sep 2025 07:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uT/FIqNF0misJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Sep 2025 07:00:51 +0000
Date: Tue, 23 Sep 2025 09:00:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org, clm@fb.com,
	dsterba@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
Message-ID: <20250923070045.GU5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250919145816.959845-1-mssola@mssola.com>
 <20250919145816.959845-2-mssola@mssola.com>
 <20250922102850.GL5333@twin.jikos.cz>
 <20250923061344.GT5333@twin.jikos.cz>
 <87jz1p4qd4.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz1p4qd4.fsf@>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ABCD422091
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Tue, Sep 23, 2025 at 08:47:35AM +0200, Miquel Sabaté Solà wrote:
> David Sterba @ 2025-09-23 08:13 +02:
> 
> > On Mon, Sep 22, 2025 at 02:47:13PM +0200, Miquel Sabaté Solà wrote:
> >> Hello,
> >>
> >> David Sterba @ 2025-09-22 12:28 +02:
> >>
> >> > On Fri, Sep 19, 2025 at 04:58:15PM +0200, Miquel Sabaté Solà wrote:
> >> >> As pointed out in the documentation, calling 'kmalloc' with open-coded
> >> >> arithmetic can lead to unfortunate overflows and this particular way of
> >> >> using it has been deprecated. Instead, it's preferred to use
> >> >> 'kmalloc_array' in cases where it might apply so an overflow check is
> >> >> performed.
> >> >
> >> > So this is an API cleanup and it makes sense to use the checked
> >> > multiplication but it should be also said that this is not fixing any
> >> > overflow because in all cases the multipliers are bounded small numbers
> >> > derived from number of items in leaves/nodes.
> >>
> >> Yes, it's just an API cleanup and I don't think it fixes any current bug
> >> in the code base. So no need to CC stable or anything like that.
> >
> > Still the changelog should say explicitly that it's not a bug fix before
> > somebody assigns a CVE to it because it mentions overflow.
> 
> Got it! I will submit a v2 and make this more explicit.

No need to, I've updated the changelog at commit time.

