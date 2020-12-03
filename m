Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CEE2CDDFB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgLCSrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:47:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:35158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbgLCSrh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 13:47:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FA51AC2E;
        Thu,  3 Dec 2020 18:46:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74740DA6E9; Thu,  3 Dec 2020 19:45:22 +0100 (CET)
Date:   Thu, 3 Dec 2020 19:45:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 01/15] btrfs: rename bio_offset of
 extent_submit_bio_start_t to opt_file_offset
Message-ID: <20201203184522.GR6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201202064811.100688-1-wqu@suse.com>
 <20201202064811.100688-2-wqu@suse.com>
 <20201202081236.GA18301@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202081236.GA18301@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 02, 2020 at 08:12:36AM +0000, Christoph Hellwig wrote:
> On Wed, Dec 02, 2020 at 02:47:57PM +0800, Qu Wenruo wrote:
> > The parameter bio_offset of extent_submit_bio_start_t is very confusing.
> > 
> > If it's really bio_offset (offset to bio), then it should be u32.
> > 
> > But in fact, it's only utilized by dio read, and that member is used as
> > file offset, which must be u64.
> > 
> > Rename it to opt_file_offset since the only user uses it as file offset,
> > and add comment for who is using it.
> 
> I think dio_file_offset might be a better name.

Sounds good, I'll change it. Thanks.
