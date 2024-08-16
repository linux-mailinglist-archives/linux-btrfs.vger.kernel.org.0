Return-Path: <linux-btrfs+bounces-7285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A30295514B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 21:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54783284772
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30031C3F11;
	Fri, 16 Aug 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INfiEl7L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmgr6lxg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INfiEl7L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmgr6lxg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E046F30D;
	Fri, 16 Aug 2024 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835911; cv=none; b=S8LqzT2RA3XO4SIT8vld51lXyRCzkEX5SyUqpTmQERTGSuC8aHPBMp1uLJJfXhwdTcrhVIpgDyQ9UApVZ3eQGcqr35iorAjNkybe8CqUtrbtol9FryzXaZXYY3uuxDSRbOfUq7ZkcWA+Sn2nqw2MNstpgmnlnZQDgdmsFTEeWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835911; c=relaxed/simple;
	bh=wRF91Xuac5qlFY6lEYkJrYyrF3JIQi24NGZajxH9k/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhTd/ZcjOrBJK2EWbDkCPo/PLzZQwc0CxxMMajsOnB8gMo/prE6ObR7wR9FOLs51uj3/+DuyQN8QjZyKjjK7BB+7BpQ/zN2Fzgffi62YN+wXpZpqF5CSlxElvLQA+HJKPTWXxIAUU2hJuESEqj8MZ+XuwNn50FxoR8XBh2Sk5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INfiEl7L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmgr6lxg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INfiEl7L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmgr6lxg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94E13200F8;
	Fri, 16 Aug 2024 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723835906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRt9XlnmYrBnBCRNCGsrSo1pRzErx88p8BUGEGdG2mc=;
	b=INfiEl7L/2s7UzmGv5FdD40Y4VIqvQUw2fq1lKPukeoNzXGFqEWdfNZzxjFd9E/JaYB7lT
	1HpiNHo9mdXGKV5fSK8ZCZ2nmryHF6vWNw8GjURVRuA+arnXpwwI6IWL/iOtOMD/+Fcld1
	WMGzThWSqX8EAYAivD48XNhHxW8DEeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723835906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRt9XlnmYrBnBCRNCGsrSo1pRzErx88p8BUGEGdG2mc=;
	b=hmgr6lxgW7DE9po9ONoWWkcn1/wfn6ccYX+zg8/gOz9Wfq/cgWrxvyUxPCt7d6DV+KtCGe
	/aZZ+1Glry7q+kDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723835906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRt9XlnmYrBnBCRNCGsrSo1pRzErx88p8BUGEGdG2mc=;
	b=INfiEl7L/2s7UzmGv5FdD40Y4VIqvQUw2fq1lKPukeoNzXGFqEWdfNZzxjFd9E/JaYB7lT
	1HpiNHo9mdXGKV5fSK8ZCZ2nmryHF6vWNw8GjURVRuA+arnXpwwI6IWL/iOtOMD/+Fcld1
	WMGzThWSqX8EAYAivD48XNhHxW8DEeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723835906;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRt9XlnmYrBnBCRNCGsrSo1pRzErx88p8BUGEGdG2mc=;
	b=hmgr6lxgW7DE9po9ONoWWkcn1/wfn6ccYX+zg8/gOz9Wfq/cgWrxvyUxPCt7d6DV+KtCGe
	/aZZ+1Glry7q+kDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75A471379A;
	Fri, 16 Aug 2024 19:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yDgxHAKmv2Z/VgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 16 Aug 2024 19:18:26 +0000
Date: Fri, 16 Aug 2024 21:18:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: only enable extent map shrinker for DEBUG builds
Message-ID: <20240816191821.GI25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <09ca70ddac244d13780bd82866b8b708088362fb.1723770634.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ca70ddac244d13780bd82866b8b708088362fb.1723770634.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -8.00

On Fri, Aug 16, 2024 at 10:40:38AM +0930, Qu Wenruo wrote:
> Although there are several patches improving the extent map shrinker,
> there are still reports of too frequent shrinker behavior, taking too
> much CPU for the kswapd process.
> 
> So let's only enable extent shrinker for now, until we got more
> comprehensive understanding and a better solution.

Thanks, that's probably better than to disable it completely. I'll
forward to patch so we get it to sable next week.

Reviewed-by: David Sterba <dsterba@suse.com>

