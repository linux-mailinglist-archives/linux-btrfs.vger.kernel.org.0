Return-Path: <linux-btrfs+bounces-11124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F465A217B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CF21670FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D8194C8B;
	Wed, 29 Jan 2025 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYXlaTpf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29842176FB0;
	Wed, 29 Jan 2025 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132063; cv=none; b=cniOJtudTc1YDj8AJ0wZ8nPqosoQs3jmcOw/QAlAE6Rdlpa0IoXe6rfjmQUsXGoIIMpKE5rB1/czlo68MvPhOAIA1ZvFWVTWCCaQS0miSngOB7m6LDlfFVpMBLM8xRqQylTB149/Z3MbfbQqxL08tfGndtqQFx47badtQg0X/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132063; c=relaxed/simple;
	bh=BcheDkbF7i4plK077EE5fx0I+7LaoMSZmCvmiRwCLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP+y1JYHovCjyi9sK70N/J1fhOdvICAJIL1jb+UZQNeAjCxsyv6OC13eWlgDMxi6rxthxaT6xMyn3Jgo/nFvO4dsDYAELRTfLDThRRor/9GAA4oDi9YI1oR54TmXx8qS9tnKAeWxz+rIb/Pu/08XMDUcySRe8nG9aUQAY5fML9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYXlaTpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E108EC4CED3;
	Wed, 29 Jan 2025 06:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738132062;
	bh=BcheDkbF7i4plK077EE5fx0I+7LaoMSZmCvmiRwCLWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYXlaTpf1UHLxCOLY2b71oBs1Z8jmc+k88hDg4mxgy9BfVh5FaZFJ0sctqiMaUJa3
	 0ERjR88O2sKxLaXENNFiYXgW5V6EWANwLybrlRdZ0uAueHnvFc/luTGhJJHi5qSyHf
	 Qhwk4n5jqTURqvwR6zUdrtKBktKuVAQJmisiNKpSZSSK6LJmo4zYOOzg6tSFgxCsOc
	 Qfzb+Ch4Hp08uSkL1c1h9vCW8n/kbD+KUJVXjOVTrDcLl+peTbMx/iozRX16+XGbqx
	 LmxLOokGigU1zjIvh0goqBVkjBWqvL4YDcg+yxNUApdR5ACop75NXb+fT4J9+7jnPJ
	 KRVcLrP4/YQHg==
Date: Wed, 29 Jan 2025 07:27:24 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 09/16] xfs: convert timeouts to secs_to_jiffies()
Message-ID: <kywszbmxtm27rlgaefr6xus6l4bpdiouqqe72px7ml72hh4ozc@5orjtzsbg75s>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <JZGx8kYNWP54f9cEViEKZlR6sGGADv31K4TOPtwvyeoDEFkRKICiFaQy04EvZtsQtc44Zozh76mkch2s8rz7mQ==@protonmail.internalid>
 <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-9-9a6ecf0b2308@linux.microsoft.com>

On Tue, Jan 28, 2025 at 06:21:54PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  fs/xfs/xfs_icache.c | 2 +-
>  fs/xfs/xfs_sysfs.c  | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 7b6c026d01a1fc020a41a678964cdbf7a8113323..7a1feb8dc21f6f71d04f88de866e5a95925e0c54 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -230,7 +230,7 @@ xfs_blockgc_queue(
>  	rcu_read_lock();
>  	if (radix_tree_tagged(&pag->pag_ici_root, XFS_ICI_BLOCKGC_TAG))
>  		queue_delayed_work(mp->m_blockgc_wq, &pag->pag_blockgc_work,
> -				   msecs_to_jiffies(xfs_blockgc_secs * 1000));
> +				   secs_to_jiffies(xfs_blockgc_secs));
>  	rcu_read_unlock();
>  }
> 
> diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
> index 60cb5318fdae3cc246236fd988b4749df57f8bfc..eed0f28afe97ead762a9539e45f292db7d0d0c4a 100644
> --- a/fs/xfs/xfs_sysfs.c
> +++ b/fs/xfs/xfs_sysfs.c
> @@ -568,8 +568,8 @@ retry_timeout_seconds_store(
>  	if (val == -1)
>  		cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
>  	else {
> -		cfg->retry_timeout = msecs_to_jiffies(val * MSEC_PER_SEC);
> -		ASSERT(msecs_to_jiffies(val * MSEC_PER_SEC) < LONG_MAX);
> +		cfg->retry_timeout = secs_to_jiffies(val);
> +		ASSERT(secs_to_jiffies(val) < LONG_MAX);
>  	}
>  	return count;
>  }
> @@ -686,8 +686,7 @@ xfs_error_sysfs_init_class(
>  		if (init[i].retry_timeout == XFS_ERR_RETRY_FOREVER)
>  			cfg->retry_timeout = XFS_ERR_RETRY_FOREVER;
>  		else
> -			cfg->retry_timeout = msecs_to_jiffies(
> -					init[i].retry_timeout * MSEC_PER_SEC);
> +			cfg->retry_timeout = secs_to_jiffies(init[i].retry_timeout);
>  	}
>  	return 0;

Looks fine to me.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> 
> 
> --
> 2.43.0
> 
> 

