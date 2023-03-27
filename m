Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F796CA10B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjC0KPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjC0KPt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 06:15:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774A512F
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 03:15:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y35so5862568ljq.4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912146;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VkwK1d2SvV+Sm6xPz/hi6NZv0KQnePVCAc9vAsxYeJE=;
        b=CLfWjnm6O2XmkL/+aNCoKDRilXmAdGybG6wnuKxee5yJ4pLVoLQ2bAetOSAO+q/QPN
         VKvtxM9HsmM9VsJNDzNEfHdErcA/Z0pBFoC0s6TJOiBDlS0h+wiOP3xZa2EeDoK8ly9C
         6QsSQv6AFX+eHgLUZwPDZVtyMxnRpdbCkLq8yyFRkPVtSHBej+Bx003i15FHtVN8Tl/+
         dd93jEU+JL6+X1RjeQlSRw3GCcgi9UVM61AHLsyAyFTUfR4181AIZ/iI8gIJ23fyqkVr
         8S4bScBblJnn5bpLFOf00Vo5AxeB4589J0tDyMUOo8KF2Xuj0ADmavUIJtJN2iw2hMr/
         6EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912146;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkwK1d2SvV+Sm6xPz/hi6NZv0KQnePVCAc9vAsxYeJE=;
        b=CRpIiQZtsaCVRrvttl7D4vkc+DG/+4R6QwjddEr67nWZaO2Uf9BWcjHeKOy1q9Cfad
         P1VN41LDMndiqFUdU5QW2WFNm8zVFJYmXAfF/J7u28FfeWN/3T2l01nxGk1KkNCiBzSE
         0/u+ZFgx85RDBCc35wvyxmJ01hEddcU7NKPaJFnDCtlDvVPJQEtOZNPEobP+AAz5pDZh
         VlC54y3OyC4Cnmd4qW2xwR8SvfoedudxjS+YWqhwttQ6YDayXJGHqlVHuAbsx181XQ4g
         iBdF26zk+azQ09XCLVKbiBHzK27lMH5UN1LMHXp/t7IX9RtdPCsZfxl79lWmZRmMV0Lu
         GTTg==
X-Gm-Message-State: AO0yUKWPlmJOlwN4uM3qJ1VcS4G2SAc8s3ceCV2wB5GaKMkVgGQQSfbr
        YU8Fu8DA8muHE/FtT0n7s0roXuxxnDq0wb27kfIviY5B8wo=
X-Google-Smtp-Source: AK7set+9EfI/qsQv7dHK0kk+/C1FWGAenZMmsoFSWmXX8i2alQfWqqPysV7uOoEZRcZInPev+VK8dE9oG21lpYdrzQs=
X-Received: by 2002:a2e:2a84:0:b0:293:4ba5:f626 with SMTP id
 q126-20020a2e2a84000000b002934ba5f626mr7806410ljq.2.1679912145665; Mon, 27
 Mar 2023 03:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:c9:b0:295:a96a:1bc6 with HTTP; Mon, 27 Mar 2023
 03:15:45 -0700 (PDT)
From:   Franz Schrober <petersmith59786@gmail.com>
Date:   Mon, 27 Mar 2023 15:15:45 +0500
Message-ID: <CAMb7Q-uWFMkCt4JwYjGCvZGvokQOAB=73CxbR3uZ8X1Uk9BubQ@mail.gmail.com>
Subject: 
To:     kim phillips <kim.phillips@freescale.com>,
        kovarththanan rajaratnam <kovarththanan.rajaratnam@gmail.com>,
        linux btrfs <linux-btrfs@vger.kernel.org>,
        Lars Wirzenius <liw@liw.fi>, lool <lool@debian.org>,
        Pierre Habouzit <madcoder@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        PDS_EMPTYSUBJ_URISHRT,PDS_TINYSUBJ_URISHRT,RCVD_IN_DNSWL_NONE,
        SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bit.ly/4094Ail
