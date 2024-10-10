Return-Path: <linux-btrfs+bounces-8805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B70998BBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1506E1C25A38
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CCC1CDFCE;
	Thu, 10 Oct 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bncb/jbf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWYOwQpu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bncb/jbf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWYOwQpu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4A1CDFA4;
	Thu, 10 Oct 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574335; cv=none; b=pc5jN0kqtOjcH0Dk5qzVsE9yqefeZvRa+qsym9aS+JqAKP5GpoUs/2bWI6uONy7cbo/P0EWmCi3UhSWhChdBuhzlPcsx+WtWZr7SfUlnrHUSuX4N18yTO/8YpTd69ECLbQh+efP8csYUT9zAbKTbg5heZr+t+urQwReZZjcTGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574335; c=relaxed/simple;
	bh=8FG78Yx/NmL46NnAHhIiOuyBrOox9hs38DDYe3tcfQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9q/DgEcgyu5BrzIMKk920vPPMjjAQdJ1wyUFJKk8ZKu4GlKGD2I4GqCX5xfPI4jmyVbbXMaAyxABzqRHJtuaYB3txaILvGzjun5njL1fQKCcsahR3p3SzVxBk1/4LQPrZsiqNAW7NrZT5x8DmsCd5+mJTLOb+NMte+MNu9Bgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bncb/jbf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWYOwQpu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bncb/jbf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWYOwQpu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97F4E1FB3D;
	Thu, 10 Oct 2024 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728574331;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1I8+AOgW2GARi6yGqEpCqcjrkgV0fcTQjlxCH5DBo0=;
	b=Bncb/jbfJjPrn7S8Ou1m14/OGJxEZO1X6pUr+L0IsWV80Jh4peHR443tKLpS0GIcTGAXvK
	PLKJyA2wlXjNIq2ab+fQgPLt5wv9NfvE2fufcjd3uxVC1wMK4yMwMHBAGDT1AbPnxJLt18
	dUQuxtAQPOMNx+u23RBK6KW9Uahhim8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728574331;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1I8+AOgW2GARi6yGqEpCqcjrkgV0fcTQjlxCH5DBo0=;
	b=jWYOwQpuDPLP1CDMenLnJnDxMTJkMEeGE+15wLZOL2RyeuY8AAboNdH1KdxJYYaE8WYLkN
	RBaGSwV1Z1/3AqBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728574331;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1I8+AOgW2GARi6yGqEpCqcjrkgV0fcTQjlxCH5DBo0=;
	b=Bncb/jbfJjPrn7S8Ou1m14/OGJxEZO1X6pUr+L0IsWV80Jh4peHR443tKLpS0GIcTGAXvK
	PLKJyA2wlXjNIq2ab+fQgPLt5wv9NfvE2fufcjd3uxVC1wMK4yMwMHBAGDT1AbPnxJLt18
	dUQuxtAQPOMNx+u23RBK6KW9Uahhim8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728574331;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1I8+AOgW2GARi6yGqEpCqcjrkgV0fcTQjlxCH5DBo0=;
	b=jWYOwQpuDPLP1CDMenLnJnDxMTJkMEeGE+15wLZOL2RyeuY8AAboNdH1KdxJYYaE8WYLkN
	RBaGSwV1Z1/3AqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 797C413A6E;
	Thu, 10 Oct 2024 15:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s0B0HXvzB2etfAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 15:32:11 +0000
Date: Thu, 10 Oct 2024 17:32:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Christian Heusel <christian@heusel.eu>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: send: cleanup unneeded variable in changed_verity
Message-ID: <20241010153206.GQ1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241010-btrfs-return-cleanup-v1-1-3d7a7649530a@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-btrfs-return-cleanup-v1-1-3d7a7649530a@heusel.eu>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 10, 2024 at 03:25:25PM +0200, Christian Heusel wrote:
> As all changed_ functions need to return something, just return 0
> directly here, as the verity status is passed via the context.
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410092305.WbyqspH8-lkp@intel.com/
> Signed-off-by: Christian Heusel <christian@heusel.eu>

Thank you, added to for-next.

