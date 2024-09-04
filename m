Return-Path: <linux-btrfs+bounces-7814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBBD96C485
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DDA2820F9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BB1E0B94;
	Wed,  4 Sep 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoIQbdBx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SqbGecLh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoIQbdBx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SqbGecLh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA71E0B8A
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469100; cv=none; b=JmuFOqd6g8P2ZQo23f3RZhRwtLnjT9a54CXD9S1vo0NFx5OvuMyBdD5NCHykoFRFin0Jddx4sNJH4KhzBrNFi3bcDt7gvmUW6nffrOaNqKyM5T8i8GZaJwDYn7mT1xLQtU7IYLkopmRVHYvQm6F2DbO0cv4RXS4jglEzc24Oku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469100; c=relaxed/simple;
	bh=VD0ol4tHMnUU70AmAWefdWJXphJd2uCHaHkZ3XqFAjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMAB6j7MoeZyMbdJ1Fmi7mo2O+BUqQi8pQcIT75T2YUz9jxOBWPpoQ5X9jXnpV2eDfKDQGs53JiO4t1kfHIS7ow1q5p+yJlTMQJcCRnMUyD7CdqH+0oKVyjOWpPQV2DZsQmmzpV48CFBWeUfJ+tlvXiuwp/vh87bU4ADhypF2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoIQbdBx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SqbGecLh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoIQbdBx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SqbGecLh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B88EC2197C;
	Wed,  4 Sep 2024 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725469096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Lt4fg0Y6hR6iBSbDrMfNMcIgozewpvBKnXGnx1T7EU=;
	b=yoIQbdBxtnYYi4146ElHnz1n7buWXgY7TrsXzuc6xHoCys91kNeW9i7aJIoK2u95p1ngA/
	enrkMRa4TRU7M1ut/Q9RpeVgU/roRCGyl+02/YzbMDC8VedMbsJlu3KveYM2tXdqZqUQKC
	4wVgGEMiKXy4yZFYiMBIBTT3mr6UBVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725469096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Lt4fg0Y6hR6iBSbDrMfNMcIgozewpvBKnXGnx1T7EU=;
	b=SqbGecLh/Mc4vcQAnZ3CQ+pKs84qkFz+PQUkWl9YI80RFqdI84Nx/NnbdzDyyCZg0q88Tj
	BzjN5nrnnZUxw8BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yoIQbdBx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SqbGecLh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725469096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Lt4fg0Y6hR6iBSbDrMfNMcIgozewpvBKnXGnx1T7EU=;
	b=yoIQbdBxtnYYi4146ElHnz1n7buWXgY7TrsXzuc6xHoCys91kNeW9i7aJIoK2u95p1ngA/
	enrkMRa4TRU7M1ut/Q9RpeVgU/roRCGyl+02/YzbMDC8VedMbsJlu3KveYM2tXdqZqUQKC
	4wVgGEMiKXy4yZFYiMBIBTT3mr6UBVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725469096;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Lt4fg0Y6hR6iBSbDrMfNMcIgozewpvBKnXGnx1T7EU=;
	b=SqbGecLh/Mc4vcQAnZ3CQ+pKs84qkFz+PQUkWl9YI80RFqdI84Nx/NnbdzDyyCZg0q88Tj
	BzjN5nrnnZUxw8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98068139D2;
	Wed,  4 Sep 2024 16:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f6PsJKiR2GY+JQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Sep 2024 16:58:16 +0000
Date: Wed, 4 Sep 2024 18:58:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/3] btrfs path auto free
Message-ID: <20240904165807.GM26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1725386993.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725386993.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B88EC2197C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Sep 03, 2024 at 11:19:04AM -0700, Leo Martins wrote:
> CHANGELOG:
> Patch 1/3
> 	- Move BTRFS_PATH_AUTO_FREE macro definition next to btrfs_path
> 	  struct.
> 
> The DEFINE_FREE macro defines a wrapper function for a given memory
> cleanup function which takes a pointer as an argument and calls the
> cleanup function with the value of the pointer. The __free macro adds
> a scoped-based cleanup to a variable, using the __cleanup attribute
> to specify the cleanup function that should be called when the variable
> goes out of scope.
> 
> Using this cleanup code pattern ensures that memory is properly freed
> when it's no longer needed, preventing memory leaks and reducing the
> risk of crashes or other issues caused by incorrect memory management.
> Even if the code is already memory safe, using this pattern reduces
> the risk of introducing memory-related bugs in the future
> 
> In this series of patches I've added a DEFINE_FREE for btrfs_free_path
> and created a macro BTRFS_PATH_AUTO_FREE to clearly identify path
> declarations that will be automatically freed.
> 
> I've included some simple examples of where this pattern can be used.
> The trivial examples are ones where there is one exit path and the only
> cleanup performed is a call to btrfs_free_path.
> 
> Leo Martins (3):
>   btrfs: DEFINE_FREE for btrfs_free_path
>   btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
>   btrfs: BTRFS_PATH_AUTO_FREE in orphan.c

I've merged the series with some adjustments, we're short on time
regarding the next merge window so we may not be able to do one more
iteration with the fixes. Thanks.

