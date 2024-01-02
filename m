Return-Path: <linux-btrfs+bounces-1190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39282821D92
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A5D1F218C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ACC11733;
	Tue,  2 Jan 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qlnhWp//";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/XgJE2Pd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qlnhWp//";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/XgJE2Pd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BF11189;
	Tue,  2 Jan 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 212BB1F38E;
	Tue,  2 Jan 2024 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704205459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpO3Z/TBJou6N6FxKxm1jCOXw5p78gMgJPOfsE00wA4=;
	b=qlnhWp//hWrEJNxyiub0KDy3E5vKcjObnIkfTA0YlO1iFoHo588ig4Hzxd0MMyK3suC7xp
	f91pp6adPEPhElveao6GcUQEalZbvUVv4pN4y1nB93ZeRR5i2yMbvkTqhQ+Sn3dUBAxk+u
	IZYs4xCRp8dRvHOGv04Dn7YGsvNzUsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704205459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpO3Z/TBJou6N6FxKxm1jCOXw5p78gMgJPOfsE00wA4=;
	b=/XgJE2PdMfRee9bqvU29CaoqKO7jUR3FQnsM6PRJZsafkHjiBIMXylVZJw4vN29Nx4UHWr
	9W9ZGepHlke6iCDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704205459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpO3Z/TBJou6N6FxKxm1jCOXw5p78gMgJPOfsE00wA4=;
	b=qlnhWp//hWrEJNxyiub0KDy3E5vKcjObnIkfTA0YlO1iFoHo588ig4Hzxd0MMyK3suC7xp
	f91pp6adPEPhElveao6GcUQEalZbvUVv4pN4y1nB93ZeRR5i2yMbvkTqhQ+Sn3dUBAxk+u
	IZYs4xCRp8dRvHOGv04Dn7YGsvNzUsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704205459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpO3Z/TBJou6N6FxKxm1jCOXw5p78gMgJPOfsE00wA4=;
	b=/XgJE2PdMfRee9bqvU29CaoqKO7jUR3FQnsM6PRJZsafkHjiBIMXylVZJw4vN29Nx4UHWr
	9W9ZGepHlke6iCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11E581340C;
	Tue,  2 Jan 2024 14:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sFObK48clGWXXwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 02 Jan 2024 14:24:15 +0000
Date: Wed, 3 Jan 2024 01:24:06 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v2 4/4] btrfs: migrate to the newer memparse_safe()
 helper
Message-ID: <20240103012406.12928a36@echidna>
In-Reply-To: <04b551a30763f776303c7ca8b0d0ffc0ed665e2a.1704168510.git.wqu@suse.com>
References: <cover.1704168510.git.wqu@suse.com>
	<04b551a30763f776303c7ca8b0d0ffc0ed665e2a.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qlnhWp//";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/XgJE2Pd"
X-Spam-Score: -4.81
X-Rspamd-Queue-Id: 212BB1F38E

On Tue,  2 Jan 2024 14:42:14 +1030, Qu Wenruo wrote:

> The new helper has better error report and correct overflow detection,
> furthermore the old @retptr behavior is also kept, thus there should be
> no behavior change.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c |  6 +++++-
>  fs/btrfs/super.c |  9 ++++++++-
>  fs/btrfs/sysfs.c | 14 +++++++++++---
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 4e50b62db2a8..cb63f50a2078 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1175,7 +1175,11 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  			mod = 1;
>  			sizestr++;
>  		}
> -		new_size = memparse(sizestr, &retptr);
> +
> +		ret = memparse_safe(sizestr, MEMPARSE_SUFFIXES_DEFAULT,
> +				    &new_size, &retptr);
> +		if (ret < 0)
> +			goto out_finish;
>  		if (*retptr != '\0' || new_size == 0) {
>  			ret = -EINVAL;
>  			goto out_finish;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3a677b808f0f..0f29fd692e0f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -263,6 +263,8 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct btrfs_fs_context *ctx = fc->fs_private;
>  	struct fs_parse_result result;
> +	/* Only for memparse_safe() caller. */
> +	int ret;
>  	int opt;
>  
>  	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
> @@ -400,7 +402,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->thread_pool_size = result.uint_32;
>  		break;
>  	case Opt_max_inline:
> -		ctx->max_inline = memparse(param->string, NULL);
> +		ret = memparse_safe(param->string, MEMPARSE_SUFFIXES_DEFAULT,
> +				    &ctx->max_inline, NULL);
> +		if (ret < 0) {
> +			btrfs_err(NULL, "invalid string \"%s\"", param->string);
> +			return ret;
> +		}
>  		break;
>  	case Opt_acl:
>  		if (result.negated) {
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 84c05246ffd8..6846572496a6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -762,6 +762,7 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
>  	char *retptr;
>  	u64 val;
> +	int ret;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -776,7 +777,10 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>  	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		return -EPERM;
>  
> -	val = memparse(buf, &retptr);
> +	ret = memparse_safe(buf, MEMPARSE_SUFFIXES_DEFAULT, &val, &retptr);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* There could be trailing '\n', also catch any typos after the value */
>  	retptr = skip_spaces(retptr);
>  	if (*retptr != 0 || val == 0)
> @@ -1779,10 +1783,14 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
>  {
>  	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
>  						   devid_kobj);
> -	char *endptr;
>  	unsigned long long limit;
> +	char *endptr;
> +	int ret;
> +
> +	ret = memparse_safe(buf, MEMPARSE_SUFFIXES_DEFAULT, &limit, &endptr);
> +	if (ret < 0)
> +		return ret;
>  
> -	limit = memparse(buf, &endptr);
>  	/* There could be trailing '\n', also catch any typos after the value. */
>  	endptr = skip_spaces(endptr);
>  	if (*endptr != 0)

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>

