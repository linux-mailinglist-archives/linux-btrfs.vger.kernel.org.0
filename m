Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA33E31C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439551AbfJXMEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 08:04:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439540AbfJXMET (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 08:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B1FAB3B3;
        Thu, 24 Oct 2019 12:04:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 26808DA733; Thu, 24 Oct 2019 14:04:30 +0200 (CEST)
Date:   Thu, 24 Oct 2019 14:04:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove btrfs_bio::flags member
Message-ID: <20191024120429.GH3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191023070447.6899-1-wqu@suse.com>
 <20191023171713.GE3001@twin.jikos.cz>
 <6306e163-0761-acf7-904c-0c9908dac84d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6306e163-0761-acf7-904c-0c9908dac84d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 24, 2019 at 09:33:18AM +0800, Qu Wenruo wrote:
> > I've briefly checked 'void *private', but looks like it can be removed
> > as well, it's holds bi_private of the first_bio (btrfs_map_bio) and it's
> > read in btrfs_end_bbio, but bbio is accessible and so bbio->private is
> > bbio->orig_bio->bi_private.
> 
> Would double check that, anyway it will be another patch.

No rush, that was only a drive-by idea. The btrfs_bio could be improved,
there are eg. some raid56-only members or other types can be narrowed or
reordered so this can be done at the same time. More work compared to
removing a completely unused member.
