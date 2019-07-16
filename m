Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06306AB74
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfGPPLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 11:11:36 -0400
Received: from verein.lst.de ([213.95.11.211]:42469 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfGPPLg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 11:11:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3D41227A81; Tue, 16 Jul 2019 17:11:33 +0200 (CEST)
Date:   Tue, 16 Jul 2019 17:11:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw
 buffers
Message-ID: <20190716151133.GA6073@lst.de>
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 06:04:16PM +0300, Andy Shevchenko wrote:
> +static inline void guid_copy_from_raw(guid_t *dst, const __u8 *src)
> +{
> +	memcpy(dst, (const guid_t *)src, sizeof(guid_t));
> +}
> +
> +static inline void guid_copy_to_raw(__u8 *dst, const guid_t *src)
> +{
> +	memcpy((guid_t *)dst, src, sizeof(guid_t));
> +}

Maybe import_guid/export_guid is a better name?

Either way, I don't think we need the casts, and they probably want
kerneldoc comments describing their use.

Same for the uuid side.

> +static inline void guid_gen_raw(__u8 *guid)
> +{
> +	guid_gen((guid_t *)guid);
> +}
> +
> +static inline void uuid_gen_raw(__u8 *uuid)
> +{
> +	uuid_gen((uuid_t *)uuid);
> +}

I hate this raw naming.  If people really want to use the generators on
u8 fields a cast seems more descriptive then hiding it.
