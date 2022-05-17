Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE7529C46
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiEQIXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiEQIXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:23:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0434165BD
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:22:59 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220517082258euoutp01bbce03f2098e9626a112e3dae49430f5~v1tBFBoCk0787907879euoutp01p
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:22:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220517082258euoutp01bbce03f2098e9626a112e3dae49430f5~v1tBFBoCk0787907879euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652775778;
        bh=kSVuyRT+G+lgXQoO7g7gUZXDkPwYb3JQgrG+W5+9dJQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uBBIoEvdrBwEXCmAjIvVKgwBNv69s0zZBGd4/24BaOd5X03SE0MiDSH73nTAF0EFD
         m+1yx4zrQExoIwT41nqt9rw9v0+O2c8cBMp0od7KYMeHaHvLQaha2y0/nJsIzt6w8a
         vnHHGOPcIqTdIEhy2BrxCs7OgWqzlJ+MA4zU/6Sg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517082257eucas1p2e9355b6639373472100b85df889ad71a~v1tAOuAHQ0631706317eucas1p22;
        Tue, 17 May 2022 08:22:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.8F.10260.16B53826; Tue, 17
        May 2022 09:22:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404~v1s-b8CUT1485514855eucas1p2c;
        Tue, 17 May 2022 08:22:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517082256eusmtrp2e1bde0b87941846a299aa32a89cb9399~v1s-ar2L60753107531eusmtrp2V;
        Tue, 17 May 2022 08:22:56 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-e2-62835b615a56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 36.A2.09404.06B53826; Tue, 17
        May 2022 09:22:56 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220517082256eusmtip1ddcbd6ad3ab46ddcb5189a4ffbf98d97~v1s-MQHRu2811128111eusmtip1N;
        Tue, 17 May 2022 08:22:56 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com, dsterba@suse.com
Cc:     gost.dev@samsung.com, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] btrfs:zoned: Fix comment description for sb_write_pointer
 logic
Date:   Tue, 17 May 2022 10:22:55 +0200
Message-Id: <20220517082255.28547-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzned3E6OYkg+mtwhYXfjQyWdw8sJPJ
        4m/XPSaLS49XsFtMPL6Z1eLz0hZ2BzaPvi2rGD3Wb7nK4vF5k5xH+4FupgCWKC6blNSczLLU
        In27BK6MN292shQ8Yq/4s6mDqYGxlbWLkYNDQsBE4vAF6S5GLg4hgRWMEpPafjJDOF8YJZbd
        X8kE4XxmlDi2cQ6QwwnWcenTWzaIxHJGiftHN0G1PGeUaJ4AUsXBwSagJdHYyQ7SICLgJnFr
        zX82EJtZIFZi48vvbCAlwgJBEhuv6oGEWQRUJV5daGMEsXkFLCW+HtzMDrFLXmLmpe/sEHFB
        iZMzn7BAjJGXaN46G2ythEAvh8TXxh42iAYXidUztrJC2MISr45vgRokI/F/53yoB6olnt74
        DdXcwijRv3M9GyQsrCX6zuSAmMwCmhLrd+lDRB0l/jw1hDD5JG68FYS4gE9i0rbpzBBhXomO
        NiGI2UoSO38+gdopIXG5aQ4LRImHxMENnCBhIWAQTNn1i3UCo8IsJG/NQvLWLIQLFjAyr2IU
        Ty0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMJqf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8BpU
        NCQJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYPJ2i+k9
        cEf0nkWiQf578y/nfip9Ozdr/Rbpq6zc2l+yXzzbpHjj7ET7P+qLV/1Y0rzmSblchv6r9czq
        71uuTbcyrBQ/vPjFkaVGxiv2nvlc8+Olz7wrKzkTpzjmbDTfzKK85aSS2p+AzvvFDvZfmQR1
        JBzVl6TulVuoufl/eK5Wuj2Pxj/Hznd+9/PemjYxur8WWLygfvpFxV2vZBq1Ti213nNVYZPm
        +V9hmx/ls3lFzFzAMTvoz/x/vk8vhyy9bXnYrN1w/v+1/KeMPkcw6X5LW3h+8XnfrzMMs0pl
        3c+o/XX6NnO9W3nz38kc8XXL7cUOhN70mrnVbZc5G1OHbqnlLXNftegJwuZHlpdus+5RYinO
        SDTUYi4qTgQA41hGJpUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xu7oJ0c1JBufWSllc+NHIZHHzwE4m
        i79d95gsLj1ewW4x8fhmVovPS1vYHdg8+rasYvRYv+Uqi8fnTXIe7Qe6mQJYovRsivJLS1IV
        MvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy3rzZyVLwiL3iz6YO
        pgbGVtYuRk4OCQETiUuf3rJ1MXJxCAksZZQ4v+UnVEJC4vbCJkYIW1jiz7UuqKKnjBLrnk5i
        6mLk4GAT0JJo7GQHqRER8JJ4s+gbG4jNLBAv8XxzJytIibBAgMSUFQIgYRYBVYlXF9rARvIK
        WEp8PbiZHWK8vMTMS9/ZIeKCEidnPmGBGCMv0bx1NvMERr5ZSFKzkKQWMDKtYhRJLS3OTc8t
        NtIrTswtLs1L10vOz93ECAzmbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4DSoakoR4UxIrq1KL
        8uOLSnNSiw8xmgLdN5FZSjQ5HxhPeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakF
        qUUwfUwcnFINTPkh7q+DlpfI+MxqezOvW6nW4cAX/X9WXaeLzTmn7BO726el/fvuJlNm5tA1
        0pJnSxiPW3q/458use3+qfJ1xstjJ65T+LlN6hW7M6tMt9fNNxMjeBOqCktSPLQ+bNMolWLP
        ffTMNV9J9s78qxuVz7XxxdbzqxhJFk1KVdvAuEeIV+LGielrJ2Q/PReUcTmO92qEzLKIB6Ky
        m7g2rVtjtVPrtWjT5RNt1lJ8RVUJ1idniBR8+iEWcfDPFneWJTMnXDI/oKZTr+FgMfvf66s5
        M6IMF+UFtlXnPnN4NfNNdtuZmzek/Ob9ePBZwqC+oVh80+QPfjqvBMs3tm/1eHNxA5O4WvoN
        g7LaH8/FfH5eV2Ipzkg01GIuKk4EAA7zBnrvAgAA
X-CMS-MailID: 20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404
References: <CGME20220517082256eucas1p2ccfe36e5fa1b170be1c2feb90e867404@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The comments describing the logic for evaluating the sb write pointer
does not represent what is done in the code. Fix it to represent the
actual logic used.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 057babaa3e05..c09b1b0208c4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -94,9 +94,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 	 * Possible states of log buffer zones
 	 *
 	 *           Empty[0]  In use[0]  Full[0]
-	 * Empty[1]         *          x        0
-	 * In use[1]        0          x        0
-	 * Full[1]          1          1        C
+	 * Empty[1]         *          0        1
+	 * In use[1]        x          x        1
+	 * Full[1]          0          0        C
 	 *
 	 * Log position:
 	 *   *: Special case, no superblock is written
-- 
2.25.1

