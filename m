Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961573871A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 08:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhERGOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 02:14:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27916 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhERGOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 02:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621318393; x=1652854393;
  h=date:from:to:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=lq0w+nEGUbWnOr5oSk2H0vaWI+hb1U/saa1lww12PBQ=;
  b=OLwL3H1E62NtYKFrzUGFyWIvw45F6hxdvkpIjANv3ObIy+JXdI0yFxWk
   +uyjFiOW8Mb2n2cad8PXv4OKTUHfIsYg4NDvWEUgIFA0G+UqNnw9dWwet
   K3gGu+Y4qMl+Slc/D+9foKFQ4uc4GthF+lRCf4Fg5un1HNAfgp4NXBj0q
   Kf8UEuR4hW2DhevkCZ46ASOmtFXwE4oyvvuK/sENeqUAYcVRn4ldOXVvm
   XX2wxo7FrJhDxfEBAxCLR+1NlgN18rwJYInS37CeA1LOfHuXs66GS2w5r
   yBtUcK9iyf4M8t6f166Bz75cEzlAvhspkGuWrssMknDZSrgPklolSCQYV
   Q==;
IronPort-SDR: deAekdQB8FxglXcLXyyyo0fg/AWFB8iV9+6sHgfVjg6LJYJoGMf2GVWw2jsSnjwv1J7VfIq2AQ
 FU3IKHt0ytxrNL2Vvgkf8k1dILbceRS6IYAPAQfxowXgNBQggAzC5lxOO5fLCmPKXatHZEtdSS
 BcpL+EBMHKxFjCAMS9eCawKWV1sUC15sfUiBbC0Fh4P3bihNlbcb2d20PaPMt0f8f9Ek8NV/RQ
 LI0JopgChr1X5rXPzukm8FcsWVyZvdwL4Q4oH69qLPXxMKd6/irm5NNdiAyDDX9gX4ZAf82je8
 t/E=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; 
   d="scan'208";a="167834443"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 14:13:13 +0800
IronPort-SDR: qhJt197202ox/peHglKiCJynqDScn22UPMeuXxkl0CuKua7hNffBlyU/6GxpOWirQ+tn1wCdc/
 9H+3caqgYEAoSayxZ/hsyiQU70HAxUESZd0fi29Cj2cIMmZ+ars+FDXhE4MeTPG7+UffRidPFe
 DQ6D/eEk/x7ROleekaeMb22PuV7o9S2zoIPlqRnWaSHZYDg5+RjJxIERWW2UxTsAuYMtIdqJn8
 e7mzWr8zQUa8cTb4LaTmva/igQCfKo5LgEJn0XrhKGTcRST2ahafyRChBjeZqHEd/XqFEYswvX
 i5EpCv3tgxgiomCKW24pL6PJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 22:52:53 -0700
IronPort-SDR: sm+n32B0uQ8jlhrlwmfwz9LWv3fca+EaUvmx3PuIKcM1k3BO2hY+syFKTVHjE3K8nrnTjtszTT
 6CqIlrLY3uQjbU6o3a2mA5dwD88hwyLwIIQ3e4TRvtULusLECasIFRuv8fpH5UuLdz6DZeFnL8
 ZBIHk2hteuxrQ2Ay7W4PPdKez72OIecUrwwk+K+oNfgzERHl4L2JmO9wvxJvoI0zZYlBFpqJHI
 zVGV8G4tEhEH7qo4U+mP5Ff3QRZTxBFZliqFxyrQBmnSxDnt+BiF0TwbGNYOzSpwyZF5m0t/1n
 0jo=
WDCIronportException: Internal
Received: from jpf009086.ad.shared (HELO naota-xeon) ([10.225.50.145])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 23:13:11 -0700
Date:   Tue, 18 May 2021 15:13:09 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: disable space cache using proper function
Message-ID: <20210518061309.ajtbe6e3da3t6wpr@naota-xeon>
References: <20210514020308.3824607-1-naohiro.aota@wdc.com>
 <275c2c31-c8e4-cf9e-9137-483efd3e1efa@gmx.com>
 <20210514153049.GZ7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514153049.GZ7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 05:30:49PM +0200, David Sterba wrote:
> On Fri, May 14, 2021 at 06:05:05PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2021/5/14 上午10:03, Naohiro Aota wrote:
> > > As btrfs_set_free_space_cache_v1_active() is introduced, this patch uses
> > > it to disable space cache v1 properly.
> > >
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >   fs/btrfs/super.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > index 4a396c1147f1..89ffc17d074c 100644
> > > --- a/fs/btrfs/super.c
> > > +++ b/fs/btrfs/super.c
> > > @@ -592,7 +592,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
> > >   		if (btrfs_is_zoned(info)) {
> > >   			btrfs_info(info,
> > >   			"zoned: clearing existing space cache");
> > > -			btrfs_set_super_cache_generation(info->super_copy, 0);
> > > +			btrfs_set_free_space_cache_v1_active(info, false);
> > 
> > Can we have a better naming?
> > 
> > The set_..._active() really looks like to *enable* space cache, other
> > than disabling it.
> 
> Agreed, it's really confusing and does the opposite of the name, this
> needs fixing.

Sure. I'll add btrfs_{enable/disable}_free_space_cache_v1() as a prep
patch.

Thanks,
