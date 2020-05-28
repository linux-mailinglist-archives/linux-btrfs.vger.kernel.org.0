Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D021E6717
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404764AbgE1QIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 12:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404666AbgE1QIV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 12:08:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 776F5ABBD;
        Thu, 28 May 2020 16:08:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0449CDA732; Thu, 28 May 2020 18:07:21 +0200 (CEST)
Date:   Thu, 28 May 2020 18:07:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        DanglingPointer <danglingpointerexception@gmail.com>,
        Joshua Houghton <joshua.houghton@yandex.ru>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH V2] btrfs-progs: add RAID5/6 support to btrfs fi us
Message-ID: <20200528160721.GN18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org,
        DanglingPointer <danglingpointerexception@gmail.com>,
        Joshua Houghton <joshua.houghton@yandex.ru>,
        David Sterba <dsterba@suse.com>
References: <20200527203748.32860-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527203748.32860-1-kreijack@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 10:37:47PM +0200, Goffredo Baroncelli wrote:
> this patch adds support for the raid5/6 profiles in the command
> 'btrfs filesystem usage'.

> $ sudo btrfs fi us / 
> Overall:
>     Device size:		  40.00GiB
>     Device allocated:		   8.28GiB
>     Device unallocated:		  31.72GiB
>     Device missing:		     0.00B
>     Used:			   5.00GiB
>     Free (estimated):		  17.36GiB	(min: 17.36GiB)
>     Data ratio:			      2.00
>     Metadata ratio:		      0.00
>     Global reserve:		   3.25MiB	(used: 0.00B)
> 
> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)

> Instead before:
> 
> $ sudo btrfs fi us /
> WARNING: RAID56 detected, not implemented
> WARNING: RAID56 detected, not implemented
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:		  40.00GiB
>     Device allocated:		     0.00B
>     Device unallocated:		  40.00GiB
>     Device missing:		     0.00B
>     Used:			     0.00B
>     Free (estimated):		     0.00B	(min: 8.00EiB)
>     Data ratio:			      0.00
>     Metadata ratio:		      0.00
>     Global reserve:		   3.25MiB	(used: 0.00B)
> 
> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)

> I rewrote the patch after some David's comments about the difficult to
> review it because I changed too much code. So this time I tried to be less
> intrusive. I leaved the old logic and I computed only the missing
> values.

Thanks, that's what I expected. Patch added to devel.
