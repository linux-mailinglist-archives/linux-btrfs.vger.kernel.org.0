Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616852289F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGUUdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 16:33:45 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:48998 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbgGUUdp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 16:33:45 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-31.iol.local with ESMTPA
        id xyxKjpuK2GrpJxyxKjhpqG; Tue, 21 Jul 2020 22:33:42 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1595363622; bh=Pw8bp6fG8a3fG2wUCdALMcb9cY/KsSkSfVV799030l8=;
        h=From;
        b=UkY5eDA0ZRNHnoFA/FwMUPGK96+PrgdveDrPzp0ipGLO9B1B1YE15t6P40gnoXg09
         XkDWTWnaJJA4gJScTWx4c4vpy5e6vObIPodnD6rZ8vx/MnF94Jrw4KJL0UbGoZsbau
         NBPjNdgLRA5VTnnmVHQEQwDen//n6EWyi28Y8hu77Jv/55oe7rZ175xk/iA9LrFt/z
         PXz1blVZOOVSc6rCKhxFCexyDbr4sZpj8nmkRYXsSAjDXALPmgvaLL2hMmKx93h6JY
         wNZnWQb19riocqct5gEtN6gySfWW1TQIwWAgi1DbCwcoIcZCmb4rQbaSWXbyvsiZpR
         Ptw3GRRn/Q5kA==
X-CNFS-Analysis: v=2.3 cv=Ief5plia c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17 a=VwQbUJbxAAAA:8
 a=NLn4WoTWf1AU9Q_8NQgA:9 a=AjGcO6oz07-iQ99wixmX:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC] btrfs: strategy to perform a rollback at boot time
Date:   Tue, 21 Jul 2020 22:33:39 +0200
Message-Id: <20200721203340.275921-1-kreijack@libero.it>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFnyMiGBkS12e7x70Wbv3tP59gwjBrDi/2JrUb+BY3d3th1wJW5gLaDN6NCZlT7M0Bvaia+uXmvQHPVdBtYtQT8ecglcuqVZz4v9m5tNoWvhvyU0reiA
 SInoA9BCRr5XLkQKosCeD1TKUnmyq/MEFPwACFRpQnA/ZY3s7v+jH0XW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

this is an RFC to discuss a my idea to allow a simple rollback of the
root filesystem at boot time.

The problem that I want to solve is the following: DPKG is very slow on
a BTRFS filesystem. The reason is that DPKG massively uses
sync()/fsync() to guarantee that the filesystem is always coherent even
in case of sudden shutdown.

The same can be useful even to the RPM Linux based distribution (which however
suffer less than DPKG).

A way to avoid the sync()/fsync() calls without loosing the DPKG
guarantees, is:
1) perform a snapshot of the root filesystem (the rollback one)
2) upgrade the filesystem without using sync/fsync
3) final (global) sync
4) destroy the rollback snapshot

If an unclean shutdown happens between 1) and 4), two subvolume exists:
the 'main' one and the 'rollback' one (which is the snapshot before the
update). In this case the system at boot time should mount the "rollback"
subvolume instead of the "main" one. Otherwise in case of a "clean" boot, the
"rollback" subvolume doesn't exist and only the "main" one can be
mounted.

In [1] I discussed a way to implement the steps 1 to 4. (ok, I missed
the point 3) ).

The part that was missed until now, is an automatic way to mount the rollback
subvolume at boot time when it is present.

My idea is to allow more 'subvol=' option. In this case BTRFS tries all the
passed subvolumes until the first succeed. So invoking the kernel as:

  linux root=UUID=xxxx rootflags=subvol=rollback,subvol=main ro 

First, the kernel tries to mount the 'rollback' subvolume. If the rollback
subvolume doesn't exist then it mounts the 'main' subvolume.

Of course after the mount, the system should perform a cleanup of the
subvolumes: i.e. if a rollback subvolume exists, the system should destroy
the "main" one (which contains garbage) and rename "rollback" to "main".
To be more precise:

	if test -d "rollback"; then
		if test -d "old"; then
			btrfs sub del "old"
		fi
		if test -d "main"; then
			mv "main" "old"
		fi
		mv "rollback" "main"
		btrfs sub del "old"
	fi

Comments are welcome
BR
G.Baroncelli

[1] http://lore.kernel.org/linux-btrfs/69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it/

P.S.
I am guessing if an idea like this can be applied to a file. E.g. a sqlite
database that instead of reling to sync/fsync, creates a reflink file as
"rollback" if something goes wrong.... The ordering is preserved. Not the
duration.

