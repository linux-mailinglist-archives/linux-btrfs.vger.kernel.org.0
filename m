Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC22B9CB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgKSVLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 16:11:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:35910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKSVLQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 16:11:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5F80ABF4;
        Thu, 19 Nov 2020 21:11:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4C79DA701; Thu, 19 Nov 2020 22:09:28 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:09:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 15/24] btrfs: extent-io: make type of
 extent_state::state to be at least 32 bits
Message-ID: <20201119210928.GP20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-16-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-16-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:40PM +0800, Qu Wenruo wrote:
> Currently we use 'unsigned' for extent_state::state, which is only ensured
> to be at least 16 bits.
> 
> But for incoming subpage support, we are going to introduce more bits,
> thus we will go beyond 16 bits.
> 
> To support this, make extent_state::state at least 32bit and to be more
> explicit, we use "u32" to be clear about the max supported bits.
> 
> This doesn't increase the memory usage for x86_64, but may affect other
> architectures.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next.
