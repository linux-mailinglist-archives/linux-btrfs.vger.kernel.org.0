Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4242129EDB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgJ2Nz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 09:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:46310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgJ2Nzz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 09:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE357AF92;
        Thu, 29 Oct 2020 13:55:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE28CDA7D9; Thu, 29 Oct 2020 14:54:16 +0100 (CET)
Date:   Thu, 29 Oct 2020 14:54:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: file-item: refactor
 btrfs_lookup_bio_sums() to handle out-of-order bvecs
Message-ID: <20201029135415.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-4-wqu@suse.com>
 <765375f6-7c4f-e9d9-f0f5-3de9bac74cce@suse.com>
 <55275e3c-1828-7180-e902-8344a571516e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55275e3c-1828-7180-e902-8344a571516e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 29, 2020 at 08:43:12PM +0800, Qu Wenruo wrote:
> On 2020/10/29 下午7:50, Nikolay Borisov wrote:
> > On 29.10.20 г. 9:12 ч., Qu Wenruo wrote:
> >> +{
> >> +	struct btrfs_csum_item *item = NULL;
> >> +	struct btrfs_key key;
> >> +	u32 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> >
> > nit: Why u32, btrfs_super_csum_size is defined as returning 'int',
> > however this function is really returning u16 since "struct btrfs_csums"
> > is defined as u16.
> 
> It was misguided by u32 from btrfs super block, where sectorsize,
> nodesize are all u32.
> 
> Any recommendation on this? Just u16 for csum_size or follow
> nodesize/sectorsize to use u32?

u32 is ok, this generates a bit better assembly than u16. I'm about to
send the patchset lifting it to fs_info and it uses u32.
