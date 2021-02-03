Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5630DA26
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhBCMt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 07:49:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:41244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhBCMrG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 07:47:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCCF6AD26;
        Wed,  3 Feb 2021 12:46:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66205DA6FC; Wed,  3 Feb 2021 13:44:34 +0100 (CET)
Date:   Wed, 3 Feb 2021 13:44:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5.1 17/62] btrfs: integrate page status update for data
 read path into begin/end_page_read()
Message-ID: <20210203124434.GB1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210202022836.290783-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202022836.290783-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 02, 2021 at 10:28:36AM +0800, Qu Wenruo wrote:
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> Changelog:
> v5.1:
> - Modify the error paths before calling begin_page_read()
>   The error path needs to unlock the page manually.
> 
> To David,
> 
> The modification to both error paths would be more sutiable as a
> separate patch.
> As they look like existing bugs.

For a separate fix that would go to stable it would have to be
independent on the subpage series which sounds like a lot of work, and
we're out of time for 5.12. If the fix really needs to land in old
stable trees then it's possible to extract that from this patch and send
as a standalone patch that does not exactly match the upstream one.
As an exception it works, we've done that in the past.
