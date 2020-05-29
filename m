Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C61E7D61
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgE2Mh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 08:37:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgE2MhZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 08:37:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF8BFAC63;
        Fri, 29 May 2020 12:37:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 06742DA7BD; Fri, 29 May 2020 14:37:23 +0200 (CEST)
Date:   Fri, 29 May 2020 14:37:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] btrfs: Read stripe len directly in
 btrfs_rmap_block
Message-ID: <20200529123723.GQ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200403134035.8875-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403134035.8875-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 04:40:34PM +0300, Nikolay Borisov wrote:
> extent_map::orig_block_len contains the size of a physical stripe when
> it's used to describe block groups (calculated in read_one_chunk via
> calc_stripe_length or calculated in decide_stripe_size and then assigned to
> extent_map::orig_block_len in create_chunk). Exploit this fact to get the
> size directly rather than opencoding the calculations. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> Hello David,
> 
> You had some reservations for this patch but now I've expanded the changelog to
> explain why it's safe to do so.

I've applied the patches to misc-next, if something goes wrong we'll
now. The patches look correct as long as I followed the changelog, but
it's not code I know by heart so if there's something missing I'm
relying on tests to catch it.
