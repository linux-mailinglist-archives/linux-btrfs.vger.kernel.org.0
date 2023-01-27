Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D967DD2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjA0Flr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjA0Flo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:41:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526570D54
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 21:41:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DEE9121C87
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674798099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BtTcAzT3Bx1Aey+gPaJ3QfhiAdPXlz0K9FmIsvMCLo=;
        b=WnaZGIz3nbzhIVZ1tSOGU5/qKstxxWXzF1/ONQXgDyS6b5dnvZ19/7v7Jp3cHupNiC717o
        wZOaZoL6/S86Pfe+6f7JBoDsWcK8BYBLM1kocgcxbCSu8JfNU1OCuwx7UZfnq0BVEhC2Tm
        MIUfcemmYAqlNM7Wvj6QYCPWsfV9bB4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E462134F5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHGaAhNk02OnLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: fix fallthrough cases with proper attributes
Date:   Fri, 27 Jan 2023 13:41:16 +0800
Message-Id: <56794e8e6e0717c5fc981cfb3a96e4b1b5180818.1674797823.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
References: <cover.1674797823.git.wqu@suse.com>
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

[FALSE ALERT]
Unlike gcc, clang doesn't really understand the comments, thus it's
reportings tons of fall through related errors:

  cmds/reflink.c:124:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                  case 'r':
                  ^
  cmds/reflink.c:124:3: note: insert '__attribute__((fallthrough));' to silence this warning
                  case 'r':
                  ^
                  __attribute__((fallthrough));
  cmds/reflink.c:124:3: note: insert 'break;' to avoid fall-through
                  case 'r':
                  ^
                  break;

[CAUSE]
Although gcc is fine with /* fallthrough */ comments, clang is not.

[FIX]
So just introduce a fallthrough macro to handle the situation properly,
and use that macro instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/reflink.c             |  2 +-
 cmds/scrub.c               | 10 +++---
 common/format-output.c     |  2 +-
 common/parse-utils.c       | 12 +++----
 common/units.c             |  6 ++--
 crypto/xxhash.c            | 73 +++++++++++++++++++-------------------
 image/main.c               |  2 +-
 kerncompat.h               |  8 +++++
 kernel-shared/print-tree.c |  2 +-
 9 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/cmds/reflink.c b/cmds/reflink.c
index 5ed9a12770e2..53f4784838c1 100644
--- a/cmds/reflink.c
+++ b/cmds/reflink.c
@@ -120,7 +120,7 @@ static int cmd_reflink_clone(const struct cmd_struct *cmd, int argc, char **argv
 		switch (c) {
 		case 's':
 			same_file = true;
-			/* fallthrough */
+			fallthrough;
 		case 'r':
 			range = malloc(sizeof(struct reflink_range));
 			if (!range) {
diff --git a/cmds/scrub.c b/cmds/scrub.c
index e6513b39f2bf..782a1310816b 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -602,7 +602,7 @@ again:
 			memset(p[curr], 0, sizeof(**p));
 			p[curr + 1] = NULL;
 			++state;
-			/* fall through */
+			fallthrough;
 		case 2: /* start of line, skip space */
 			while (isspace(l[i]) && i < avail) {
 				if (l[i] == '\n')
@@ -613,7 +613,7 @@ again:
 			    (!eof && !memchr(l + i, '\n', avail - i)))
 				goto again;
 			++state;
-			/* fall through */
+			fallthrough;
 		case 3: /* read fsid */
 			if (i == avail)
 				continue;
@@ -629,7 +629,7 @@ again:
 				_SCRUB_INVALID;
 			i += j + 1;
 			++state;
-			/* fall through */
+			fallthrough;
 		case 4: /* read dev id */
 			for (j = 0; isdigit(l[i + j]) && i+j < avail; ++j)
 				;
@@ -638,7 +638,7 @@ again:
 			p[curr]->devid = atoll(&l[i]);
 			i += j + 1;
 			++state;
-			/* fall through */
+			fallthrough;
 		case 5: /* read key/value pair */
 			ret = 0;
 			_SCRUB_KVREAD(ret, &i, data_extents_scrubbed, avail, l,
@@ -682,7 +682,7 @@ again:
 			if (ret != 1)
 				_SCRUB_INVALID;
 			++state;
-			/* fall through */
+			fallthrough;
 		case 6: /* after number */
 			if (l[i] == '|')
 				state = 5;
diff --git a/common/format-output.c b/common/format-output.c
index c7e021b58f2c..18993ad66636 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -74,7 +74,7 @@ static void print_escaped(const char *str)
 		case '"':
 		case '\\':
 			putchar('\\');
-			/* fallthrough */
+			fallthrough;
 		default:
 			putchar(*str);
 		}
diff --git a/common/parse-utils.c b/common/parse-utils.c
index f16b7aac1b3b..bb3c2bbf366a 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -184,22 +184,22 @@ u64 parse_size_from_string(const char *s)
 		switch (c) {
 		case 'e':
 			mult *= 1024;
-			/* fallthrough */
+			fallthrough;
 		case 'p':
 			mult *= 1024;
-			/* fallthrough */
+			fallthrough;
 		case 't':
 			mult *= 1024;
-			/* fallthrough */
+			fallthrough;
 		case 'g':
 			mult *= 1024;
-			/* fallthrough */
+			fallthrough;
 		case 'm':
 			mult *= 1024;
-			/* fallthrough */
+			fallthrough;
 		case 'k':
 			mult *= 1024;
-			/* fallthrough */
+			fallthrough;
 		case 'b':
 			break;
 		default:
diff --git a/common/units.c b/common/units.c
index 698dc1d0508e..8d708cddc03e 100644
--- a/common/units.c
+++ b/common/units.c
@@ -89,15 +89,15 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
 	case UNITS_TBYTES:
 		base *= mult;
 		num_divs++;
-		/* fallthrough */
+		fallthrough;
 	case UNITS_GBYTES:
 		base *= mult;
 		num_divs++;
-		/* fallthrough */
+		fallthrough;
 	case UNITS_MBYTES:
 		base *= mult;
 		num_divs++;
-		/* fallthrough */
+		fallthrough;
 	case UNITS_KBYTES:
 		num_divs++;
 		break;
diff --git a/crypto/xxhash.c b/crypto/xxhash.c
index c2f1be9f7449..7f7f3f74328c 100644
--- a/crypto/xxhash.c
+++ b/crypto/xxhash.c
@@ -116,6 +116,7 @@ static void* XXH_memcpy(void* dest, const void* src, size_t size) { return memcp
 #define XXH_STATIC_LINKING_ONLY
 #include "xxhash.h"
 
+#include "kerncompat.h"
 
 /* *************************************
 *  Compiler Specific Options
@@ -397,41 +398,41 @@ XXH32_finalize(U32 h32, const void* ptr, size_t len, XXH_alignment align)
     } else {
          switch(len&15) /* or switch(bEnd - p) */ {
            case 12:      PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 8:       PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 4:       PROCESS4;
                          return XXH32_avalanche(h32);
 
            case 13:      PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 9:       PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 5:       PROCESS4;
                          PROCESS1;
                          return XXH32_avalanche(h32);
 
            case 14:      PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 10:      PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 6:       PROCESS4;
                          PROCESS1;
                          PROCESS1;
                          return XXH32_avalanche(h32);
 
            case 15:      PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 11:      PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 7:       PROCESS4;
-                         /* fallthrough */
+			 fallthrough;
            case 3:       PROCESS1;
-                         /* fallthrough */
+			 fallthrough;
            case 2:       PROCESS1;
-                         /* fallthrough */
+			 fallthrough;
            case 1:       PROCESS1;
-                         /* fallthrough */
+			 fallthrough;
            case 0:       return XXH32_avalanche(h32);
         }
         XXH_ASSERT(0);
@@ -825,63 +826,63 @@ XXH64_finalize(U64 h64, const void* ptr, size_t len, XXH_alignment align)
     } else {
         switch(len & 31) {
            case 24: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 16: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case  8: PROCESS8_64;
                     return XXH64_avalanche(h64);
 
            case 28: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 20: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 12: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case  4: PROCESS4_64;
                     return XXH64_avalanche(h64);
 
            case 25: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 17: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case  9: PROCESS8_64;
                     PROCESS1_64;
                     return XXH64_avalanche(h64);
 
            case 29: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 21: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 13: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case  5: PROCESS4_64;
                     PROCESS1_64;
                     return XXH64_avalanche(h64);
 
            case 26: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 18: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 10: PROCESS8_64;
                     PROCESS1_64;
                     PROCESS1_64;
                     return XXH64_avalanche(h64);
 
            case 30: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 22: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 14: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case  6: PROCESS4_64;
                     PROCESS1_64;
                     PROCESS1_64;
                     return XXH64_avalanche(h64);
 
            case 27: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 19: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 11: PROCESS8_64;
                     PROCESS1_64;
                     PROCESS1_64;
@@ -889,19 +890,19 @@ XXH64_finalize(U64 h64, const void* ptr, size_t len, XXH_alignment align)
                     return XXH64_avalanche(h64);
 
            case 31: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 23: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case 15: PROCESS8_64;
-                         /* fallthrough */
+		    fallthrough;
            case  7: PROCESS4_64;
-                         /* fallthrough */
+		    fallthrough;
            case  3: PROCESS1_64;
-                         /* fallthrough */
+		    fallthrough;
            case  2: PROCESS1_64;
-                         /* fallthrough */
+		    fallthrough;
            case  1: PROCESS1_64;
-                         /* fallthrough */
+		    fallthrough;
            case  0: return XXH64_avalanche(h64);
         }
     }
diff --git a/image/main.c b/image/main.c
index 8900297ebe1a..ecf464e5b0a2 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1431,7 +1431,7 @@ static int restore_one_work(struct mdrestore_struct *mdres,
 			switch (ret) {
 			case Z_NEED_DICT:
 				ret = Z_DATA_ERROR;
-				__attribute__ ((fallthrough));
+				fallthrough;
 			case Z_DATA_ERROR:
 			case Z_MEM_ERROR:
 				goto out;
diff --git a/kerncompat.h b/kerncompat.h
index 6fb79ac88351..74383ed9ff6c 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -227,6 +227,14 @@ static inline int mutex_is_locked(struct mutex *m)
 #define __attribute_const__	__attribute__((__const__))
 #endif
 
+/* To silent compilers like clang which doesn't understand comments. */
+
+#if __has_attribute(__fallthrough__)
+# define fallthrough			__attribute__((__fallthrough__))
+#else
+# define fallthrough			do {} while (0)  /* fallthrough */
+#endif
+
 /**
  * __set_bit - Set a bit in memory
  * @nr: the bit to set
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index ba1caa88fcf1..534166283997 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -796,7 +796,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 			fprintf(stream, "FIRST_CHUNK_TREE");
 			break;
 		}
-		/* fall-thru */
+		fallthrough;
 	default:
 		fprintf(stream, "%llu", (unsigned long long)objectid);
 	}
-- 
2.39.1

