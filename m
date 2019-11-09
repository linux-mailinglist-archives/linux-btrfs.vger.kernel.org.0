Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A901DF61C6
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 23:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKIWsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 17:48:08 -0500
Received: from mail.rptsys.com ([23.155.224.45]:13995 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfKIWsI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 17:48:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id DF854BE425A1F
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2019 16:48:07 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y1iO7wa1TrS1 for <linux-btrfs@vger.kernel.org>;
        Sat,  9 Nov 2019 16:48:07 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 3977FBE425A04
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2019 16:48:07 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 3977FBE425A04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573339687; bh=KAxAqiiNuPU9Nc61iQ0P10zhESlLmFT6Ukifno4P8VY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MHFWRqpbtlVu+MV4PY/fmgF7/IBsyV3BEVKZTeSOQuOl68K2AAK41dj/zTe5nPRHs
         XTi9igzs/QlLFDodrWofGGV9Y83tfA/j4ydegYXVFpHTFUeNh3JkNRbSWY3PLkJzLt
         0J62R3JRtenu0c2L7YiASU1Nvz0OLZKw02N20wOU=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ECybXMpdOEaY for <linux-btrfs@vger.kernel.org>;
        Sat,  9 Nov 2019 16:48:07 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 08408BE4259F7
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2019 16:48:07 -0600 (CST)
Date:   Sat, 9 Nov 2019 16:48:05 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1000805314.68851.1573339685782.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: Unusual crash -- data rolled back ~2 weeks?
Thread-Index: RXOsokHARtBw/xwBvljfwkDz5Lz3MBcfXxUL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One item I did forget to mention here is that the underlying device was expanded online using "btrfs fi resize max /mount/path" at most a month before the failure -- I don't have the exact timestamps available, so there remains a possibility that the latest files on the currently mounted filesystem correspond to the filesystem as it was immediately prior to the resize operation.

Again, any suggestions welcome.  It took us a bit of time (and several large file restores) to realize the filesystem had rolled back vs just corrupted a few files, so while there does exist a raw copy of the filesystem it is tainted by being mounted and written to before the copy was taken.

----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> To: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Saturday, November 9, 2019 4:33:29 PM
> Subject: Unusual crash -- data rolled back ~2 weeks?

> We just experienced a very unusual crash on a Linux 5.3 file server using NFS to
> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no apparent
> underlying disk subsystem problems, and when the server was hard rebooted to
> clear the D wait the BTRFS filesystem remounted itself in the state that it was
> in approximately two weeks earlier (!).  There was also significant corruption
> of certain files (e.g. LDAP MDB and MySQL InnoDB) noted -- we restored from
> backup for those files, but are concerned about the status of the entire
> filesystem at this point.
> 
> We do not use subvolumes, snapshots, or any of the advanced features of BTRFS
> beyond the data checksumming.  I am at a loss as to how BTRFS could suddenly
> just "forget" about the past two weeks of written data and (mostly) cleanly
> roll back on the next mount without even throwing any warnings in dmesg.
> 
> Any thoughts on how this is possible, and if there is any chance of getting the
> lost couple weeks of data back, would be appreciated.
> 
> Thank you!
