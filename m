Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777E6192AAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 15:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYOCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 10:02:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbgCYOCE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 10:02:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 26BD5AD55;
        Wed, 25 Mar 2020 14:02:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34D72DA7EB; Wed, 25 Mar 2020 15:01:32 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:01:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Relocation and backref resolution fixes
Message-ID: <20200325140132.GC5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313211709.148967-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313211709.148967-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:17:05PM -0400, Josef Bacik wrote:
> These are standalone fixes that came out of my debugging Zygo's problems.  The
> first two address a problem with how we handle restarting relocation.
> Previously this rarely happened, because if it had people would have complained.
> The restart logic was broken in a few subtle ways, and these two patches address
> those issues.
> 
> The third patch just boggles my mind.  We were recording reloc roots based on
> their current bytenr.  This worked fine if we never restarted, but broke if we
> had to lookup a ref to a reloc root that we found on the tree.  This is because
> that would point at the commit root of the reloc root, but if we had modified
> the reloc root we'd no longer be able to find it.
> 
> And finally the last one was a weird deadlock that Zygo's insane test rig found,
> as he runs the dedup thing while balancing and deleting snapshots, which made
> this thing fall out.  Thanks,

This series is now in misc-next, thanks. 
