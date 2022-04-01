Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E14EEEF7
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbiDAONn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346725AbiDAONk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 10:13:40 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 360B6220FC9
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 07:11:50 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 4A3B429EAD3; Fri,  1 Apr 2022 10:11:44 -0400 (EDT)
Date:   Fri, 1 Apr 2022 10:11:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Konstantinos Skarlatos <k.skarlatos@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Adding a 4TB disk to a 2x4TB btrfs (data:single) filesystem and
 balancing takes extremely long (over a month). Filesystem has been deduped
 with bees
Message-ID: <YkcIIFuxqj5l17Nu@hungrycats.org>
References: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 01, 2022 at 02:13:58PM +0300, Konstantinos Skarlatos wrote:
> Hello,
> I am running btrfs on 2x 4TB HDDs (data: single, metadata: raid1) and i
> added another 4TB disk.
> According to btrfs wiki i should run balance after adding the new device.
> My problem is that this balance takes extremely long, it is running for 4
> days and it still has 91% left.
> Is this normal, and can i do anything to fix this?
> 
> kernel is linux-5.17.1, i have also tried with 5.16 kernels.
> mount options are: rw,relatime,compress-force=zstd:11,space_cache=v2
> I have been using bees for dedup, but it is disabled for the balance.

Deduplication increases the reflink count and increases relocation time.
Snapshots increase the time as well, but not as directly:  creating the
snapshot doesn't increase balance time, but the snapshot will convert
into reflinks over time as the snapshot diverges from its origin subvol,
and those reflinks do increase relocation time.

2x4TB with single profile works out to about 8000 block groups.
Each block group will take between 1 and 60 minutes on 7200 rpm spinning
drives, mostly dependent on the number of reflinks in the block group
(relocating the data takes only 5-10 seconds, the reflink updates are
the vast majority of the relocation time).

The expected range of balance times will be between 8000 minutes (5.5
days) and 8000 hours (333 days or 48 weeks).

As Hugo pointed out, it's not necessary to balance more than a few
block groups in this situation.  You have to ensure that the amount
of unallocated space on all the disks is large enough to contain one
mirror copy of the metadata.  For most users that means at most 0.5%
unallocated on each disk.  If you've already balanced 9% of the disk
then you've already done 18x more balancing than needed and you can
stop now.

> I am not doing any IO on the disks, they have no smart errors, and none of
> them are SMR (2x WD40EFRX and 1x ST4000DM000)
> Autodefrag is disabled, and i also have checked that the disks are in stable
> drive cages in order to be sure i have no problems with vibration.
> Benchmarking them gives normal speeds. Quotas have never been enabled.
> 
