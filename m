Return-Path: <linux-btrfs+bounces-6160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61E924C16
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09EE0B21DD1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 23:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10217A5BC;
	Tue,  2 Jul 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4V4imhy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MPz2efBR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V4V4imhy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MPz2efBR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715591DA30B
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962657; cv=none; b=SAGotZosVsHUoTZi4p72njGdjKM2106zvKMMHCO1E9Q8lYH4Ho+7F4YMCYyTHQ1UcSs4ShucpumBL3q/ocLU3AWZmnqVZOCudtb/LuR3SRUswO8m/1x4SGOhXZjgPpUdByq1OxlBhmHWcJL7bOBW1Q2Z2btwwM08Wn+0d3JtERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962657; c=relaxed/simple;
	bh=dwIsX+I0yvsqJP+ySH61szhroa2YA7MxRQYktRQDui0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcLu2lkKgXlvaqEM6QmzBGLzI5ZfW9hwf2BNXZpfHgGPjG6KnxMCRRkBI+3gLaebS6fkeOweu5pT8DtoEsSIbMpFaP4y38pj/6bR/t9qA5zjhixEsOWVhNUYRIv2rlHgJ1I1GXVVdzK8DBe3HRMgiQ8nLzRQ4bWkjqCMGW6Q7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4V4imhy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MPz2efBR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V4V4imhy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MPz2efBR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D91F21B90;
	Tue,  2 Jul 2024 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719962653;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl62W+DcPas2WW/zPsmfG5QqwwEOWZHUmFX4TmGHNgk=;
	b=V4V4imhyHb+GtAKFudhkVVxkF13OnuNrU3p9VVvJJfIKDeRaI/cgD65xfdtG4L2/gfNgaQ
	lyCEa+Af2Zltyy6DBZpt2EmIjm8+zHKmX4YSQdWISFCl91WVq3U1qO6d03vosFNVVzmWqp
	gyKZbcQmI3lXnkP/MnzmQuH8ZidWUbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719962653;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl62W+DcPas2WW/zPsmfG5QqwwEOWZHUmFX4TmGHNgk=;
	b=MPz2efBR7/ywz2x+5Q/ebwkL3cEQXPclgHGo/KQwp97IDjQucJOAv4+U95Yh5NT5h1dgjQ
	zvl07ruK55tV3zBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719962653;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl62W+DcPas2WW/zPsmfG5QqwwEOWZHUmFX4TmGHNgk=;
	b=V4V4imhyHb+GtAKFudhkVVxkF13OnuNrU3p9VVvJJfIKDeRaI/cgD65xfdtG4L2/gfNgaQ
	lyCEa+Af2Zltyy6DBZpt2EmIjm8+zHKmX4YSQdWISFCl91WVq3U1qO6d03vosFNVVzmWqp
	gyKZbcQmI3lXnkP/MnzmQuH8ZidWUbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719962653;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vl62W+DcPas2WW/zPsmfG5QqwwEOWZHUmFX4TmGHNgk=;
	b=MPz2efBR7/ywz2x+5Q/ebwkL3cEQXPclgHGo/KQwp97IDjQucJOAv4+U95Yh5NT5h1dgjQ
	zvl07ruK55tV3zBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39CB51395F;
	Tue,  2 Jul 2024 23:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pqPlDR2MhGYUKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 23:24:13 +0000
Date: Wed, 3 Jul 2024 01:24:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Chung-Chiang Cheng <cccheng@synology.com>
Cc: linux-btrfs@vger.kernel.org, shepjeng@gmail.com, btrfs@cccheng.net
Subject: Re: [PATCH] btrfs-progs: inspect tree-stats: support to show a
 specified tree
Message-ID: <20240702232408.GO21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cccf210bb40ff2455b03c8e6f77a9bef62d80cb3.1719910442.git.cccheng@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cccf210bb40ff2455b03c8e6f77a9bef62d80cb3.1719910442.git.cccheng@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.96
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.96 / 50.00];
	BAYES_HAM(-2.96)[99.84%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cccheng.net];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Tue, Jul 02, 2024 at 04:55:02PM +0800, Chung-Chiang Cheng wrote:
> tree-stats currently displays only some global trees and fs-tree 5. Add
> support to show the stats of a specified tree.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

That's useful, thanks. I've added the option to documentation too.

