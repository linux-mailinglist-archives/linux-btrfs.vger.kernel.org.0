Return-Path: <linux-btrfs+bounces-15661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E660B11350
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 23:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AAA1898AFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4B23BCEE;
	Thu, 24 Jul 2025 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lKaO4KVT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aMprQNko";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nus45jHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8H4ikgmg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178621858A
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394097; cv=none; b=ZP1sGJx/9I1fa2hx27efjA71yBWXTGImbw96KurSjklW36YhKt7uJo2SdaiDi0SnM+yqfpIQy0DGU7aVFT903SyeMHE+EiFRfz05vg9jCC0ziEZHylPqrs5FHxKwQnqp7gSBala9o2sd/hPVBd0HltjCdVjdHED4Lg5fZMNgp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394097; c=relaxed/simple;
	bh=VcmD+L58qfqXMfeQCg8MAfJggMlDcw+xEb31J8MNZ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aADC6FKdcZDdNYPYcwZ6MpO+CY8PRnivuGgdEYNqlE68vPyImx9qnjUll2/6VjKWqhtx+qHWpqBQJzqVeknU6EakIlVjFsv2auQQ4r9sf8M5kvQXP/d/Q0kAuQSaWDGFK6Ij6Oe3bBbe7AinLK3naq7CZevSWlilWpP15Lj/x+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lKaO4KVT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aMprQNko; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nus45jHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8H4ikgmg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1C251FB42;
	Thu, 24 Jul 2025 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753394092;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7oH0IC4lGoAvSo+0Jq4x6AnW+dyxrEKQsqezC5wuqs=;
	b=lKaO4KVT06b+W7hkh9jRjqttJPPEEdTFc8Yp+99VHffIXQv1+CiYBu5NqGj3Gu2Wdp3dl3
	/TL57HDrFkbHRUcoCF80CHLHoa445LS0a4Sjc8B1LA46TC/8HT95XnW8QvXjcPaF8JHS0c
	Pl5SVa2d4e2+Q5ZpLewM+CO2TRHxTCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753394092;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7oH0IC4lGoAvSo+0Jq4x6AnW+dyxrEKQsqezC5wuqs=;
	b=aMprQNkoVwepAcxXHFHDTRYVt7WgY754WfLhRtwZhl4PIwMgQUbj+jwkWbUQPGZw5Wiy3/
	dO+cCF/opHwZRWCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nus45jHY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8H4ikgmg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753394091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7oH0IC4lGoAvSo+0Jq4x6AnW+dyxrEKQsqezC5wuqs=;
	b=nus45jHYrGoSz/dnqDQWem0CwOgbDSsKo/iiRqanXswZKQNbajPH+JF3xaUv1ifxR6tXyC
	V91uN6XuFhcOOCqzQl9FSA4D/2iW5JV45teXK0pw5OaJueMKgpNugRRE6rM81Z5kUBFeF0
	iPDOkDDZQqg1MZyZdtDwwUGscHzwdg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753394091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7oH0IC4lGoAvSo+0Jq4x6AnW+dyxrEKQsqezC5wuqs=;
	b=8H4ikgmg5/pmmVQJxbZXvqPEgTB8DyZabgAfV/uEvrNdTgbMhF2jOgfx6IMolmXBQCTrIs
	Pu0+Cuq/tWyHXGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7CDF13302;
	Thu, 24 Jul 2025 21:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NK1UMKurgmgpMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 24 Jul 2025 21:54:51 +0000
Date: Thu, 24 Jul 2025 23:54:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/2] btrfs: zoned: directly call do_zone_finish() from
 btrfs_zone_finish_endio_workfn()
Message-ID: <20250724215450.GG6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250722113912.16484-1-jth@kernel.org>
 <20250722113912.16484-2-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722113912.16484-2-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E1C251FB42
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Tue, Jul 22, 2025 at 01:39:10PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When btrfs_zone_finish_endio_workfn() is calling btrfs_zone_finish_endio()
> it already has a pointer to the block group. Furthermore
> btrfs_zone_finish_endio() does additional checks if the block group can be
> finished or not.
> 
> But in the context of btrfs_zone_finish_endio_workfn() only the actual
> call to do_zone_finish() is of interest, as the skipping condition when
> there is still room to allocate from the block group cannot be checked.
> 
> Directly call do_zone_finish() on the block group.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 245e813ecd78..e997b236d00a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2461,12 +2461,16 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
>  
>  static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
>  {
> +	int ret;
>  	struct btrfs_block_group *bg =
>  		container_of(work, struct btrfs_block_group, zone_finish_work);
>  
>  	wait_on_extent_buffer_writeback(bg->last_eb);
>  	free_extent_buffer(bg->last_eb);
> -	btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
> +	ret = do_zone_finish(bg, true);
> +	if (ret)
> +		btrfs_handle_fs_error(bg->fs_info, ret,
> +				      "Failed to finish block-group's zone");

The btrfs_handle_fs_error() is odd and should not be used in new code.
Is there another way how you can signal a problem from the endio
callback?

