Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8165068EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348868AbiDSKon (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 06:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiDSKok (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 06:44:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5922526
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 03:41:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c23so15421327plo.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+pUQ03bbjApxFr+6C8b9/cnAL2hsO3EeAFuRUe7zhp4=;
        b=llXVN1OR+dirptA23pAzO44LFPYDXW4f/rEVhjIv2FPd923v8JilvKRihITTWVG9Ux
         NRAK8gbzVMxMRvsibr7RX4o/ye22DQH88nl7P9FzRF/Li0M8eM2l6PQ4ARSGrbwpi5H/
         7oEYxoVYWJCQ0ZN79FF67JuEkfbT+NYOqhatTLhgAyaIRqFvUaEP3jCEIsbCxWlyCyKl
         Giawh5R8Zl6yyAOR5OdTB7xzaggZe6iqp6VXMIxCBS0YZA1KxijhBveezitiloEv2uNM
         Euy3mzcp/V1Vt7vMlXa6Bhm7A+f5E1FNTvDNbZTQib2AFRc3TcG0E/AGlJH4IYJaIBR/
         r6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+pUQ03bbjApxFr+6C8b9/cnAL2hsO3EeAFuRUe7zhp4=;
        b=KZGrOBf/waQIShiqipOmrOQ8P+MCGFoVPssVRBUzy2Ubwa3O4ERPcmIu0s4XQ80nZC
         dRJ3KHl6rL9G3frvFSeKIVSvwQmZF2pdJFzjZQH+VaWlyIT0oBrTofJa3kol1bztD2/0
         y2e1H+gn8IoPP6QS5SUa1E9b4hbkh5a15+VxX4f2d1s6MUiuJtAiwa4fHUtu9perlDdW
         joieOUJR92vR59Z4UcNMIqCG11xfe4cH7YpdJhtnnraGImZyqAFLYNldY1THQELjc0Hj
         fuSKdkJdr1AEe20FFgjcue231RMdp9xF6HufbQV465rAD01VXnyezw8rcne3XEUyA3Xq
         bK6g==
X-Gm-Message-State: AOAM53003oA7xbtFSfIaKoxxhpupk3UgvB70aBrWvvg/yJ/sGkGvxTom
        HGGeNO0u7BkCGA43muexuwhAA6wp623T9o8/A6Po+VD8nYo=
X-Google-Smtp-Source: ABdhPJw+wE438uZdYlzK48I9XWcFRwWO3qdfLm2J9q/dHckK9CH4Z2DqylFOIykSo6lOzgtzCEJKs+lA99TjCApJoSk=
X-Received: by 2002:a17:90a:6d96:b0:1c9:c1de:ef2f with SMTP id
 a22-20020a17090a6d9600b001c9c1deef2fmr22928118pjk.210.1650364917304; Tue, 19
 Apr 2022 03:41:57 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Powell <alexj.powellalt@googlemail.com>
Date:   Tue, 19 Apr 2022 20:11:46 +0930
Message-ID: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
Subject: space still allocated post deletion
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi team,
I have deleted hundreds of GB of files however space still remains the
same, even after a full balance and a dusage=0 balance. The location I
am deleting from is usually a mount point but I found some files had
saved there while the array was unmounted, which I then removed.

root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
6.4G /mnt/data/triage/complete
189G /mnt/data/triage/incomplete
195G /mnt/data/triage

root@bean:/home/bean# rm -rf /mnt/data/triage/complete/*
root@bean:/home/bean# rm -rf /mnt/data/triage/incomplete/*
root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
0 /mnt/data/triage/complete
0 /mnt/data/triage/incomplete
0 /mnt/data/triage

root@bean:/home/bean# btrfs filesystem show
Label: none  uuid: 24933208-0a7a-42ff-90d8-f0fc2028dec9
Total devices 1 FS bytes used 209.03GiB
devid    1 size 223.07GiB used 211.03GiB path /dev/sdh2

root@bean:/home/bean# du -h --max-depth=1 /
244M /boot
91M /home
7.5M /etc
0 /media
0 /dev
0 /mnt
0 /opt
0 /proc
2.7G /root
1.6M /run
0 /srv
0 /sys
0 /tmp
3.6G /usr
13G /var
710M /snap
22G /

Linux bean 5.15.0-25-generic #25-Ubuntu SMP Wed Mar 30 15:54:22 UTC
2022 x86_64 x86_64 x86_64 GNU/Linux
btrfs-progs v5.16.2
