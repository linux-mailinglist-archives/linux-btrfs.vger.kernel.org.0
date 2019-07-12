Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9711669D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfGLJVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 05:21:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbfGLJVj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 05:21:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85B97AF6B;
        Fri, 12 Jul 2019 09:21:38 +0000 (UTC)
Date:   Fri, 12 Jul 2019 11:21:38 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: free checksum hash on in close_ctree
Message-ID: <20190712092138.GC16276@x250.microfocus.com>
References: <20190711152304.11438-1-jthumshirn@suse.de>
 <565cf2c9-6b97-349f-9540-655daa3c85f4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <565cf2c9-6b97-349f-9540-655daa3c85f4@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 12, 2019 at 03:34:45PM +0800, Qu Wenruo wrote:
> Not yet in upstream, thus I believe David could just fold this fix into
> the original commit.
 
Right, I just didn't know if David's gonna rebase his branch before the pull
request. AFAIK Linus doesn't really like recently rebased branches.

> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although for the folding case, that reviewed-by won't make much sense.

Thanks anyways,
	Johannes

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
