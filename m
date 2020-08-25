Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA53F25188B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHYM3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYM3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 08:29:48 -0400
X-Greylist: delayed 277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Aug 2020 05:29:48 PDT
Received: from oker.escape.de (oker.escape.de [IPv6:2a00:1030:1004:107::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA45C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 05:29:47 -0700 (PDT)
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.15.2/8.15.2/$Revision: 1.90 $) with ESMTPS id 07PCP51B005786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 14:25:05 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.15.2/8.15.2/Submit) with UUCP id 07PCP55Z005785
        for linux-btrfs@vger.kernel.org; Tue, 25 Aug 2020 14:25:05 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id 07PCOT4e003055
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 14:24:29 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id 07PCOTow003052;
        Tue, 25 Aug 2020 14:24:29 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     linux-btrfs@vger.kernel.org
Subject: Re: Link count for directories
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
        <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
        <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
        <20200824222306.GA26736@angband.pl>
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   25 Aug 2020 14:24:29 +0200
In-Reply-To: <20200824222306.GA26736@angband.pl>; from Adam Borowski on Tue, 25 Aug 2020 00:23:06 +0200
Message-ID: <ygfwo1mq5fm.fsf@tehran.isnogud.escape.de>
Lines:  22
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adam Borowski <kilobyte@angband.pl> writes:

> It's just an implementation detail of sysvfs, and a case of
> bug-compatibility.  The link count of a directory is always 1 as btrfs,
> ext4, xfs, etc -- none of them support directory hardlinks, unlike sysvfs.

No, allmost all other file systems handle the directory link count in
the traditional way, at least minix, ext2, ext3, ext4, xfs, tmpfs,
devtmpfs, devpts, sysfs, cgroup on Linux do so.  And also FreeBSD ufs
and devfs, NetBSD ffs, tmpfs, and kernfs, and OpenBSD ffs and mfs do
that also.

I'd like to check how zfs handles this (on Linux, FreeBSD or Solaris),
but currently have no access to a system using it.

> So the proper value, as documented, is 1.  Copying sysvfs behaviour is also
> costly as you need to know the count of contents while statting parent.

No, it's not that costly.  Directories start with nlink = 2 and nlinks
is incremented or decremented with each mkdir or rmdir system call.

urs
