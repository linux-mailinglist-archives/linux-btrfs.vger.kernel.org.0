Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B500D6E2A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGSIj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 04:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfGSIj5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 04:39:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79B43AC58;
        Fri, 19 Jul 2019 08:39:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 0/2] Refactor snapshot vs nocow writers locking
Date:   Fri, 19 Jul 2019 11:39:47 +0300
Message-Id: <20190719083949.5351-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, 

Here is the second version of the DRW lock for btrfs. Main changes from v1: 

* Fixed all checkpatch warnings (Andrea Parri)
* Properly call write_unlock in btrfs_drw_try_write_lock (Filipe Manana)
* Comment fix. 
* Stress tested it via locktorture. Survived for 8 straight days on a 4 socket
48 thread machine.

I have also produced a PlusCal specification which I'd be happy to discuss with 
people since I'm new to formal specification and I seem it doesn't have the 
right fidelity: 

---- MODULE specs ----
EXTENDS Integers, Sequences, TLC

CONSTANT NumLockers

ASSUME NumLockers > 0

(*--algorithm DRW

variables
    lock_state = "idle",
    states = {"idle", "write_locked", "read_locked", "read_waiting", "write_waiting"},
    threads = [thread \in 1..NumLockers |-> "idle" ] \* everyone is in idle state at first, this generates a tuple

define
INV_SingleLockerType  == \/ lock_state = "write_locked" /\ ~\E thread \in 1..Len(threads): threads[thread] = "read_locked"
                         \/ lock_state = "read_locked" /\ ~\E thread \in 1..Len(threads): threads[thread] = "write_locked"
                         \/ lock_state = "idle" /\ \A thread \in 1..Len(threads): threads[thread] = "idle"
end define;

macro ReadLock(tid) begin
    if lock_state = "idle" \/ lock_state = "read_locked" then
        lock_state := "read_locked";
        threads[tid] := "read_locked";
    else
        assert lock_state = "write_locked";
        threads[tid] := "write_waiting"; \* waiting for writers to finish
        await lock_state = "" \/ lock_state = "read_locked";
    end if;

end macro;

macro WriteLock(tid) begin
    if lock_state = "idle" \/ lock_state = "write_locked" then
        lock_state := "write_locked";
        threads[tid] := "write_locked";
    else
        assert lock_state = "read_locked";
        threads[tid] := "reader_waiting"; \* waiting for readers to finish
        await lock_state = "idle" \/ lock_state = "write_locked";
    end if;

end macro;

macro ReadUnlock(tid) begin
    if threads[tid] = "read_locked" then
        threads[tid] := "idle";
        if ~\E thread \in 1..Len(threads): threads[thread] = "read_locked" then
            lock_state := "idle"; \* we were the last read holder, everyone else should be waiting, unlock the lock
        end if;
    end if;

end macro;

macro WriteUnlock(tid) begin
    if threads[tid] = "write_locked" then
        threads[tid] := "idle";
        if ~\E thread \in 1..Len(threads): threads[thread] = "write_locked" then
            lock_state := "idle"; \* we were the last write holder, everyone else should be waiting, unlock the lock
        end if;
    end if;

end macro;

process lock \in 1..NumLockers

begin LOCKER:
    while TRUE do
        either
            ReadLock(self);
        or
            WriteLock(self);
        or
            ReadUnlock(self);
        or
            WriteUnlock(self);
        end either;
    end while;
end process;

end algorithm; *)

====


Nikolay Borisov (2):
  btrfs: Implement DRW lock
  btrfs: convert snapshot/nocow exlcusion to drw lock

 fs/btrfs/ctree.h       | 10 ++---
 fs/btrfs/disk-io.c     | 46 ++++++----------------
 fs/btrfs/extent-tree.c | 35 -----------------
 fs/btrfs/file.c        | 11 +++---
 fs/btrfs/inode.c       |  8 ++--
 fs/btrfs/ioctl.c       | 10 ++---
 fs/btrfs/locking.c     | 88 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h     | 20 ++++++++++
 8 files changed, 134 insertions(+), 94 deletions(-)

-- 
2.17.1

