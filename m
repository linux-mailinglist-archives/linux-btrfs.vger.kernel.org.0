Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965C528818E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 06:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgJIE5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 00:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIE5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 00:57:31 -0400
X-Greylist: delayed 2222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Oct 2020 21:57:31 PDT
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2ACC0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4l6oQ2SR7Iu+yPbWYxUCulUeaonkBYnkB09EyvQquSQ=; b=H2QLyQcDEAJ5rxIGiCpJr4UE33
        7CQinxD0RGEHlO/lGYT9S98AZNXSKhjlxPVW7z7H4LG+/rNNxWRyJg6PdIwh0b6jZuiFcBdV75De4
        ltgWH746RKIupijz9S9cH6zyS9tERa95nYGdZtsIXBcxAdHvHCd8n4QmEhAFl3KlIX43j1M+hrGk8
        NXVBEZOLWA9WtF0GvDGedkgZdmFHsBjgVb/tT9tBdpltBxOF9eyJK94tpGv/ypCUZJ+tpSFlofk8p
        8WN5juZfQZABVZlKVXxLkISLSrVYvYKxzFTWO/qaxNJRHfJQrC0yFJTZAR/Nj7HzV3jZVXVZbRd9C
        O+MaenSw==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1kQjtK-00089x-HK; Fri, 09 Oct 2020 04:20:26 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 82FBDDE3A652; Fri,  9 Oct 2020 13:20:23 +0900 (JST)
Date:   Fri, 9 Oct 2020 13:20:23 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: replacing a disk in a btrfs multi disk array with raid10
Message-ID: <20201009042023.GG52743@bulldog.preining.info>
References: <20200803052651.GA685777@bulldog.preining.info>
 <CAJCQCtSeZCVpnxeip6D1nRb-nuvTYyJdY2SFWeDUQMV0BnAbyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSeZCVpnxeip6D1nRb-nuvTYyJdY2SFWeDUQMV0BnAbyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

(please Cc)

sorry for the late reply - real life.

It turned out that the disk I use is well known to misreport this
property, and thus it can be ignored.

But I had to deal with (temporary) loss of one disk. Fortunately, 
Debian's initramfs dropped me into a proper shell where I could mount
the array in degraded mode and just remove the device.

Just one hiccup I realized: **after** some time I could re-connect the
one disc from the array that was missing (I needed a x1 NVMe extender
which I didn't have at the beginning). I though reconnecting is as
simple as 
	btrfs device add -f /dev/nvme0n1p1 /
but it turned out, because that disk has been part of the array, it was
rejected. Even using the -f option did not work. At the end I had to
fdisk the drive and trash the partition table and btrfs info to get it
ready to be re-added.
Full story https://www.preining.info/blog/2020/09/dealing-with-lost-disks-in-a-btrfs-array/

Anyway, all suprisingly smooth. Thanks to all of you.

Best

Norbert

On Mon, 03 Aug 2020, Chris Murphy wrote:
> On Sun, Aug 2, 2020 at 11:51 PM Norbert Preining <norbert@preining.info> wrote:
> >
> > Hi all
> >
> > (please Cc)
> >
> > I am running Linux 5.7 or 5.8 on a btrfs array of 7 disks, with metadata
> > and data both on raid1, which contains the complete system.
> > (btrfs balance start -dconvert=raid1 -mconvert=raid1 /)
> >
> > Although btrfs device stats / doesn't show any errors, SMART warns about
> > one disk (reallocated sector count property) and I was pondering
> > replacing the device.
> 
> Some of these are considered normal. I suggest making sure each
> drive's SCT ERC value is less than the SCSI command timer. You want
> the drive to give up on reading a sector before the kernel considers
> the command "overdue" and does a link reset - losing the contents of
> the command queue. Upon read error, the drive reports the sector LBA
> so that Btrfs can automatically do a fixup.
> 
> More info here. It applies to mdadm, lvm, and Btrfs raid.
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
> 
> Once you've done that, do a btrfs scrub.
> 
> >
> > What is the currently suggested method given that I cannot plug in
> > another disk into the computer, all slots are used up (thus a btrfs
> > replace will not work as far as I understand).
> 
> btrfs replace will work whether the drive is present or not. It's just
> safer to do it with the drive present because you don't have to mount
> degraded.
> 
> 
> > Do I need to:
> > - shutdown
> > - pysically replace disk
> > - reboot into rescue system
> > - mount in degraded mode
> > - add the new device
> 
> Use 'btrfs replace'
> 
> > - resize the file system (new disk would be bigger)
> 
> Currently 'btrfs replace' does require a separate resize step. 'device
> add' doesn't, resize is implied by the command.
> 
> 
> > - start a new rebalancing
> >         (for the rebalance, do I need to give the
> >         same -dconvert=raid1 -mconvert=raid1 arguments?)
> 
> Not necessary. But it's worth checking 'btrfs fi us -T' and making
> sure everything is raid1 as you expect.

--
PREINING Norbert                              https://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
