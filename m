Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05BB25789F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHaLqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgHaLqQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:46:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFD9EAC4A;
        Mon, 31 Aug 2020 11:46:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1C0BDA840; Mon, 31 Aug 2020 13:45:03 +0200 (CEST)
Date:   Mon, 31 Aug 2020 13:45:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eryu Guan <guan@eryu.me>
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] fstests: btrfs/218 check if mount opts are applied
Message-ID: <20200831114503.GU28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eryu Guan <guan@eryu.me>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200804205648.11284-1-marcos@mpdesouza.com>
 <20200830161519.GC3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830161519.GC3853@desktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 31, 2020 at 12:15:19AM +0800, Eryu Guan wrote:
> On Tue, Aug 04, 2020 at 05:56:48PM -0300, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > This new test will apply different mount points and check if they were applied
> > by reading /proc/self/mounts. Almost all available btrfs options are tested
> > here, leaving only device=, which is tested in btrfs/125 and space_cache, tested
> > in btrfs/131.
> > 
> > This test does not apply any workload after the fs is mounted, just checks is
> > the option was set/unset correctly.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> I'm seeing this diff when testing with v5.9-rc2 kernel and v5.4
> btrfs-progs, is that expected?
> 
>     +Could not find 'relatime,compress=lzo,space_cache,subvolid' in 'rw,relatime,compress=lzo:3,space_cache,subvolid=5,subvol=/', using 'compress=lzo'
>     +Could not find 'relatime,compress=lzo,space_cache,subvolid' in 'rw,relatime,compress=lzo:3,space_cache,subvolid=5,subvol=/', using 'compress=lzo'
>     +Could not find 'relatime,compress-force=lzo,space_cache,subvolid' in 'rw,relatime,compress-force=lzo:4,space_cache,subvolid=5,subvol=/', using 'compress-force=lzo'
>     +Could not find 'relatime,compress-force=lzo,space_cache,subvolid' in 'rw,relatime,compress-force=lzo:4,space_cache,subvolid=5,subvol=/', using 'compress-force=lzo'
>      Silence is golden

This should be fixed by 282dd7d77184 ("btrfs: reset compression level
for lzo on remount") that is in v5.9-rc3.
