Return-Path: <linux-btrfs+bounces-13470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A2A9F57E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B83318927A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626B279799;
	Mon, 28 Apr 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0//jG33q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="te+aYbD9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6ath4cq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K2lRdW6d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AA25D8E8
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857106; cv=none; b=DX23E6lJVW59gCzz27A1drobXr9XjULPi3lPbTgrr4Gcr4n4NDpaYSpEzs9EcpJ6GzCCsyqMdfZN9427kYgKNaRuZiKcQL7ILFSBV3Ndn0bUn++XgCvgc9K+xP4Woo/B444qbi1umYM6F6WROapQHJii+idY0pSnt+qT65niE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857106; c=relaxed/simple;
	bh=Zk13aGfhDq+/1CWbzAfpGtzdzATPDCszvqAQ33djx7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTwRcqlGgZs7uusQLZpKSsuEt2Eo8d3n32iuzKrVxZGBQbW7qx0bu3l2VbZBpJkoVc5RmGXPUyQ+SsEEGwCnr+6+5LHSKCwFLw7ssVHCTLnaRyLxPLfV4F+qYc0gzRJsZhwmz7fqsR2fi3Kg4a2tHybKCthaR+06zu2rM6vqbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0//jG33q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=te+aYbD9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6ath4cq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K2lRdW6d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7066021200;
	Mon, 28 Apr 2025 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745857103;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oozj7gfcIlpEKq6m23L1CXgS5MzQP8yU/GrBCvSFSMg=;
	b=0//jG33qpkek20V4dKhzAOSFYF/+ULOmjmlA3s6VU+T/vc6CN2ozHkrR8avWkjllz564St
	91b9IItOZdFrK3rv/e5OuMnsoz+3HzYg5wNkbiPmNxECBDS2/jzI8Xe/BOjsQrBydE3ec3
	wj83xbilUChJ5FrAKMN+mx6Y/f5b2fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745857103;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oozj7gfcIlpEKq6m23L1CXgS5MzQP8yU/GrBCvSFSMg=;
	b=te+aYbD9exzVDS313YR6s+B4ghrvO8S5/yUWlkwz5HWaBVUPbUxhE1V/bnrDUL7QU8tnVM
	NXm0hClH6T58pZCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745857102;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oozj7gfcIlpEKq6m23L1CXgS5MzQP8yU/GrBCvSFSMg=;
	b=E6ath4cqpZFttby24ICI7QCtelwubFA2M8vUFNFldnp0vNHIlQAJepxdCKYwew+YyqAqut
	Jcf3njieoJX6c1Mjcn6uLpzITvkNuYeCt71mhjj1BH0U0qs1dTHYv1ePmRy1SLb1KRk8Ck
	gpojYWCFRJo/CiEvct/R9JCtpFGq4Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745857102;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oozj7gfcIlpEKq6m23L1CXgS5MzQP8yU/GrBCvSFSMg=;
	b=K2lRdW6dTS+5AdsoAup3nAs2+8O4hMi4n8/KIzkzbi2H4lrNEpwafc2ertO/a1P/4DW8GO
	tMT9oNWBloGXeMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C6751336F;
	Mon, 28 Apr 2025 16:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RZVmEk6qD2idGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 28 Apr 2025 16:18:22 +0000
Date: Mon, 28 Apr 2025 18:18:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: handle empty eb->folios in num_extent_folios()
Message-ID: <20250428161813.GF7139@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 25, 2025 at 02:58:38PM -0700, Boris Burkov wrote:
> num_extent_folios() unconditionally calls folio_order() on
> eb->folios[0]. If that is NULL this will be a segfault. It is reasonable
> for it to return 0 as the number of folios in the eb when the first
> entry is NULL, so do that instead.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 9915fcb5db02..e8b92340b65a 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -292,6 +292,8 @@ static inline int __pure num_extent_pages(const struct extent_buffer *eb)
>   */
>  static inline int __pure num_extent_folios(const struct extent_buffer *eb)
>  {
> +	if (!eb->folios[0])
> +		return 0;

This somehow codifies that we have valid pointers in the first N
entries. The usage pattern for eb follows that and we don't manipulate
the folios once the object is initialized so I guess it's safe to do it
just like that.

Reviewed-by: David Sterba <dsterba@suse.com>

