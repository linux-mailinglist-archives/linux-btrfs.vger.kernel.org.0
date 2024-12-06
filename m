Return-Path: <linux-btrfs+bounces-10098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59139E76DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0D2874B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1114A4F0;
	Fri,  6 Dec 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="issa/4vA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GNjCoOos";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNv9ZD6T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eGVXqYSk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6E206299
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505490; cv=none; b=axwZVYGMUfJN238QwHYftdN3qv418OsvuSYvCcgDkJ2ieb+cJN1/BP1p2eFlMxphgn00WNvSbvODIpqSB54CeCV/ZpR3GaIKXME0tfVfQRTZg7jDabYvY9Mcs4APYlskYYdMFvUhsHybBOBQy3ciqIzyGsBWp7mYCIwNB6ckxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505490; c=relaxed/simple;
	bh=ioDOjJphd3rW5oPXpM7h6/utk2cMn4TspmVCxP/rgPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc/sEmhI+4WRhpZzjj14kD1Fs21HYcnZPzKAF1NLaP1WOaB9A1oXGQMWoEaONjB/MmMjpTg4CPVWVH9Fnt4V49XEdzvG6tRLL/V8DK6qXG0CwO9XR7hoVh3qcrTsSJz9/l+A3d4oRG8v0kkJjuZGv+s+GS1Kc51idKTVAu5PJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=issa/4vA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GNjCoOos; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNv9ZD6T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eGVXqYSk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FB9E2110A;
	Fri,  6 Dec 2024 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733505486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNhbm6tZZ6MeiQFoZ88NViB6dXtj3Eo5i8oVturks3o=;
	b=issa/4vAh5X2ac6LDY36KT9rTvHiKEYS7m36Ul8anW5kj3Sa5X862utWefhyod69DcnpPn
	ogmfvRZDUg8Y/9Oh5R12M7/LGG8kbLDyjFdoCnFzB/hyONOq04uSYWYv6Y4odPKsga51bR
	iBWCN3w+1hnX681Ki5nYXCZrWBW8ZfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733505486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNhbm6tZZ6MeiQFoZ88NViB6dXtj3Eo5i8oVturks3o=;
	b=GNjCoOosjA7XTptWQ7QMnaBWh6mazsKwEE+HsY06Xn6P+FMOhRUx6rHv0lSCIUlW7gqeDd
	pNE+cen63rhu1mDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733505485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNhbm6tZZ6MeiQFoZ88NViB6dXtj3Eo5i8oVturks3o=;
	b=HNv9ZD6T7wBHZK3Vm/AGyr684HG4IkpmwBGhTJ/YN6QreIJQnMRZGHk3XfLNmU7413chua
	wSm8GxN5leCD3IkY14xB5CZ9Zn6ndINnRmQqyfeJz3hCMDJVt8NbRlr2GJ80H4vZ2S0oV0
	wyxnQj+J1PqHPEh1IR8LKpypezZJqnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733505485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNhbm6tZZ6MeiQFoZ88NViB6dXtj3Eo5i8oVturks3o=;
	b=eGVXqYSkK+UQd0q5ts7qimeuPti9JBQbYomFvrRyRWjvYbDDBHE9hnDNRtjGyzaP3UW3VX
	lxPcM7ENg/1x+RDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D70C13647;
	Fri,  6 Dec 2024 17:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bsx+Gs0xU2fwGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 17:18:05 +0000
Date: Fri, 6 Dec 2024 18:18:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v3 07/10] btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status
Message-ID: <20241206171800.GJ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731076425.git.anand.jain@oracle.com>
 <a3749f20bc368ce20781f7a294d78a39386cd234.1731076425.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3749f20bc368ce20781f7a294d78a39386cd234.1731076425.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 15, 2024 at 10:54:07PM +0800, Anand Jain wrote:
> Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
> CONFIG_BTRFS_DEBUG") introduces a way to enable or disable experimental
> features, print its status during module load, like so:
> 
> Btrfs loaded, debug=on, assert=on, zoned=yes, fsverity=yes
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Oh and please change the subject so it's actually understandable, 'pr'
is not a verb.

