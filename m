Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A61DE527
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgEVLOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 07:14:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgEVLOo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 07:14:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9D85AC37;
        Fri, 22 May 2020 11:14:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8540EDA9B7; Fri, 22 May 2020 13:13:47 +0200 (CEST)
Date:   Fri, 22 May 2020 13:13:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: balance root leak and runaway balance fix
Message-ID: <20200522111347.GJ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200520065851.12689-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520065851.12689-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 02:58:49PM +0800, Qu Wenruo wrote:
> This patchset will fix the most wanted balance bug, runaway balance.
> All my fault, and all small fixes.

Well, that happens.

d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")

is the most broken patch in recent history (5.1+), there were so many
fixups but hopefully this is the last one. I've tagged the patches for
5.1+ stable but we'll need manual backports due to the root refcount
changes in 5.7.

I reproduced the umount crash and verified the fix, the runaway balance
does not happen anymore in the test so I guess we have all the needed
fixes in place to allow the fast balance cancel. Thanks.
