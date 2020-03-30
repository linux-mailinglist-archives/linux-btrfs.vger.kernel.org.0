Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51F19726F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 04:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgC3C3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 22:29:35 -0400
Received: from mail.virtall.com ([46.4.129.203]:48604 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgC3C3e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 22:29:34 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 3409F41A3DC1;
        Mon, 30 Mar 2020 02:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1585535372; bh=XlFiUu/1JXFbUbfiyWkERKcGFbHp+F7tgcLZGtaGYek=;
        h=Date:From:To:Cc:Subject;
        b=dgr5NC1g5qiwgcNjpfMlP+fuhJ/dtel9QmRJW3G5gC70PtTiQiqxYdSYfHbrajHX5
         Bl3oPsE0fDnrj7kqEcYoaAZPqaqcxkh3aQZV47Yn5Tjk0vdidQHY5laqeb+yUJrbjL
         /8KkLdxyi1CEu2t5W0c6InjyPbOIo63nGlQ2KxRauO0A9MFchJMtNYzBZuqz+ESZdG
         scrrTU/AhQ+iaZsv8u/d21KnoEJgxVqWZInMKEfqPltZfwZ6/rrf27IgwHxFoiLsRY
         jXhyPHjf52mDar63lkDqANYngnl1gdd/M0DfInhu2huSKRXBwtVBGJBN7nzvBpgLKF
         3nCKTm5HISMHQ==
X-Fuglu-Suspect: 5dab00429ba74c7a8f44635898963c6f
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Mon, 30 Mar 2020 02:29:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Mar 2020 11:29:19 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     4brad@templetons.com
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
Message-ID: <94d08f2b57dd2df746436a0d6bb5f51e@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu
> LTS if it has a data corruption bug.   I don't know if I've seen any
> release of 5.4.14 in a PPA yet -- manual kernel install is such a pain
> the few times I have done it.

You have all kernels compiled as packages here (for Ubuntu):

https://kernel.ubuntu.com/~kernel-ppa/mainline/

So just download two deb packages, dpkg -i, and done.

btrfs can be still not quite as stable as one would wish, but the 
following work well for me on quite many servers:

- use a recent kernel - late 5.5.x, now perhaps 5.6 - will typically 
work better for btrfs than a default distribution kernel

- use "noatime" mount option

- use "space_cache=v2" mount option

- absolutely do not use qgroups (make sure this command returns an error 
saying that quotas are not enabled): btrfs qgroup show /mount/point

- if using RAID-5, make sure to use RAID-1 for metadata (and raid1c3 
metadata for RAID-6 data)

- if you use any software automation, make sure that it doesn't 
accidentally re-enable quotas (in btrfs, there is no mount flag for 
quotas, unlike in other filesystems, so it's not intuitive to say if the 
quotas are enabled or not)


Tomasz Chmielewski
https://lxadm.com
