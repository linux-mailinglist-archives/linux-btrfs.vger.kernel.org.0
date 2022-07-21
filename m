Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFD57C446
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 08:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiGUGQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGUGQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 02:16:48 -0400
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 23:16:47 PDT
Received: from sender4-pp-o93.zoho.com (sender4-pp-o93.zoho.com [136.143.188.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1743E6A
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 23:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658383297; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YkJYa26BIzuKPQjxYgJGEBSv2YZAZQDz8//Cjhw7VT+nUsprlaffN4/g1leSyk9m5jnD7urhSCD55TYXgpZsNvuwODvD53W9EwdwuzqZRaczJ0JBtYrrCbUChmMNuutt1EXeexHCBeyhfZep8IBetdC9DZy0nqilAJC0v1ML1MA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658383297; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject; 
        bh=CE1Xk4p5RR17p5R3WbIoxrG3xk/BTEPCABwgd4UK3no=; 
        b=F4FXMN3sS4VIdW1R6Xid791yb0swidn5qiz268hzekD0m1FllyzCGi7ygauPfZ6r2CC6842cW1o9ogypu7DtPCgI3UvH2O0ga3fTcBRKJ8unB/r+L1kMwTofxbg774wxbXyhkH8OOXme2yy3fB7rgNB7eoC143YNZ38vWE+1Dxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=G5R68XGS3s3KBVSzrOtS3Dr87irVIJMSNO9QUzaZCx8U19RTKlOaeL3uMnZlVqXecXcEcDCNLKsO
    ZfZDZr2lyNQ6EP8nftScWv3iweG8HIAzKo/tHlocFAHNrogllW9p  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658383297;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=CE1Xk4p5RR17p5R3WbIoxrG3xk/BTEPCABwgd4UK3no=;
        b=XXngohLGRK66UAj3Pr+FDZKSL0FaIP58FjIpBOdwf/ulmpgjF6movwaF4cIIK3ls
        aj7DfSY+loTW52pGhrD8Rq14xUf/VBWsJd8nBRWh4OxcI9745ZvZDtq0N2HYNl2otgX
        cOFllotcST5SK4ymsQ2LC/R1sAhLjEbNKk+9NP3c=
Received: from localhost.localdomain (58.247.201.70 [58.247.201.70]) by mx.zohomail.com
        with SMTPS id 1658383293885517.2826142931983; Wed, 20 Jul 2022 23:01:33 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     anand.jain@oracle.com, hmsjwzb@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix fstest case btrfs/219
Date:   Thu, 21 Jul 2022 14:01:03 +0800
Message-Id: <20220721060103.3355-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
fstest btrfs/291 failed.

[How to reproduce]
mkdir -p /mnt/test/219.mnt
xfs_io -f -c "truncate 256m" /mnt/test/219.img1
mkfs.btrfs /mnt/test/219.img1
cp /mnt/test/219.img1 /mnt/test/219.img2
mount -o loop /mnt/test/219.img1 /mnt/test/219.mnt
umount /mnt/test/219.mnt
losetup -f --show /mnt/test/219.img1 dev
mount /dev/loop0 /mnt/test/219.mnt
umount /mnt/test/219.mnt
mount -o loop /mnt/test/219.img2 /mnt/test/219.mnt

[Root cause]
if (fs_devices->opened && found_transid < device->generation) {
	/*
	 * That is if the FS is _not_ mounted and if you
	 * are here, that means there is more than one
	 * disk with same uuid and devid.We keep the one
	 * with larger generation number or the last-in if
	 * generation are equal.
	 */
	mutex_unlock(&fs_devices->device_list_mutex);
	return ERR_PTR(-EEXIST);
}

[Personal opinion]
User might back up a block device to another. I think it is improper
to forbid user from mounting it.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6aa6bc769569a..76af32032ac85 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * tracking a problem where systems fail mount by subvolume id
 		 * when we reject replacement on a mounted FS.
 		 */
-		if (!fs_devices->opened && found_transid < device->generation) {
+		if (fs_devices->opened && found_transid < device->generation) {
 			/*
 			 * That is if the FS is _not_ mounted and if you
 			 * are here, that means there is more than one
-- 
2.37.0

