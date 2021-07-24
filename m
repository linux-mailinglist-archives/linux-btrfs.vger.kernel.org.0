Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CFB3D48A9
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGXQNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 12:13:52 -0400
Received: from verein.lst.de ([213.95.11.211]:40992 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhGXQNv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 12:13:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E83467373; Sat, 24 Jul 2021 18:54:20 +0200 (CEST)
Date:   Sat, 24 Jul 2021 18:54:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: fixes and cleanups for block_device refcounting v3
Message-ID: <20210724165420.GA22350@lst.de>
References: <20210724071249.1284585-1-hch@lst.de> <20210724072223.GA2930@lst.de> <718272a2-de67-c849-7c6e-2232f8762b23@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718272a2-de67-c849-7c6e-2232f8762b23@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 10:06:31AM -0600, Jens Axboe wrote:
> Shall we get patch 1 queued up for next week, and then look at the rest
> for the 5.15 block tree once the btrfs fix lands in mainline?

Sounds good.  The btrfs patch is in fact in mainline already as of today.
