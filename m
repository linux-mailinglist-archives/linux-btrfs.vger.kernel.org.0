Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166E0481968
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Dec 2021 05:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbhL3Eqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Dec 2021 23:46:30 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:45358 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232488AbhL3Eqa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Dec 2021 23:46:30 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 7C560126F68; Wed, 29 Dec 2021 23:46:29 -0500 (EST)
Date:   Wed, 29 Dec 2021 23:46:29 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Mark Murawski <markm-lists@intellasoft.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS FS corruption
Message-ID: <Yc05pduSyUaeZ5GI@hungrycats.org>
References: <41c94bee-eb97-a280-21c3-bcfe216f078d@intellasoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c94bee-eb97-a280-21c3-bcfe216f078d@intellasoft.net>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 29, 2021 at 03:30:46PM -0500, Mark Murawski wrote:
> Kernel: Debian 5.10.70-1~bpo10+1 (2021-10-10)

I've been trying to reproduce the "ghost dirents" bug on 5.10 without
success.  It's much easier to hit on 5.14 and 5.15, but apparently not
impossible on 5.10.

> # ls -al /mnt/var/lib/postgresql/12/main/pg_stat_tmp/
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> ls: cannot access '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp':
> No such file or directory
> total 80
> drwx------ 1 1001 1001   94 Dec 29 13:52 .
> drwx------ 1 1001 1001  552 Dec 29 13:51 ..
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001 1864 Dec 29 13:52 db_16391.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp
> -????????? ? ?    ?       ?            ? global.tmp

This looks like the "ghost dirents" bug I've been chasing for a while.

Some prior discussion at

	https://lore.kernel.org/linux-btrfs/CAL3q7H4CYtaW_aEQSEZ_KxZ_ba3u=FmPT8VtXH+OE6FTR8oxOQ@mail.gmail.com/
> 
> This is a dev/test vm so we can do intrusive operations on it...

If you can reproduce this reliably, can you apply a kernel patch:

	v5.16-rc1: 9a35fc9542fa btrfs: change error handling for btrfs_delete_*_in_log

There's a link to the commit in the kernel.org thread.

> Should I run btrfsck?

Ghost dirents can be removed by the normal 'rm -rf' tool (though it will
complain with errors).  You can run btrfs check to confirm that this is
the only problem on the filesystem.

> btrfs scrub did not show any errors/fixes and it did not fix the issue.

Scrub verifies metadata block csums, and there will be no errors in
csums from the ghost dirent bug case, so scrub will not detect or report
ghost dirents.
