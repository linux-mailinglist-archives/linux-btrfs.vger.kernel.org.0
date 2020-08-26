Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F042533EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHZPoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 11:44:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:36096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZPoZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 11:44:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49A60AD63;
        Wed, 26 Aug 2020 15:44:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23967DA730; Wed, 26 Aug 2020 17:43:16 +0200 (CEST)
Date:   Wed, 26 Aug 2020 17:43:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: small compile warning fixes
Message-ID: <20200826154316.GI28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200826004734.89905-1-wqu@suse.com>
 <20200826153112.GH28318@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826153112.GH28318@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 05:31:12PM +0200, David Sterba wrote:
> On Wed, Aug 26, 2020 at 08:47:32AM +0800, Qu Wenruo wrote:
> > Although the global parameter fs_info would affect all repair tests...
> 
> Can you please be more specific?

Ok I see, fsck/013-extent-tree-rebuild test fails.
