Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C03D4544
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 08:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGXFuI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 01:50:08 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:65136
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhGXFuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 01:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lithops.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=ldMb5DzJlwI9Sr3+1eKJWlCEYElR84GZfmsud9rJXMA=;
        b=Mx38RZBU/v3wWXi+yNhjei9tEUYJ8QCRizngSG5CUekPJXnbmp85ecIr+dFQDcP1dlK2ZgOykU+Af
         H5JPkAg6BpXv6wg0Hd8alqPrKY8uT3UfkTbjfTLyQKyhLmYkf5VLbxoDOZw8iIqSVxzO5aeo+HGNqM
         hFhEPf1aI6M2Sqxd+OJXSr2dQ1WuBg8xZrwCNjtAZCL1OYZqwmTsW5gHUyrfBPNas1LTY7f8cZESuR
         l2n/bYq1DZFaE+wosian/VGHP2E7Z6THJXP7cQA3tuqRl896y7qX/h+gPEyGlc4FNdXx3M5cp9Cs2G
         ieaSA1CBollUp+J2fVmWvs+IF04FlFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lithops.se; s=rsa1;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=ldMb5DzJlwI9Sr3+1eKJWlCEYElR84GZfmsud9rJXMA=;
        b=WxJ9AqWzF3q303Vk+9ZkVqGm6RYUMJqGbfm2io7k6Q4lTJhLGj69rjcfWS+PLDgqIZL2zNQpCGoWa
         ctQ+AmY/EaMofKzMhlSob0DnFUPBPe41P9gnbgcBx6x2FJRn96JIvJhG6hvXhXr9G4MWiQq4nWm66F
         W/PzFzR+N/rpuuST1VTwk/ZVfByIrFzN9f8KZgzbHDnXj2MSf72k0AcrHc7qX3oNwW+iRQvWqCR8RU
         C6zXMOxAhPE3V5u6B0fDisvSHaoL9Intl4GqEucq+qHiiPljeuDeHHB9jVrUUw3gljxqj8//L20cNO
         g+0mDHeb33JrLuRSWZIzVidYJ7fJoiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=lithops.se; s=ed1;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=ldMb5DzJlwI9Sr3+1eKJWlCEYElR84GZfmsud9rJXMA=;
        b=IOqvPhmwUUWhwPRuGIAB6mSm+qt5vwE+B/TNUls0WC8f/U44YlGFBe1ly2O6giixcOlXiPA1n2srU
         uGOqYl8Dg==
X-HalOne-Cookie: 7c4cb3475847e645bec247bd13178d69876a6d1d
X-HalOne-ID: a878ac70-ec48-11eb-bd4a-d0431ea8a290
Received: from poirot.localdomain (unknown [178.255.113.211])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPA
        id a878ac70-ec48-11eb-bd4a-d0431ea8a290;
        Sat, 24 Jul 2021 06:30:37 +0000 (UTC)
Date:   Sat, 24 Jul 2021 08:30:37 +0200
From:   Jonas Aaberg <cja@lithops.se>
To:     Martin Raiber <martin@urbackup.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: On the issue of direct I/O and csum warnings
Message-ID: <20210724083037.463fb0d5@poirot.localdomain>
In-Reply-To: <0102017ad4affb63-e12c8463-8971-4b1c-b271-ee880969fa5b-000000@eu-west-1.amazonses.com>
References: <20210723165517.2614d1b4@poirot.localdomain>
        <0102017ad4affb63-e12c8463-8971-4b1c-b271-ee880969fa5b-000000@eu-west-1.amazonses.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 23 Jul 2021 18:45:40 +0000
Martin Raiber <martin@urbackup.org> wrote:

> On 23.07.2021 16:55 Jonas Aaberg wrote:
> > Hi,
> >
> > I use btrfs on dm-crypt. About two months ago, I started to get:
> >
> > --
> > BTRFS warning (device dm-0): csum failed root 257 ino 1068852 off
> > 25690112 csum 0xa27faf9a expected csum 0x4c266278 mirror 1 BTRFS
> > error (device dm-0): bdev /dev/mapper/disk0 errs: wr 0, rd 0, flush
> > 0, corrupt 349, gen 0
> > --
> >
> > kind of warning/errors on my laptop. I went a bought a new NVME disk
> > because I'm rather found of my data, eventhough most is backup-ed
> > up.
> >
> > A week later, I started to get the same kind of warning/error
> > message on my new NVME. After half a day of memtest86, resulted in
> > no memory errors found, I gave up on my otherwise stable laptop and
> > started to use an old laptop that I've been to lazy to sell instead
> > while looking out for a decent pre-owned newer laptop.
> >
> > Now I'm just about to install and move over to a newly bought
> > laptop, when today my old laptop started to show the same
> > warning/errors. My old laptop does not share a single part with the
> > laptop which I previous got the "checksum failure" warnings on.
> > Therefore I have a hard time to believe that I've gotten the same
> > hardware failure twice.
> >
> > Then I found:
> > <https://btrfs.wiki.kernel.org/index.php/Gotchas> and "Direct I/O
> > and CRCs".
> >
> > Which I believe is what I've ran into. One of the affect files is
> > a log file from syncthing on both computers.  
> 
> I wouldn't be certain about the conclusion that it is the direct I/O
> csum issue. Are you sure syncthing is writing to logs via direct I/O?
> That would be bad e.g. because it disables btrfs compression and log
> files compress really well. So I'd say report additional information
> like kernel version (and if it is a vanilla kernel), how your btrfs
> is setup (metadata RAID1), etc.

No, I've not checked syncthing and its dependencies. But I'll do that.
Just to be sure we're talking about the same thing, "direct" means
O_DIRECT on syscall open()?

I use archlinux, with their stock "linux-lts" kernel which has been
on 5.10 since winter/spring. I'm sure that the two last checksum errors
have occurred on 5.10.x - unsure about exactly which version. Currently
the computer runs 5.10.52, but it was after a system update and a
restart that I noticed the checksum error. So the checksum error
probably occurred on a previous kernel version in the 5.10 range.

regarding mount options:

/dev/mapper/disk0 on / type btrfs
(rw,relatime,compress=zstd:3,ssd,space_cache,autodefrag,subvolid=256,subvol=/__current/ROOT)
/dev/mapper/disk0 on /home type btrfs
(rw,relatime,compress=zstd:3,ssd,space_cache,autodefrag,subvolid=257,subvol=/__current/home)
/dev/mapper/disk0 on /var/log type btrfs
(rw,relatime,compress=zstd:3,ssd,space_cache,autodefrag,subvolid=258,subvol=/__current/log)

No raid. Just btrfs upon dmcrypt.

The file with faulty checksum is in the subvolume=/__current/home.
(/home//jonas/.config/syncthing/index-v0.14.0.db/007197.log)

If I recall right, I did correct the checksum errors on the first nvme
disk where it occurred. The second NVME is left as it is when it
occurred, and the error is still present on my SSD. So I can maybe get
some history if needed.

Any more information that you would like to have?

> 
> > I have just one humble request, please do something about this
> > checksum error message. Just add printk with a link to:
> > <https://btrfs.wiki.kernel.org/index.php/Gotchas> and the issue of
> > "Direct I/O and CRCs".  
> The problem is nothing can be done without impacting performance and
> direct I/O is used for performance.
Understood. I was talking about making the print less alarming.

> IMO it should be disabled by
> default (i.e. it just pretends to do direct I/O like ZFSOnLinux) and
> be able to be enabled via mount option.
Sounds like a good idea.

> >
> > Maybe update the wiki with:
> > `find <mountpoint> -inum <ino-number-from-warning-message>`
> > would be a helpful as well.  
> 
> btrfs inspect-internal inode-resolve
> <ino-number-from-warning-message> <fs>
> 
> is faster.
Thanks!

BR,
 Jonas Aaberg


