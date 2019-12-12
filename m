Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9240611C583
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 06:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLLFiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 00:38:05 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23041 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfLLFiF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 00:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576129084; x=1607665084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axl2360cB3kSpFIcxqHsLa9NUIBKsFL1Mip/esEaRvs=;
  b=m9lJmZVo86pZccQxnI6YK6DAeWZBpL2cblVEvRjQNABy9s/qamigCoqC
   Q0ibLE0YtZww9zKjlU/ylgf3iIGnFwNZfj/q1JwcnMo6Yr1nOEkfhy0lQ
   qgflaaRl2QhhSmuW2ZqztEZMyPYQX5AYf4cKH/mmfgyuzeQ+vxbHYGbzF
   mvQLxcE5yDfquB6OC7X54MMx7fEt75pS+YaaQ3Lay2uhv3j9erz+olqmg
   jKB5LWiwsHU+pUQ+I7zx7Sfe0vgNMUPznbGWFBSWr46QMT88pJVGmIu0q
   G0LQ2KCjrU10Bej0/WYz59sD2OhX+uiQ/3E15yzdt1GAdDllVyW1SU7ji
   g==;
IronPort-SDR: YaKmXtaUlC65dMq9z551ZQdYQmVQ4+5kKlsXWmHHrhZwSARLAoT9MH7/ZxcNnnY4hW9Jo5IxKy
 H/bCdV35muJwJ9NCMXyizF+se/3wnahgNht+Q/Lvts1NbReHQwq/PsScR+y9eVGzig/4B9Id+Q
 fVjK0vtN8YbnlsofyHFFyaeVMLtA3cdMq12vqLLR+80RtL0e6Md28Zw5z04Th9DNJiSPNYw+oB
 dowGnNw0G8xVakvEmfctRL8Uvr7a1msU2V55BpP3HBlhRJ256gGcvClZg6/vjVCpJrvlca8tfB
 ObU=
X-IronPort-AV: E=Sophos;i="5.69,304,1571673600"; 
   d="scan'208";a="126777885"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2019 13:37:52 +0800
IronPort-SDR: TBLl/p8qxDttEgUP205fo6Ov60Sh0nCQ/IYGjUj7y5pjxmkaB7fkvwEvNTUJdpGBSfv1ksK5Yc
 DEvZ63hZVbJF/nTgV8CAXL5wku4yjFmvQj4JaQw/vDLQqGKo3+aBhIUOZJJF0kIbg9v8Co0vSf
 3XpFJMVMuqn0Bbl97iKjJngNT0NDdCjiR7nfpAzUKVOrU22MMXxFBZSTpOEh4hXOyIU0QkAeht
 MshSatz/zOCr5dfJ/s0cCgAd2WfpZSb8mK6f2lZdyc3Q6COrzTYr+UIgGUm2VNqe/guZQ8wUel
 bQQVDrTv5WlvtUqmc9L+M0WH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 21:32:05 -0800
IronPort-SDR: Yf7lw4ZNfoOWJuaQmnciqVCN2Y2cf31wYjkupjD06FpX0f8gq+sqEdLVF8Iyra3hX8jCSdYEPs
 HGS6tqnCFGyjJWa7gedi1orcm2n+PTtePYyCxcZOpZ38xTe41GhNW3J+fNQhemiEEzQ1f4Um/u
 24AajtJhuHsxczL3hY7EwShvnNk5x7F1WdgmDNLH66FSf+YiUUXDKbxKXp0OxCVx1zxJMx02Wu
 /EBxtLBmrzZbaWLOW0jddz1zJrJpFnTvKEq+HeZzwP9kUxOeBKyW7KHmAcVJFSzlq9bN5/ZVCU
 uzQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 11 Dec 2019 21:37:52 -0800
Received: (nullmailer pid 2050815 invoked by uid 1000);
        Thu, 12 Dec 2019 05:37:50 -0000
Date:   Thu, 12 Dec 2019 14:37:50 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] fstests: btrfs/09[58]: Use hash to replace unreliable od
 output
Message-ID: <20191212053750.vxikimln5pjbaaot@naota.dhcp.fujisawa.hgst.com>
References: <20191212053034.21995-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191212053034.21995-1-wqu@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 01:30:34PM +0800, Qu Wenruo wrote:
>[BUG]
>With latest master, btrfs/09[58] fails like:
>
>  btrfs/095 2s ... - output mismatch (see xfstests-dev/results//btrfs/095.out.bad)
>      --- tests/btrfs/095.out     2019-12-12 13:23:24.266697540 +0800
>      +++ xfstests-dev/results//btrfs/095.out.bad      2019-12-12 13:23:29.340030879 +0800
>      @@ -4,32 +4,32 @@
>       File contents before power failure:
>       0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       *
>      -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>      +771 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>       *
>      -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>      ...
>      (Run 'diff -u xfstests-dev/tests/btrfs/095.out xfstests-dev/results//btrfs/095.out.bad'  to see the entire diff)
>  btrfs/098 2s ... - output mismatch (see xfstests-dev/results//btrfs/098.out.bad)
>      --- tests/btrfs/098.out     2019-12-12 13:23:24.266697540 +0800
>      +++ xfstests-dev/results//btrfs/098.out.bad      2019-12-12 13:23:31.306697545 +0800
>      @@ -3,20 +3,20 @@
>       File contents before power failure:
>       0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       *
>      -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>      +537 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>       *
>      -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      ...
>      (Run 'diff -u xfstests-dev/tests/btrfs/098.out xfstests-dev/results//btrfs/098.out.bad'  to see the entire diff)
>  Ran: btrfs/095 btrfs/098
>  Failures: btrfs/095 btrfs/098
>  Failed 2 of 2 tests
>
>[CAUSE]
>It looks like commit 37520a314bd4 ("fstests: Don't use gawk's strtonum")
>is making _filter_od doing stupid filtering.

I sent a fix to the list. That commit is parsing od's offsets as decimal
which actually is octal.

https://lore.kernel.org/fstests/20191212031152.1906287-1-naohiro.aota@wdc.com/T/#u

>[FIX]
>Personally speaking, I don't really care about whatever _filter_od is
>doing at all.
>And since these two test cases only care about the content, let's use
>hash to replace unreliable _filter_od output.
>While move the filtered (and meaningless) od output to $seqres.full.

I think using hash break the tests on non-4k blocks.

Actually, they both once used hash, but changed to use od with commit
55144172825f ("btrfs/095: work on non-4k block sized filesystems") and
commit 2099e00681dd ("btrfs/098: work on non-4k block sized filesystems").

>
>Reported-by: Nikolay Borisov <nborisov@suse.com>
>Signed-off-by: Qu Wenruo <wqu@suse.com>
>---
> tests/btrfs/095     | 13 +++++++++----
> tests/btrfs/095.out | 36 ++++--------------------------------
> tests/btrfs/098     | 14 ++++++++++----
> tests/btrfs/098.out | 24 ++++--------------------
> 4 files changed, 27 insertions(+), 60 deletions(-)
>
>diff --git a/tests/btrfs/095 b/tests/btrfs/095
>index 4c810a5d..4b381a9e 100755
>--- a/tests/btrfs/095
>+++ b/tests/btrfs/095
>@@ -122,8 +122,10 @@ $CLONER_PROG -s $((768 * $BLOCK_SIZE)) -d $((150 * $BLOCK_SIZE)) -l $((25 * $BLO
> # fsync and before the next transaction commit.
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>
>-echo "File contents before power failure:"
>-od -t x1 $SCRATCH_MNT/foo | _filter_od
>+echo "File hash before power failure:"
>+_md5_checksum $SCRATCH_MNT/foo
>+echo "File contens before power failure:" >> $seqres.full
>+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
> # During log replay, the btrfs delayed references implementation used to run the
> # deletion of back references before the addition of new back references, which
>@@ -135,8 +137,11 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
> # failure of the insertion that ended up turning the fs into read-only mode.
> _flakey_drop_and_remount
>
>-echo "File contents after log replay:"
>-od -t x1 $SCRATCH_MNT/foo | _filter_od
>+echo "File hash after log replay:"
>+_md5_checksum $SCRATCH_MNT/foo
>+
>+echo "File contents after log replay:" >> $seqres.full
>+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
> _unmount_flakey
>
>diff --git a/tests/btrfs/095.out b/tests/btrfs/095.out
>index e73b24d5..5c3ec951 100644
>--- a/tests/btrfs/095.out
>+++ b/tests/btrfs/095.out
>@@ -1,35 +1,7 @@
> QA output created by 095
> Blocks modified: [135 - 164]
> Blocks modified: [768 - 792]
>-File contents before power failure:
>-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>-*
>-257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>-*
>-1431
>-File contents after log replay:
>-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>-*
>-257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>-*
>-1431
>+File hash before power failure:
>+beaf47c36659ac29bb9363fb8ffa10a1
>+File hash after log replay:
>+beaf47c36659ac29bb9363fb8ffa10a1
>diff --git a/tests/btrfs/098 b/tests/btrfs/098
>index 0e0b5123..e42e3146 100755
>--- a/tests/btrfs/098
>+++ b/tests/btrfs/098
>@@ -69,8 +69,11 @@ $CLONER_PROG -s $(((200 * $BLOCK_SIZE) + (5 * $BLOCK_SIZE))) \
> # first fsync we did before.
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>
>-echo "File contents before power failure:"
>-od -t x1 $SCRATCH_MNT/foo | _filter_od
>+
>+echo "File hash before power failure:"
>+_md5_checksum $SCRATCH_MNT/foo
>+echo "File contents before power failure:" >> $seqres.full
>+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
> # The fsync log replay first processes the file extent item corresponding to the
> # file offset mapped by 100th block (the one which refers to the [5, 10[ block
>@@ -95,10 +98,13 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
> #
> _flakey_drop_and_remount
>
>-echo "File contents after log replay:"
> # Must match the file contents we had after cloning the extent and before
> # the power failure happened.
>-od -t x1 $SCRATCH_MNT/foo | _filter_od
>+echo "File hash after log replay:"
>+_md5_checksum $SCRATCH_MNT/foo
>+
>+echo "File contents after log replay:" >> $seqres.full
>+od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
> _unmount_flakey
>
>diff --git a/tests/btrfs/098.out b/tests/btrfs/098.out
>index 98a96dec..e3db64a0 100644
>--- a/tests/btrfs/098.out
>+++ b/tests/btrfs/098.out
>@@ -1,22 +1,6 @@
> QA output created by 098
> Blocks modified: [200 - 224]
>-File contents before power failure:
>-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-341
>-File contents after log replay:
>-0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>-*
>-310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>-*
>-341
>+File hash before power failure:
>+39b386375971248740ed8651d5a2ed9f
>+File hash after log replay:
>+39b386375971248740ed8651d5a2ed9f
>-- 
>2.23.0
>
