Return-Path: <linux-btrfs+bounces-8283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A1B987E01
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 07:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634FE282397
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69B17836E;
	Fri, 27 Sep 2024 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OI5rp1Tv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OI5rp1Tv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0E174EFA
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416431; cv=none; b=a6ujhbEbPebYs1QEc9ZQc5y+0YNhgbZDUcYRDm5X1ET6LXB0nWtyVwTgYODEqr9KUd9Z7/udR0QeoND49bCzBlFbJOpW3fdIv4AXV6jTIyL/5yCB8mfZxQ1UwGysruQCEjoqrKtWFbapMECNZDzv2Xy4sp6Vn59jLO6qnIs9hHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416431; c=relaxed/simple;
	bh=7tIMzyPtXtvqDfYxqOAqQD6OH8r8LDhl/DSh3GvBr4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbBSCa2z1XJ+ZlsWrhwjhggK9dOo4W1N7Rb41PfjYILtVdKPNP9Qr9JtfiYFp0068o3bxS43H58OFABbbl2aSjoWd6bodWX+58VHws9epSEoaagGnjrCGTTwVA3U/f/AlYpf/1rIYhQ+0HtvrcCC5BuDqigcdr6K3az3OxJjbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OI5rp1Tv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OI5rp1Tv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F5481FB59
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727416427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bbPipif40V+AfRZ7jn8unps3KsJ2m5fpMaPoqSgk84=;
	b=OI5rp1Tvg9ieFRF3m9tXa26syOkEJT+PqdwG3SpSyQVSCKKv05BssIw6PFIolnTmTR9R1d
	WOZubbqnvd2CjCBDlvy6jpNLHEUWBwFBDLMajnvVZcJ+C6l9ofbjH1fdViZMZRzmVjWp42
	tTXf8OYX/tvSylU/zjMUstHTwVDQ9Tw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727416427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bbPipif40V+AfRZ7jn8unps3KsJ2m5fpMaPoqSgk84=;
	b=OI5rp1Tvg9ieFRF3m9tXa26syOkEJT+PqdwG3SpSyQVSCKKv05BssIw6PFIolnTmTR9R1d
	WOZubbqnvd2CjCBDlvy6jpNLHEUWBwFBDLMajnvVZcJ+C6l9ofbjH1fdViZMZRzmVjWp42
	tTXf8OYX/tvSylU/zjMUstHTwVDQ9Tw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 694E013A58
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qJ8HC2pI9maDBwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 05:53:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: misc-tests: new test case check the handling of full file clone
Date: Fri, 27 Sep 2024 15:23:25 +0930
Message-ID: <4946daa87f04c8068a9af7bc7d9b7092cb70263f.1727416314.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727416314.git.wqu@suse.com>
References: <cover.1727416314.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The new test case will utilize the following send stream:

Stream 1:

subvol          ./ro_subv1                      uuid=769f87d1-98b2-824f-bf18-9d98178ad2e2 transid=7
chown           ./ro_subv1/                     gid=0 uid=0
chmod           ./ro_subv1/                     mode=755
mkfile          ./ro_subv1/o257-7-0
rename          ./ro_subv1/o257-7-0             dest=./ro_subv1/source
write           ./ro_subv1/source               offset=0 len=4000
chown           ./ro_subv1/source               gid=0 uid=0
chmod           ./ro_subv1/source               mode=600
utimes          ./ro_subv1/source               atime=2024-09-27T13:26:25+0800 mtime=2024-09-27T13:26:25+0800 ctime=2024-09-27T13:26:25+0800
mkfile          ./ro_subv1/o258-7-0
rename          ./ro_subv1/o258-7-0             dest=./ro_subv1/dest
clone           ./ro_subv1/dest                 offset=0 len=4000 from=./ro_subv1/source clone_offset=0
chown           ./ro_subv1/dest                 gid=0 uid=0
chmod           ./ro_subv1/dest                 mode=600
utimes          ./ro_subv1/dest                 atime=2024-09-27T13:26:25+0800 mtime=2024-09-27T13:26:25+0800 ctime=2024-09-27T13:26:25+0800
utimes          ./ro_subv1/                     atime=2024-09-27T13:26:25+0800 mtime=2024-09-27T13:26:25+0800 ctime=2024-09-27T13:26:25+0800

Stream 2:

snapshot        ./ro_snap1                      uuid=e78c9b7c-1bea-fc48-aaf3-6a4d98eba473 transid=9 parent_uuid=769f87d1-98b2-824f-bf18-9d98178ad2e2 parent_transid=7
write           ./ro_snap1/source               offset=0 len=3900
truncate        ./ro_snap1/source               size=3900
utimes          ./ro_snap1/source               atime=2024-09-27T13:26:25+0800 mtime=2024-09-27T13:26:25+0800 ctime=2024-09-27T13:26:25+0800
clone           ./ro_snap1/dest                 offset=0 len=3900 from=./ro_snap1/source clone_offset=0
truncate        ./ro_snap1/dest                 size=3900
utimes          ./ro_snap1/dest                 atime=2024-09-27T13:26:25+0800 mtime=2024-09-27T13:26:25+0800 ctime=2024-09-27T13:26:25+0800

The stream is generated using v6.11 kernel, as upstream commit
46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if it ends
at i_size") allows full file clone to further reduce the stream size.

Verify that "btrfs receive" command has the proper workaround to handle
such full file clone correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../ro_snap1.stream.zst                       | Bin 0 -> 293 bytes
 .../ro_subv1.stream.zst                       | Bin 0 -> 413 bytes
 .../066-receive-full-file-clone/test.sh       |  24 ++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 tests/misc-tests/066-receive-full-file-clone/ro_snap1.stream.zst
 create mode 100644 tests/misc-tests/066-receive-full-file-clone/ro_subv1.stream.zst
 create mode 100755 tests/misc-tests/066-receive-full-file-clone/test.sh

diff --git a/tests/misc-tests/066-receive-full-file-clone/ro_snap1.stream.zst b/tests/misc-tests/066-receive-full-file-clone/ro_snap1.stream.zst
new file mode 100644
index 0000000000000000000000000000000000000000..e190b6ca7f050ae16ed11a6b278658fdea5c9adb
GIT binary patch
literal 293
zcmdPcs{c3TEB{^&1{2<-lA^R?-Qtp>)Wlo{Mg|53A0TF8@Z107AU^{KLs5Qwab9A9
zAtQqT!}FfmHPWyCc&z%I<vZi`l42&HJST$)P^N5t`^6cXn*8@m%$*_Lb?K2PP==i$
zjGuvlpTV_b)mnZAHiqK-(xT*4A)t&fgAM<GF`zYq47Z-7Okn{E+3;Hd`63Jx^d!G>
zGw?7lI(<vq7xY+w%T8>q5N8-rPJkiab{?|?KLZOxN@{V5h^Uyjh-*u5sKt8Y^aYtb
zo`U<<xC)Ch1mv8YE5(q*F+-B!fZ&6S3=57fj&<5n{N4hxZ{vj9WPJn^?nvw?$u!7&
luh{Nz-PpJJK>IC@9;31yigTFPGv;#`@UaQ7R&Bgf1OO`|ST_Iw

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/066-receive-full-file-clone/ro_subv1.stream.zst b/tests/misc-tests/066-receive-full-file-clone/ro_subv1.stream.zst
new file mode 100644
index 0000000000000000000000000000000000000000..f70aeebb7cf5161d0fe3db25496ed29d7e12430b
GIT binary patch
literal 413
zcmdPcs{c2oU$B;k;fO#|Nl{v{ZgELbYGN(}BLf424iGak?0Y}=5kCV5Ls5QwacNSS
zAtQqTL)rZHi!(Mg`R|vQJ43wd(jz9IJUfF7P`xk%leumWKaj-+5)%M2gcu@2OHEmU
z+_#JpKt3}=PTp<id?QnHU2|OnW}rBu7*Lp#VF$n976G8X;{4L0<kVe2L--jU-1uw9
zFC@&cfd8ygns{>;o7n1Ov5On5fEq*?9+uT#<7VJtV08MHwlC<h02gO*tMN7qCK26Z
zc|H~_3@NF_C1F670t{dNZ~H9)v}pl@h^Uyj!f9o>RU#b+y}w&Hi9A=x<na_V`PE^n
zCo;2EK$IaM=j2=qg#%0zHH9Ygg)k?~VLH~Z+O6<c#9@gx)^mZUEjff<?wbDjg36^*
zL;gdX+>I62Nw&%AE-Fmkc;syI)(Z(Njvq`8$w)j}^0w@aaM=`2gBkD6UE5N#Bd{{m
zLHgd(?cZ4{6N>xaFIDk)`_$&`*ZC*p-p(s${q$V-*Ay0JxnfmCi8PV8k2@{_07?#w
AHUIzs

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/066-receive-full-file-clone/test.sh b/tests/misc-tests/066-receive-full-file-clone/test.sh
new file mode 100755
index 000000000000..63fa922a5600
--- /dev/null
+++ b/tests/misc-tests/066-receive-full-file-clone/test.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# Verify "btrfs-receive" can handle a full file clone (clone length is not
+# aligned but matches inode size) into a larger destination file.
+#
+# Such clone stream can be generated since kernel commit 46a6e10a1ab1
+# ("btrfs: send: allow cloning non-aligned extent if it ends at i_size").
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+tmp=$(_mktemp "receive-full-file-clone")
+
+setup_root_helper
+prepare_test_dev
+check_global_prereq zstd
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+run_check zstd -d -f ./ro_subv1.stream.zst -o "$tmp"
+run_check "$TOP/btrfs" receive -f "$tmp" "$TEST_MNT"
+run_check zstd -d -f ./ro_snap1.stream.zst -o "$tmp"
+run_check "$TOP/btrfs" receive -f "$tmp" "$TEST_MNT"
+run_check_umount_test_dev
+rm -f -- "$tmp"
-- 
2.46.1


