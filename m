Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8603B1764E4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 21:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCBU1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 15:27:09 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.38]:30970 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgCBU1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 15:27:09 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id CA9F7400C52EF
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2020 14:27:07 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 8redjLlPHXVkQ8redjg2ZH; Mon, 02 Mar 2020 14:27:07 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SEVLQq7X4qNDPdBic3qFXHlHV+o1TYwy3yjz/z8KJg4=; b=ClyHDDppzIl/5EUkjWfD8vZJX
        Np70GGL8y94elZlJDzT/tP9Ii4asb0Wbj+jLGj4UnEXRnbZIwArBt+5JxctHSrh8D2DgK0Jz1Drya
        zAR16964BPuWlSI1RCM9DLwUE+P60MCIYE7GJ7G4ENM+PMmBUVgEwWUoABVEAjlMiYGCWq1uIvi14
        tPBNcngaNZpNdcY9KhoHrmKgF1fXyQGFTW3YJW5YnjYzuExXmGXi2v1bjeIS+xNVgxJiTahRwixVN
        OoR46gtF43KklS83ZwyGr40q/2AAu2ev7HHBoTCLXC2MzF2pXQ3f4qX/PjQ5aLT8ufWNzmpuzSReS
        DcwpOw9wg==;
Received: from 189.26.179.234.dynamic.adsl.gvt.net.br ([189.26.179.234]:57942 helo=hephaestus)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j8red-003rNT-2D; Mon, 02 Mar 2020 17:27:07 -0300
Date:   Mon, 2 Mar 2020 17:30:06 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        wqu@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] progs: mkfs-tests: Skip test if truncate failed with
 EFBIG
Message-ID: <20200302203006.GA22707@hephaestus>
References: <20200224180534.15279-1-marcos@mpdesouza.com>
 <20200302200716.GW2902@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200302200716.GW2902@twin.jikos.cz>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.179.234
X-Source-L: No
X-Exim-ID: 1j8red-003rNT-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.179.234.dynamic.adsl.gvt.net.br (hephaestus) [189.26.179.234]:57942
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2020 at 09:07:16PM +0100, David Sterba wrote:
> On Mon, Feb 24, 2020 at 03:05:34PM -0300, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > The truncate command can fail in some platforms like PPC32[1] because it
> > can't create files up to 6E in size. Skip the test if this was the
> > problem why truncate failed.
> > 
> > [1]: https://github.com/kdave/btrfs-progs/issues/192
> 
> Issue: #192

David, can you please drop this patch and use the attached one instead? This one
has been tested by the user who reported the issue in bug 192.

Thanks,
  Marcos
> 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Added to devel, thanks.

--zYM0uCDKw75PZbzx
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: inline;
	filename="0001-progs-mkfs-tests-Skip-test-if-truncate-failed-with-E.patch"

From 52b96ac75c2f8876f1ed9424cef92a4557306009 Mon Sep 17 00:00:00 2001
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 15 Feb 2020 19:47:12 -0300
Subject: [PATCH] progs: mkfs-tests: Skip test if truncate failed with EFBIG

The truncate command can fail in some platform like PPC32[1] because it
can't create files up to 6E in size. Skip the test if this was the
problem why truncate failed.

[1]: https://github.com/kdave/btrfs-progs/issues/192

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/018-multidevice-overflow/test.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
index 6c2f4dba..b8e2b18d 100755
--- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
+++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
@@ -14,7 +14,17 @@ prepare_test_dev
 run_check_mkfs_test_dev
 run_check_mount_test_dev
 
-run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
+# truncate can fail with EFBIG if the OS cannot created a 6E file
+stdout=$($SUDO_HELPER truncate -s 6E "$TEST_MNT/img1" 2>&1)
+ret=$?
+
+if [ $ret -ne 0 ]; then
+	if [[ "$stdout" == *"File too large"* ]]; then
+		_not_run "Current kernel could not create a 6E file"
+	fi
+	_fail "Truncate command failed: $ret"
+fi
+
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img2"
 run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img3"
 
-- 
2.25.0


--zYM0uCDKw75PZbzx--
