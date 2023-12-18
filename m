Return-Path: <linux-btrfs+bounces-1012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA08167B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 08:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB516B22012
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD4101EC;
	Mon, 18 Dec 2023 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dRUUH6XJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o93xeuG1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dRUUH6XJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o93xeuG1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07E101C0
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9992222AD;
	Mon, 18 Dec 2023 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702885773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KiM4PYVqRplbZbNOhzuluAiWOwW7UOGXvHiHjq/LfQ=;
	b=dRUUH6XJSUdefnR1t01vuxGMnv7BvxYdRyHqmXU0vESfdnyR+2j1630D1M36bd9QnbgFWA
	seZiO+IZCfZeix/38Ei+E9DWPPsn2Da+ZgCivAevQXpp8aycNJXWYZMN1BSjtqC1RuRvSK
	OK8J13NaJax8cP28xL6TCFbnOfyb4ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702885773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KiM4PYVqRplbZbNOhzuluAiWOwW7UOGXvHiHjq/LfQ=;
	b=o93xeuG1GwSsQb0BvF3xAUUEF9Co21rbRBwlfndIh9AvP8Md+ehrTWZf5V0UU3i/JHWO28
	bSjUZeuQnvhmQVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702885773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KiM4PYVqRplbZbNOhzuluAiWOwW7UOGXvHiHjq/LfQ=;
	b=dRUUH6XJSUdefnR1t01vuxGMnv7BvxYdRyHqmXU0vESfdnyR+2j1630D1M36bd9QnbgFWA
	seZiO+IZCfZeix/38Ei+E9DWPPsn2Da+ZgCivAevQXpp8aycNJXWYZMN1BSjtqC1RuRvSK
	OK8J13NaJax8cP28xL6TCFbnOfyb4ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702885773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KiM4PYVqRplbZbNOhzuluAiWOwW7UOGXvHiHjq/LfQ=;
	b=o93xeuG1GwSsQb0BvF3xAUUEF9Co21rbRBwlfndIh9AvP8Md+ehrTWZf5V0UU3i/JHWO28
	bSjUZeuQnvhmQVDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B3C2313997;
	Mon, 18 Dec 2023 07:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mMh0E4z5f2UsdwAAn2gu4w
	(envelope-from <ddiss@suse.de>); Mon, 18 Dec 2023 07:49:32 +0000
Date: Mon, 18 Dec 2023 18:49:17 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: sysfs: use kstrtoull_suffix() to replace
 memparse()
Message-ID: <20231218184917.064e105e@echidna>
In-Reply-To: <2693b00ca850b0f604e03c836e71d0ad8a93ffee.1702628925.git.wqu@suse.com>
References: <cover.1702628925.git.wqu@suse.com>
 <2693b00ca850b0f604e03c836e71d0ad8a93ffee.1702628925.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.04
X-Spamd-Result: default: False [-3.04 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(0.56)[0.188];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi Qu,

On Fri, 15 Dec 2023 19:09:24 +1030, Qu Wenruo wrote:

> Since memparse() itself can not handle overflow at all, use
> memparse_ull() to be extra safe.

s/memparse_ull/kstrtoull_suffix/

> Now overflow values can be properly detected.

Please document how the sysfs API changes with this, in addition to
overflow handling:
- support for 'E' / 'e' suffixes dropped
- only one trailing '\n' accepted, instead of many isspace()

The latter might break a few scripts.

Cheers, David

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/sysfs.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 84c05246ffd8..089c3fc123fe 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -760,7 +760,7 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  {
>  	struct btrfs_space_info *space_info = to_space_info(kobj);
>  	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> -	char *retptr;
> +	int ret;
>  	u64 val;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -776,11 +776,9 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		return -EPERM;
>  
> -	val = memparse(buf, &retptr);
> -	/* There could be trailing '\n', also catch any typos after the value */
> -	retptr = skip_spaces(retptr);
> -	if (*retptr != 0 || val == 0)
> -		return -EINVAL;
> +	ret = kstrtoull_suffix(buf, 0, &val, KSTRTOULL_SUFFIX_DEFAULT);
> +	if (ret < 0)
> +		return ret;
>  
>  	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
>  
> @@ -1779,14 +1777,12 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
>  {
>  	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
>  						   devid_kobj);
> -	char *endptr;
>  	unsigned long long limit;
> +	int ret;
>  
> -	limit = memparse(buf, &endptr);
> -	/* There could be trailing '\n', also catch any typos after the value. */
> -	endptr = skip_spaces(endptr);
> -	if (*endptr != 0)
> -		return -EINVAL;
> +	ret = kstrtoull_suffix(buf, 0, &limit, KSTRTOULL_SUFFIX_DEFAULT);
> +	if (ret < 0)
> +		return ret;
>  	WRITE_ONCE(device->scrub_speed_max, limit);
>  	return len;
>  }





