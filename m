Return-Path: <linux-btrfs+bounces-15113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB795AEE3FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E97A70F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD5293B5A;
	Mon, 30 Jun 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sX6bXf8r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DRmz9FO5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sX6bXf8r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DRmz9FO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D91293474
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299924; cv=none; b=ofQplZDWXq4yDh++n/exeimjQoWxXazSqGwBY93gRbKTfjRqo9ZjnYqO0rp+sH2yGbPLtSqzjqez1di9lqaMfJQ3r/Tk23rE259AsPWphQ52czlZCikXMgbhNUhqO+JMXggUywfVzlblBLYBWBtOdWYK6RcKIsbJcDM5z0spaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299924; c=relaxed/simple;
	bh=OTgHz5BPWUyNmICGRHI+1HVx9C5GFaPFBrdd+vIsADY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQIvFy4Cs/MfItS6cMUTWPD3Y60MRzXYasdJn74oE03Xh4zuj+6Z/Qe2fhSpNzO1yDpgJ7MkCo9UiCDalhUe8ZE4zyoWjJIy/lT9JzOq/HiTOjVC6wWDx10aRXOJ4CweNvulXyvKSN4axBoc5fRj4HA0dRGDDmqd6Bx9dlztn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sX6bXf8r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DRmz9FO5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sX6bXf8r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DRmz9FO5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1453C1F393;
	Mon, 30 Jun 2025 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751299921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZB9L+qtg0kPF9bZYIHkALdIZecIHLBaU7RsTnIU8Pw=;
	b=sX6bXf8rNOO2I59qKECNYBSAgvu3bbn6qt29Zr1CkavFVffeP8iEcfqbQz8sMLYRW+l4Rd
	UrYBf/EE9ZkqELd0OQp0hm8odxPFxN56ZGvr5y1u7oe3Y7XnC6Yoz/hofHKJAzZSt7boMX
	ml6xa0VMtOuZzYI/IlRoEdWc78PfX6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751299921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZB9L+qtg0kPF9bZYIHkALdIZecIHLBaU7RsTnIU8Pw=;
	b=DRmz9FO5Av6Ena9lPfYzJzK4DQyduaSTYfL4/tTF2m3luxeNty/WPJ+9cCm7brj1htKs6O
	mFvSlQLhSqLOFbDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sX6bXf8r;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DRmz9FO5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751299921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZB9L+qtg0kPF9bZYIHkALdIZecIHLBaU7RsTnIU8Pw=;
	b=sX6bXf8rNOO2I59qKECNYBSAgvu3bbn6qt29Zr1CkavFVffeP8iEcfqbQz8sMLYRW+l4Rd
	UrYBf/EE9ZkqELd0OQp0hm8odxPFxN56ZGvr5y1u7oe3Y7XnC6Yoz/hofHKJAzZSt7boMX
	ml6xa0VMtOuZzYI/IlRoEdWc78PfX6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751299921;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZB9L+qtg0kPF9bZYIHkALdIZecIHLBaU7RsTnIU8Pw=;
	b=DRmz9FO5Av6Ena9lPfYzJzK4DQyduaSTYfL4/tTF2m3luxeNty/WPJ+9cCm7brj1htKs6O
	mFvSlQLhSqLOFbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B1713983;
	Mon, 30 Jun 2025 16:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZrVqAFG3YmhlFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 16:12:01 +0000
Date: Mon, 30 Jun 2025 18:11:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: accessors: delete token versions of set/get
 helpers
Message-ID: <20250630161159.GI31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751032655.git.dsterba@suse.com>
 <a7f51e27606c24c063007273d0189bad487b921f.1751032655.git.dsterba@suse.com>
 <8993e49a-7fc2-41a0-8dec-3dbbf84ec601@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8993e49a-7fc2-41a0-8dec-3dbbf84ec601@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1453C1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Sun, Jun 29, 2025 at 10:43:26AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/27 23:33, David Sterba 写道:
> > Once upon a time there was a need to cache address of extent buffer
> > pages, as it was a costly operation (map_private_extent_buffer(),
> > cfed81a04eb555 ("Btrfs: add the ability to cache a pointer into the
> > eb")).  This was not even due to use of HIGHMEM, this had been removed
> > before that due to possible locking issues ( a65917156e3459 ("Btrfs:
> > stop using highmem for extent_buffers")).
> > 
> > Over the time the amount of work in the set/get helpers got reduced and
> > became quite straightforward bounds checking with an unaligned
> > read/write, commit db3756c879773c ("btrfs: remove unused
> > map_private_extent_buffer").
> 
> Thanks a lot for the history of the token accessors.
> 
> And this is also a great chance to us to sync the removal of token eb 
> accessors to the progs.
> 
> If you haven't yet started that progs removal, I'm totally fine to do that.

I usually do the kernel->progs sync before a release, inspired by the
kernel git log where it applies. I haven't started with the accessors
updates as I have a few more changes to those files pending but I
wouldn't mind if you do it now.

