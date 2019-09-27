Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2367BC0181
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfI0Iw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 04:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:40560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfI0Iw1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 04:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0231AE65;
        Fri, 27 Sep 2019 08:52:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B943DA897; Fri, 27 Sep 2019 10:52:45 +0200 (CEST)
Date:   Fri, 27 Sep 2019 10:52:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu WenRuo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2.1] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
Message-ID: <20190927085245.GT2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190822021415.9425-1-wqu@suse.com>
 <dbd46651-de06-ed81-29b2-ea547b77269e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd46651-de06-ed81-29b2-ea547b77269e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 07:28:23AM +0000, Qu WenRuo wrote:
> I see you have pushed the patch to mainline.
> 
> However I still remember you have hit several false alerts even with
> this version.
> Did you still see such false alerts anymore?

I have to check again. I know you sent an updated version, we might need
an incremental fix. The original version was kept due to close time to
merge window. Thanks.
