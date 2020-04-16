Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA591AC1D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894570AbgDPMzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 08:55:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894377AbgDPMza (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 08:55:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF96FAB64;
        Thu, 16 Apr 2020 12:55:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38CCCDA727; Thu, 16 Apr 2020 14:54:49 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:54:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 2/2] btrfs: Reformat btrfs_tree.h comments
Message-ID: <20200416125448.GK5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415084113.64378-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 15, 2020 at 04:41:13PM +0800, Qu Wenruo wrote:
> Since we're here, modify btrfs_tree.h to follow the latest comment
> style.
> 
> This involves:
> - Use upper case char for the first word
> - Use one line comment if possible
> - Add the ending dot if it's a sentence
> - Add more comment explaining the usage of each tree
> - Add key type/objectid/offset reference URL
> - Remove dead comment
> - Update the header define line to reflect the filename
> - Add newline to seperate long comment

Going through the file I think we could do more changes so the format
documentation is complete. I'd also reformat the defines so the name and
value are separated by a few tabs. My changes on top of your patch will
be in misc-next but the plan is to squash them in the end. It'll
probably take a few more passes so the style is consistent.
