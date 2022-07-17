Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF28657759C
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiGQJ4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQJ4E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 05:56:04 -0400
X-Greylist: delayed 207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Jul 2022 02:56:01 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA830186C5
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Reply-To:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yvYpI0jFJySBqdvo0w2Q4dBf/AHSiFj+QPgFIVV2VXU=; b=Jxx0KuI2fwy/dNskTLJZrgRp/3
        kSuA8GYjmczre7rAldgtuH21b5s3mEMLtlvsOOjjJ+FsqBe4bjfRq+qNahEqSA2NaWVhxCwo44t9s
        OLG2gtKEKJ00NYxFCyoLgtQVHqfjlTzghFzxYEMKuw4CaPSbL3PjGn4ai7JX4vAYwrjJbXTZEV//w
        wSx09UBDVYTxcWd/5lU5lqNP94MCFL/K0Wgff5FoTkKjuVKslGOQKvJjpqs3relw9u9Hg/7prwjB8
        sTZVoJd0ngpXj7OSnuvamWdx1x1slmKqOxVj9TEY8QVVlcp7XSiPs+SoSxmQsAYPg1Dh0HQlvD820
        CsiVdcuQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:10286 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1oD0wx-0002p2-Rn
        for linux-btrfs@vger.kernel.org; Sun, 17 Jul 2022 11:52:31 +0200
To:     linux-btrfs@vger.kernel.org
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: btrfs device stats in table?
Message-ID: <d7bd334d-13ad-8c5c-2122-1afc722fcc9c@dirtcellar.net>
Date:   Sun, 17 Jul 2022 11:52:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.13
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am not skilled enough to supply the patch , but would it be possible 
for someone to please consider adding a table view for "btrfs device 
stats /mnt" as the current output is rather "messy". Something easier to 
read would be much appreciated.


for example borrowing the output from btrfs fi us -T /mnt
---snip---
              Data     Metadata System
Id Path      RAID1    RAID1C4  RAID1C4  Unallocated
-- --------- -------- -------- -------- -----------
  5 /dev/sdh1  1.81TiB  4.00GiB        -     4.62GiB
10 /dev/sdf1  1.80TiB  7.00GiB        -     9.00GiB
11 /dev/sdi1  1.81TiB        -        -     9.29GiB
---snap---


and perhaps adding a -T view for device stats as well for consistency...
for example : btrfs de st -T /mnt to output something like...

---snip---
              I/O Errors
Id F Path      write    read     flush    corrupt  generation
-- - --------- -------- -------- -------- -------- ----------
  5 * /dev/sdh1 1234567  7654321   13579     97531      24816
10 - /dev/sdf1       0        0       0         0          0
11 * /dev/sdi1       5        4       3         2          1
---snap---

