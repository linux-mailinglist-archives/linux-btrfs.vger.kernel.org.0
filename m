Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694EC18D93F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 21:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCTU16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 16:27:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:48566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgCTU16 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 16:27:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D4EFAEF1;
        Fri, 20 Mar 2020 20:27:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C1DADA70E; Fri, 20 Mar 2020 21:27:28 +0100 (CET)
Date:   Fri, 20 Mar 2020 21:27:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix removal of raid[56|1c34} incompat flags after
 removing block group
Message-ID: <20200320202728.GI12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200320184348.845248-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320184348.845248-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 20, 2020 at 06:43:48PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are incorrectly dropping the raid56 and raid1c34 incompat flags when
> there are still raid56 and raid1c34 block groups, not when we do not any
> of those anymore. The logic just got unintentionally broken after adding
> the support for the raid1c34 modes.
> 
> Fix this by clear the flags only if we do not have block groups with the
> respective profiles.
> 
> Fixes: 9c907446dce3 ("btrfs: drop incompat bit for raid1c34 after last block group is gone")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, that was a stupid mistake. As it's a regression fix, I'll send
as an rc fix.
