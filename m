Return-Path: <linux-btrfs+bounces-4874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E688C1397
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8399B1C20E29
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE1DDDA;
	Thu,  9 May 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7HInkw4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4PQ8C7wk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7HInkw4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4PQ8C7wk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58DDDA9
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274823; cv=none; b=t2arG3Kqhw/5KXcmO1KZc49w7V8fzSDwruEE0aQsbQL7I7a1angWN7MWPv5LdbjHFJ4xJBxbxH8Dz84utILtcq2fdaOh+K0nuApmhQEZsP9UlcSCOejpwSDkgoJ92N9YkOpOSjp9DTbmzJpu81Co2vvIUB5vZ+K1wnyAcqv5hHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274823; c=relaxed/simple;
	bh=Zpc/UZg9KmtzVrdZj6JLXmazBg8mSgHMGAyfK7f4wsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+tCCp+vktENQvGSFyOB+epWKSzccfkoAl1L6TmCLvQfFKLVDc2wBN5OXSfHoMgfwaQQaveFfLwNFekM1t9Uwh8UGsDsoPA/mB+9Ot1ZPuf/l/Zrz/TnPFZnczXsaQf9BUb+U18eFnFaAQSsFgquyub0FTTuGc04J5EdDh7J/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7HInkw4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4PQ8C7wk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7HInkw4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4PQ8C7wk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1018D38A08;
	Thu,  9 May 2024 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715274819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4S6xNzx3JzTsKRwfpzlfqEnnwPzU82aRMnlU8XJfRRk=;
	b=S7HInkw4VXj1zF/3y/SAMRMhPXrB/o8YZBw4rPZDo+uCB2aFqpGIVO1iqPvMiYgMA1plIB
	YwM630vWbwWrxdQ54B4I36Fb6HxerpEeI4tClsoa+6+7bLRAumn5Ww7jCM7tUdOuA60MAb
	E459D38Es5F+7DoBI/GZXtc5qv8iPP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715274819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4S6xNzx3JzTsKRwfpzlfqEnnwPzU82aRMnlU8XJfRRk=;
	b=4PQ8C7wkugulQfn7OI4NsY4Y5er4hxw0HfHDAW8Q5WOkEqvDPImgKlPIYfX6ioHej66ANx
	4MDfhnKu546Yg6Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715274819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4S6xNzx3JzTsKRwfpzlfqEnnwPzU82aRMnlU8XJfRRk=;
	b=S7HInkw4VXj1zF/3y/SAMRMhPXrB/o8YZBw4rPZDo+uCB2aFqpGIVO1iqPvMiYgMA1plIB
	YwM630vWbwWrxdQ54B4I36Fb6HxerpEeI4tClsoa+6+7bLRAumn5Ww7jCM7tUdOuA60MAb
	E459D38Es5F+7DoBI/GZXtc5qv8iPP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715274819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4S6xNzx3JzTsKRwfpzlfqEnnwPzU82aRMnlU8XJfRRk=;
	b=4PQ8C7wkugulQfn7OI4NsY4Y5er4hxw0HfHDAW8Q5WOkEqvDPImgKlPIYfX6ioHej66ANx
	4MDfhnKu546Yg6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2ED213A24;
	Thu,  9 May 2024 17:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FXXlOkIEPWYbMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 17:13:38 +0000
Date: Thu, 9 May 2024 19:13:36 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix use-after-free due to race with dev
 replace
Message-ID: <20240509171336.GL13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ccab86c78fc2a1fd6dd320efa289863df7158ca9.1715167144.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccab86c78fc2a1fd6dd320efa289863df7158ca9.1715167144.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 08, 2024 at 12:20:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> While loading a zone's info during creation of a block group, we can race
> with a device replace operation and then trigger a use-after-free on the
> device that was just replaced (source device of the replace operation).
> 
> This happens because at btrfs_load_zone_info() we extract a device from
> the chunk map into a local variable and then use the device while not
> under the protection of the device replace rwsem. So if there's a device
> replace operation happening when we extract the device and that device
> is the source of the replace operation, we will trigger a use-after-free
> if before we finish using the device the replace operaton finishes and
> frees the device.
> 
> Fix this by enlarging the critical section under the protection of the
> device replace rwsem so that all uses of the device are done inside the
> critical section.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

I'll add CC for 6.1+ before sending a pull request, there are some
dependencies but otherwise it applies cleanly.

