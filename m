Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0B4EEC14
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbiDALPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiDALPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:15:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA4EA760
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:14:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bq8so5077145ejb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=LCePTVvVP6NNXN0nV1wIves547GSNi8TXNroUTBpaRk=;
        b=ajQ0nFxQZt0uuGIZZLgt4Lds8zLc2ItjrBlbUGWS8oiZwtWKcLwWQg011k6FtAFKkB
         wpjC/pSkZHzY19DFtOvk2P0YqFOBnzlfYLirlPwgLmGR74/5x2pT4m1anKgEySiiX2ge
         99ZcBT0aN9x6ZJeiuJoK3L0S9nsC3077aGuac2kbZ2Dj5hGHqHtcvduvMMUyFP9hwFM7
         W7jumqjfVvCElV4yobdWfbQ6vd3zUD5rfle6Tj7j/X90q2Wf1M4ibzS5ENf0OYthd+D/
         0miM1rMecFRTUrnFlKZSEn2crhr80eVmn90DXs67REuh3/v4fPKR8r947ImG+Ac4Xfuc
         QF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=LCePTVvVP6NNXN0nV1wIves547GSNi8TXNroUTBpaRk=;
        b=GHndJkgs98/N6bG8cHvDnklX8iWPFPPRr1Ejfp9VQolGYpcam0wPHyhuy2XUXFdBb1
         LaLMV9Hv/UhLUdiDfD/S1C3Rde2F3AnaFHuOAY3li6M6ly/LmoRKFE7y+uhjSXEyQX8U
         d/w6dvNxmEfdfmw0TqOP8U450rLsyehjFln1I40LBIYD1zezBvlv24kNQqLBd23hcjvV
         OC87qWr5XKLyaYklj4W+uPM4GodpYqAwrkVabAbaiz2BDde2pC6JOLiYpHT7TV1J5Jqz
         cbAM2ipMGRAjmYFndsb9wKE12Mww6IZWvJ/nE15T/eQRCmEH6gz45EWLlrvLZXielvnK
         DS7A==
X-Gm-Message-State: AOAM533VHbxBGVy0q01LqJ2MJFRH/sYqrPrQM5sExK2QUcNB51/DMAfu
        rxANebadZnX50xW3t+obuub2gxCUxbM=
X-Google-Smtp-Source: ABdhPJxIkgemsnPxJLcJU0UpYYqFF8TmkOziBuKJC7eXAj0nqaOkZTWjFvO+W4HdlletTQ/QiBcyQQ==
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id i6-20020a170906264600b006d5d889c92bmr9211405ejc.696.1648811642290;
        Fri, 01 Apr 2022 04:14:02 -0700 (PDT)
Received: from ?IPv6:2a02:587:af09:1bb8:e04b:d138:63fd:e7c0? ([2a02:587:af09:1bb8:e04b:d138:63fd:e7c0])
        by smtp.googlemail.com with ESMTPSA id v20-20020a056402349400b00419651e513asm1111562edc.45.2022.04.01.04.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 04:14:01 -0700 (PDT)
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Subject: Adding a 4TB disk to a 2x4TB btrfs (data:single) filesystem and
 balancing takes extremely long (over a month). Filesystem has been deduped
 with bees
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org
Message-ID: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
Date:   Fri, 1 Apr 2022 14:13:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I am running btrfs on 2x 4TB HDDs (data: single, metadata: raid1) and i 
added another 4TB disk.
According to btrfs wiki i should run balance after adding the new device.
My problem is that this balance takes extremely long, it is running for 
4 days and it still has 91% left.
Is this normal, and can i do anything to fix this?

kernel is linux-5.17.1, i have also tried with 5.16 kernels.
mount options are: rw,relatime,compress-force=zstd:11,space_cache=v2
I have been using bees for dedup, but it is disabled for the balance.
I am not doing any IO on the disks, they have no smart errors, and none 
of them are SMR (2x WD40EFRX and 1x ST4000DM000)
Autodefrag is disabled, and i also have checked that the disks are in 
stable drive cages in order to be sure i have no problems with vibration.
Benchmarking them gives normal speeds. Quotas have never been enabled.
