Return-Path: <linux-btrfs+bounces-17105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC576B9484D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800912A0DA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2630EF92;
	Tue, 23 Sep 2025 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdzM+7j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CdYA6w6T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdzM+7j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CdYA6w6T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5935962
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608032; cv=none; b=L5f74lalU1x3MKRvKNrW/FFDrYqtT/KNvGCh8AFyJwEvmJe4Of2d5/wwyde2v+a2PTzdtmyI82ukO4QlzdDpvEE0VpHjqTQy5IuL+Hun0pY1OddRMG99e26Dfalw90pahOdRu/WJzg2QyAFvo8fHscdeYfHBPRqCUJANFltbTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608032; c=relaxed/simple;
	bh=J9gy6SwBwKbNJRJfqzaqaXsB6YC/9KQ5yKraVWpE0tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hik27PWNE/CYNpb0cshgzmi2dK3A+v91IoRdXFAXJhvQ8G0j6v8GIi+lkQhyG/VSj4zxA1KLfwOr05Evdq0spBHpmDwue8ezPaPrwHSmUf0AO/lvb3/zKX/cxrzQ5p1Xs+rCY6e3di0mPxpG0ffkLOqbVhS4ylr8MEIxdb8Nl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdzM+7j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CdYA6w6T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdzM+7j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CdYA6w6T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8264F1F387;
	Tue, 23 Sep 2025 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758608029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjM/026vtRrQBD0c3KLR3jf8ti+O6K0zxHGZ6S8iRi0=;
	b=wdzM+7j5CoZRSS1m0mYxE0T1lROQ6pPusUZwdwNg3cNCYmPIWOzN8QgfzHqRbH4xbmSJMj
	WZXvFwfCHtnVbOERrmZFjLsEf0ZuKqrKw0aP3KYUgdp+d8YvX+Yp0TbX7o6CeOBP6OjCVA
	X/g73sqKp4dwrW9eGKbFxO1oQfm3JxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758608029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjM/026vtRrQBD0c3KLR3jf8ti+O6K0zxHGZ6S8iRi0=;
	b=CdYA6w6TQn3KxlNVOfca0j4csMd/5VAC/jed12Duc/nXrLkYEHl6yY9lTPw15HtmGx4CPl
	y3X+FG9C7ky2FdAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wdzM+7j5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CdYA6w6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758608029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjM/026vtRrQBD0c3KLR3jf8ti+O6K0zxHGZ6S8iRi0=;
	b=wdzM+7j5CoZRSS1m0mYxE0T1lROQ6pPusUZwdwNg3cNCYmPIWOzN8QgfzHqRbH4xbmSJMj
	WZXvFwfCHtnVbOERrmZFjLsEf0ZuKqrKw0aP3KYUgdp+d8YvX+Yp0TbX7o6CeOBP6OjCVA
	X/g73sqKp4dwrW9eGKbFxO1oQfm3JxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758608029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjM/026vtRrQBD0c3KLR3jf8ti+O6K0zxHGZ6S8iRi0=;
	b=CdYA6w6TQn3KxlNVOfca0j4csMd/5VAC/jed12Duc/nXrLkYEHl6yY9lTPw15HtmGx4CPl
	y3X+FG9C7ky2FdAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67625132C9;
	Tue, 23 Sep 2025 06:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SX8UGZ060mhoFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Sep 2025 06:13:49 +0000
Date: Tue, 23 Sep 2025 08:13:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org, clm@fb.com,
	dsterba@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
Message-ID: <20250923061344.GT5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250919145816.959845-1-mssola@mssola.com>
 <20250919145816.959845-2-mssola@mssola.com>
 <20250922102850.GL5333@twin.jikos.cz>
 <87h5wu4pta.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5wu4pta.fsf@>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8264F1F387
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.21

On Mon, Sep 22, 2025 at 02:47:13PM +0200, Miquel Sabaté Solà wrote:
> Hello,
> 
> David Sterba @ 2025-09-22 12:28 +02:
> 
> > On Fri, Sep 19, 2025 at 04:58:15PM +0200, Miquel Sabaté Solà wrote:
> >> As pointed out in the documentation, calling 'kmalloc' with open-coded
> >> arithmetic can lead to unfortunate overflows and this particular way of
> >> using it has been deprecated. Instead, it's preferred to use
> >> 'kmalloc_array' in cases where it might apply so an overflow check is
> >> performed.
> >
> > So this is an API cleanup and it makes sense to use the checked
> > multiplication but it should be also said that this is not fixing any
> > overflow because in all cases the multipliers are bounded small numbers
> > derived from number of items in leaves/nodes.
> 
> Yes, it's just an API cleanup and I don't think it fixes any current bug
> in the code base. So no need to CC stable or anything like that.

Still the changelog should say explicitly that it's not a bug fix before
somebody assigns a CVE to it because it mentions overflow.

