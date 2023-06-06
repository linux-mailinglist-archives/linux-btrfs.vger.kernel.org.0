Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8407250CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 01:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbjFFX2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 19:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbjFFX2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 19:28:11 -0400
X-Greylist: delayed 469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 16:28:10 PDT
Received: from npcomp.net (unknown [209.195.0.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198DC170A
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 16:28:10 -0700 (PDT)
Received: by npcomp.net (Postfix, from userid 1000)
        id 6CB4E22707; Tue,  6 Jun 2023 23:20:20 +0000 ()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
        s=eldondev; t=1686093620;
        bh=FNeXhNvN5NDVO50+8Q9+La5FVv3F5dKYy9EFGtBLZe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dBun4DF9I8ecgY6+514B1OhYZKan/RdigBCRzt1j2Txsvag3BJyQzv493f6VunYyT
         l1Mfyhl+7ig0WcPz/iLcAaql9b7PoupNIk9+cj5qwdnqfNpte8cz5kjpaSYsp8ShHl
         GCrtHiZ78c7AkaT9wfcjH0B87zl0DE9jWgo5I8no=
Date:   Tue, 6 Jun 2023 23:20:20 +0000
From:   Eldon <btrfs@eldondev.com>
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: rollback to a snapshot
Message-ID: <ZH+/NKVEk7Lc31mr@invalid>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 08:58:03PM +0000, Bernd Lentes wrote:
> Hi guys,
> 
> thanks for your help.
> 
> I have an Ubuntu box which I wanted to upgrade. Fortunately I made a snapshot before.
> The upgrade ran only partially and now I want to go back to my snapshot.
> I booted the system now with a recuse cd.
> This is my setup:
> 
> root@Microknoppix:/home/knoppix# mount|grep btrfs
> /dev/mapper/ubuntu--vg-ubuntu--lv on /mnt/btrfs type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)
> 
> root@Microknoppix:/home/knoppix# btrfs sub list /mnt/btrfs
> ID 430 gen 1215864 top level 5 path .snapshots
> ID 434 gen 1213568 top level 430 path .snapshots/06-06-2023--15:16_PRE_UPGRADE
> ID 435 gen 1216086 top level 430 path .snapshots/06-06-2023
> I want to go back to ID 434 or 435.

Hi Bernd,
I would generally agree that changing the default subvolume is the best
strategy to get the desired result. I would create a new writable
subvolume from the snapshot you want to use, in a reasonable place to
put it. I use my own idiosyncratic paths, but you can use whatever you
want. I would use a destination outside of the .snapshots directory,
maybe something like .live .
Then, do the btrfs subvolume set-default to that subvolume.

That's how I usually do my rollbacks, hope it helps with your situation.

Cheers,
Eldon
