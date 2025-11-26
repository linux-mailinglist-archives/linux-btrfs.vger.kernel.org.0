Return-Path: <linux-btrfs+bounces-19354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 022CEC878FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 01:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F89E3537A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2731A262D;
	Wed, 26 Nov 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UsdBUXk7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z8/2IXWS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+36ZQqE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZTyNsXx1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42072F50F
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116132; cv=none; b=sSNyFLVORNzj60rQk5QqSg+AWoOmhm8PknelOKn8Uc18pzaa1tUJh2y4q3YP9wyjACQkyfkA5EZbCMlzyki5Qd6qJO4Ia6alaz2JragO3ubAibvMxc6W/ab+QdmpxoUS/7XdewzjFJFcnLiTuAX+r9In0/jdW5V2h5pmOW/ZmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116132; c=relaxed/simple;
	bh=U8S0GCMVAsz5L4cW+/Lnwdn0V9CF8ecI55CwDFThpaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7/3x5hqyWRlH54KHFG3Bo4jkzWqeg3JX9SAk2OzglIHfkcJnTl/TfbdOjyvlrBZENkGlwExYJjRvHigBfqS0/eVOb/0XnlvFPQOc4vCiWw5TqX7kJleu1YAr1waFg+/VKgpxWqNhun60aQlXo1MZbw0h0Xva5RYSdnqchrOIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UsdBUXk7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z8/2IXWS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+36ZQqE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZTyNsXx1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 308B45BD90;
	Wed, 26 Nov 2025 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764116129;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=UsdBUXk7cHjnJmRnaEU9hwoSxw0u7xi4eJ7jNFn9HnGssZlkNWZwdsLkIFz6V7a/SxLO7k
	OH5tJDOxwP/Cl0D6TUMN5AK/ss8iFCHysTYANRW30I35VkHoEyNxFkIF+et3rKSAPWL2i9
	Gu2k8Q6/z0Fc4chb2nz+CHvF58tq7xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764116129;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=Z8/2IXWSnC/1meP7MKHEHDgoVGl8DCZqvPJf7YYACY20+CPKSEcP1d07fy9qMQ8h3ocl+1
	vMCeTvZoyKtQ41Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764116128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=H+36ZQqE6tsgUZ3p0kXsOW6BF7+6g0EZJHttR9rj89roCzcqq0wwoYiI4VTpdvNwTtOhE5
	9u8I4U3p0u7Pgwl/XC77T1G6YADulSY7UGLDPRKsrms/UfSaUHkZeTnd2/O76m7fmMBg6j
	d5cBTfku1bJoGCuYrdhv8+Pr3xQQsoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764116128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sA8Pu6GjexaoK5oqKYEEM1+zYvyY2pk2eGWfIX+7D+A=;
	b=ZTyNsXx1x8aGHhtcF6r32cj8hJYdXoDcA8FgNYhp+sToGjV0IzY9+Bgm1d+N/q0ICBD6vQ
	n9RM9j8RSSAWfqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1819E3EA63;
	Wed, 26 Nov 2025 00:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqy4BaBGJmmAEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Nov 2025 00:15:28 +0000
Date: Wed, 26 Nov 2025 01:15:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Wol <antlists@youngman.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <20251126001526.GA13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Nov 25, 2025 at 06:25:41PM +0000, Wol wrote:
> Probably not the problem, but how old are the drives? About 2020, WD 
> started shingling the Red line (you had to move to Red Pro to get 
> conventional drives).

The WD SN700 is an NVMe, though one can imagine how they could be
actually shingled with slightly tilted overlapping sockets.

