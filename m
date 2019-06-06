Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A68E36F30
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfFFIyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 04:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbfFFIyy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 04:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67920AD56;
        Thu,  6 Jun 2019 08:54:53 +0000 (UTC)
Date:   Thu, 6 Jun 2019 10:54:52 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: correctly validate compression type
Message-ID: <20190606085452.GA4172@x250>
References: <20190606080106.10640-1-jthumshirn@suse.de>
 <SN6PR04MB5231CD8957F12BBEA8093A828C170@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR04MB5231CD8957F12BBEA8093A828C170@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 08:43:34AM +0000, Naohiro Aota wrote:
[...]
> > +bool btrfs_compress_is_valid_type(const char *str, size_t len)
> > +{
> > +	int i;
> > +
> > +	for (i = 1; i < ARRAY_SIZE(btrfs_compress_types); i++) {
> > +		size_t comp_len = strlen(btrfs_compress_types[i]);
> > +
> > +		if (comp_len != len)
> 
> Should this be "if (comp_len > len)"?

I thought about this as well and essentiall it is 'comp_len > len' as the
strncmp() later compares up to comp_len anyways. But your're rigth it'll fail
on values like "zlib:9".

Thanks,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
