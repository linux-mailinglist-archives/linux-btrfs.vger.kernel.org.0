Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488C06794D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfGMI2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 04:28:03 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:55343 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfGMI2C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 04:28:02 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 5F9758C71
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 10:27:59 +0200 (MEST)
Date:   Sat, 13 Jul 2019 10:27:59 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190713082759.GB16856@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 2019-07-13 (06:59), Andrei Borzenkov wrote:
> 13.07.2019 2:17, Ulli Horlacher ?8H5B:
> 
> > I need to find (all) subvolume directories.

> That is just coincidence because @/.snapshot subvolume is mounted on
> /.snapshot. It could also be mounted under /var/lib/snapper (insert your
> path here).

Yes, this is the problem for me!


> > But what if a btrfs filesystem does not have a toplevel /@/ directory, but
> > anything else, like /this/is/my/top/directory ?
> > 
> 
> btrfs does not have "top level directory" beyond single /.

I used the wrong naming.
I have meant "top level directory beyond /"


> It is entirely up to the user who creates it how subvolumes are named and
> structured. You can well have /foo, /bar, /baz mounted as /, /var and
> /home.

And how can I find them in my mounted filesystem?
THIS is my problem.
As I wrote: "find / -inum 256" is too slow.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
