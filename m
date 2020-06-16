Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12AE1FC1D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 00:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFPWsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 18:48:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPWsx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 18:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFEBAADCA;
        Tue, 16 Jun 2020 22:48:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F46EDA7C3; Wed, 17 Jun 2020 00:48:41 +0200 (CEST)
Date:   Wed, 17 Jun 2020 00:48:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH 4/4] btrfs: free anon_dev earlier to prevent exhausting
 anonymous block device pool
Message-ID: <20200616224840.GI27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-5-wqu@suse.com>
 <605ee3c8-0afa-5c00-9c66-fa385c20ce99@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605ee3c8-0afa-5c00-9c66-fa385c20ce99@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 03:23:03PM -0400, Josef Bacik wrote:
> > By freeing it earlier we reclaim the anon_dev quicker, hopefully to
> > reduce the chance of exhausting the pool.
> 
> Why isn't this happening as part of the root teardown once all the references to 
> it are gone?  Thanks,

This is where it happens now and is correct. The problem is that deleted
subvolumes keep the id allocated until they are cleaned up, ie. all the
dead roots consume the id though we don't need it anymore. Creating and
deleting snapshots at large will produce a long list of dead subvolumes.
THis patch will return the ids at the earlies possible moment so they
can get reused.
