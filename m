Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BB30ABD2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhBAPpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 10:45:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:49096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhBAPos (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 10:44:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8313BAB92;
        Mon,  1 Feb 2021 15:44:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09038DA6FC; Mon,  1 Feb 2021 16:42:17 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:42:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 16/18] btrfs: introduce btrfs_subpage for data inodes
Message-ID: <20210201154217.GQ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-17-wqu@suse.com>
 <62fa0a03-e375-8528-0e75-a593745eae1d@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62fa0a03-e375-8528-0e75-a593745eae1d@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 11:56:39AM -0500, Josef Bacik wrote:
> On 1/26/21 3:34 AM, Qu Wenruo wrote:
> > @@ -8345,7 +8347,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> >   	wait_on_page_writeback(page);
> >   
> >   	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
> > -	set_page_extent_mapped(page);
> > +	ret2 = set_page_extent_mapped(page);
> > +	if (ret2 < 0) {
> > +		ret = vmf_error(ret2);
> > +		goto out_unlock;
> > +	}
> 
> Sorry I missed this bit in my last reply, you need a
> 
> ret = vmf_error(ret2);
> unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
> goto out_unlock;

Folded to the patch, thanks.
