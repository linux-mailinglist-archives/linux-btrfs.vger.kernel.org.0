Return-Path: <linux-btrfs+bounces-1141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635F81ECA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F391F21460
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896045396;
	Wed, 27 Dec 2023 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fy65utrA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hzzG6cK/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fy65utrA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hzzG6cK/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EF5228;
	Wed, 27 Dec 2023 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 186D721F0A;
	Wed, 27 Dec 2023 06:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703658455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FakuDnvNk9/YjmcoZ/WVOYeU7HnKDgkIl+6IPRziswE=;
	b=fy65utrANAhoHW1PKl99U1yOzgRDKnt8FQbQ09zIHtO9y4vy9ktIWn3cEHe8O+Q2WJPPPJ
	bLGSPzBRNK000hGl+D1vpaxgdJmy9iB93fCr3fI3PF9OsbQZieMr6cFDg0ogS0Pc8xO+Fa
	v6P6o8p0yLYWIYzqeyAa4I9YCG320AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703658455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FakuDnvNk9/YjmcoZ/WVOYeU7HnKDgkIl+6IPRziswE=;
	b=hzzG6cK/ky4Ian2nbOoLikiSrP5+sHLGkaIG8VBjFIxiq7uuRS+vb32BJwWx+/ue4E7j0/
	pUR+m7dVzc1nr1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703658455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FakuDnvNk9/YjmcoZ/WVOYeU7HnKDgkIl+6IPRziswE=;
	b=fy65utrANAhoHW1PKl99U1yOzgRDKnt8FQbQ09zIHtO9y4vy9ktIWn3cEHe8O+Q2WJPPPJ
	bLGSPzBRNK000hGl+D1vpaxgdJmy9iB93fCr3fI3PF9OsbQZieMr6cFDg0ogS0Pc8xO+Fa
	v6P6o8p0yLYWIYzqeyAa4I9YCG320AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703658455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FakuDnvNk9/YjmcoZ/WVOYeU7HnKDgkIl+6IPRziswE=;
	b=hzzG6cK/ky4Ian2nbOoLikiSrP5+sHLGkaIG8VBjFIxiq7uuRS+vb32BJwWx+/ue4E7j0/
	pUR+m7dVzc1nr1Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E67113902;
	Wed, 27 Dec 2023 06:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iZciOtLDi2WOIAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Wed, 27 Dec 2023 06:27:30 +0000
Date: Wed, 27 Dec 2023 17:27:09 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH 3/3] btrfs: migrate to the newer memparse_safe() helper
Message-ID: <20231227172709.4402bc6c@echidna>
In-Reply-To: <6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu@suse.com>
References: <cover.1703324146.git.wqu@suse.com>
	<6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu@suse.com>
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
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sat, 23 Dec 2023 20:28:07 +1030, Qu Wenruo wrote:

> The new helper has better error report and correct overflow detection,
> furthermore the old @retptr behavior is also kept, thus there should be
> no behavior change.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c |  8 ++++++--
>  fs/btrfs/super.c |  8 ++++++++
>  fs/btrfs/sysfs.c | 14 +++++++++++---
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 4e50b62db2a8..8bfd4b4ccf02 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1175,8 +1175,12 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>  			mod = 1;
>  			sizestr++;
>  		}
> -		new_size = memparse(sizestr, &retptr);
> -		if (*retptr != '\0' || new_size == 0) {
> +
> +		ret = memparse_safe(sizestr, MEMPARSE_SUFFIXES_DEFAULT,
> +				    &new_size, &retptr);
> +		if (ret < 0)
> +			goto out_finish;
> +		if (*retptr != '\0') {

Was dropping the -EINVAL return for new_size=0 intentional?

>  			ret = -EINVAL;
>  			goto out_finish;
>  		}
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3a677b808f0f..2bb6ea525e89 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -400,6 +400,14 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->thread_pool_size = result.uint_32;
>  		break;
>  	case Opt_max_inline:
> +		int ret;
> +
> +		ret = memparse_safe(param->string, MEMPARSE_SUFFIXES_DEFAULT,
> +				    &ctx->max_inline, NULL);
> +		if (ret < 0) {
> +			btrfs_err(NULL, "invalid string \"%s\"", param->string);
> +			return ret;
> +		}
>  		ctx->max_inline = memparse(param->string, NULL);

Looks like you overlooked removal of the old memparse() call above.

Cheers, David

