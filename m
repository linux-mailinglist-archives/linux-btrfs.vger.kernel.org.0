Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB151CEB5
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 May 2022 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357014AbiEFCQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355450AbiEFCQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 22:16:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF05FF13
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 19:13:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so10309603lfa.12
        for <linux-btrfs@vger.kernel.org>; Thu, 05 May 2022 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5FNaabrC6PovMzmgLTJE+RjizuNby3zrHzRf1McH87Y=;
        b=WCGajJqdEourOqHM7BVeLx7Ikqe/XblUMaCiVmPjXr6rNihjqSPMLNd/lHh8NT9CVJ
         EiEi6JXIxmbOoWBbFJGOPkzQnVN3I0iNCUvMei7TjUdBuXHGCcbJiPTp5rpK1GjgB4Tl
         q4csFZDz0p8AZgYrK61mQ62Q2dhNSiV6fdR3BGjBEowt+IlS5iZHq/+4w2UOTZeTV5/h
         lxpqtPw7OGHoa+Z9PYEE+wpLp4XbfDQ9drw02bhpWmCQXfLaV2rRxTg/WLcUVCzuP10N
         Osnzl+BmebVJNVSCIhRfEHWt4ye6iOrw0tNF+76JaXipEeS/Y5/VKZPBm12MaoW1/wgY
         SXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5FNaabrC6PovMzmgLTJE+RjizuNby3zrHzRf1McH87Y=;
        b=vtHGOnhcIVBcUWIpWCyKzvChGO/MmAvncj3hkHR+DfW7ecXhY31vq263Bacbag9h82
         FsB30fNgousTADRRuZhp8mpwraKcwhx0YOFftwKdjXzbljwX4SpKoqGuHDM++u9aKRqX
         oJ1D2xk/KdyHGksRE1Q/CILOCWr99vD82ASNIowFeif3K72r16rmCPbQpH7PW8vR20AV
         8V55rLvc6EbHPZTICEXXR01GVH0iCKdLlfyXAuG2S8P50mZ0TcXdUsLn2LQTnzaV2RVE
         Zk00v3q2005VTgU8KLH2U8XmR07lVMTsPOKaxpQcZoed4p7w4LkUKnok9ZI3ETqb4hb4
         v3dg==
X-Gm-Message-State: AOAM531uN6S2Pu4CVuj4I3gwAF8bXJCwLZ9aCtsMddckiPUpiiLf/tyR
        CE4PnEhAkR7FytDt3PQ/W5ZRxoIaLFGP3vEJZX0fliSa5M5L7A==
X-Google-Smtp-Source: ABdhPJwBOUl2iPeoPE5yUekkkmcU6ixkgp8Km6sQSWOo1H6xsi60ul5pWS9zdIDDxgg2cso4ENBBfYHxAOkUdZrO++Q=
X-Received: by 2002:a05:6512:1051:b0:473:bb50:e36f with SMTP id
 c17-20020a056512105100b00473bb50e36fmr908573lfb.306.1651803182876; Thu, 05
 May 2022 19:13:02 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Zapatka <alexzapatka@gmail.com>
Date:   Fri, 6 May 2022 02:12:51 +0000
Message-ID: <CAFd7XocnyH8d_U8A0Mjy9+fk=DOTyiHzTR9FX+QSFevMtHGs=Q@mail.gmail.com>
Subject: How important is a full balance?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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

How important is completing a full balance after adding a device?  I
had a 16tb single array.  I then added a 4tb harddrive and started a
full balance.  It's been running for several days and I still have 81%
to go.  Despite that, if I look at the usage statistics the drive has
balanced out the free space among the 5 physical drives.  dmesg still
shows chunks being moved... is it worth completing the balance even if
it takes several weeks?  or is it "good enough" because the files are
distributed?
