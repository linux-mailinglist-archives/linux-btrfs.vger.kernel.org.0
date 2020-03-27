Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF40195A4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 16:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgC0PwQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 11:52:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgC0PwQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 11:52:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 74232ACE3;
        Fri, 27 Mar 2020 15:52:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87522DA72D; Fri, 27 Mar 2020 16:51:43 +0100 (CET)
Date:   Fri, 27 Mar 2020 16:51:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/39] btrfs: qgroup: Use backref cache based backref
 walk for commit roots
Message-ID: <20200327155143.GO5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 04:32:37PM +0800, Qu Wenruo wrote:
> This patchset is based on misc-5.7 branch.
> 
> The branch can be fetched from github for review/testing.
> https://github.com/adam900710/linux/tree/backref_cache_all
> 
> The patchset survives all the existing qgroup/volume/replace/balance tests.

Thanks for the rebase, the whole patchset passed fstests so I'll start
merging it. The backref cache (patches 33-39) still need review but
because the tests pass it can be in for-next. The cleanup part 1-32
seems safe so that'll go to misc-next soonish, once I go through the
patches, there are some minor style issues.
