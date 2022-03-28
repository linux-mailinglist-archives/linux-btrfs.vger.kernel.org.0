Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE34E9890
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiC1NrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbiC1NrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85184D612
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E300161195
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 13:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA5C340F3;
        Mon, 28 Mar 2022 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648475122;
        bh=jY1Kd0/ZNcN1qkxxaL6SMzUn7DlRxHcj7MjOQto18JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b062a7zxuDzxw+1bWi/A+wbk/nsFS7PHt0sYRQdOw9aizm+bua408Gq+JYwtEHY8h
         +gQNoK5nbJQIyAMBBwynqBlbYD/852utokWyzocT8HB0J/ORC83U4rjfky3CSElPCb
         yGPeoYxe3rED/kWmmQsYVtgveKRPApoEz3CH6kd6wp2tMccjBfdb8IjgPRJKB7EVVq
         jiZjK86e7I8cs4RPuMclg3ouVjmAYj3RhHTBckhXgB7ztjGTKJq+AGvCOSO7u4YDYA
         iW3sKeHi/2Zlp5aXE6WZnaZ8B30Xtbw0qWJe3Rql8AQK24IZzMYkgTntNdOk34KF7y
         DKVsNOIuXsClA==
Date:   Mon, 28 Mar 2022 14:45:19 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Message-ID: <YkG775DW5ip1gktJ@debian9.Home>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
 <YkGzTsQtFNI9s7Ji@debian9.Home>
 <PH0PR04MB7416B28BD43CE79E2D6A75349B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YkG2WL4Fa096+6xt@debian9.Home>
 <20220328133635.saheqkncmgmh2xn2@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328133635.saheqkncmgmh2xn2@naota-xeon>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 01:36:36PM +0000, Naohiro Aota wrote:
> On Mon, Mar 28, 2022 at 02:21:28PM +0100, Filipe Manana wrote:
> > On Mon, Mar 28, 2022 at 01:14:02PM +0000, Johannes Thumshirn wrote:
> > > On 28/03/2022 15:09, Filipe Manana wrote:
> > > > On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:
> > > >> Running generic/406 causes the following WARNING in btrfs_destroy_inode()
> > > >> which tells there is outstanding extents left.
> > > > 
> > > > I can't trigger the warning with generic/406.
> > > > Any special setup or config to trigger it?
> > > > 
> > > > The change looks fine to me, however I'm curious why this isn't triggered
> > > > with generic/406, nor anyone else reported it before, since the test is
> > > > fully deterministic.
> > > > 
> > > 
> > > I am able to trigger the WARN() with a different test (which is for a different,
> > > not yet solved problem) on my zoned setup. With this patch, the WARN() is gone.
> > 
> > I have no doubts about the fix being correct.
> > I'm just puzzled why I can't trigger it with generic/406, given that it's a very
> > deterministic test.
> >
> > If there's any special config or setup (mount options, zoned fs, etc), I would
> > like to have it explicitly mentioned in the changelog.
> 
> I don't think it's super special. I can always reproduce it on 1GB
> zram device. Here is the mkfs setup, and no mount options are
> specified.

Ok, that, the 1G device, explains it.

It's trigfering a short-write, due to not being able to allocate a large extent and
instead allocating a smaller one. And the test does not fail if we write less than
what we requested, as it redirects xfs_io's stdout to the .full file and does not
check that we wrote the exact amount we asked to write (which is a rather bad test
IMO, should also check we are able to read what we wrote before, etc).

The change looks good to me.

With an updated subject, you can add:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> 
> ++ mkfs.btrfs -f -d single -m single /dev/zram0
> btrfs-progs v5.16.2
> See http://btrfs.wiki.kernel.org for more information.
> 
> Performing full device TRIM /dev/zram0 (1.00GiB) ...
> NOTE: several default settings have changed in version 5.15, please make sure
>       this does not affect your deployments:
>       - DUP for metadata (-m dup)
>       - enabled no-holes (-O no-holes)
>       - enabled free-space-tree (-R free-space-tree)
> 
> Label:              (null)
> UUID:               b7260fb1-fa0e-4acd-8c3d-0530799a9fd3
> Node size:          16384
> Sector size:        4096
> Filesystem size:    1.00GiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         single            8.00MiB
>   System:           single            4.00MiB
> SSD detected:       yes
> Zoned device:       no
> Incompat features:  extref, skinny-metadata, no-holes
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1     1.00GiB  /dev/zram0
