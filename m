Return-Path: <linux-btrfs+bounces-16046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4EB246EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 12:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41888188CF08
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7F2F28F2;
	Wed, 13 Aug 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Grw191E3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lz8ky2mj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Grw191E3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lz8ky2mj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E812EFDA7
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079844; cv=none; b=ONfZ92n1MDBza7QmcPgR42l/3oYo2vdsLsH7+dZ5BY4lrqxp7626R0SrGAx4AfgindgUWh5knZThOMOgMqPd+WlGt9MXj7SQfY0Lx3HAkpb+9wbx0PFHHTHCvkSvdl3H1XiNSp3Sz/l4CvHL3FfT3b0LoFO7ufO5pvqF+uuIGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079844; c=relaxed/simple;
	bh=jDX/jRJ73W2h30t1+RzghkzxaEGcJOWRQjNSQ+Lbad0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qub7/a2qmpmMgOYB6sbBblJO1gDPq0iasP8dmQgOu60IyKCKu3xEUCG/bLka4uF7e6OpNdflBnjCLyboMTmIFGPydedp9ZTviQMpply5HoSOainBbKUhqW1E+84Mol6ptx/vtl5ymBx/F4YF3xhJuFFhI7arerGwm0w83sFceA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Grw191E3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lz8ky2mj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Grw191E3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lz8ky2mj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17A191F455;
	Wed, 13 Aug 2025 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755079841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg32AyR3DTzflrgOvAeTxrZRMU2pr/Uc4H4TfA/PcOo=;
	b=Grw191E3FoRp20c5j4m9lv3Tw4wKjCmSUSbE1kJplCzqtm7PhKyzQP3r5LO/TksVU5yxEg
	B/MrxOxkRfnTMlVO0GgIkEWRTVUuhzltv8OH6yzmQweUYk6zuO5qWGj6MJxwQXC9wGBxTR
	3Vag0byTzTE4sutWFT3ECGLu3yquR+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755079841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg32AyR3DTzflrgOvAeTxrZRMU2pr/Uc4H4TfA/PcOo=;
	b=Lz8ky2mjF+OOuhIgMaAtlttLMrDiF+8/86BjRZeIZAcwV7WiynEVnAFswO9loJHU2TTe3z
	7F5H8waX3aai39CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755079841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg32AyR3DTzflrgOvAeTxrZRMU2pr/Uc4H4TfA/PcOo=;
	b=Grw191E3FoRp20c5j4m9lv3Tw4wKjCmSUSbE1kJplCzqtm7PhKyzQP3r5LO/TksVU5yxEg
	B/MrxOxkRfnTMlVO0GgIkEWRTVUuhzltv8OH6yzmQweUYk6zuO5qWGj6MJxwQXC9wGBxTR
	3Vag0byTzTE4sutWFT3ECGLu3yquR+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755079841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg32AyR3DTzflrgOvAeTxrZRMU2pr/Uc4H4TfA/PcOo=;
	b=Lz8ky2mjF+OOuhIgMaAtlttLMrDiF+8/86BjRZeIZAcwV7WiynEVnAFswO9loJHU2TTe3z
	7F5H8waX3aai39CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED56813929;
	Wed, 13 Aug 2025 10:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LnyBOaBknGhtJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 13 Aug 2025 10:10:40 +0000
Date: Wed, 13 Aug 2025 12:10:39 +0200
From: David Sterba <dsterba@suse.cz>
To: sawara04.o@gmail.com
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, brauner@kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix and unify mount option log messages
Message-ID: <20250813101039.GA22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250812180009.1412-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812180009.1412-1-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Wed, Aug 13, 2025 at 03:00:05AM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> This patch series fixes and unifies the log messages related to btrfs
> mount options.
> 
> The first patch addresses a regression where mount option messages were
> no longer displayed during initial mounts after the fsconfig migration.
> 
> The second patch unifies the log messages for NODATACOW and NODATASUM
> options, which were being handled with the same logic but had
> inconsistent and duplicate messages.
> 
> Thanks,
> Kyoji
> 
> Kyoji Ogasawara (2):
>   btrfs: restore mount option info messages during mount
>   btrfs: Align log messages and fix duplicates for NODATACOW/NODATASUM

Added to for-next, thanks.

