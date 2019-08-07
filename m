Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4089E851CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHGRMU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 13:12:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729804AbfHGRMU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 13:12:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B80C9AE1B;
        Wed,  7 Aug 2019 17:12:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FEE3DA8F5; Wed,  7 Aug 2019 19:12:51 +0200 (CEST)
Date:   Wed, 7 Aug 2019 19:12:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Re: [PATCH v2] btrfs: qgroup: Try our best to delete qgroup relations
Message-ID: <20190807171251.GY28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Andrei Borzenkov <arvidjaar@gmail.com>
References: <20190806140507.5204-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806140507.5204-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 10:05:07PM +0800, Qu Wenruo wrote:
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
> ---
> changelog:
> v2:
> - Fix a condition for checking either @parent or @member is not found

Patch replaced in misc-next, thanks.
