Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C710B267
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK0P02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 10:26:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:37594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfK0P02 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 10:26:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B882AEEC;
        Wed, 27 Nov 2019 15:26:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FF9BDA733; Wed, 27 Nov 2019 16:26:24 +0100 (CET)
Date:   Wed, 27 Nov 2019 16:26:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] btrfs: reset device back to allocation state when
 removing
Message-ID: <20191127152624.GS2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191126084006.23262-1-jthumshirn@suse.de>
 <20191126084006.23262-3-jthumshirn@suse.de>
 <20191126171703.GO2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126171703.GO2734@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 06:17:03PM +0100, David Sterba wrote:
> > +	/* Verify the device is back in a pristine state  */
> > +	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
> > +	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
> > +	ASSERT(list_empty(&device->dev_alloc_list));
> > +	ASSERT(list_empty(&device->post_commit_list));
> > +	ASSERT(atomic_read(&device->reada_in_flight) == 0);
> > +	ASSERT(atomic_read(&device->dev_stats_ccnt) == 0);
> > +	ASSERT(RB_EMPTY_ROOT(&device->alloc_state.state));
> 
> I went through members of the device struct, lots of them are set once
> so don't change. last_flush_error is set and read during commit,
> 
> Besides the dev_state bits handled above, I think tre rest should be
> here too, ie.  BTRFS_DEV_STATE_IN_FS_METADATA and
> BTRFS_DEV_STATE_MISSING (though this might be ok to keep as-is).

So BTRFS_DEV_STATE_MISSING should stay, the state is changed through the
scanning.

BTRFS_DEV_STATE_IN_FS_METADATA should be asserted for 'not-set', this is
normally set_bit at mount time so the last use of devices with the bit
set should set it back to zero.
