Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C904348290F
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 05:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiABEDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 23:03:30 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:49929 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiABED3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 23:03:29 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id D0FDE405C0
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 22:04:12 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 715398034FC0
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 22:03:27 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 606678206666
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 22:03:27 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W0P5NzsuFmvY for <linux-btrfs@vger.kernel.org>;
        Sat,  1 Jan 2022 22:03:27 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 0D6A68206661
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 22:03:26 -0600 (CST)
Message-ID: <b6f84999f9506ca2e72673d8e94e72a0f29cea11.camel@ericlevy.name>
Subject: Re: parent transid verify failed
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sat, 01 Jan 2022 23:03:25 -0500
In-Reply-To: <YdEbsxw7Nk0GKKzN@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
         <Yc9Wgsint947Tj59@hungrycats.org>
         <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
         <YdDAGLU7M5mx7rL8@hungrycats.org>
         <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
         <YdDurReZpZQeo+7/@hungrycats.org>
         <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
         <YdEbsxw7Nk0GKKzN@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2022-01-01 at 22:27 -0500, Zygo Blaxell wrote:

> Yes, that's normal with lazy umounts.  With a lazy umount, the mount
> point is removed immediately, so you get all the behavior you
> described,
> but the filesystem is not actually umounted until after the last open
> file descriptors referencing the filesystem are closed (that's the
> "lazy" part).

All of the explicit umount calls I gave had no lazy flag. I don't
understand the full details of your comments, as I am only aware of
lazy umount as a fallback for failing umount calls in synchronous
operations.

It seems the way mounts work, especially when interacting with user
space solutions, such as FUSE and Gvfs, is often burdened by legacy
design never updated to work properly. I have seen Gvfs pull down an
entire system from trying to access a file in a user mount, since the
mount was made before a network connection with the Samba server was
dropped.

For laptops these kinds of vulnerability are quite debilitating.

> You can run btrfs scrub to verify the data and metadata.
> 
> The most probable outcome is that everything's OK.  The device layer
> reported failed writes to btrfs, and btrfs aborted the last
> transaction
> to protect the on-disk data.  I would not expect any errors in either
> btrfs check or scrub, as this scenario is one the filesystem is
> designed
> and tested for.

Great, thanks. Scrub reported no errors, and the check reported none,
as already mentioned.

> Since you're transitioning from one disk to multiple disks, you
> should
> convert metadata to raid1, and ensure there's sufficient unallocated
> space on the first drive to hold metadata as it grows.  This can be
> done

I thought it was the default for disk pools, fully duplicated metadata,
and JBOD-style for payload data.

> with two balance commands:
> 
> 	btrfs balance start -dlimit=16 /fs
> 
> 	btrfs balance start -mconvert=raid1,soft /fs

Does balance manage balanced utilization of disks? For specific
scenarios, unbalanced disk usage is actually desirable, for example, my
current one, in which the devices are logical volumes on a redundant
back end. Using as much of one volume as possible simplifies
reallocation of back end storage resources.

---

I am noticing that the order of devices in now reversed. I am wondering
whether what happened is that iSCSI, either on the client or server
side, reversed the order, by some quirk or design flaw. while I had the
live mount. Still, it doesn't explain why I originally was able to see
the new, unpartitioned device and add it to the pool.

Another possibility is that the sequence of add/remove/add, which I
explained earlier, caused some problem, but it also seems not clear
how, since all of these operations are synchronous.

