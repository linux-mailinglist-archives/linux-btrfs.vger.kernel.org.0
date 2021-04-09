Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29714359C55
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhDIKuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 06:50:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIKus (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Apr 2021 06:50:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35651AF95;
        Fri,  9 Apr 2021 10:50:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B2F5DA732; Fri,  9 Apr 2021 12:48:21 +0200 (CEST)
Date:   Fri, 9 Apr 2021 12:48:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: zoned: move superblock logging zone location
Message-ID: <20210409104820.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
 <d22f8dfc-5ca4-4dab-2733-61563475a4a5@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22f8dfc-5ca4-4dab-2733-61563475a4a5@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 08, 2021 at 10:57:32AM -0400, Josef Bacik wrote:
> On 4/8/21 4:25 AM, Naohiro Aota wrote:
> > confusion.
> > 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> Thanks Naohiro, this makes it much easier to understand,
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Dave, I know you're on vacation, this needs to go to Linus for this cycle so we 
> don't have two different SB slots for two different kernels.  I don't want to 
> disturb your vacation, so I'll put this in a pull request tomorrow to Linus.  If 
> you already had plans to do this let me know and I'll hold off.  Thanks,

We don't even have mkfs support for zoned filesystem merged so that the
format is not final was not an issue and that's why I did not hurry
pushing it in that cycle and I still rather not do that.

The design-level problem is the backup copy offset, that's been
discussed in some previous iteration - whether it's right to place all
copies under the first 1T or if we should spread them. For me this is
still not settled, I haven't read through all the replies and given it
enough thought.

That could lead to another change of the offsets that I'm sure we want
to avoid.
