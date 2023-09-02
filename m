Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F58790550
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbjIBFqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Sep 2023 01:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjIBFqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Sep 2023 01:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79A92;
        Fri,  1 Sep 2023 22:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AE9A6147D;
        Sat,  2 Sep 2023 05:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3864CC433C7;
        Sat,  2 Sep 2023 05:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693633606;
        bh=rOXhxrATnSe7ZTqNJF5H0XKIr0bGzM4Yx5pwgKkbdvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToqcA9FQKfKtvQFf2GeE153kMZrqSHxNzbBZURXzUvEq0mM0yRTlixlS1GUTvfdFV
         sV/4sSbAayRKKuKXrw6GfEIAYEpGxIAzh65jNvcFFcOqkHetbEYP3DVPqtZYVGclMx
         ppbkry8H10JrS64KIECG9b8quKFwZ/vKjdtKC+0lEFbc+ViVxg1nrFW0FpsH31b4XF
         CC3CNqc/xpdqiiWMJzrTsg8hBYVMHHyvj7vGqFiJ6miCbJ9sAkCSrW2pNCNv6UCPr9
         IsdB4LP4VSVFVIlBqD/mWFRVLB/VRlRD7u9hgLBKWhgzp8VXnrMx0v5WFW6gbbFeSs
         jrBRHCai7CsBg==
Date:   Sat, 2 Sep 2023 13:46:39 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Message-ID: <20230902054639.vpkrlnxqytjcwisy@zlang-mailbox>
References: <20230824234714.GA17900@frogsfrogsfrogs>
 <20230901193609.yy7isx4pv6ax4g2k@zlang-mailbox>
 <f7925e65-5d8a-43b4-962c-07e1050abaad@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7925e65-5d8a-43b4-962c-07e1050abaad@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 02, 2023 at 08:40:17AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/2 03:36, Zorro Lang wrote:
> > On Thu, Aug 24, 2023 at 04:47:14PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > I run fstests in a readonly container, and accidentally uninstalled the
> > > btrfsprogs package.  When I did, this test started faililng:
> > > 
> > > --- btrfs/282.out
> > > +++ btrfs/282.out.bad
> > 
> > I can't merge this patch, it fails:
> > 
> >    Applying: btrfs/282: skip test if /var/lib/btrfs isnt writable
> >    error: 282.out: does not exist in index
> >    Patch failed at 0001 btrfs/282: skip test if /var/lib/btrfs isnt writable
> >    ...
> > 
> > How can you generate this patch with btrfs/282.out.bad?
> 
> It's the diff format in the commit message confusing "git am".
> 
> You can add extra space(s) in the commit message so that "git am" can
> understand what's going on.

Ahaha, I just noticed that it's commit log, I thought it's a part of
the source code :-D

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Zorro
> > 
> > > @@ -1,3 +1,7 @@
> > >   QA output created by 282
> > >   wrote 2147483648/2147483648 bytes at offset 0
> > >   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> > > +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> > > +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: Read-only file system. Status recording disabled
> > > +WARNING: failed to open the progress status socket at /var/lib/btrfs/scrub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or directory. Progress cannot be queried
> > > 
> > > Skip the test if /var/lib/btrfs isn't writable, or if /var/lib isn't
> > > writable, which means we cannot create /var/lib/btrfs.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >   tests/btrfs/282 |    7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/tests/btrfs/282 b/tests/btrfs/282
> > > index 980262dcab..395e0626da 100755
> > > --- a/tests/btrfs/282
> > > +++ b/tests/btrfs/282
> > > @@ -19,6 +19,13 @@ _wants_kernel_commit eb3b50536642 \
> > >   # We want at least 5G for the scratch device.
> > >   _require_scratch_size $(( 5 * 1024 * 1024))
> > > 
> > > +# Make sure we can create scrub progress data file
> > > +if [ -e /var/lib/btrfs ]; then
> > > +	test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
> > > +else
> > > +	test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
> > > +fi
> > > +
> > >   _scratch_mkfs >> $seqres.full 2>&1
> > >   _scratch_mount
> > > 
> > > 
> > 
> 
