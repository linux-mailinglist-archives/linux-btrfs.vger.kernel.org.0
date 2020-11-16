Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66A52B4B1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgKPQ2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 11:28:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:43442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgKPQ2s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 11:28:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28650AD11;
        Mon, 16 Nov 2020 16:28:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A079ADA6E3; Mon, 16 Nov 2020 17:27:02 +0100 (CET)
Date:   Mon, 16 Nov 2020 17:27:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: file-item: refactor btrfs_lookup_bio_sums()
 to handle out-of-order bvecs
Message-ID: <20201116162702.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201028072432.86907-1-wqu@suse.com>
 <20201028072432.86907-4-wqu@suse.com>
 <20201103194650.GD6756@twin.jikos.cz>
 <2e0deb82-c2cf-088b-5abf-92003823613b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0deb82-c2cf-088b-5abf-92003823613b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 04, 2020 at 07:42:21AM +0800, Qu Wenruo wrote:
> >> +	if (path->nodes[0]) {
> >> +		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
> >> +				      struct btrfs_csum_item);
> >> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> >> +		csum_start = key.offset;
> >> +		csum_len = btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
> >> +			   csum_size * sectorsize;
> > 
> > 			path->slots[0]) / csum_size * sectorsize
> > 
> > This expresission would be better on one line
> 
> But it's already over 80 charactors.
> 
> Or maybe I could use a small helper to do the csum_len calcuation like
> calc_csum_lenght(path)?

If it's a slight 80 columns overflow I'm joining the lines, there are
exceptions like ending ); or ) { or if the first part of the word is
enough to understand.
