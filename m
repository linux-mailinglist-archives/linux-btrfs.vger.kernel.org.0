Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC725B020
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgIBPvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:51:23 -0400
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:47387 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIBPvU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:51:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1132874|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0700758-0.000428012-0.929496;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.IRrhU6._1599061862;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IRrhU6._1599061862)
          by smtp.aliyun-inc.com(10.147.41.231);
          Wed, 02 Sep 2020 23:51:02 +0800
Date:   Wed, 2 Sep 2020 23:50:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     dsterba@suse.cz, Marcos Paulo de Souza <marcos@mpdesouza.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] fstests: btrfs/218 check if mount opts are applied
Message-ID: <20200902155057.GG3853@desktop>
References: <20200804205648.11284-1-marcos@mpdesouza.com>
 <20200830161519.GC3853@desktop>
 <20200831114503.GU28318@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831114503.GU28318@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 31, 2020 at 01:45:03PM +0200, David Sterba wrote:
> On Mon, Aug 31, 2020 at 12:15:19AM +0800, Eryu Guan wrote:
> > On Tue, Aug 04, 2020 at 05:56:48PM -0300, Marcos Paulo de Souza wrote:
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > 
> > > This new test will apply different mount points and check if they were applied
> > > by reading /proc/self/mounts. Almost all available btrfs options are tested
> > > here, leaving only device=, which is tested in btrfs/125 and space_cache, tested
> > > in btrfs/131.
> > > 
> > > This test does not apply any workload after the fs is mounted, just checks is
> > > the option was set/unset correctly.
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > I'm seeing this diff when testing with v5.9-rc2 kernel and v5.4
> > btrfs-progs, is that expected?
> > 
> >     +Could not find 'relatime,compress=lzo,space_cache,subvolid' in 'rw,relatime,compress=lzo:3,space_cache,subvolid=5,subvol=/', using 'compress=lzo'
> >     +Could not find 'relatime,compress=lzo,space_cache,subvolid' in 'rw,relatime,compress=lzo:3,space_cache,subvolid=5,subvol=/', using 'compress=lzo'
> >     +Could not find 'relatime,compress-force=lzo,space_cache,subvolid' in 'rw,relatime,compress-force=lzo:4,space_cache,subvolid=5,subvol=/', using 'compress-force=lzo'
> >     +Could not find 'relatime,compress-force=lzo,space_cache,subvolid' in 'rw,relatime,compress-force=lzo:4,space_cache,subvolid=5,subvol=/', using 'compress-force=lzo'
> >      Silence is golden
> 
> This should be fixed by 282dd7d77184 ("btrfs: reset compression level
> for lzo on remount") that is in v5.9-rc3.

Great!

Marcos, would you please refresh the patch to include the kernel fix in
commit log? Thanks!

Eryu
