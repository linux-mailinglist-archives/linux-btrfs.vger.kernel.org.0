Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582312871A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgJHJf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 05:35:56 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:48326 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJHJf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 05:35:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id C2240348C302;
        Thu,  8 Oct 2020 11:35:54 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S_XVuyPSfI04; Thu,  8 Oct 2020 11:35:52 +0200 (CEST)
Received: from latitude (geri.datenkhaos.de [81.7.17.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Thu,  8 Oct 2020 11:35:52 +0200 (CEST)
Date:   Thu, 8 Oct 2020 11:35:46 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: failed to read block groups: Operation not permitted
Message-ID: <20201008093546.GA388958@latitude>
References: <20201006090918.GA269054@latitude>
 <9cd7f2d0-4256-7311-483e-b1169e4c3655@gmx.com>
 <20201008092409.GB387879@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008092409.GB387879@latitude>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020 Okt 08, Johannes Hirte wrote:
> On 2020 Okt 06, Qu Wenruo wrote:
> > 
> > 
> > On 2020/10/6 下午5:09, Johannes Hirte wrote:
> > > I recently encountered filesystem damage on a VM. During normal
> > > operation, the filesystem was remounted ro suddenly. Dmesg showed me
> > > some errors about parent transid verify failed. I've forced of the VM
> > > and tried to mount the image on the host, but failed with:
> > > 
> > > [  340.702391] BTRFS info (device loop0p1): disk space caching is enabled
> > > [  340.702393] BTRFS info (device loop0p1): has skinny extents
> > > [  341.815890] BTRFS error (device loop0p1): parent transid verify failed on 152064327680 wanted 323984 found 323888
> > > [  341.831183] BTRFS error (device loop0p1): parent transid verify failed on 152064327680 wanted 323984 found 323888
> > 
> > Your extent tree is corrupted. Metadata CoW is broken.
> > 
> > I don't believe only extent tree get corrupted, other part of your fs
> > can also be corrupted.
> > 
> > > [  341.831194] BTRFS error (device loop0p1): failed to read block groups: -5
> > > [  341.851954] BTRFS error (device loop0p1): open_ctree failed
> > > 
> > > A btrfs check resulted in:
> > > 
> > > btrfs check /dev/loop0p1
> > > Opening filesystem to check...
> > > parent transid verify failed on 152064327680 wanted 323984 found 323888
> > > parent transid verify failed on 152064327680 wanted 323984 found 323888
> > > parent transid verify failed on 152064327680 wanted 323984 found 323888
> > > Ignoring transid failure
> > > leaf parent key incorrect 152064327680
> > > ERROR: failed to read block groups: Operation not permitted
> > > ERROR: cannot open file system
> > > 
> > > The host is running libvirt with kvm, btrfs with RAID1. The VMs are raw
> > > images, with btrfs too. I've switche this VM from io=native to
> > > io=io_uring, and suspect that this caused the damage. All machines are
> > > running kernel 5.8.13.
> > 
> > I'm not sure about the io_uring setup. IIRC as long as you're not using
> > cache=unsafe, it should be safe.
> > 
> > Does the io_uring ignores the flush?
> 
> 
> Putting someone with more knowledge into cc.
> 
> For another VM, I've found several errors in the log of the host machine:
> 
> BTRFS warning (device sda1): direct IO failed ino 5988432 rw 1,2131969 sector 0x123ab840 len 32768 err no 10
> 
> 
> The VM was remounted ro too, like the first one. But in this case the
> filesystem was ok after a check. 

I have to correct this. There are several csum errors on this VM like
this:

BTRFS warning (device vda1): checksum/header error at logical 9660727296 on dev /dev/vda1, physical 6488064: metadata leaf (level 0) in tree 257

-- 
Regards,
  Johannes Hirte

