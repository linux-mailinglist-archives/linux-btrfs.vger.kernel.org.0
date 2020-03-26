Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622B5193B70
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 10:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCZJDP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 05:03:15 -0400
Received: from lists.nic.cz ([217.31.204.67]:34878 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCZJDP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 05:03:15 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 30E32142F70;
        Thu, 26 Mar 2020 10:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1585213393; bh=GxcFqwVa86C4LeBYRn8TQrt01rLrI9paWKjZnPW4YAQ=;
        h=Date:From:To;
        b=q2gOy1vFXs7WoEF9DTuKa9E6jBtA3eBK4Lip25vz/iAfFgDMFiDqCsDqv9D+78YcL
         HebWFCVG6Cgu9X4VZY/fchExhhn5PCturSUYAKWaJST1iNeHUAZdc977UwCKhmbuFH
         JgoBzBHzzNua2Fel4SgV7Htufjm7082cJP4XYadw=
Date:   Thu, 26 Mar 2020 10:03:12 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH U-BOOT v2 2/3] fs: btrfs: Reject fs with sector size
 other than PAGE_SIZE
Message-ID: <20200326100312.32cbae6f@nic.cz>
In-Reply-To: <20200326053556.20492-3-wqu@suse.com>
References: <20200326053556.20492-1-wqu@suse.com>
        <20200326053556.20492-3-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 26 Mar 2020 13:35:55 +0800
Qu Wenruo <wqu@suse.com> wrote:

> Although in theory u-boot fs driver could easily support more sector
> sizes, current code base doesn't have good enough way to grab sector
> size yet.
>=20
> This would cause problem for later LZO fixes which rely on sector size.
>=20
> And considering that most u-boot boards are using 4K page size, which is
> also the most common sector size for btrfs, rejecting fs with
> non-page-sized sector size shouldn't cause much problem.
>=20
> This should only be a quick fix before we implement better sector size
> support.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Cc: Marek Behun <marek.behun@nic.cz>
> ---
>  fs/btrfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2dc4a6fcd7a3..b693a073fc0b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -7,6 +7,7 @@
> =20
>  #include "btrfs.h"
>  #include <memalign.h>
> +#include <linux/compat.h>
> =20
>  #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN	\
>  				 | BTRFS_HEADER_FLAG_RELOC	\
> @@ -232,6 +233,13 @@ int btrfs_read_superblock(void)
>  		return -1;
>  	}
> =20
> +	if (sb->sectorsize !=3D PAGE_SIZE) {
> +		printf(
> +	"%s: Unsupported sector size (%u), only supports %u as sector size\n",
> +			__func__, sb->sectorsize, PAGE_SIZE);
> +		return -1;
> +	}
> +
>  	if (btrfs_info.sb.num_devices !=3D 1) {
>  		printf("%s: Unsupported number of devices (%lli). This driver "
>  		       "only supports filesystem on one device.\n", __func__,

Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
