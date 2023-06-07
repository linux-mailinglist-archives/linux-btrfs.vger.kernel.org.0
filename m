Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33F2725662
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjFGHvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbjFGHvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 03:51:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F526A2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686124160; x=1686728960; i=quwenruo.btrfs@gmx.com;
 bh=mGflICHcntiF2MjTl4KcPpXnZjh4noC6XOdGfBd2P+8=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=rhfqweRZbUwMIB9DMOCxCUUVGLYigHQ2ew7RInhERBoel/8hKuQ+63QwhUsq9TfIOEz4i8s
 OxHT7WDnyLt0ycRwTUqnYqZbqGS7QfT6W75hBw9HLL3DS8nHGXFyWe6nPalllMwipmpS9DzwL
 RO4vV12IXnXhVqgvEHKLxGSs+elIcTY0C3viXbEfSo9grr5PtXkKUIkCyrKYfDRyS6mu/b0Xx
 euJd0OajsOordzacsceBnucn5pbYgQSYw+4YUGjmROTWqzUyKFk6qUdDuRAPL7aDoxHk14vPf
 Ijh1ICZZn+KPSzRkicBoxUt1yx17+RQC+BHjpdrGYaECMspzn2TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1qGOQG1SBH-009gpF; Wed, 07
 Jun 2023 09:49:20 +0200
Message-ID: <0e0e4790-1d05-7abc-00d9-85bc23541c26@gmx.com>
Date:   Wed, 7 Jun 2023 15:49:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Is "echo 3 > drop_caches" async or hardware dependent?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:he4FraN1cQCvAhoTRr3UjGNBa7JxXoR3Vp9SxR1VbadIVbcE2Fu
 r719BZD+uLFHpQ1tJz0UPOlj/SQ8BIJG21BvzhZ79bind2TxwZS6tpmby/6kOCaK/I9wf+X
 arLJC4ei49+f8KulORATmGea6q+W2bk1n28nmdjRME4TVUa53RQPlgo8UrUHdA1N3OsmZPe
 wTgyuoeFV8qVeGd4ac+JQ==
UI-OutboundReport: notjunk:1;M01:P0:nJ7Io1dMFeo=;Bl8HaOPr0ItGUKIFFSMU6Vqy/lP
 53YqAY05QqIOrS6jbwz73PBSNWfSwsAGSl/5irrc4axM8HhWt8IqKIwB98++h+6Ds1azFDxWQ
 L4xJMLRQR/zK5z6Y6mr5q9GWUOMwNkSmowXOpJyblSeUwL7Et2NfzRDP6VjN7hUDYJMuQbaqS
 KMpC3yl3Dp2mqG9nVrVD2sN4e3vYy+v5wC5KqViLt0BTWJv0oUHYY2tZuq35M0Kr2QdvzCMpB
 /6//Iv2qeuEZ8bPHThmMkCrnm3ZLZsRyuZOSxeQjc9uaGoLX7D/0qoeGvMk07+62sor/eb+5/
 urqJ+J6VNSqXuwSH0R+IyAGosvMN6r1qbjTbNpuUaLRAvP7/KFnQJnrCFiNXYcQ8bjf5UMH5U
 zZfDPTj5k5RVmrf8N/seRUqwgg8jC3M0qxp+3NsUB15faFmIc36v3Hk1t0u/0uvGH0bnChRK8
 iseGAGiQV36lda9zlgEsKyPb8E3FKqId1qSaZy9i9JFkpBh4M01Aybtd7IUk5pxLq4NQFjN0v
 mzWHpBz48VxwUQGfgZlDx+5IT0KcHFWjXfx7C8quhSK83lzWMLbeKdca7gZmouC/yHtNmKHkl
 FuIf1CDMkTO8qS2wm6uEDMVdm5L1YoQL+PrUAC/6YNmRp0fQAPkIUVtpii+4SMoDJcuepDsLF
 jXkO+Ygbe2YNWE0gB1y2TL/0Kz4lxdWZzxo+Dw96RFycLOgpUGg9x6Wm6I89W7G2cNG8BgYny
 /LocZ/AhvDVErKrFggX4C5GBmxOcKmzGELfJwbq9Yo7GuLL4DrDQwdaI+l7sNR4bWlgBROlOj
 y2MHEaZJViXr8CLbGtjEtLvaDFDPA2dVythWN78dvsNLaaC5RneFOqAvvzfVjfCuUT83ip+Qv
 L/jU0bVcSSV+zAv2NM9hrL5wxUYA76g3fPjjmbk5vhwz7GHyQrMpfQ1YRDzF821wpQMy8AK7O
 91yK5w==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Recently I got a very weird test failure, btrfs/266 on Aarch64 with 64K
page size.

The test case itself is utilizing the read time repair ability of btrfs,
and the test case is already supporting larger page sizes.

After quite some digging, the root cause is pinned down to the test case
itself, mostly related to the "echo 3 > /proc/sys/vm/drop_caches" behavior=
.

The TL;DR is, at least on Aarch64 with 64K page size, "echo 3 >
/proc/sys/vm/drop_caches" doesn't ensure all the page cache is dropped,
thus later operations can still use the page cache.

For now I can change the test case to use directIO to avoid populating
page cache at all.

But considering this "echo 3 > drop_caches" behavior is utilized by a
lot of test scripts, I'm wondering is there guarantee all non-dirty page
cache dropped before returning? (Aka, sync or async)

And is the behavior platform/page size specific? I haven't hit the same
problem on x86_64 at all.

Thanks,
Qu
