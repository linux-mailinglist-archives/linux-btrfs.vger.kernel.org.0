Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA42A2E00
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgKBPT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 10:19:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:55630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgKBPT4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 10:19:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 292FBACA3;
        Mon,  2 Nov 2020 15:19:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08BECDA7D2; Mon,  2 Nov 2020 16:18:17 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:18:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: replace s_blocksize_bits with
 fs_info::sectorsize_bits
Message-ID: <20201102151817.GF6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <1021ce9995a25cca9dbfeb49ba298aaff53f0986.1603981453.git.dsterba@suse.com>
 <8154edcf-f82f-1e1e-8313-433ff46d94c1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8154edcf-f82f-1e1e-8313-433ff46d94c1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 02, 2020 at 10:23:43PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/10/29 下午10:27, David Sterba wrote:
> > The value of super_block::s_blocksize_bits is the same as
> > fs_info::sectorsize_bits, but we don't need to do the extra dereferences
> > in many functions and storing the bits as u32 (in fs_info) generates
> > shorter assembly.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> This patch is great.
> 
> I was just going to kill all "inode->i_sb->s_blocksize_bits" for subpage.
> 
> Although for subpage case, we may populate sb->s_blocksize_bits to
> PAGE_SHIFT, as current subpage doesn't support real subpage write at all.
> Thus we want everything from DIO alignement to reflink alignment to
> still be PAGE_SIZE.

Yeah the different alignment constraints with subpage will be
interesting.
