Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5207C824B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfHESN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 14:13:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728701AbfHESN1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 14:13:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CBFCAECB;
        Mon,  5 Aug 2019 18:13:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7EF7DABC7; Mon,  5 Aug 2019 20:13:57 +0200 (CEST)
Date:   Mon, 5 Aug 2019 20:13:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: Try our best to delete qgroup relations
Message-ID: <20190805181356.GG28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
References: <20190803064559.9031-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803064559.9031-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 03, 2019 at 02:45:59PM +0800, Qu Wenruo wrote:
> When we try to delete qgroups, we're pretty cautious, we make sure both
> qgroups exist and there is a relationship between them, then try to
> delete the relation.
> 
> This behavior is OK, but the problem is we need to two relation items,
> and if we failed the first item deletion, we error out, leaving the
> other relation item in qgroup tree.
> 
> Sometimes the error from del_qgroup_relation_item() could just be
> -ENOENT, thus we can ignore that error and continue without any problem.
> 
> Further more, such cautious behavior makes qgroup relation deletion
> impossible for orphan relation items.
> 
> This patch will enhance __del_qgroup_relation():
> - If both qgroups and their relation items exist
>   Go the regular deletion routine and update their accounting if needed.
> 
> - If any qgroup or relation item doesn't exist
>   Then we still try to delete the orphan items anyway, but don't trigger
>   the accounting update.
> 
> By this, we try our best to remove relation items, and can handle orphan
> relation items properly, while still keep the existing behavior for good
> qgroup tree.
> 
> Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Adding this to misc-next, please send a fstests testcase, thanks.
