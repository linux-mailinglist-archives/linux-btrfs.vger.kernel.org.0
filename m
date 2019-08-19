Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13ED91FC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 11:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfHSJPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 05:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfHSJPs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 05:15:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0221AEFD
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 09:15:47 +0000 (UTC)
Date:   Mon, 19 Aug 2019 11:15:47 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] btrfs: sysfs: export supported checksums
Message-ID: <20190819091547.GC8571@x250>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <cover.1564046812.git.jthumshirn@suse.de>
 <e377ded65e4f2799776596ead308658710e4c8c1.1564046812.git.jthumshirn@suse.de>
 <d79d158e-f68a-a7ad-6e29-387a6ed42ecc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d79d158e-f68a-a7ad-6e29-387a6ed42ecc@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 12:19:13PM +0300, Nikolay Borisov wrote:
> > +static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
> > +	.kobj_attr = __INIT_KOBJ_ATTR(checksums, S_IRUGO,
> > +				      btrfs_checksums_show,
> > +				      btrfs_checksums_store),
> 
> Since we won't ever support writing to this sysfs just kill
> btrfs_checksums_store and simply pass NULL as the last argument to
> INIT_KOBJ_ATTR.
> 

Yup will do.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
