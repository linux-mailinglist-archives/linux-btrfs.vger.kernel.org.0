Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE8984B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfHUTnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 15:43:07 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35433 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfHUTnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 15:43:07 -0400
Received: by mail-wm1-f49.google.com with SMTP id l2so3352442wmg.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=b/OXkbPvTuBIRH32fYbbMkZMfH0apgoTiBlBAQBJ+a4=;
        b=q2lf+B3ZaMg3cV4ghI+hzaBKsZWtHTUSqOKNsUUbg963ou9KRM7jZu8XNSw2RoRqBg
         YlmT5pEXzEodh7lwWdpFc1zik6pMRS7CJzjZjEPSAtfBY/1M/U5GaRFevlXblqnv9BYa
         i+Hi0tsJdjMZqnxkfJ0oOYGKsDsBHqyCJBa9WlEX2DpJoG6v/txrciNhli2Ye8zYLCJT
         EKy5fazJzUIiduNMdfWMzQnYfTUnAYbkb1uxTE+qmEDB4W+Yf9loo22Ns6rDFJaO6UHX
         mkR0RnadXCn6ldXIw8xanudNS3OkOzGVC/w60N/NJNbma5Pj/j5Nm9okFhOqzS3Z6f/k
         D4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b/OXkbPvTuBIRH32fYbbMkZMfH0apgoTiBlBAQBJ+a4=;
        b=NOiTQbO5jI+/3V0pGjsTQwXVuvkKczSyurcg/ECnD0Rnc6awqdKXdF9wi6XUdEA/qU
         nZxAoTGvczqUPZXDAbkS8ToL7nFc9eY8M1ug2rDBFaxPGbnNfQGcuCqBrfJZMzy3qKu/
         S+oamkQ+PN7UuMjshge/Bntss3x8UkMlB0eQdteTNDs0E3HrQrZvoXhyJSLPpppPJ1+5
         G6Jo3HAAf9CmIolVbBdoYFA+DaFOqhE7chWpkadLOOJ9lM/2sytIjUjxq5DFLixkZLYp
         WNhCVAYc5RIpXSeRnQDtOVzTAUEQQ3w3lIGF1SG3WeK7VLc/vd0EcFjr3MtQ/BhxJD3w
         7DCw==
X-Gm-Message-State: APjAAAViUsQ7aFBs990lCEJ1JOoWUXStuSwWzMMTfci7A9oX+GhvxbWR
        yluheLeDYadH0bfignOIViFCd6mxYKgy86d9p2PP5xNP7hScCw==
X-Google-Smtp-Source: APXvYqyit5shYjjGUilNlLuNHeRx8JYqnFkNyEcwES6nMORIdisxGignaLja/hW1udVpdwuOO9RR1++sXAeWQRBiwRE=
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr1928032wme.176.1566416584545;
 Wed, 21 Aug 2019 12:43:04 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 21 Aug 2019 13:42:53 -0600
Message-ID: <CAJCQCtRYFtPGn2drNxrcuYFTTvmvRD7iuDNG=i1cDvSu=zcF6A@mail.gmail.com>
Subject: Btrfs on LUKS on loopback mounted image on Btrfs
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Why do this? a) compression for home, b) encryption for home, c) home
is portable because it's a file, d) I still get btrfs snapshots
anywhere (I tend to snapshot subvolumes inside of cryptohome; but I
could "snapshot" outside of it by reflink copying the backing file.

But, I'm curious about other's experiences. I've been doing this for a
while (few years) in the following configuration.

NVMe>plain partition>Btrfs sysroot->fallocated file that also has
chattr +C applied>attached to loop device>luksopen>Btrfs on the
dmcrypt device>mounted at /home.

sysroot mkfs options: -dsingle -msingle
cryptohome mkfs options: -M

Btrfs sysroot mount options: noatime,compress=zstd:3,ssd,space_cache=v2
dmcrypt discard passthrough is enabled
Btrfs crypto home mount options: noatime,compress=zstd:3,ssd,space_cache=v2

Ergo, pretty much the same except the smallish home uses mixed block
groups, and I mainly did that to avoid any balance related issues in
home, and figure the allocation behavior at this layer is
irrelevant/virtual anyway. The Btrfs on top of the actual device does
used separate block groups, and sees the "stream" from the loop device
as all data.

I have done some crazy things with this, like, I routinely,
intentionally, just force power off on the laptop while this is all
assembled as described. Literally hundreds of times. Zero complaints
by either Btrfs (as in no mount time complaints, no btrfs check
complaints, no scrub complaints, no Firefox database complaints). I
admit I do not often do super crazy things like simultaneous heavy
writes to both sysroot and home, and *then* force the power off. I
have done it, just not enough times that I can say for sure it's not
possible to corrupt either one of these file systems.

I have not benchmarked this setup at all, but I notice no unusual
latency. It might exist, just that the use cases I regularly use don't
display any additional latency (I do go back and forth between a
crypto home and plaintext home on the same system). For VMs, the
images tend to be +C raw images in /var/lib/libvirt/images; but a
valid use case exists for VM user sessions, including GNOME Boxes
which creates a qcow2 file in /home. That's a curious case I haven't
tested. There's now a new virtio-fs driver that might be better for
this use case, and directly use a subvolume in cryptohome, no VM
backing file needed. (?)

Cryptohome does get subject to fstrim.timer, which passes through and
punches holes in the file just fine. But, as a consequence of this
entire arrangement, the loopback mounted file does fragment quite a
lot. It's only a 4GiB image file, not even half full, and there are
18000+ fragments for the file. I don't defragment it, ever. I don't
use autodefrag. But I'm using NVMe, which has super low latency and
supports multiqueueing. I think it would be a problem on conventional
single queue SATA SSD and HDD.

And to amp this up a notch, I wonder about parallelism or multiqueue
limitations of the loop device? I know XFS and Btrfs both do leverage
parallelism quite a bit.

Anyway, the point is, I'm curious about this arrangement, other
arrangements, and avoiding pathological cases.

-- 
Chris Murphy
