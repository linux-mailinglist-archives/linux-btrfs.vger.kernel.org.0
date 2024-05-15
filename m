Return-Path: <linux-btrfs+bounces-5008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887F8C6A08
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5911C2131D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272C156236;
	Wed, 15 May 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n59zXZz7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gipg6oIU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n59zXZz7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gipg6oIU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256A156226
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788444; cv=none; b=qqLn55brFON6qJ8hfCjWGTtpH4fVAsxKuWj/BFAohLiSck0P4/+1DiLWwEjfsnGa/tNb4222vD8UfZa/pECR1gyv06H1aPlKrA2H5dBH/Ji/KPxgQinOCMCzlp0HrK+G++MLBntH+wnrcV9KLWWeFn8ykDhNSIfPNKzC6jPdNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788444; c=relaxed/simple;
	bh=GHEyuJ+/OjOmxs3ynZUbLJifF53Ia0EPS68hJFS0+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyOGK2eKXV/EiZ4mjDaS3jCbrgRodcXSdBcu7Qm7GsNT2r2LjNJxS95LG7leyuB6EGRpuKzHOkvob4gLCdu/zDuPBQEMopt2f+F0K6+o3XDfv6zxHQzMr+KdmgBf2ZQjQE7BFdhXNw7sWAEWjtLIOwWxHBrVflpAZ0VmBR9ABMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n59zXZz7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gipg6oIU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n59zXZz7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gipg6oIU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 184C320883;
	Wed, 15 May 2024 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715788441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAa9g/skXnGNM8fI6adOV5gRQlFH7F/sK8oPeYwjUgA=;
	b=n59zXZz7edQpKC2oMGsxygQprMFGarAdp0+Hg4W1SKuihBCTJE4x3MfCj0j4r71SAWZcmp
	bk3Ou5WfGt7vAY7HgbB7i2AZsZtz4Hq9uGjbHAv0IBWSu8e4WPIgUv6Pp7hV+8vMwfoviz
	6fR4rb49ZZ6sWN2f+o2vVQvfVT1BxMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715788441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAa9g/skXnGNM8fI6adOV5gRQlFH7F/sK8oPeYwjUgA=;
	b=gipg6oIUQpVkBn6y5InLalp2mgvIF1DlTlh9O25fI/4xh1XoP411kTvVRGPxlrREFfw9tC
	B+wfRdezKsVmHVAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715788441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAa9g/skXnGNM8fI6adOV5gRQlFH7F/sK8oPeYwjUgA=;
	b=n59zXZz7edQpKC2oMGsxygQprMFGarAdp0+Hg4W1SKuihBCTJE4x3MfCj0j4r71SAWZcmp
	bk3Ou5WfGt7vAY7HgbB7i2AZsZtz4Hq9uGjbHAv0IBWSu8e4WPIgUv6Pp7hV+8vMwfoviz
	6fR4rb49ZZ6sWN2f+o2vVQvfVT1BxMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715788441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAa9g/skXnGNM8fI6adOV5gRQlFH7F/sK8oPeYwjUgA=;
	b=gipg6oIUQpVkBn6y5InLalp2mgvIF1DlTlh9O25fI/4xh1XoP411kTvVRGPxlrREFfw9tC
	B+wfRdezKsVmHVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A21A1372E;
	Wed, 15 May 2024 15:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+pHApnaRGZvewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 15:54:01 +0000
Date: Wed, 15 May 2024 17:53:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: raid56: do extra dumping for
 CONFIG_BTRFS_ASSERT
Message-ID: <20240515155355.GN4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 15, 2024 at 01:14:01PM +0930, Qu Wenruo wrote:
> There are several hard-to-hit ASSERT()s hit inside raid56.
> Unfortunately the ASSERT() expression is a little complex, and except
> the ASSERT(), there is nothing to provide any clue.
> 
> Considering if race is involved, it's pretty hard to reproduce.
> Meanwhile sometimes the dump of the rbio structure can provide some
> pretty good clues, it's worthy to do the extra multi-line dump for
> btrfs raid56 related code.
> 
> The dump looks like this:
> 
>  BTRFS critical (device dm-3): bioc logical=4598530048 full_stripe=4598530048 size=0 map_type=0x81 mirror=0 replace_nr_stripes=0 replace_stripe_src=-1 num_stripes=5
>  BTRFS critical (device dm-3):     nr=0 devid=1 physical=1166147584
>  BTRFS critical (device dm-3):     nr=1 devid=2 physical=1145176064
>  BTRFS critical (device dm-3):     nr=2 devid=4 physical=1145176064
>  BTRFS critical (device dm-3):     nr=3 devid=5 physical=1145176064
>  BTRFS critical (device dm-3):     nr=4 devid=3 physical=1145176064
>  BTRFS critical (device dm-3): rbio flags=0x0 nr_sectors=80 nr_data=4 real_stripes=5 stripe_nsectors=16 scrubp=0 dbitmap=0x0
>  BTRFS critical (device dm-3): logical=4598530048
>  assertion failed: orig_logical >= full_stripe_start && orig_logical + orig_len <= full_stripe_start + rbio->nr_data * BTRFS_STRIPE_LEN, in fs/btrfs/raid56.c:1702
>  ------------[ cut here ]------------
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please add the patch to for-next so we can start getting more info from
the crashes, thanks.

