Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA37484028
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 11:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiADKut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 05:50:49 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:46091 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiADKut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 05:50:49 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 8CEB540508
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 04:51:35 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id AFE8C80343E6
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 04:50:48 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id A18E080343E9
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 04:50:48 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wh7NDQWj_029 for <linux-btrfs@vger.kernel.org>;
        Tue,  4 Jan 2022 04:50:48 -0600 (CST)
Received: from epl-dy1-mint.home (pool-108-35-160-232.nwrknj.fios.verizon.net [108.35.160.232])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 7163C80343E6
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 04:50:48 -0600 (CST)
Message-ID: <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
Subject: Re: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Tue, 04 Jan 2022 05:50:47 -0500
In-Reply-To: <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
         <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
         <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
         <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2022-01-03 at 19:51 +0800, Qu Wenruo wrote:

> The filesystem (normally) doesn't maintain such info, what a
> filesystem
> really care is the unused/used space.
> 
> For fstrim case, the filesystem will issue such discard comand to
> most
> (if not all) unused space.
> 
> And one can call fstrim multiple times to do the same work again and
> again, the filesystem won't really care.
> (even the operation can be very time consuming)
> 
> The special thing in btrfs is, there is a cache to record which
> blocks
> have been trimmed. (only in memory, thus after unmount, such cache is
> lost, and on next mount will need to be rebuilt)
> 
> This is to reduce the trim workload with recent async-discard
> optimization.

So in the general case (i.e. no session cache), the trim operation
scans all the allocation structures, to process all non-allocated
space?

> > Why is the
> > command not sent instantly, as soon as the space is freed by the
> > file
> > system?
> 
> If you use discard mount option, then most filesystems will send the
> discard command to the underlying device when some space is freed.
> 
> But please keep in mind that, how such discard command gets handled
> is
> hardware/storage stack dependent.
> 
> Some disk firmware may choose to do discard synchronously, which can
> hugely slow down other operations.
> (That's why btrfs has async-discard optimization, and also why fstrim
> is
> preferred, to avoid unexpected slow down).

Yes, but of course as I have used "instantly", I meant, not necessarily
synchronously, but simply near in time.

The trim operation is not avoiding bottlenecks, even if it is non-
blocking, because it operates at the level of the entire file system,
in a single operation. If Btrfs is able to process discard operations
asynchronously, then mounting with the discard option seems preferable,
as it requires no redundant work, adds no serious delay until until the
calls are made, and depends on no activity (not even automatic
activity) from the admin.

I fail to see a reason for preferring trim over discard.

