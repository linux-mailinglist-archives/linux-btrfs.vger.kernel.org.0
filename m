Return-Path: <linux-btrfs+bounces-9101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD99AD108
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4120D1C21C9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB071CC8AA;
	Wed, 23 Oct 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvMr8BE6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17zLIoSv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvMr8BE6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17zLIoSv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F81CACEF
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701167; cv=none; b=hkeYdtXFNkDODZA3pQlTu5aH39MoErbD6vk5EKcaGOyw5jQ9oM5cHLR3brnEcmBQWckZWaii9LS0guRl4+VVRuqhMSnEuqVqcuWb+NNartLyFZ9ODkenLy7Epl8/Ut591iZhBQR1fR9B0GNtAKDa1JVeztNRU07rYel7RWxK1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701167; c=relaxed/simple;
	bh=uQ+oEudamflaXydhGjeDAYXDBjcCPnwefLXRSEwK36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq9K6OH39Ivs5UldI5jSW5NLlaKelkVhIGyk7rn35iGooqmL2zIfS3C8q/aK/GId4vpOA0VPidQoOp6+y6GWFxaxpe2k7uPKZnT6vidM/elxbxBqX9UHsCYJbFNqgpGJPqISqx3EI4ucOcqX7RuavRUTknBMGN0BVDLsX8b+BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GvMr8BE6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=17zLIoSv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GvMr8BE6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=17zLIoSv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B7D11FDBA;
	Wed, 23 Oct 2024 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729701164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHxhwvDp/8tbm/KCxp/KMbO65uy4fcaoLeHeB9QayMM=;
	b=GvMr8BE6HAFX70SEpBze2T0qT4/JTDlEHu/y4BVvt6snsc7bgA7djk67+fpY+GmTC6t9of
	kUbAU/9FjprvJbSNYovVGzsBLVmOSYFQteEeutL/pOnJkxyW2jgpBZmb4n7y9n/98wpC7x
	qzJRoyfcfxbSHch8nS3zg3kMmq/6Wyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729701164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHxhwvDp/8tbm/KCxp/KMbO65uy4fcaoLeHeB9QayMM=;
	b=17zLIoSvwghn6Y9Nqhny0rPO3Vk9wRiAyuoz2egXwftWTnWp2vBmTVFwPvdB11fasqciPx
	TAoMZlN3WvKDHhBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729701164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHxhwvDp/8tbm/KCxp/KMbO65uy4fcaoLeHeB9QayMM=;
	b=GvMr8BE6HAFX70SEpBze2T0qT4/JTDlEHu/y4BVvt6snsc7bgA7djk67+fpY+GmTC6t9of
	kUbAU/9FjprvJbSNYovVGzsBLVmOSYFQteEeutL/pOnJkxyW2jgpBZmb4n7y9n/98wpC7x
	qzJRoyfcfxbSHch8nS3zg3kMmq/6Wyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729701164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHxhwvDp/8tbm/KCxp/KMbO65uy4fcaoLeHeB9QayMM=;
	b=17zLIoSvwghn6Y9Nqhny0rPO3Vk9wRiAyuoz2egXwftWTnWp2vBmTVFwPvdB11fasqciPx
	TAoMZlN3WvKDHhBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1060913AD3;
	Wed, 23 Oct 2024 16:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 50/IAywlGWcUPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 23 Oct 2024 16:32:44 +0000
Date: Wed, 23 Oct 2024 18:32:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Enno Gotthold <egotthold@suse.com>,
	Fabian Vogt <fvogt@suse.com>
Subject: Re: [PATCH v2] btrfs: fix mount failure due to remount races
Message-ID: <20241023163237.GD31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a682e48c161eece38f8d803103068fed5959537d.1729665365.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a682e48c161eece38f8d803103068fed5959537d.1729665365.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -8.00
X-Spam-Flag: NO

On Wed, Oct 23, 2024 at 05:08:51PM +1030, Qu Wenruo wrote:
> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> +		ret = btrfs_reconfigure(fc);

This gives me a warning (gcc 13.3.0):

fs/btrfs/super.c: In function ‘btrfs_reconfigure_for_mount’:
fs/btrfs/super.c:2011:56: warning: suggest parentheses around ‘&&’ within ‘||’ [-Wparentheses]
 2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



