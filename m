Return-Path: <linux-btrfs+bounces-9917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9B9D9B1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E8CB2D6DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3E1D5CF2;
	Tue, 26 Nov 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SR0JLTve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5tpBSNM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SR0JLTve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5tpBSNM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C43EA69
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637306; cv=none; b=HuBHGdCHJ/uuPWdOcyNc8jWtUlKUl5pgz/eefeWTD5T/MdpglKagppsokHbZtwTfvNmjAZJFlJ79iSRMvhnKHGI2x3OOrZK7sHS2bK3JQtGk6U7TD1ZwqZwkp92BkpyaA0Kr1vLWe7DhRqjmLwwoLMOQR2WbvFBf1VUqBfs7p+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637306; c=relaxed/simple;
	bh=9E8iur0hppNF7xtx4PC0W9o9DW/VqcyTQvdbywN4jpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoW8aiXmqftcbS3h/Czyn1/CoBxHaetglw6axg58VZdOnYgTcVu+hNH4kl63Z1bnSJWKb2Ae4UJ17Yz5QeNfWAzeScinyWrFhQBIPKRB/qaRFtMRY1YzAwwpyQOt6C5gy0YHtWg8nvh6aZwwcFO8kTuwVUIVsCH0mUPsyHTsNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SR0JLTve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5tpBSNM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SR0JLTve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5tpBSNM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97E621F74D;
	Tue, 26 Nov 2024 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732637302;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHBFFyS6Ekz0YYpWeyBvcEy2vSVqMDqGx3WRVRq1IDc=;
	b=SR0JLTve13U125xCgj2VrG0hQkfWb9+Dn0cVev81khZuQXwf9zNXAX6XbVCV74NyMBI2K2
	TQWS5hHoskzWNC6zER+6RwB+fiG65wK4IseIY3QQXG39AzlMazSKmNIceT+nVeiwbL4nJh
	8RnHmofk67DcewvC/lEgqE2fVy6xP/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732637302;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHBFFyS6Ekz0YYpWeyBvcEy2vSVqMDqGx3WRVRq1IDc=;
	b=v5tpBSNMkLqpJmNoNJI4RF6qNJqU1O1A8/onompHwiat+khMDWCuPEKmzKf098qupee0iS
	bgcuuwdaq2BjncAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732637302;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHBFFyS6Ekz0YYpWeyBvcEy2vSVqMDqGx3WRVRq1IDc=;
	b=SR0JLTve13U125xCgj2VrG0hQkfWb9+Dn0cVev81khZuQXwf9zNXAX6XbVCV74NyMBI2K2
	TQWS5hHoskzWNC6zER+6RwB+fiG65wK4IseIY3QQXG39AzlMazSKmNIceT+nVeiwbL4nJh
	8RnHmofk67DcewvC/lEgqE2fVy6xP/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732637302;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHBFFyS6Ekz0YYpWeyBvcEy2vSVqMDqGx3WRVRq1IDc=;
	b=v5tpBSNMkLqpJmNoNJI4RF6qNJqU1O1A8/onompHwiat+khMDWCuPEKmzKf098qupee0iS
	bgcuuwdaq2BjncAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FE9E139AA;
	Tue, 26 Nov 2024 16:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E7QKH3byRWd1GwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 16:08:22 +0000
Date: Tue, 26 Nov 2024 17:08:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/6] btrfs: fix double accounting of ordered extents
 during errors
Message-ID: <20241126160817.GJ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1730269807.git.wqu@suse.com>
 <2faab8a96c6dd2a414a96e4cebae97ecbddf021d.1730269807.git.wqu@suse.com>
 <2327765d-c139-495e-94f0-5bab11adf440@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2327765d-c139-495e-94f0-5bab11adf440@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sun, Nov 24, 2024 at 06:01:27PM +1030, Qu Wenruo wrote:
> I know this is part of the subpage patches, but this is really a bug fix 
> for the existing subpage handling.
> 
> Appreciate if anyone can give this a review.

Looks correct to me. One suggestion to clean up the parameters and to
pass bio_ctrl and read the last_sibmitted and the bitmap directly, so
something like that:

cleanup_ordered_extents(BTRFS_I(inode), folio, &bio_ctrl, cur_end + 1);

replacing the parameters with the values in the function. Though after
another thought, the explicit expressions like
"page_start + PAGE_SIZE - bio_ctrl->last_submitted"
and "cur_end + 1 - bio_ctrl.last_submitted" make it a bit readable. Up
to you.

