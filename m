Return-Path: <linux-btrfs+bounces-7603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA2961B0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 02:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D8528522C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84712E7E;
	Wed, 28 Aug 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HBw3YIqp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/M80smc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKHts8sb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXe1VTsk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF530D512
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804629; cv=none; b=vAuq3uNAQgoAO6dTGE6bAtEnXvGFDGG4Gltboa05mrLzfkzIMan6ajCCC6IVsCaaa++m9dnRgk3fig6/qjk7/kz3VUh85k3Jf774Rb9aDw4J1Pe+mHH3Zr0hnJBRAEBYkgX+kPUGUE4W5GFloyqqpE0TxrCYt7Sfyd7xIqjjL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804629; c=relaxed/simple;
	bh=y7Z/XEtHzGu/+bRafSlrtoaUaE4sifMo0z9smt+P+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhcFV7R0U7jYDvxnsI2QFkva/344IyE0158DmqfbK1qkQHXr3Bm8TYJEsWrYGr2n6zNmyJPo/feN76GajbIHc2oJIeVKyY3g9M/Z/2GtAw/GsyJhL2lyUy4xCSAhr40QsIS0OanrSSYK+1Wv8sTDqWjLv/5mSY6h+H1swK5uagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HBw3YIqp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/M80smc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKHts8sb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXe1VTsk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D34251FB9B;
	Wed, 28 Aug 2024 00:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724804626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1hQZiCtQuqx7cigPpDtlMPV2cEEQV4E9Tm8EfEWQgM=;
	b=HBw3YIqpoJT/xqknJY65BWlcFvHvNmkR9PM1U98DwxjXIpLwD9LbwmB4K8zTgErCFIGzm2
	5i0hq/y+HP7z/u32V6EmcBcqzyf0Abh4jDXPCsX3+DhCcXy6ekb/xdWR6uLPL6gpTWqrqP
	VWCOSdztfjaF9zVoYreel3lXSs4pzo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724804626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1hQZiCtQuqx7cigPpDtlMPV2cEEQV4E9Tm8EfEWQgM=;
	b=n/M80smcWqwsCXo6+QWUPTemJrJrqDGHd10IpWZBOVp8X2OD2vk/Xlld5wODUPwdlrO3sB
	zw73dYLl6SdgD6Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724804624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1hQZiCtQuqx7cigPpDtlMPV2cEEQV4E9Tm8EfEWQgM=;
	b=kKHts8sbEczse9VKU7dgp5bU4KxAN0sJGW0mDOaOs/6E6sB6ai72OJ9mPJxSIRQc5qMUE3
	lkzSbBSL+b5ygipyQ4EvBXLeXQgjtlTrb+24TC7/x+GozkLAvZrvhp61ar9CnEe+NJrmxC
	Sqd/UP3EErsyaw4re2LH59VeNirwPaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724804624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1hQZiCtQuqx7cigPpDtlMPV2cEEQV4E9Tm8EfEWQgM=;
	b=xXe1VTskE/KxKPFZDlpTJGSiswe0aUQPOo0pk1lru8SyEG9xpZNIwHJhgnf4FQKy0g3kUM
	AH0pmqXy6mCTj/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B90A91373A;
	Wed, 28 Aug 2024 00:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jBvqLBBuzmbTQQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 00:23:44 +0000
Date: Wed, 28 Aug 2024 02:23:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
Message-ID: <20240828002335.GE25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724785204.git.loemra.dev@gmail.com>
 <ed3ccffaef20ae705342051ca697567eabcc1769.1724785204.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3ccffaef20ae705342051ca697567eabcc1769.1724785204.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.98
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.18)[-0.879];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Aug 27, 2024 at 12:08:44PM -0700, Leo Martins wrote:
> Add automatic path freeing in zoned.c, the examples here are both fairly
> trivial with one exit path and the only cleanup is btrfs_free_path.
> ---
>  fs/btrfs/zoned.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 66f63e82af793..158bb0b708805 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -287,7 +287,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>  /* The emulated zone size is determined from the size of device extent */
>  static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);

This looks good, I've tested that applied in the code and looked at the
function how it feels in the code, I think we can settle on that.

So if you're going to send more such updates, you can use a template
changelog like:

"All cleanup paths lead to btrfs_path_free so we can define path with the
 automatic free callback."

It describes why it can be used and roughly what it does if somebody
sees it for the first time.

