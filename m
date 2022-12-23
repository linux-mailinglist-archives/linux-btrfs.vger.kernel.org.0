Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C7654B6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Dec 2022 03:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiLWC5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Dec 2022 21:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiLWC5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Dec 2022 21:57:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515592B63D;
        Thu, 22 Dec 2022 18:57:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7213B255A6;
        Fri, 23 Dec 2022 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671764220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VmjwX/LYjcWyamL0EuTMi3M5g6zZR+Ov2Nf/jgOc8KY=;
        b=uUzDrKKa7YRkIZCghXRltIT7NsCtokwVcYvNOmWKNTT5ueRmzNtkYhTiH2mTRAAvwV351C
        XLPXXTABNBEjmComf12s9rG5To9xZglP65F/I5/WkWZV9hlP6KBcZ59WI60OB+6x0Ky212
        cVlpgxY6ehw5uLHLjK2NlvH4wEEnnXQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E1AB138E0;
        Fri, 23 Dec 2022 02:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ir3KFfsYpWOBXAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 23 Dec 2022 02:56:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs/154: migrate to python3
Date:   Fri, 23 Dec 2022 10:56:42 +0800
Message-Id: <20221223025642.33496-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test case btrfs/154 is still using python2 script, which is already EOL.
Some rolling distros like Archlinux is no longer providing python2
package anymore.

This means btrfs/154 will be harder and harder to run.

To fix the problem, migreate the python script to python3, this involves
the following changes:

- Change common/config to use python3
- Strong type conversion between string and bytes
  This means, anything involved in the forged bytes has to be bytes.

  And there is no safe way to convert forged bytes into string, unlike
  python2.
  I guess that's why the author went python2 in the first place.

  Thankfully os.rename() still accepts forged bytes.

- Use bytes specific checks for invalid chars.

The updated script can still cause the needed conflicts, can be verified
through "btrfs ins dump-tree" command.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/config                   |  2 +-
 src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
 tests/btrfs/154                 |  4 ++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/common/config b/common/config
index b2802e5e..e2aba5a9 100644
--- a/common/config
+++ b/common/config
@@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
 export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
 export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
 export THIN_CHECK_PROG="$(type -P thin_check)"
-export PYTHON2_PROG="$(type -P python2)"
+export PYTHON3_PROG="$(type -P python3)"
 export SQLITE3_PROG="$(type -P sqlite3)"
 export TIMEOUT_PROG="$(type -P timeout)"
 export SETCAP_PROG="$(type -P setcap)"
diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
index 6c08fcb7..d29bbb70 100755
--- a/src/btrfs_crc32c_forged_name.py
+++ b/src/btrfs_crc32c_forged_name.py
@@ -59,9 +59,10 @@ class CRC32(object):
     # deduce the 4 bytes we need to insert
     for c in struct.pack('<L',fwd_crc)[::-1]:
       bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
-      bkd_crc ^= ord(c)
+      bkd_crc ^= c
 
-    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
+    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
+          bytes(s[pos:], 'ascii')
     return res
 
   def parse_args(self):
@@ -72,6 +73,12 @@ class CRC32(object):
                         help="number of forged names to create")
     return parser.parse_args()
 
+def has_invalid_chars(result: bytes):
+    for i in result:
+        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
+            return True
+    return False
+
 if __name__=='__main__':
 
   crc = CRC32()
@@ -80,12 +87,15 @@ if __name__=='__main__':
   args = crc.parse_args()
   dirpath=args.dir
   while count < args.count :
-    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
+    origname = os.urandom (89).hex()[:-1].strip ("\x00")
     forgename = crc.forge(wanted_crc, origname, 4)
-    if ("/" not in forgename) and ("\x00" not in forgename):
+    if not has_invalid_chars(forgename):
       srcpath=dirpath + '/' + str(count)
-      dstpath=dirpath + '/' + forgename
-      file (srcpath, 'a').close()
+      # We have to convert all strings to bytes to concatenate the forged
+      # name (bytes).
+      # Thankfully os.rename() can accept bytes directly.
+      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
+      open(srcpath, mode="a").close()
       os.rename(srcpath, dstpath)
       os.system('btrfs fi sync %s' % (dirpath))
       count+=1;
diff --git a/tests/btrfs/154 b/tests/btrfs/154
index 240c504c..6be2d5f6 100755
--- a/tests/btrfs/154
+++ b/tests/btrfs/154
@@ -21,7 +21,7 @@ _begin_fstest auto quick
 
 _supported_fs btrfs
 _require_scratch
-_require_command $PYTHON2_PROG python2
+_require_command $PYTHON3_PROG python3
 
 # Currently in btrfs the node/leaf size can not be smaller than the page
 # size (but it can be greater than the page size). So use the largest
@@ -42,7 +42,7 @@ _scratch_mount
 #    ...
 #
 
-$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
+$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
 echo "Silence is golden"
 
 # success, all done
-- 
2.39.0

