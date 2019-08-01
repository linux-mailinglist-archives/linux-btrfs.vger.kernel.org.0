Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5277DC19
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfHANDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 09:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfHANDN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 09:03:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AF34ACFE
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 13:03:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66D4BDA7D9; Thu,  1 Aug 2019 15:03:43 +0200 (CEST)
Date:   Thu, 1 Aug 2019 15:03:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove unnecessary check from
 join_running_log_trans
Message-ID: <20190801130343.GS28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190523115126.10532-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523115126.10532-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 23, 2019 at 02:51:26PM +0300, Nikolay Borisov wrote:
> join_running_log_trans checks btrfs_root::log_root outside of
> btrfs_root::log_mutex to avoid contention on the mutex. Turns out this
> check is not necessary because the two callers of join_running_log_trans
> (both of which deal with removing entries from the tree-log during
> unlink) explicitly check whether the respective inode has been logged in
> the current transaction. If it hasn't then it won't have any items in
> the tree-log and call path will return before calling
> join_running_log_trans. If the check passes, however, then it's
> guaranteed that btrfs_root::log_root is set because the inode is logged.
> 
> Those guarantees allows us to remove the speculative as well as the
> implicity and tricky memory barrier. No functionl changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---

Added to misc-next, thanks.
