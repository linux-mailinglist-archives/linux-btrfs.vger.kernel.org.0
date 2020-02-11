Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1AFA1598F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgBKSpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:45:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:42400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgBKSpN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:45:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77ADCAD57;
        Tue, 11 Feb 2020 18:45:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F4FDDA781; Tue, 11 Feb 2020 18:59:04 +0100 (CET)
Date:   Tue, 11 Feb 2020 18:59:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] Fix memory leak on failed cache-writes
Message-ID: <20200211175903.GC2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 12:10:18AM +0900, Johannes Thumshirn wrote:
> Fstests' test case generic/475 reliably leaks the btrfs_io_ctl::pages
> allocated in __btrfs_write_out_cache().
> 
> The first four patches are small things I noticed while hunting down the
> problem and are independant of the last patch in this series freeing the pages
> when we throw away a dirty block group.

Thanks, just a note about the patch ordering: the fix 5/5 should go
first so it applies cleanly without the unrelated cleanups. As it's a
leak fix it'll go to some rc and then to stable.
