Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B185036CFE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhD1AIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 20:08:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28778 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbhD1AIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 20:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619568459; x=1651104459;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=G78ktExlDeLCOyyzJcw+PnwaQdINDZljaylm7pNSy28=;
  b=irXiYvRkgDLhKtEqsGhsyBQe+NmR7jVCWORQADvTW4+jpv6yyBfFMWLj
   9ktM0ThGyLEGtBMxtGvG3lKKaTYVMPTkZdISV2AiWDEQJyK4otlpvcjXu
   QjKkc7nDpAR3hc14EXKAG2QkZ7TXG+FkAwUipwrtX8vIVzIra7qsao2n8
   0Un2NOS6ECvig8dm+KumLEE4eqJ9rYjz77WWEEURuBAFqCdCIhPdWur84
   b/yQDE80K8i0VXcmccIaRDWLJpmY7Vbl0CyP5Xx9XTJAFExEhX9h4xDNX
   kruwkF+HY8a+9Otr8g6GtjhYBNhbf70FeRM5rcBt9P6Rx5iWbAhqSIVb0
   A==;
IronPort-SDR: 7jY9RuJgbV5/Fd1w9HgU6JlGEaQglY/kIGAf3+U0ICg9m70qcq3i5j7uF+nW3dOpX5zUnkhQh6
 jBd16HmfHwZiWcLIjhxzM/zCFj8RToB07ZF5wKYPk1lHul5Y933/D7PfO5fMgU6O8UPcEfgoi9
 Sk++VyZDdql22SKsTTFZMe2O51otTDbftWPSbKQm7xbAX5ikGGfgobQKQL1iR3qfzXyWtmxNo7
 /JQfG+CLt1j8ZunJh+C2KUvDCot9Sj2bE0H1Xd5MtlIiC/b9YWArAFBFg080m4xVuAXeLfZQtW
 Hcw=
X-IronPort-AV: E=Sophos;i="5.82,256,1613404800"; 
   d="scan'208";a="171006594"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 08:07:39 +0800
IronPort-SDR: cvDaTKNzGIjaaDo11ngGTLH4WWZut2iNwVvZxUHJdY44EpDGNpbxeBwC/821DqlIbJSNtX7xED
 wI7mO646tM1CvIka6ypYeVJDk/ZSMsf8LwPniJsfb4Vms7eonN7jrLxyclrS16PiJxUA09q/NE
 1cY5G/nrSBC+I9H75KGHLKLxDUfznaezv8I3S1KKpRZEprKTKoezncFwbKUYIP6Hy3Bjaxq9LH
 es/T0qZOuaRrT+Gn5epyP907rWg+SH/EC3duVLrPRN6wA1WEwGy02mpQBhET4j+lfxxztnDEA9
 423gBX5pgU0c2Fo4yqsdbpN9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 16:46:29 -0700
IronPort-SDR: uT7nO/LKSltB/BJTaGzHzvpPVqTmFUwcI3otAtxQU8u934oPFmBbYjQihvxQyhbV5NhEZrBaOR
 mgSuA+JQ01//9hTSjw48+H3e3hvI7+X3+Ah3dO69MaHCB2QVWouRb/E3DRWprYXk76mAbqVObe
 9eYtduIggl5wHV3KHWQFHgRxadgrWOFdlEb8rKp0A3+i4vb0+BfSWlaCHKEclw0YwKQWWHDB3S
 PiFqdx7dvXAv19FMNOVyeQsb4sbzZ+/1wlJYu1cM8YM0eCm3BkPx1+Kw4vP6VllcDJh3k9Z86e
 pYg=
WDCIronportException: Internal
Received: from ctm87y2.ad.shared (HELO naota-xeon) ([10.225.48.120])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 17:07:38 -0700
Date:   Wed, 28 Apr 2021 09:07:37 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 04/26] btrfs-progs: zoned: add new ZONED feature flag
Message-ID: <20210428000737.uurli7wtweiaajny@naota-xeon>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <c222a684214512e36fc721ee23ded5145bf9d89c.1619416549.git.naohiro.aota@wdc.com>
 <20210427154636.GK7604@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427154636.GK7604@suse.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 27, 2021 at 05:46:36PM +0200, David Sterba wrote:
> On Mon, Apr 26, 2021 at 03:27:20PM +0900, Naohiro Aota wrote:
> > With the zoned feature enabled, a zoned block device-aware btrfs allocates
> > block groups aligned to the device zones and always write in sequential
> > zones at the zone write pointer position.
> > 
> > It also supports "emulated" zoned mode on a non-zoned device. In the
> > emulated mode, btrfs emulates conventional zones by slicing the device with
> > a fixed size.
> > 
> > We don't support conversion from the ext4 volume with the zoned feature
> > because we can't be sure all the converted block groups are aligned to zone
> > boundaries.
> > 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/fsfeatures.c        | 8 ++++++++
> >  common/fsfeatures.h        | 3 ++-
> >  kernel-shared/ctree.h      | 4 +++-
> >  kernel-shared/print-tree.c | 1 +
> >  4 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> > index 569208a9e5b1..c0793339b531 100644
> > --- a/common/fsfeatures.c
> > +++ b/common/fsfeatures.c
> > @@ -100,6 +100,14 @@ static const struct btrfs_feature mkfs_features[] = {
> >  		NULL, 0,
> >  		NULL, 0,
> >  		"RAID1 with 3 or 4 copies" },
> > +#ifdef BTRFS_ZONED
> > +	{ "zoned", BTRFS_FEATURE_INCOMPAT_ZONED,
> > +		"zoned",
> > +		NULL, 0,
> > +		NULL, 0,
> > +		NULL, 0,
> > +		"support Zoned devices" },
> > +#endif
> >  	/* Keep this one last */
> >  	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
> >  };
> > diff --git a/common/fsfeatures.h b/common/fsfeatures.h
> > index 74ec2a21caf6..1a7d7f62897f 100644
> > --- a/common/fsfeatures.h
> > +++ b/common/fsfeatures.h
> > @@ -25,7 +25,8 @@
> >  		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
> >  
> >  /*
> > - * Avoid multi-device features (RAID56) and mixed block groups
> > + * Avoid multi-device features (RAID56), mixed block groups, and zoned
> > + * btrfs
> >   */
> >  #define BTRFS_CONVERT_ALLOWED_FEATURES				\
> >  	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
> 
> Looks like BTRFS_FEATURE_INCOMPAT_ZONED should be here.

Since, we do not support converting ext4 to zoned btrfs, I didn't list
it here. I do not think we can support the converting easily, since
ext4's data might not aligned to the zone boundary.
