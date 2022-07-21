Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EABA57C674
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 10:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiGUIhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiGUIhA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 04:37:00 -0400
Received: from sender4-pp-o93.zoho.com (sender4-pp-o93.zoho.com [136.143.188.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902628729;
        Thu, 21 Jul 2022 01:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658392612; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RZuvCtiU4fKZaz+xbff2VIqiPdkTLtN41r0+W1V6BWSCLkwfC1qk3Usks/cEEVsCnVK575F1BlJ8WPrVDkTq9V5WanBsEwrd0FI2pQInHfg7rqvw2wyG//gDCOpDmPfyS2F2P6rawD8rVHnk4ZmQYYGyMIvBdIEs4BO5rr6sHug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658392612; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=CE1Xk4p5RR17p5R3WbIoxrG3xk/BTEPCABwgd4UK3no=; 
        b=SyVBugycFOPlhHgOb3X8UpvAYyE2bj2H63RV+qBJNms194PEQZy5QjR28oNZAYh3HRLiI01MmtNGvyJOJIC4PcmGdlR3I9GQhR0fXYmXWmZPjEoGCUXSBku24gVWkycIiW2ZWn+Q4C6D27t/nbqmQhOtpF3mSH/Wac7vUTGii7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=euHo0Fc7Jdb32iFSTPOuhv/F3vJlDCbjE2r6dDD4CJOEgQO/VqkocQTs0FZt1uuhf9SJB+zxu/MU
    TPa+K+zsAbF/b/zbxRmkzNDkkBlRc5utFZa9wubsQjwfTrjtb6Iz  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658392612;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=CE1Xk4p5RR17p5R3WbIoxrG3xk/BTEPCABwgd4UK3no=;
        b=dOtXi33j/Fen5kR5h8r8QMuE5Ojya4cxcYL294zk5+asVzMwRQCxEHB2tQJPcWT5
        FqZlj/ghXKfdxaEehZBfowa8KtZHCBfZcbh5k2UYIjmzL47pLUSCvtKiBdPsPs2rdK/
        YepmBB1q5ar1VJ5npKuJGJjgQE7SGwXR7mF/OIA4=
Received: from localhost.localdomain (58.247.201.70 [58.247.201.70]) by mx.zohomail.com
        with SMTPS id 1658392610284663.8069833515924; Thu, 21 Jul 2022 01:36:50 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     anand.jain@oracle.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH]btrfs: Fix fstest case btrfs/219
Date:   Thu, 21 Jul 2022 16:36:08 +0800
Message-Id: <20220721083609.5695-1-hmsjwzb@zoho.com>
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

