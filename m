Return-Path: <linux-btrfs+bounces-3038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F49873A0C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5580B2465E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F4134CCC;
	Wed,  6 Mar 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sONVMWFr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239587F7FA;
	Wed,  6 Mar 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737335; cv=none; b=a9v3wYzTF4M/ZPPKezY2CDYeHof0lx+kS95n6fk1xRweXJMKkyk66C6JnaTVgl+9P06mtgrPayVZLI/waC1qk9UcCdro9d/2bpj6tjnQeezMF5JN2jqf/Q6Rm8odGDcaif67FnYmt7VPVE2ooWIi/oTJDx+dmBwPbUbs0KxTjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737335; c=relaxed/simple;
	bh=MEsFizS9ivrCmzmfoentSkr3GLEZiOKdKet/aTPiETA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzwM5MvP2pvlE3i9B1FyBoRrWWfCmevzM59d1eq8i1m/oAUY/4VJh5Vqa1iXpI9FvLs0zzlUFdKk/9NYbcbp+X85efMl1kWp443MpoIAjX+zqMz/gSk435gTDcDkQBgu+TekuQheswxCINjy8KMKeGJEZeGwjG7QBsEl7UxpmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sONVMWFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB95BC433C7;
	Wed,  6 Mar 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709737334;
	bh=MEsFizS9ivrCmzmfoentSkr3GLEZiOKdKet/aTPiETA=;
	h=From:To:Cc:Subject:Date:From;
	b=sONVMWFrbYkKn3A13OTP0gDSgFEPuhCyQ/9M/UYzhaB+hSUQeSIEpVBZkjC6lnuFj
	 x5lZc2mDWpzBLUT3oqQoKdw17m5Wqk5huYn6PwcZmowyYjKH98xPGm91nhNMfde3ky
	 Lv3E+mgLxo+G6OwAI/L0RI3MSlH2OLI4cIiOuhXZgjqCaomQ+E8kIaxbPbubMgiUDf
	 Ksv/c9jLDex4VETRkv96fLQrlxrtQxJzsyh7DpLJS5DvnruE6qUraMed2eqXokGLZA
	 4Y7WWf1aQwey5YHmMgnZX29ctXPoVW+60xA7KosvNXrBEtd3xT1TkcSC6N35J+q2Z0
	 Yp10R02aMnvZQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix grep warning at _require_btrfs_mkfs_uuid_option()
Date: Wed,  6 Mar 2024 15:01:57 +0000
Message-ID: <ef2df19486ef71adccd14b3df0bf475ecc7f3b38.1709737287.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When running _require_btrfs_mkfs_uuid_option(), some grep versions
complain about escaping the dash characters and make the tests that
use this function fail like this:

  btrfs/313       2s - output mismatch (see /root/fstests/results//btrfs_normal/btrfs/313.out.bad)
      --- tests/btrfs/313.out	2024-03-05 18:48:34.929372495 +0000
      +++ /root/fstests/results//btrfs_normal/btrfs/313.out.bad	2024-03-05 20:52:27.745166101 +0000
      @@ -1,5 +1,8 @@
       QA output created by 313
       ---- clone_uuids_verify_tempfsid ----
      +grep: warning: stray \ before -
      +grep: warning: stray \ before -
      +grep: warning: stray \ before -
       Mounting original device
       On disk fsid:		FSID
      ...
      (Run 'diff -u /root/fstests/tests/btrfs/313.out /root/fstests/results//btrfs_normal/btrfs/313.out.bad'  to see the entire diff)
  btrfs/314       3s - output mismatch (see /root/fstests/results//btrfs_normal/btrfs/314.out.bad)
      --- tests/btrfs/314.out	2024-03-05 18:48:34.929372495 +0000
      +++ /root/fstests/results//btrfs_normal/btrfs/314.out.bad	2024-03-05 20:52:32.880237216 +0000
      @@ -1,6 +1,9 @@
       QA output created by 314

       From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
      +grep: warning: stray \ before -
      +grep: warning: stray \ before -
      +grep: warning: stray \ before -
       wrote 9000/9000 bytes at offset 0
      ...

So fix this by not escaping anymore the dashes and using the -- separator
before the regex pattern parameter.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index 3eb2a91b..aa344706 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -93,7 +93,7 @@ _require_btrfs_mkfs_uuid_option()
 	local cnt
 
 	cnt=$($MKFS_BTRFS_PROG --help 2>&1 | \
-				grep -E --count "\-\-uuid|\-\-device-uuid")
+				grep -E --count -- "--uuid|--device-uuid")
 	if [ $cnt != 2 ]; then
 		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid options"
 	fi
-- 
2.43.0


