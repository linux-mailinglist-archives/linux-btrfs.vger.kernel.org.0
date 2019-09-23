Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2999CBB7D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfIWPYc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 11:24:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfIWPYb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 11:24:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 756D7AD2A;
        Mon, 23 Sep 2019 15:24:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90CCBDA871; Mon, 23 Sep 2019 17:24:50 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:24:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add assert to catch nested transaction commit
Message-ID: <20190923152450.GE2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190912153144.26638-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912153144.26638-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 06:31:44PM +0300, Nikolay Borisov wrote:
> A recent patch to btrfs showed that there was at least 1 case where a
> nesed transaction was committed. Nested transaction in this case  means
> a code which has a transaction handle calls some function which in turn
> obtains a copy of the same transaction handle. In such cases the correct
> thing to do is for the lower callee to call btrfs_end_transaction which
> contains appropriate checks so as to not commit the transaction which
> will result in stale trans handler for the caller.
> 
> To catch such cases add an assert in btrfs_commit_transaction ensuring
> btrfs_trans_handle::use_count is always 1.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
