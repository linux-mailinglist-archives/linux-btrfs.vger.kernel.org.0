Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B737A9752
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIURWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjIURWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EA44F58
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:13:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEF8C4E660;
        Thu, 21 Sep 2023 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695303200;
        bh=mCuXRDN/Fl0nhpc3xAYyMwnxfQqvzEbCut3DXdqKvis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JtzfFVQ/6rS10ThlmwXXMIOvjPjOkd9Ig0qS1qm8O+bB1Xlje9ZpkZNM8yEUYA0PD
         6QRHATMcVEKNoug1vGYOAQriOIyFM8kXte1C10yO57ZkyzkCfS2syMM1F3qRpgSfIE
         BPblse9oSPafvjdv4uZnBa4L6Rgfn1+3X7Drd8WP56I3W4uZYsZDGEmSe5s/+ak89p
         cB9NM1dsAc1ZkqZQQBFCNOYfAXZ7hba91+kYIG9aGp0zmVlkPqnmZObAwViMJS+a6a
         Bqu4nco9lDAc2Kd0D3KV/7P/OETq2pBLfFBTalVE2bUUHZB/5hJRFDWFpzq1S3Xp+n
         NvwImabNBfLtA==
Date:   Thu, 21 Sep 2023 15:33:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230921-blumig-aneinander-c0298538fe40@brauner>
References: <20230921121945.4701-1-jack@suse.cz>
 <20230921-wettrennen-warfen-1067d17aef27@brauner>
 <20230921130729.rmxq43efbod4gd3a@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230921130729.rmxq43efbod4gd3a@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 03:07:29PM +0200, Jan Kara wrote:
> On Thu 21-09-23 14:50:07, Christian Brauner wrote:
> > On Thu, Sep 21, 2023 at 02:19:45PM +0200, Jan Kara wrote:
> > > From: Christoph Hellwig <hch@lst.de>
> > > 
> > > The file system type is not a very useful holder as it doesn't allow us
> > > to go back to the actual file system instance.  Pass the super_block
> > > instead which is useful when passed back to the file system driver.
> > > 
> > > This matches what is done for all other block device based file systems and it
> > > also fixes an issue that block device freezing (as used e.g. by LVM when
> > > performing device snapshots) starts working for btrfs.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > > Message-Id: <20230811100828.1897174-7-hch@lst.de>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/btrfs/super.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > 
> > > Hello,
> > > 
> > > I'm resending this btrfs fix. Can you please merge it David? It's the only bit
> > > remaining from the original Christoph's block device opening patches and is
> > > blocking me in pushing out the opening of block devices using bdev_handle.
> > > Thanks!
> > 
> > Thanks for resending.
> > 
> > Next time we will ensure that a vfs triggered conversion must go through
> > a vfs tree as this half converted state with forgotten patches is not
> > something that we should repeat.
> 
> Yeah, I agree it would be good to find a smoother way to handle such
> merges. I understand David's desire to give changes proper testing which
> generally doesn't happen in linux-next but on maintainer's own branches and
> infrastructure but perhaps some stable branch in VFS tree that filesystem
> maintainers could pull when putting together the branch they push out to
> the testing infrastructure would work?

Yes, I'm very happy to provide this. Also worth nothing that everything
that goes through vfs.git sees xfstests for all affected filesystems.

Ideally we'll automate this directly on that repo at some point for all
official branches.

Right now I personally have:

https://github.com/brauner/mkosi-kernel

which uses mkosi to build a GPT image fully unprivileged with an:

ESP partition
root partition (of chosen format)
2-4 testing partitions

for any distro I need with any kernel config I want:

mkosi -d debian -t disk -f

During boot it generates a bunch of unprivileged users via
systemd-userdb drop-ins placed in /etc/userdb/ during build:
https://github.com/brauner/mkosi-kernel/tree/main/mkosi.extra/etc/userdb
creating testing users (user1, fsgqa, fgqa2, 123456-fsgqa) for xfstests.

Then I just fire the relevant tests using incus (formerly LXD). All
branches get the same treatment usually for ext4, xfs, btrfs via
-g quick (btrfs gets multiple devices - that's why there's 4 partitions).
