Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0208199EB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCaTKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 15:10:54 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:38449 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgCaTKx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 15:10:53 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id JMHijXV70jfNYJMHij3qIE; Tue, 31 Mar 2020 21:10:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585681851; bh=ZsCCzO9eQPsrouw3GgzVVNziMaQ+nYT9dT4o2+uXM9E=;
        h=From;
        b=uLBKyIMijvIOJsOOSHegdLK01YAm8ciOQA1YHiJA5TMX4Iqf08qGIcFOs/Ns8+LSM
         y/oLSM+xRPfUe8T6yhNqOsF9UmRnfS/DhMj7eErpLddh7VB/8QqREBmcZhOqBZZE++
         gn5UaPx4uPmO+QjFED3NkftZJyPPKwijwpEp7NMDEnBqXYXKWo4f2785amkRupuFPw
         4yydE21z9nl5hPLTB1V9mM/xWW+1e9bHFzNZEIhgeFsgqqjn9sAcXbUDHHgZ1BkjqI
         pWXTDpxrP9M6s8iCEte9gErC/bP2ovdGRE5Sq7jYfyK8cjwLVcB8ossO5o22sEnezM
         c1/wmzvOxi9mg==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=X8O9t2tcqu8mHWPlI2QA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs-progs: add warning for mixed profiles filesystem
Date:   Tue, 31 Mar 2020 21:10:41 +0200
Message-Id: <20200331191045.8991-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGNfLIHCkLZha9d5dLtr7lsKmMdrqTXWKjPExfzL24rKaiOhP05e2IuAS8mgYOBQ7n/WFTWzKxrs8waBs59DvmAOYl0UHtvoESmNGPjQQbe1Ct9ywePY
 cLjDv3yncj3M9Ojpw+9abitaEJsNntsyg4NKd1KfUm05P03SWVmBiFsz2nN/263Gtak0YnlIkwmU+cJOjI1m034diuKXAAMjSMkBnSmvyyzjDzeYk4lVBC5S
 aZmRcXsAEXEGkExpO602IwiQOH4wqyyKxUhBLsKvrGBP63vQT/gQDlZrjB4/uJhH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hi all,

the aim of this patch set is to issue a warning when a mixed profiles
filesystem is detected. This happens when the filesystems contains
(i.e.) raid1c3 and single chunk for data.

BTRFS has the capability to support a filesystem with mixed profiles.
However this could lead to an unexpected behavior when a new chunk is
allocated (i.e. the chunk profile is not what is wanted). Moreover
if the user is not aware of this, he could assume a redundancy which
doesn't exist (for example because there is some 'single' chunk when
it is expected the filesystem to be full raid1).
A possible cause of a mixed profiles filesystem is an interrupted
balance operation or a not fully balance due to very specific filter.

The check is added to the following btrfs commands:
- btrfs balance pause
- btrfs balance cancel
- btrfs filesystem usage
- btrfs device add

Suggestion about which commands should (not) have this check are 
welcome.

v1 
- first issue
v2 
- add some needed missing pieces about raid1c[34]
- add the check to more btrfs commands

Example of output:

$ sudo ./btrfs fi us /tmp/t/
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
Overall:
    Device size:		  30.00GiB
    Device allocated:		   7.78GiB
    Device unallocated:		  22.22GiB
    Device missing:		     0.00B
    Used:			   1.94GiB
    Free (estimated):		  11.89GiB	(min: 9.77GiB)
    Data ratio:			      2.33
    Metadata ratio:		      1.50
    Global reserve:		   3.25MiB	(used: 0.00B)

Data,single: Size:1.00GiB, Used:973.87MiB (95.10%)

Data,RAID1C3: Size:2.00GiB, Used:178.98MiB (8.74%)

Metadata,single: Size:256.00MiB, Used:94.69MiB (36.99%)

Metadata,RAID1: Size:256.00MiB, Used:188.45MiB (73.61%)

System,single: Size:32.00MiB, Used:16.00KiB (0.05%)

WARNING: ------------------------------------------------------
WARNING: Detection of multiple profiles for a block group type:
WARNING:
WARNING: * DATA ->          [raid1c3, single]
WARNING: * METADATA ->      [raid1, single]
WARNING:
WARNING: Please consider using 'btrfs balance ...' commands set
WARNING: to solve this issue.
WARNING: ------------------------------------------------------


In this case there are two kind of chunks for data (raid1c3 and single)
and metadata (raid1, single).

Patch #1 and #2 are preparatory ones.
Patch #3 contains the code for the check.
Patch #4 adds the check to the command 'btrfs fi us'

Comments are welcome

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5



