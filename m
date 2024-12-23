Return-Path: <linux-btrfs+bounces-10640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644AC9FB4A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 20:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B756F1884CB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEC1C3C02;
	Mon, 23 Dec 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6pCLOaG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mPtztKUf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6pCLOaG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mPtztKUf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53574161328;
	Mon, 23 Dec 2024 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734981548; cv=none; b=Pu0e3FR8MuFWGsEGBlNs7lYiFsNRegCR2/G/gyYM0oGcr4DQERHpoHWgOmRh0vc+p1p13+VQlb3ueTY94ihFzawgA+6s5PxEsRP5XR5wPyD7pXzzGIArC6GIIZdIu6vk9t8VDbrbAR9dQ6jBpxxxO8T2yhB/5AP7LJJknHWFSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734981548; c=relaxed/simple;
	bh=PG06oFbSnKDZgG9APbXSuV7Zby8YIDotlMezzwQlCaY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjFBhmeAmwxGs1zYS492273EtJqPlbzvaZTd6uSHrZcutjNvu3BG9EaonrxT9AHC4zeo9nUtXIq7CU/AMBh3WuTUOAUiPwQ4z9OCL9eMjOMN0YsUI9AvbSWfmDeB1hlA1vMgdCw1zC5yiQQV49gPwG6I0K113y4UMQzAGafpqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6pCLOaG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mPtztKUf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6pCLOaG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mPtztKUf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48F6A22056;
	Mon, 23 Dec 2024 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734981538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWlU1D/qA2+BDZ7v959Jv9tTkte+COenKkLeak7XEKk=;
	b=c6pCLOaGZKU+df6S6BCI3AUgLksNnrVYjOg72GDssJDW1PNcodjtaqLMbunSaUgzKKzE+y
	5MlO6LRIePyPqtG5xp6IoBaLjGNBe90bP2sSd6ir4bLcADZ3oEqyru58TtbrHly5XiHM08
	+TzDqwjAio/HlErv5N5c4m9hzf0nREY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734981538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWlU1D/qA2+BDZ7v959Jv9tTkte+COenKkLeak7XEKk=;
	b=mPtztKUfNcBoaqmD3Me2JbTpk00R3Ku7k1+4rQYRgCbjhTzf0AZZqhj7jQ2CKoEF5+zgZv
	SY9OoZHY9TRI//Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734981538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWlU1D/qA2+BDZ7v959Jv9tTkte+COenKkLeak7XEKk=;
	b=c6pCLOaGZKU+df6S6BCI3AUgLksNnrVYjOg72GDssJDW1PNcodjtaqLMbunSaUgzKKzE+y
	5MlO6LRIePyPqtG5xp6IoBaLjGNBe90bP2sSd6ir4bLcADZ3oEqyru58TtbrHly5XiHM08
	+TzDqwjAio/HlErv5N5c4m9hzf0nREY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734981538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWlU1D/qA2+BDZ7v959Jv9tTkte+COenKkLeak7XEKk=;
	b=mPtztKUfNcBoaqmD3Me2JbTpk00R3Ku7k1+4rQYRgCbjhTzf0AZZqhj7jQ2CKoEF5+zgZv
	SY9OoZHY9TRI//Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3416713485;
	Mon, 23 Dec 2024 19:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0/V6DKK3aWfgawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Dec 2024 19:18:58 +0000
Date: Mon, 23 Dec 2024 20:18:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't include '<linux/rwlock_types.h>' directly
Message-ID: <20241223191852.GJ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241217070542.2483-2-wsa+renesas@sang-engineering.com>
 <0199c644-dfd7-43ce-b02a-459461299fb7@gmx.com>
 <Z2QDK9uFrXUIhJn2@shikoro>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2QDK9uFrXUIhJn2@shikoro>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[sang-engineering.com,gmx.com,vger.kernel.org,fb.com,toxicpanda.com,suse.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Thu, Dec 19, 2024 at 12:27:39PM +0100, Wolfram Sang wrote:
> Hi,
> 
> > > -#include <linux/rwlock_types.h>
> > > +#include <linux/spinlock_types.h>
> > 
> > I think we can just remove the *_type.h include header completely.
> 
> I agree, spinlock.h is enough.

I've updated the fix to drop rwlock_types.h as spinlock.h is already
there. Added to for-next, thanks.

