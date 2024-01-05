Return-Path: <linux-btrfs+bounces-1273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB229825AEA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734842869A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DAD3609A;
	Fri,  5 Jan 2024 19:04:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA736083;
	Fri,  5 Jan 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C028A1F8B3;
	Fri,  5 Jan 2024 19:04:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D608136F5;
	Fri,  5 Jan 2024 19:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A546Jq5SmGWgZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 05 Jan 2024 19:04:14 +0000
Date: Fri, 5 Jan 2024 20:04:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM,
	ddiss@suse.de, geert@linux-m68k.org, rdunlap@infradead.org
Subject: Re: [PATCH v4 4/4] btrfs: migrate to the newer memparse_safe() helper
Message-ID: <20240105190402.GA28693@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704422015.git.wqu@suse.com>
 <0c006657fd7d5d923e135bdd4cecc5bcf6a01451.1704422015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c006657fd7d5d923e135bdd4cecc5bcf6a01451.1704422015.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C028A1F8B3
X-Spam-Flag: NO

On Fri, Jan 05, 2024 at 01:05:02PM +1030, Qu Wenruo wrote:
> The new helper has better error report and correct overflow detection,
> furthermore the old @retptr behavior is also kept, thus there should be
> no behavior change.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Disseldorp <ddiss@suse.de>
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

Please drop the comment.

