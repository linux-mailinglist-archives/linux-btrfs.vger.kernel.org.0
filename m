Return-Path: <linux-btrfs+bounces-4650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17418B7250
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 13:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EAA1C230F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC98712C805;
	Tue, 30 Apr 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pMhqhVnS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7GtKO0/K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pMhqhVnS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7GtKO0/K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1C12C530
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475217; cv=none; b=Xq8HisCr2rX0lw6Ng6Ui+9CfzOaL7Ij+0CkGVMejPnO9wXkXHWHCT051HPD8d5xVejh+2tw1v8b89aM3i0S+1AurGaPMwPhkbUjN5kZ7eak9+cBxGNZHvgHVkpAfrMBp8vV+3SZdVFLSBNBD2saNskUDfuHMsalrTMd+TlPsmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475217; c=relaxed/simple;
	bh=XxL8pLKXOtj0/EyBQnoDeclrsQTd+gqD0v3ZuaPtV/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHGx6uHBieKP7d0+HapjtXXSpeF4X+1VBeJYgN5NEgky2CL6YOsrG36ly5M1aSlrQ7b9ycmjDKF5Ef1E07iB+vGCoJWyUK1F9fR1htT+xSX1qqXwHqgcCpfDYkC9q+Oj7jfUUpF8Em4yt+VpppOp7HzQ1NZpDqU+55Z8eyykI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pMhqhVnS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7GtKO0/K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pMhqhVnS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7GtKO0/K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 979261F7D3;
	Tue, 30 Apr 2024 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714475213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aDp7tiI38hi5lI9YIZD5yvQAh8XOUH6zStOp1UUXBY=;
	b=pMhqhVnS2vJyp52Chk8ZdogdQSQHnNj38k1mHRInpVwHsl4g6ULxxbMQg9lOM/lUWjZ3bw
	VmEUz12OntZZzz+/us4KPyaaNPgD163JqqcZ2mdsDhVch4k+r0MnwLePWP0EA0obaBC/+p
	sk3M/Izib4KkxA6kkcuBxsE4H/Qr6Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714475213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aDp7tiI38hi5lI9YIZD5yvQAh8XOUH6zStOp1UUXBY=;
	b=7GtKO0/KGy0M6/K93yE0fsdgSaX30+rbLLw+nheFkXw2I7Z80oKflzbse+A/K9ltE5Blmw
	IIP3VH45uQJlGyAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714475213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aDp7tiI38hi5lI9YIZD5yvQAh8XOUH6zStOp1UUXBY=;
	b=pMhqhVnS2vJyp52Chk8ZdogdQSQHnNj38k1mHRInpVwHsl4g6ULxxbMQg9lOM/lUWjZ3bw
	VmEUz12OntZZzz+/us4KPyaaNPgD163JqqcZ2mdsDhVch4k+r0MnwLePWP0EA0obaBC/+p
	sk3M/Izib4KkxA6kkcuBxsE4H/Qr6Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714475213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aDp7tiI38hi5lI9YIZD5yvQAh8XOUH6zStOp1UUXBY=;
	b=7GtKO0/KGy0M6/K93yE0fsdgSaX30+rbLLw+nheFkXw2I7Z80oKflzbse+A/K9ltE5Blmw
	IIP3VH45uQJlGyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8596E136A8;
	Tue, 30 Apr 2024 11:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id STB5IM3QMGaeAQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Apr 2024 11:06:53 +0000
Date: Tue, 30 Apr 2024 12:59:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240430105938.GM2585@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
 <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]

On Tue, Apr 30, 2024 at 07:35:11AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/30 02:01, David Sterba 写道:
> > On Mon, Apr 29, 2024 at 06:13:33AM -0700, Boris Burkov wrote:
> >> I support the auto deletion in the kernel as you propose, I think it
> >> just makes sense. Who wants stale, empty qgroups around that aren't
> >> attached to any subvol? I suppose that with the drop_thresh thing, it is
> >> possible some parent qgroup still reflects the usage until the next full
> >> scan?
> >
> > The stale qgroups have been out for a long time so removing them after
> > subvolume deletion is changing default behaviour, this always breaks
> > somebody's scripts or tools.
> 
> If needed I can introduce a compat bit (the first one), to tell the
> behavior difference.
> 
> And if we go the compat bit way, I believe it can be the first example
> on how to do a kernel behavior change correctly without breaking any
> user space assumption.

I don't see how a compat bit would work here, we use them for feature
compatibility and for general access to data (full or read-only). What
we do with individual behavioral changes are sysfs files. They're
detectable by scripts and can be also used for configuration. In this
case enabling/disabling autoclean of the qgroups.

