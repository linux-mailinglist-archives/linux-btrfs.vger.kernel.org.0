Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F1618D0B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEIPef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 11:34:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbfEIPef (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 11:34:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4AEDAB6D;
        Thu,  9 May 2019 15:34:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F54FDA8DC; Thu,  9 May 2019 17:35:31 +0200 (CEST)
Date:   Thu, 9 May 2019 17:35:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: Always use a cached extent_state in
 btrfs_lock_and_flush_ordered_range
Message-ID: <20190509153531.GW20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190507071924.17643-1-nborisov@suse.com>
 <20190507071924.17643-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507071924.17643-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 10:19:24AM +0300, Nikolay Borisov wrote:
> In case no cached_state argument is passed to
> btrfs_lock_and_flush_ordered_range use one locally in the function. This
> optimises the case when an ordered extent is found since the unlock
> function will be able to unlock that state directly without searching
> for it again.

This will speed up all callers that previously did not cache the state,
right? That can improve bring some improvement, I wonder if the caching
can be used in more places, there are still many plain lock_extent
calls.

check_can_nocow calls unlock_extent from 2 locations, so passing the
cached pointer could help in case the ordered is found and thus unlock
happens outside of btrfs_lock_and_flush_ordered_range. Elsewhere it's
only the locking part so the cache would have to be passed along, but
this might not make sense in all cases. Anyway, that's for another
patch.
