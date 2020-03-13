Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE78C1847D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 14:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMNRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 09:17:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgCMNRo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 09:17:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61F3BAE87;
        Fri, 13 Mar 2020 13:17:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5CF00DA7A7; Fri, 13 Mar 2020 14:17:17 +0100 (CET)
Date:   Fri, 13 Mar 2020 14:17:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 0/4] Btrfs: make ranged fsyncs always respect the
 given range
Message-ID: <20200313131717.GL12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200309124108.18952-1-fdmanana@kernel.org>
 <20200312203324.GI12659@twin.jikos.cz>
 <CAL3q7H42gkjx83Eqd1sfvtqOcj0k4BjLLr-k-C=mA2COcw1dEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H42gkjx83Eqd1sfvtqOcj0k4BjLLr-k-C=mA2COcw1dEA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 11:01:35AM +0000, Filipe Manana wrote:
> > > Filipe Manana (4):
> > >   Btrfs: fix missing file extent item for hole after ranged fsync
> > >   Btrfs: add helper to get the end offset of a file extent item
> > >   Btrfs: factor out inode items copy loop from btrfs_log_inode()
> > >   Btrfs: make ranged full fsyncs more efficient
> >
> > Moved from for-next to misc-next, thanks.
> 
> Btw, Josef's reviewed-by tag is missing in the changelog of patch 4
> (however there's an unusual reviewed-by tag from you).

I meant to put my rev-by to the cleanup patches, for the 4th patch I'll
update it.
