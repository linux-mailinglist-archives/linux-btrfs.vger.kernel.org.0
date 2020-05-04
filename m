Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94991C33D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEDHnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgEDHnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 03:43:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8350C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 00:43:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g12so7800091wmh.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=SWfHWK1DLY2SCVokDxcGpC5kJ3iquNeKZlHUFOTtxwA=;
        b=cJd4dfLwQIBshZ/E/Kq8GnJYMdsAddQRbcc0dD0rZ4Bf7smIiTsqK0oazsfmKmrzn+
         TAlSJ26NPgsJpccpTj5DPNsOe/Rxx4AoWnoYVn5mRK6TOf0z/mMC9H0faqRQi3bVxugp
         XLer9r7aOUmLPcClREu8cuNnOSn6atq4Z1XLeBS3S6y8bmzscIhLNavR8PbZdU+nb17B
         4VFHC5dv2hEHOjAMVVe/fcPZwUZ8fCOa3Q/riVoWhR3smJrevwXenszlXZ6zCzNH3vPm
         4lgNDxa4ZZuqC5qzLv1Q/ckuYUIj/0J3TUX2RRXfymm+LaqlphqQxCFt0/lA0JAMURnE
         ZClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SWfHWK1DLY2SCVokDxcGpC5kJ3iquNeKZlHUFOTtxwA=;
        b=PoVFl035hxhX7fk2pM4kdNlg3YtQWFGqUXHiseG27dr6ozXT7l3b3R4gTyYg5QITuT
         vL7aZ1J9XkecSY92QOfDMDF+as1RQMuKgoQxaGOJ+DilQ337t7UC425fVTbBGDiPGlOo
         joZkQk9ngi99EJxIM8+zQOwNjN+FYo5534KJi5JQq0IFlH2UJwyAEuhqLfX95ZUWTISt
         owCp6e+8+jx5j3Ls9qa65p/1SLoZNM84BR3rmj1r8M5gz2sNiJvFAJ2zSE6EHbrT8/du
         6KuwcP6YeCqjJ7gwwd4A6xutgZsaMu8JT42zBj9xkC5VCGxOChQ3Rqt9eT5s6CGnwF8m
         mbkg==
X-Gm-Message-State: AGi0PubVRbGRGlno8fJG4WHEPQJY+NvP2XTjjBuAwgEWHBJDQ6E5wDAe
        cfjEhaLH9Ml91nUiiG/6LuBNSQ/lSgoM56Stpb7tDZDaURw=
X-Google-Smtp-Source: APiQypIUllDE9Zc5+YFcLVOa4+9fkzn34xxFxP1CZg6LmHxaxoBokLRzscm4nmWU3ziCK/uglPSJBF9myLMOzKuwerM=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr12924263wmb.128.1588578222424;
 Mon, 04 May 2020 00:43:42 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 01:43:26 -0600
Message-ID: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
Subject: 5.6, slow send/receive, < 1MB/s
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs-5.6-1.fc32.x86_64
kernel-5.6.8-300.fc32.x86_64

I have one snapshot of a subvolume being sent from one Btrfs
filesystem to another. Both are single device. The HDD scrub
performance is ~90MB/s. The send/receive is averaging less than 2MB/s.
Upon attaching strace to the send PID, it dies.

# btrfs send /mnt/first/scratch/gits.20200503/ | btrfs receive /mnt/aviat
ERROR: command length 1718776930 too big for buffer 65536
#

$ sudo strace -p 5628
strace: Process 5628 attached
ioctl(4, BTRFS_IOC_SEND, {send_fd=6, clone_sources_count=0,
clone_sources=NULL, parent
_root=0, flags=0}) = ?
+++ killed by SIGPIPE +++

During the send/receive, top reports both of them using 90%+ CPU

rsync averages 65MBs

Another subvolume, also one snapshot, has long periods of time (1/2
hour) where the transfer rate is never above 500K/s, but both the
btrfs send and btrfs receive PIDS are pinned at 99%+ CPU.

perf top during high btrfs command CPU consumption and low IO throughput

  34.01%  [kernel]                                [k]
mutex_spin_on_owner
  28.35%  [kernel]                                [k] mutex_unlock
    8.05%  [kernel]                                [k]
mwait_idle_with_hints.constprop.
    5.10%  [kernel]                                [k] mutex_lock

perf top during moderate btrfs command CPU consumption and high IO throughput

 15.16%  [kernel]                                [k]
fuse_perform_write
 10.27%  [kernel]                                [k]
mwait_idle_with_hints.constprop.
   7.97%  [kernel]                                [k] mutex_unlock
   7.35%  [kernel]                                [k]
mutex_spin_on_owner
    5.75%  btrfs                                   [.] __crc32c_le


I suspect many fragments for some files when performance is slow, and
somehow btrfs send is more adversely affected by this than cp or
rsync.

-- 
Chris Murphy
