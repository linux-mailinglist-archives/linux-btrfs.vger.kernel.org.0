Return-Path: <linux-btrfs+bounces-13039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A8A8A51A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 19:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CB53BA4A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D722192EA;
	Tue, 15 Apr 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dgLKvi1S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpuXXGzb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jjcVcKFA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rqBm99c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D32185A8
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737146; cv=none; b=U8IcLer8RUKNLHmZ0PrK6ueAWAw1FgmfF8+ymqiMjQ1fVhugdzh5D0LwpErlrdjA4pzcKDMQ/exqpCpkOTFSX1CS+5JsMx+Ko+2APN5AqkvMzmemZ45+F6+rLgQz5FWhqvo3TWMn5fT37AY97Efyu0IC1Do7Vr2y352eiOBc12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737146; c=relaxed/simple;
	bh=JzuekTe3Sb1rluDkYZ00MVFULECL7CPEavs6F/bavks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/OIwE5iJ2XfEOohlYx/yjNOg8FhbqCx8dJXiQQPQ7UYuPsCVnBZnI6SARwEaK4aqJRGYMXane9wn+vzqx2yXpAj0b2twEGe3fZZsJe78Nzd/x02rM3qtAarMLfIl3N9CgOdPd3YC5nTinNUrWoQx0E9R3lgXi2nU6kP+6OQxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dgLKvi1S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpuXXGzb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jjcVcKFA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rqBm99c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF4FA2118F;
	Tue, 15 Apr 2025 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744737143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csSGlNnq7HLtkGdQXgJDmSjkSlCwYpNK3NKJn4DL1Ek=;
	b=dgLKvi1SkNlLdVwopX3y7hWIralVgcL4gNyAAPzUvrxessieNZS/qtG//ZKSS79j2/0o4L
	CF/CCjN8sIQDRTUfA8EXw4bBcr/M4U/5YujvZAFbk8m63hj5Z18KYjYM7jPmpUBTvEJtX8
	UYbJFg2tTOBs1k9OEzjp7Hx/D3MlklY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744737143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csSGlNnq7HLtkGdQXgJDmSjkSlCwYpNK3NKJn4DL1Ek=;
	b=hpuXXGzbL/8NwtL0jDm8fI1/wluiDn0kVqjCUmRp3OY8+N72nfSV8gH6ko3cLkPNZdni+k
	RoIRxKtVRkbZYlCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744737142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csSGlNnq7HLtkGdQXgJDmSjkSlCwYpNK3NKJn4DL1Ek=;
	b=jjcVcKFADbPOjvzQ6FxlLY1RcD4GCah+8NUGq17wsPeZxJUcwjgVBB3s89if20tG7THuUU
	5f9hdkWOz8gI+2Ehmkob0WzGRg8hRC03l2F9US2UG2wwl/G+9SQdjFcQvjC6euQGCsDSNO
	Ttc2YiL+ZBYDHK8dVO9GrUxUMxixC0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744737142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csSGlNnq7HLtkGdQXgJDmSjkSlCwYpNK3NKJn4DL1Ek=;
	b=1rqBm99cYNglJjYJYKrtQ1CqbxjFmUIfwnsvOnYpeoAekvyjn9aQhqjqy9g1et7CIcaZ/s
	ejDGHg8QsVL32IAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3E0F137A5;
	Tue, 15 Apr 2025 17:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZeyYL3aT/mf4bgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 17:12:22 +0000
Date: Tue, 15 Apr 2025 19:12:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: reuse exit helper in btrfs_bioset_init()
Message-ID: <20250415171217.GJ16750@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250415035340.851288-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415035340.851288-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 14, 2025 at 09:53:40PM -0600, Yangtao Li wrote:
> Use btrfs_bioset_exit() instead, which is the preferred patttern in btrfs.
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -add Suggested-by

Adding tags is not a reason for resend, you can reply to the patch if
there's something trivial missing. If there are functional changes it
makes sense to resend.

Added to for-next, thanks.

