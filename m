Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A46E564D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDRBSS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 21:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDRBSQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 21:18:16 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62C24C02
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 18:17:57 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4D83FC01D; Tue, 18 Apr 2023 03:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780673; bh=dygc0OaokYdVl4wdSabvCKFMHdZhaFuQ6GohbYeH/AE=;
        h=From:Subject:Date:To:Cc:From;
        b=sR1XTMq1fYZXsjgGQyRphqPDM76CRron5UkpWVnhDyH+RMytqoZoF6xDO35XvU4il
         tpYhC5+YzWzNSk/6Aek28OraAr+b4O31UMA6cQrbxgo/iEVLTS81exDkgnEiKLoMKj
         riFAEPOLTmoZ5jGQjfoc5yFCC2TCVZ05ObwKqi48hQuCIx5+3mpYYw8a8PBbcuzEPC
         D5jfmDmRPueV26yJCJoP/WYaD6e1SVnLuF39MigcuxTxOaiXYp852lxA/gvBlrlDhU
         QCSIShxKWxnKRkgExt2IFl/Q3RQPc+fs8wJM2mtPHDYrQvbtUUCQT3+QfafpLgo9aF
         zKnAv/fyvmNXw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B61C6C009;
        Tue, 18 Apr 2023 03:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780672; bh=dygc0OaokYdVl4wdSabvCKFMHdZhaFuQ6GohbYeH/AE=;
        h=From:Subject:Date:To:Cc:From;
        b=WkUjdJl/NDRvdSxhnbLM74fLDqTjVhwOSrnud5ejfcKNf8PsrCz56CglUh5j+sAlk
         ZH/Zns9Cl2vLj5Qa9KICZbX8IetB6MkgGrYwuDvzH7ursjY/8FQ08LBBOM/7VzjA9x
         r3Q93p76CKfekru7BTeHmyitOI2HQsxxkQ58OGFYe0uuOzoaWxyQPGRavgUibMeebN
         bbXuJ5UcLUcwx9qTqQFYhHLMNPQspqq/xntRAR4CwY20D/0P56Wbh9Q9ynVvVs8ESB
         J3Zl/ZRbCRz9kl0t4VI9TC8EbDX+NwWrdUitu8DIr85VyerFs3yLzKWNjLBPZAl2SX
         T0MoQVmt8aWvw==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id 0fee24ca;
        Tue, 18 Apr 2023 01:17:47 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH U-BOOT 0/3] btrfs: fix and improve read code
Date:   Tue, 18 Apr 2023 10:17:32 +0900
Message-Id: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKzvPWQC/x3NsQrCQBCE4VcJW7uQXIKopS+QRiux2OTmzBWeY
 feQQMi7e7H8GH5mJYNGGF2qlRTfaPGTCppDReMk6QWOvphc7dq6a048ZA3GWDJSZoX4AufDEa0
 7i++ohIMYeFBJ47Snb7EM3YdZEeLyf3vQna99f6Pntv0ANukh/YUAAAA=
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=mVPO3YrnTHdK+F7rWnq8sj2m0J+3a57gdYMc01tQWH0=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkPe+7bb8BWYg5sOvPW/NS9yFUITaQ0LZOMCENv
 FKpF0bAt9uJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZD3vuwAKCRCrTpvsapjm
 cK1BD/9iGP8RvoNvGrLIDLgCu78C5aiHifLNY4dy2Td6+xtpqq6xPtJjciu8NP9aJcJ2RHin6EQ
 Yb2C4y3kwZytRiypApl4w4lljmYDEba1OogtS0b6vm8LGHp4vS1qO/Kzk2UA2WAielZuM/MFL32
 g6Wnt1breARwq/bCNFMTVv9CmFaW2UShMyfQYB66oiVIharriNbAoDvUHy5ZauSA9yHEz1gHDMd
 Gde3fzH4KSokLeiTTb5qXEuGMYdmigV3Mu8GWcNmoAKpSzb0uPkRg4KyQ2wexRNqM8+0ELjo8wA
 NwhUP5zte30oplQcQ5PWUXTz69vyo/wtafDZ/gsTIwq/pvD/SopYkRpstqn0yDaurSFIWCFri45
 OLQpsJb+1w486XEmm3qeANppBFSd5npzKvpllnOnQSIh1zUBAAXFCBjkTeiztVCrOihTAWRVC6D
 o2JGIqfLRw0cjCtSFJhCsQAAHlFG6/dNRNXxQ+oFKV4kPKdYbTO3z2Bg43OsBdPsxQ/aIdD/az3
 9rGlH9eHlc7kfRK3+qUjlRfHjCziVvBUpOZaLxfpQntzmXWPubxT9iFs2v1ZPTnoMAcaEL4njMR
 SNgRoR1wCL5ZF8pg8XBJzJyJd5kj9uZtDPea0iQ6GQTPbEdy6ahKBdT+SxnaeWOymycYg3HL1r8
 B5robUFgeULnBXA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm posting this as a series but this is really three independant
patches.
The first is a real bug that has made our board unable to boot as it was
corrupting the kernel and image CRC validation failed (yay for checksums
-- any plan of enabling validation of data checksums too? I see the code
is there for metadata already, so it's probably not missing that much,
but unfortunately as far as I understand it would only have seen that
the extent data was correct and still corrupted the final buffer as it's
just an offset error...)

The second patch is an opportunistic optimization as I noticed the code
behaved differently than before, and there doesn't seem to be a reason
the reads couldn't be coalesced.

The last patch is just something that looked odd and looks "obviously
better" but I'll leave that up to you.

Thanks!

Link: https://lore.kernel.org/linux-btrfs/20200525063257.46757-1-wqu@suse.com/ [1]
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Dominique Martinet (3):
      btrfs: fix offset within btrfs_read_extent_reg()
      btrfs: btrfs_file_read: allow opportunistic read until the end
      btrfs: btfs_file_read: zero trailing data if no extent was found

 fs/btrfs/inode.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)
---
base-commit: 5db4972a5bbdbf9e3af48ffc9bc4fec73b7b6a79
change-id: 20230418-btrfs-extent-reads-e2df6e329ad4

Best regards,
-- 
Dominique Martinet | Asmadeus

