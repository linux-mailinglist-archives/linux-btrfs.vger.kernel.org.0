Return-Path: <linux-btrfs+bounces-5068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A188C896B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 17:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECA21F223B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172A12F589;
	Fri, 17 May 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+Qdp+Aw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PUQo08cj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+Qdp+Aw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PUQo08cj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588012F398
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960237; cv=none; b=UJxCL2lLhMVgKJEL6uBfKzQynQFpzxXKGKWDYQGrKJkj4Tx9a32yyJWiP3SzZuDI121qfX0uk6ahWYEm33ACK6yFlMsUDBPMy/Q8wJY/SKcF5wbgC3PdVx9+XdzCT/1LSnpVYaImdsmXb0M/Nz3XfJfnh1mvPja2dBTYCeh2k8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960237; c=relaxed/simple;
	bh=oKHfKKrTRICISgZElKxFFBCWiUgwT5iM4UK7oVwsFcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ6XN9g/ShReXVK0LZL5fNSW0qAfR0XpFFfoR5l0Een11TAVc8IKxsM6oLYZ5x5NFlEsI4TB9um/FcOl2s1ygQeeyXNJIiajaxdLEEg7Xo99jaIbE1bNQn2Wa1ZcjG0KKKLFCud4Sl0TV9VywP3T2SjEFN2d/sFXpTGJUUeJYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+Qdp+Aw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PUQo08cj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+Qdp+Aw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PUQo08cj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6514D5D507;
	Fri, 17 May 2024 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715960233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhTv9pnw3YdFUqArw1Arnty7KfHH+/4CCjubg8HjUvQ=;
	b=L+Qdp+AwYb2qPRVxs+p3bxcGOon4NwXhXh0c5yDsy6XJ7I/XexLyHIXUESL1/jp5RPb8f1
	G/MSv5gDzX+VMxtEdszp1ZRsHAo4t0ekoFgzAkweHr6j35nI0Uwtm9jFBFUL13lX9ciAQ2
	wY6QXcOVEcsR5yMatNv/eDE7cksaotU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715960233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhTv9pnw3YdFUqArw1Arnty7KfHH+/4CCjubg8HjUvQ=;
	b=PUQo08cj3NLoGD8AaCAxPVxqtwVgynn48MehyrJdBO5eJd7GlfyE+55wPsAQCAKoZpXQuc
	SIAM0xePAn8XfvCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715960233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhTv9pnw3YdFUqArw1Arnty7KfHH+/4CCjubg8HjUvQ=;
	b=L+Qdp+AwYb2qPRVxs+p3bxcGOon4NwXhXh0c5yDsy6XJ7I/XexLyHIXUESL1/jp5RPb8f1
	G/MSv5gDzX+VMxtEdszp1ZRsHAo4t0ekoFgzAkweHr6j35nI0Uwtm9jFBFUL13lX9ciAQ2
	wY6QXcOVEcsR5yMatNv/eDE7cksaotU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715960233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhTv9pnw3YdFUqArw1Arnty7KfHH+/4CCjubg8HjUvQ=;
	b=PUQo08cj3NLoGD8AaCAxPVxqtwVgynn48MehyrJdBO5eJd7GlfyE+55wPsAQCAKoZpXQuc
	SIAM0xePAn8XfvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53FB513991;
	Fri, 17 May 2024 15:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KvQFFKl5R2YuIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 May 2024 15:37:13 +0000
Date: Fri, 17 May 2024 17:37:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tune: fix btrfstune --help for -m -M option
Message-ID: <20240517153711.GA17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4fba8ba903d32bba3f8f92db50823fd7aea38bc4.1715831939.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fba8ba903d32bba3f8f92db50823fd7aea38bc4.1715831939.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.91
X-Spam-Level: 
X-Spamd-Result: default: False [-3.91 / 50.00];
	BAYES_HAM(-2.91)[99.64%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.956];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, May 16, 2024 at 12:19:03PM +0800, Anand Jain wrote:
> The -m | -M option for the btrfstune, sounds like metadata_uuid is being
> changed which is wrong, the fsid is being changed the original fsid is
> being copied into the metadata_uuid. So update the help.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.

