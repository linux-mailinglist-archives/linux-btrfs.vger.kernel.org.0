Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6914778360E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 01:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjHUXBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjHUXBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 19:01:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACD130;
        Mon, 21 Aug 2023 16:01:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2360C22C36;
        Mon, 21 Aug 2023 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692658894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OrjdQp+w39LZyeG75apvjbB7hVZKgPU2qQY+SL5MUbM=;
        b=DWnhAxoI/1WaosEOpiMXsKUrpsVDWIdIy5f6wqg1wAB5LHqDWdKq4IgMndHmvQ6rI80iFP
        cFj6OqbSP/VoMfUmlph5b/Uikiwf8fGmiJSZlIfbYjGnfqOrceFQfW9mWziwsRSfGl+iWy
        i5y1fjDXYiDvqvQnmKE7q5muUl71G7k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27AF21330D;
        Mon, 21 Aug 2023 23:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PMz5Oczs42QCQQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 21 Aug 2023 23:01:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: [PATCH v2] fstests: fsstress: wait interrupted aio to finish
Date:   Tue, 22 Aug 2023 07:01:29 +0800
Message-ID: <20230821230129.31723-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a very low chance to hit data csum mismatch (caught by scrub)
during test case btrfs/06[234567].

After some extra digging, it turns out that plain fsstress itself is
enough to cause the problem:

```
workload()
{
	mkfs.btrfs -f -m single -d single --csum sha256 $dev1 > /dev/null
	mount $dev1 $mnt

	#$fsstress -p 10 -n 1000 -w -d $mnt
	umount $mnt
	btrfs check --check-data-csum $dev1 || fail
}

runtime=1024
for (( i = 0; i < $runtime; i++ )); do
	echo "=== $i / $runtime ==="
	workload
done
```

Inside a VM which has only 6 cores, above script can trigger with 1/20
possibility.

[CAUSE]
Locally I got a much smaller workload to reproduce:

	$fsstress -p 7 -n 50 -s 1691396493 -w -d $mnt -v > /tmp/fsstress

With extra kernel trace_prinkt() on the buffered/direct writes.

It turns out that the following direct write is always the cause:

  btrfs_do_write_iter: r/i=5/283 buffered fileoff=708608(709121) len=12288(7712)

  btrfs_do_write_iter: r/i=5/283 direct fileoff=8192(8192) len=73728(73728) <<<<<

  btrfs_do_write_iter: r/i=5/283 direct fileoff=589824(589824) len=16384(16384)

With the involved byte number, it's easy to pin down the fsstress
opeartion:

 0/31: writev d0/f3[285 2 0 0 296 1457078] [709121,8,964] 0
 0/32: chown d0/f2 308134/1763236 0

 0/33: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) d0/f2[285 2 308134 1763236 320 1457078] return 25, fallback to stat()
 0/33: awrite - io_getevents failed -4 <<<<

 0/34: dwrite - xfsctl(XFS_IOC_DIOINFO) d0/f3[285 2 308134 1763236 320 1457078] return 25, fallback to stat()

Note the 0/33, when the data csum mismatch triggered, it always fail
with -4 (-EINTR).

It looks like with lucky enough concurrency, we can get to the following
situation inside fsstress:

          Process A                 |               Process B
 -----------------------------------+---------------------------------------
 do_aio_rw()                        |
 |- io_sumit();                     |
 |- io_get_events();                |
 |  Returned -EINTR, but IO hasn't  |
 |  finished.                       |
 `- free(buf);                      | malloc();
                                    |  Got the same memory of @buf from
                                    |  thread A.
                                    | Modify the memory
                                    | Now the buffer is changed while
                                    | still under IO

This is the typical buffer modification during direct IO, which is going
to cause csum mismatch for btrfs, and btrfs properly detects it.

This is the direct cause of the problem.

The root cause is that, io_uring would use signals to handle
submission/completion of IOs.
Thus io_uring operations would interrupt AIO operations, thus causing
the above problem.

[FIX]
To fix the problem, we can just retry io_getevents() so that we can
properly wait for the IO.

This prevents us to modify the IO buffer before writeback really
finishes.

With this fixes, I can no longer reproduce the data corruption.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix all call sites of io_getevents()
- Update the commit message to show the root cause
  Thanks a lot to Jens Axboe for pointing out the root problem.
---
 ltp/fsstress.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 6641a525..abe28742 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2072,6 +2072,22 @@ void inode_info(char *str, size_t sz, struct stat64 *s, int verbose)
 			 (long long) s->st_blocks, (long long) s->st_size);
 }
 
+#ifdef AIO
+static int io_get_single_event(struct io_event *event)
+{
+	int ret;
+
+	/*
+	 * We can get -EINTR if competing with io_uring using signal
+	 * based notifications. For that case, just retry the wait.
+	 */
+	do {
+		ret = io_getevents(io_ctx, 1, 1, event, NULL);
+	} while (ret == -EINTR);
+	return ret;
+}
+#endif
+
 void
 afsync_f(opnum_t opno, long r)
 {
@@ -2111,7 +2127,7 @@ afsync_f(opnum_t opno, long r)
 		close(fd);
 		return;
 	}
-	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
+	if ((e = io_get_single_event(&event)) != 1) {
 		if (v)
 			printf("%d/%lld: afsync - io_getevents failed %d\n",
 			       procid, opno, e);
@@ -2223,7 +2239,7 @@ do_aio_rw(opnum_t opno, long r, int flags)
 			       procid, opno, iswrite ? "awrite" : "aread", e);
 		goto aio_out;
 	}
-	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
+	if ((e = io_get_single_event(&event)) != 1) {
 		if (v)
 			printf("%d/%lld: %s - io_getevents failed %d\n",
 			       procid, opno, iswrite ? "awrite" : "aread", e);
-- 
2.41.0

