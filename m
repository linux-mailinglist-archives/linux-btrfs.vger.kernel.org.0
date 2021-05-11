Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E125137A634
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhEKMDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 08:03:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhEKMDo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 08:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 058E4ADCE;
        Tue, 11 May 2021 12:02:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E6F9DA96D; Tue, 11 May 2021 14:00:07 +0200 (CEST)
Date:   Tue, 11 May 2021 14:00:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: linux-next: Tree for May 11 (btrfs)
Message-ID: <20210511120007.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20210511133551.09bfd39c@canb.auug.org.au>
 <56cef5d3-cfb4-abe2-1cbc-f146b720396c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cef5d3-cfb4-abe2-1cbc-f146b720396c@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 10:13:17PM -0700, Randy Dunlap wrote:
> On 5/10/21 8:35 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20210510:
> > 
> 
> on i386:
> 
> ld: fs/btrfs/extent_io.o: in function `btrfs_submit_read_repair':
> extent_io.c:(.text+0x624f): undefined reference to `__udivdi3'

Thanks for the report, will be fixed in the next for-next snapshot.
