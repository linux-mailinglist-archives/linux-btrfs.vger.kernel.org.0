Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639DF5BD1EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiISQLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISQLq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 12:11:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0828E0A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 09:11:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so15825877wrq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:from:to:cc:subject:date;
        bh=zLZ7ROIxaGymbggabYyhljTWcKv+Zro2fWDSv4vg1z8=;
        b=hFW43OIgepPKO7r8z64z2S3Z0IfZLgTsXw+FaFx3HtjXG2V+dcC7gUK7mY/Igy2OWh
         hucRISpESkZP/W+27FizrzmlolNjCZueH18248t94ltGNuxynBu7gLmw1RyuyG5oXoB1
         JW5ItNXan8ytZMhEEITS+7QH5xMKxLtZ9/CAtMtrsGVQrTbGg12R7H4wTRTsqiy0BjNa
         mrKEv9iZIv90E7yj3gvbmDpyE7fyIqTukMUIRsLqixYNwFZ/DC3+hL9Y7fa38jXgbopm
         kqU42sxc4wx4DoK1ULgBWL6C2Ka+HYIMHHWBD3mtBDLhLJQvnfGHD+z88L8a/WKe4cGn
         RvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zLZ7ROIxaGymbggabYyhljTWcKv+Zro2fWDSv4vg1z8=;
        b=D7tfUwasHeLQxNQv5afzgSIvlF3i8q3UcgWUK2ucVJ6VTsu0zTZ2BuWSEf3dR8KQkg
         ptueVfKwJ9lY52/h1s6XmO2Aw/hGccmpmFkO8H4nxEt+uYdeb3fZx5n5amATjeUKeAvk
         EeyN51MR/dKUaJ5DD1vWOf59mDNlQ+RGr2A5K0Z7t4UEeM36m3w0Qi/NV/C1ov5VbSoU
         8aXl/DzvlgO/d4K307gf3+81Zm5iqk2fKJVDsxPp8e46qiXp5LRwEixBnYHbbmb1cPo2
         NmqIGsSr1slvQrfB7PwjoH7wm2Kvm6SrwIGartMQxVjQs8K3NJY17Aos1m4MhkUVntQh
         qoZw==
X-Gm-Message-State: ACrzQf0qbMonEt5xxVbz0diB/BsRKZ6cQNEalU6sT1nBO5LGEe/zhpLJ
        AYf9bnkaDlRON56nMwBJue8jwVSrU3Q=
X-Google-Smtp-Source: AMsMyM7TZ3A6M0rlo8CfZDVZSaOG4osO5TCA0BEAf1g1KNTmE3Cbr8IVEW/I2ElBDl+FR9z6x8W84Q==
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id v10-20020adfe4ca000000b00228d8b748a7mr10950353wrm.300.1663603904006;
        Mon, 19 Sep 2022 09:11:44 -0700 (PDT)
Received: from [127.0.0.1] (77.119.203.40.wireless.dyn.drei.com. [77.119.203.40])
        by smtp.gmail.com with ESMTPSA id w14-20020adf8bce000000b0022ac119fcc5sm14714602wra.60.2022.09.19.09.11.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:11:43 -0700 (PDT)
Message-ID: <19a351d3d3c9b16c599da5d1de1e94d9@swift.generated>
Date:   Mon, 19 Sep 2022 18:11:38 +0200
Subject: Domain hardwaremonitor.de
From:   Peter Schroeder <schroederp64@gmail.com>
To:     "" <linux-btrfs@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sehr geehrte Damen und Herren!

hardwaremonitor.de Domain Name ist jetz=
t verf=C3=BCgbar und ist jetzt zu verkaufen.
Falls Sie weitere Informatio=
nen brauchen, freue ich mich auf Ihre Nachricht.

Einen guten Start in =
die Woche

Peter Schroeder

-----------------------------------
