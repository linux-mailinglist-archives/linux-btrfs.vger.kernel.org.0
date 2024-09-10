Return-Path: <linux-btrfs+bounces-7908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7F973A8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958951C2508A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E0199254;
	Tue, 10 Sep 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkgtW4oo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9u5wzj0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkgtW4oo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F9u5wzj0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94765136E2E;
	Tue, 10 Sep 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979823; cv=none; b=WG94og5FMdFYyh1aLKgBi70ZmRDpTPFYgUCbW2XybgBBVl3PD9VlGq4ZStaAfoAltUEny0u5zL8lUBJtceDgm3CiNzwx4tFTsYj6dMARMzpCy3y98vYwJsvPqgMkX2BeXFsckv18O5+X9j+C5nd3zBUr4whJQ82Vs/nDK6xwYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979823; c=relaxed/simple;
	bh=Ttb17fWPzBccPvewaZqFsvW9UFCAeycVOHXmA3i3a+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUnVtQappJlAYY09Zc2R/MC2HYiaVQtUcPJHALmLkWETs/uvOuFAG23mXux17rQjzsAytXUjMKBu0rxdb6czaOszqPzOrmQV2Jw1hfzL9gQRNLf4q845giXfXtMqzAfg1GE8mxOYmOqVBJl/tbvQqN+qoa+NLU0waekZMQbnUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkgtW4oo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9u5wzj0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkgtW4oo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F9u5wzj0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A52571F7D4;
	Tue, 10 Sep 2024 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725979819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ29AzcKDpDjGvOx70CsETlOuiNVFHfULBI6NQ4GRA0=;
	b=EkgtW4ooYQJ6e5ecQ9HcA/G0wRpAfi2FhfSpmKNsiTk0/LJy32mkcVuS4vTUf4Hy7kGW+M
	ocU40znkWPfpWkkmn8qa2x5KdABgjZ41eSCGPt/tIBcobjyW8/FR1cysGloA0UXb2Q72sp
	o0uPXSaAGMDXHyByb9Qez2Z2l0B1hxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725979819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ29AzcKDpDjGvOx70CsETlOuiNVFHfULBI6NQ4GRA0=;
	b=F9u5wzj0V0cZ5oQlDBuTBIbGTq4N+8kgA6OT4j06b2v29mlwuJkjw/DMR+fLMCiTTW8bVb
	Vi0Z8/kGj9bOcMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725979819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ29AzcKDpDjGvOx70CsETlOuiNVFHfULBI6NQ4GRA0=;
	b=EkgtW4ooYQJ6e5ecQ9HcA/G0wRpAfi2FhfSpmKNsiTk0/LJy32mkcVuS4vTUf4Hy7kGW+M
	ocU40znkWPfpWkkmn8qa2x5KdABgjZ41eSCGPt/tIBcobjyW8/FR1cysGloA0UXb2Q72sp
	o0uPXSaAGMDXHyByb9Qez2Z2l0B1hxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725979819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ29AzcKDpDjGvOx70CsETlOuiNVFHfULBI6NQ4GRA0=;
	b=F9u5wzj0V0cZ5oQlDBuTBIbGTq4N+8kgA6OT4j06b2v29mlwuJkjw/DMR+fLMCiTTW8bVb
	Vi0Z8/kGj9bOcMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B935132CB;
	Tue, 10 Sep 2024 14:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ruVHatc4GbJOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Sep 2024 14:50:19 +0000
Date: Tue, 10 Sep 2024 16:50:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
Message-ID: <20240910145018.GA17038@suse.cz>
Reply-To: dsterba@suse.cz
References: <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
 <CAL3q7H6NP_Rr33cdeV3+=GvseOafowaED-maWhtUw65P4Bti+w@mail.gmail.com>
 <617cf535-4534-42da-9bee-2ef6c2806efb@wdc.com>
 <CAL3q7H4nvqLwk7g=rZ3NVp+W2ttAHN7mi8QO-qy7hqhe0AzoJA@mail.gmail.com>
 <2a190823-3089-46a7-9e0f-14d77ae15692@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a190823-3089-46a7-9e0f-14d77ae15692@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto];
	TO_DN_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 09, 2024 at 12:31:23PM +0000, Johannes Thumshirn wrote:
> On 09.09.24 14:29, Filipe Manana wrote:
> >>>
> >>> So the idea I suggested was not like this.
> >>> The idea was just to not ever down_read() the semaphore if the current
> >>> task is the replace task.
> >>
> >> So your idea is sth like the following (not yet tested):
> > 
> > Yes, exactly.
> 
> Thanks.
> 
> >>> For my suggestion, since we will skip the locking of the semaphore,
> >>> we'll have to compare "current" with "dev_replace->replace_task"
> >>> without any locking,
> >>> but that's ok and we can use data_race() to silence KCSAN.
> >>
> >> I'll check if KCSAN actually complains about this.
> >>
> >> As for David's remark, do you prefere a pid or a task_struct to be
> >> stored in struct dev_replace?
> > 
> > I'm fine with either one.
> 
> Ok David, your call then. I'm fine with either one as well.

The task struct works, so please use it, thanks.

