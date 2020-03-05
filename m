Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9617A741
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 15:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCEOUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 09:20:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:52980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgCEOUY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 09:20:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94657B33F;
        Thu,  5 Mar 2020 14:20:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91B65DA703; Thu,  5 Mar 2020 15:19:59 +0100 (CET)
Date:   Thu, 5 Mar 2020 15:19:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3 3/3] Btrfs: implement full reflink support for inline
 extents
Message-ID: <20200305141959.GC2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200224171327.3655282-1-fdmanana@kernel.org>
 <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
 <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 05, 2020 at 11:57:52AM +0000, Filipe Manana wrote:
> So this actually isn't safe.
> 
> It can bring back the race that leads to file extent items with
> overlapping ranges. Not because of the hole detection part but because
> of the part where we copy extent items from the fs/subvolume tree into
> the log tree using btrfs_search_forward(), as we copy all extent
> items, including the ones outside the fsync range - so we could race
> in the same way as we did during hole detection with ordered extent
> completion for ordered extents outside the range.
> 
> I'll have to rework this a bit.

Ok, I'll remove the branch from for-next. Thanks.
