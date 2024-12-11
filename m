Return-Path: <linux-btrfs+bounces-10259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D09ED4C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0993283D73
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367D209F3C;
	Wed, 11 Dec 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfLay1Tw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DducWeUc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfLay1Tw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DducWeUc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FE207A34
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942495; cv=none; b=CzLfd18GkBaiL9JCRW1mKkyFjWqApZn76OlkamvNHFLO3o6fQp9+CPpl/lG0eFSz7FJ3Na66fHfR/mh2m4EwnsfuZITZxL5OVaEWZ8TatndYWKPV8mgcCnF5Om6il84xunitykWvjJbafEXHu8Wb7b9fP1UnDfhzgHJsBtigPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942495; c=relaxed/simple;
	bh=yjSNcdwR0KjgyW6EVk18YaIUg1RVRGWoBSHHWfYDFMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJy2GUINvr5PRHVBRap0MI4+UAU9+taS5hfZtS4+A/9256ZaR37UaRKiElPntdb9dkOuG/v0CG+Y+GDzhgFo4qjUnnmhniutjH3JtvD5Q09OdUDIYKm44CHIoWxsiFPWE/pe6zOtrwg6KAqCk8xFqLiCEXIZu0kQ9pCX6DY4RKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfLay1Tw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DducWeUc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfLay1Tw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DducWeUc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B463221180;
	Wed, 11 Dec 2024 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpsB/kZjwAYzF7CitYs5lgKu/0ClCs6vBZYtk6oNBFQ=;
	b=LfLay1TwzDJ4bYIYKxTaXsaGnQDngiI4DQdvYChL+0CMJtf0Iz/Z0VOmkqPCvhQkV9Nrp1
	WxfDCsLiurA+iN5sGiwY+9BxMZNmzoVfhi6LKuCW5tih+RefeSEhn/8dPZHLyCZDYzUoQu
	oiI7ZwYqzRPVnWGokbwy9Kw9TCVleQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpsB/kZjwAYzF7CitYs5lgKu/0ClCs6vBZYtk6oNBFQ=;
	b=DducWeUcxypaaeHRzU2YX1mLwmnEkINOfCC3i9aMMdv0p8dEwuk+ionppW4PdFXlFf7+Vm
	Pf4qRO13fcMQgsDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpsB/kZjwAYzF7CitYs5lgKu/0ClCs6vBZYtk6oNBFQ=;
	b=LfLay1TwzDJ4bYIYKxTaXsaGnQDngiI4DQdvYChL+0CMJtf0Iz/Z0VOmkqPCvhQkV9Nrp1
	WxfDCsLiurA+iN5sGiwY+9BxMZNmzoVfhi6LKuCW5tih+RefeSEhn/8dPZHLyCZDYzUoQu
	oiI7ZwYqzRPVnWGokbwy9Kw9TCVleQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942491;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpsB/kZjwAYzF7CitYs5lgKu/0ClCs6vBZYtk6oNBFQ=;
	b=DducWeUcxypaaeHRzU2YX1mLwmnEkINOfCC3i9aMMdv0p8dEwuk+ionppW4PdFXlFf7+Vm
	Pf4qRO13fcMQgsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A16CA13927;
	Wed, 11 Dec 2024 18:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5akvJ9vcWWfUfwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 11 Dec 2024 18:41:31 +0000
Date: Wed, 11 Dec 2024 19:41:30 +0100
From: David Sterba <dsterba@suse.cz>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Message-ID: <20241211184130.GR31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Dec 10, 2024 at 01:06:07PM -0600, Roger L. Beckermeyer III wrote:
> Adds rb_find_add_cached() as a helper function for use with
> red-black trees. Used in btrfs to reduce boilerplate code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412092033.josUXvY4-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412091004.4vQ7P5Kl-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090944.g3jpT1Cz-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090919.RdI1OMQg-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090922.LHCgRc17-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412091036.JGaCqbvL-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090921.E0n0Ioce-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090958.CtUdYRwP-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090922.Cg7LuOhS-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202412090910.F5gin2Tv-lkp@intel.com/
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>  include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++

This is generic code and you need to CC the right people to get their
ack and reviewed-by. Alternatively we can have our own copy in
fs/btrfs/misc.h and then move it to the generic code.

