Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9D148646
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 14:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbgAXNlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 08:41:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387743AbgAXNlN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 08:41:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FCF6AF10;
        Fri, 24 Jan 2020 13:41:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4226DA730; Fri, 24 Jan 2020 14:40:55 +0100 (CET)
Date:   Fri, 24 Jan 2020 14:40:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Message-ID: <20200124134055.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200123235820.20764-1-wqu@suse.com>
 <CAL3q7H5FRdvnxG4KQhLTaaHFcP_bMUQsOxoJxfQwi8L8npGxDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5FRdvnxG4KQhLTaaHFcP_bMUQsOxoJxfQwi8L8npGxDA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:24:50AM +0000, Filipe Manana wrote:
> On Fri, Jan 24, 2020 at 12:07 AM Qu Wenruo <wqu@suse.com> wrote:
> > Reported-by: Filipe Manana <fdmanana@suse.com>
> > Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
> > Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking a block group RO")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Now it looks good, thanks!

Thank you both, patch on the way to 5.5-rc8 or 5.6 final.
