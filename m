Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C190D334A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJJVVh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 17:21:37 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:58539 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVVh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 17:21:37 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id EB6959404
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 23:21:33 +0200 (MEST)
Date:   Thu, 10 Oct 2019 23:21:33 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: rsync -ax and subvolumes
Message-ID: <20191010212133.GA3648@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20191010172011.GA3392@tik.uni-stuttgart.de>
 <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 2019-10-10 (20:47), Kai Krakow wrote:

> > I run into the problem that "rsync -ax" sees btrfs subvolumes as "other
> > filesystems" and ignores them.
> 
> I worked around it by mounting the btrfs-pool at a special directory:
> 
> mount -o subvolid=0 /dev/disk/by-label/rootfs /mnt/btrfs-pool

This is only possible by root, but not by regular users.
Yes, there are true multi-user systems still out there :-)


> Actually, you could also just bind-mount into /mnt/btrfs, bind-mounts
> won't inherit other mounts but will still see pure subvolumes.

Again, only possible by root.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
