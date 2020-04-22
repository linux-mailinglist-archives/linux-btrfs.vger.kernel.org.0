Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EBB1B4EB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDVU6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 16:58:53 -0400
Received: from mail.nic.cz ([217.31.204.67]:44294 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDVU6x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 16:58:53 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id C9D77141340;
        Wed, 22 Apr 2020 22:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587589131; bh=MN4GWXXz4E4pVN26b+k1w//LVANaZmtqXZ2CNJo8Mm0=;
        h=Date:From:To;
        b=u1M+XbYt1Qm3ghxteyVMmlxoif5ETnctW0rMpQeIaalUEyn2JKxKAaoeOFqOfaZRu
         H9CSw/fXEZgROCBjLZsH3QHqb3XpBqquCcPCZIJBjR9nTEbg/+RerJQRCkb9NjQS5j
         G4hol4cg+uaF8jute2lwvh8T5wzw06stjMIJaIsA=
Date:   Wed, 22 Apr 2020 22:58:51 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: when does btrfs create sparse extents?
Message-ID: <20200422225851.3d031d88@nic.cz>
In-Reply-To: <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
References: <20200422205209.0e2efd53@nic.cz>
        <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
        <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 22 Apr 2020 14:44:46 -0600
Chris Murphy <lists@colorremedies.com> wrote:

> e.g. from a 10m file created with truncate on two Btrfs file systems
> 
> original holes format (default)
> 
>     item 6 key (257 EXTENT_DATA 0) itemoff 15768 itemsize 53
>         generation 7412 type 1 (regular)
>         extent data disk byte 0 nr 0
>         extent data offset 0 nr 10485760 ram 10485760
>         extent compression 0 (none)
> 
> On a file system with no-holes feature set, this item simply doesn't
> exist. I think basically it works by inference. Both kinds of files
> have size in the INODE_ITEM, e.g.
> 
>     item 4 key (257 INODE_ITEM 0) itemoff 32245 itemsize 160
>         generation 889509 transid 889509 size 10485760 nbytes 0
> 
> Sparse extents are explicitly stated in the original format with disk
> byte 0 in an EXTENT_DATA item; whereas in the newer format, sparse
> extents exist whenever EXTENT_DATA items don't completely describe the
> file's size.

Ok this means that U-Boot currently gained support for the original
sparse extents.

I fear that current u-boot does not handle the new no-holes feature.
