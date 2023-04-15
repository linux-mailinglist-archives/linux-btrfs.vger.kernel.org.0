Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DD6E3337
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDOTAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 15:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDOTAG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 15:00:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98AC3AA7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 12:00:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso2988219a12.1
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681585203; x=1684177203;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8EpyedTb0BxerxifPpweQnjyQ3G755Yhv944vBSsWf4=;
        b=d8qdXG4bFV2a0j2txmJ8XkSYh0v/hhxMvDqkqYcw7chX8dAm+IdHA8L+NZR57Wiu3A
         lnVG9M1INXrSicMXQUC1W8PTMSGtbfzH0EDjKyxCt+AUPGSGpgy1ZuPQYDD4NyflzLK7
         emJJJxe0RtTYy6I2rAzmMFTsIUaT0KI42nJ3Cp5QQ9X0FgTGDitldwT0Hc2BRFmS3big
         c9MchIQnWBEGPEG+/VZleh038hhQA5TAvufwBW4AgE1fdki2KYbV97MZFkE9Jjq5TAfJ
         fNMlj45OjhvAk2BHuiPtTo3fmtvWwtoqebpCmQdXnD/4Nn3hm3H0VPFGCVSXrs9oATmB
         0I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681585203; x=1684177203;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EpyedTb0BxerxifPpweQnjyQ3G755Yhv944vBSsWf4=;
        b=BNrLpxsKILYc67WxIVrn+OPWvPtItoSBkQ40pzra+xiizipU6dtu6jpGCXEZPZ2Zjl
         DNo6lyMGTvtv3q0sO5lJ0OESviwzht3mx9K2kQidIIsLXW4mGZD91DWh026mYTK1bFwS
         Luq7I4k2nag3HVe123O6+7yVZ2bA3OA0BT77PKLAvYbHP99El5A+73P6EtiezI2EtuuK
         pgUj/wwkqyLWD7t5Vvdb+Dfjm7z7ZjgmKX0LGJZI4woB2ASKa575yKCm5yljcU7U/pmg
         XouB9+qAYHVOTnwg29kimjCecb5jUY+QrYFEAgU2PS5Yopx0vmcpqiKEvvgD82USMLBZ
         Yj8A==
X-Gm-Message-State: AAQBX9eDqgOtMRCjCZ8XvhrRW57iUBiFqsn0lKEtpyCCZ0UabgnV/+9B
        CxHGmR0YVf35kyICcl48//H08XWUi1mBPyMa08qP/8dXlOvx6w==
X-Google-Smtp-Source: AKy350Z5rpR0IHd7BVZ9V/EbVwpRtvQ8/wiwjmnPTTlc8GvLmJOjXGuZ+cnDWFzgjaZ13VaPR6m7mZQrNE0KRMV+FOU=
X-Received: by 2002:a50:ab02:0:b0:4fc:473d:3308 with SMTP id
 s2-20020a50ab02000000b004fc473d3308mr4935626edc.8.1681585202705; Sat, 15 Apr
 2023 12:00:02 -0700 (PDT)
MIME-Version: 1.0
From:   Torstein Eide <torsteine@gmail.com>
Date:   Sat, 15 Apr 2023 20:59:50 +0200
Message-ID: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
Subject: scrub/balance a specif LBA range
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi
I have a disk with "Pending Sector remap".
That can be view with:

``smartctl -l defects  /dev/sdd``

````
Pending Defects log (GP Log 0x0c)
Index                LBA    Hours
    0        11454997800        -
....
    7        11454997807        -
    8        11455002752        -
....
   15        11455002759        -
   16        11464481352        -
....
   31        11464486423        -
   32        11480702000        -
....
    39        11480702007        -
````

Can I tell btrfs scrub or balance to move files on these locations?
I was thinking the balance `drange` may work but was unsure of the
correct format.
-- 
Torstein Eide
Torsteine@gmail.com
