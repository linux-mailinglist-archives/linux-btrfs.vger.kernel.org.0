Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92651424E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354523AbiD2Gal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiD2Gak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 02:30:40 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCA5F8C8
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 23:27:23 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id r8so4739417qvx.10
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wnZ+4hGD8VkIzGL89o0JwTkix/B8iwi8MkUwZhIE88E=;
        b=Z4FwKwcaknT6sDUs4UkZ1Z1npiYhjqVNJsxf+5OevQjjEPxjmpC4HWG7C9u1ZbgcPS
         68BBZ+e5XolH8Zvpbby/LNNIBor34TOjc+ZDrH5I25i3qjHoT1Tpxls9rcnYoPPVKsHf
         EhGIUd5sLRcZHKCdCcQqq8nNTEk0546Pe5BCLB65JJE5npRhvm3+osXRRZ/NmdCgSGZP
         0J2oFM2ydCs9bQfN9ETTogAeej7N7y7hIBrGZzlUPGf4dDmBJsgBJTjiocqbUw90eHEJ
         hWUi1LxqiyD5XZLRY6DFR64GFbU2Q3j1Mw3+G36pnkL5EtrH3A5JJIhWV4h3lOtCx23t
         lpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wnZ+4hGD8VkIzGL89o0JwTkix/B8iwi8MkUwZhIE88E=;
        b=IzCJDu36mNvBIC27JteLGNWl7ZlgxAO9sMCv1Hn67LWdnD4/7Kgv67LSTl8ZlbAgiV
         3HrdiFzKJWLxn7vNAERAhZixjbNS92CiHQBERVwVGQ8BUZkmJSQ7K0Ezij2RgYgysLNB
         w4ADnI3Bi1KPcw0dlSGGGgvBS3D/ghMyxB/plgSmaK3lEW+m5EqYnmSMn2Bfy3gYzd9p
         BwcYwKabAccq7QOyBve8J4GjyCXV+4MaxitF5gYHSamRTEXTnIlN5As496FCVML8oQG9
         YHxbf/iae22aHlTYiVf+EgYENkFiN6EQ7InEJ0tFChpODfMluccULvsbR/mP92nY4mpZ
         YHKg==
X-Gm-Message-State: AOAM532FCnXSur1aZCzSaNfpwUlC+rEQNMO9D8S1tEH5dv1VPx8b9knu
        ElE+FRJRbXyUUsx9u4u9bBvw/pCTnL9sJy8iECMpXr4v1Dg=
X-Google-Smtp-Source: ABdhPJzKlLGNxCNs1YT69UX8QJi2KEOEVdyp6L/NzNlxSZLPm3yqqfNu/f0fCa0ErDe9ojN/on+cuFTvxHVYddPIBtg=
X-Received: by 2002:ad4:5f06:0:b0:446:e96:b193 with SMTP id
 fo6-20020ad45f06000000b004460e96b193mr26478899qvb.100.1651213642294; Thu, 28
 Apr 2022 23:27:22 -0700 (PDT)
MIME-Version: 1.0
From:   Inhwi Hwang <dlsgnl1@gmail.com>
Date:   Fri, 29 Apr 2022 15:26:45 +0900
Message-ID: <CAGy3qQDeMHQMx6ULiw2uGfiJWzumpyb1jhKgizF5UsRppAoRPQ@mail.gmail.com>
Subject: Question on file system on ZNS SSD
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
This is Inhwi Hwang from Seoul National University Distributed
Computing Laboratory.
I've contacted you to ask some questions about the file system on the ZNS SSD.

I read the documentation of BTRFS on zoned device(Zoned - btrfs Wiki
(kernel.org)).
I want to check the performance of BTRFS on ZNS SSD.
I attached BTRFS on a ZNS SSD(ZN540),
but a basic write test using fio failed and raised errors.
For example:


Could you let me know your environment settings and fio scripts?

My experiment environment:
ubuntu desktop21.04
kernel version: v5.17.4 and v5.16.20
btrfs version: v5.16.2
fio version : v3.25
fio command : fio --filename=/mnt/nvme1n2/test.txt --direct=0 \
                      --size=10G --rw=write --verify=md5 --bs=128K
--output=${OUTPUT_NAME}

Best regards,
Inhwi Hwang
