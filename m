Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0311D7A1C57
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjIOKfX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKfW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 06:35:22 -0400
X-Greylist: delayed 199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 03:35:18 PDT
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [89.1.8.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B33A94
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 03:35:17 -0700 (PDT)
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id 6915912983
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 12:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=netcologne.de;
        s=nc1116a; t=1694774116;
        bh=XivfFzVVwl9wA06PbxlOJkjvR0uFvJOjhS/34uVAFvw=;
        h=From:Date:Message-ID:Subject:To:From;
        b=NonLthyiA9/t8icVFecfu4ZslfrSz4kGK6IIjhjfCbO3fK/wMuIAp8tWYhv0EXhpf
         ydgU6ojnbkQc93sMa4ArUiZY8VN2xVKYUc6v8VDsRlox/PrWi7To/mVeRRL222o33N
         7G+aRaFtxllchXA+rj9uYc0UKfG+LcSTMSIgKp/IcbTieCUGXnYOzX1CzNVUR5v6Jp
         DWrHGaEvMeogyWiF4oQfpklVoWYKjVpI4RrzVv2W0JXkzcpLJXLXR/yAvdjwpDWhZ8
         fhEddEPd0RSaBpTBSs4pfoDEIJGGO3OV4UvOo7fuKQ7z9YpRqFcCBsuL4eAF1qyqIT
         sjzuE2TgqQr7g==
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA id 4439311D85
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 12:35:16 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-577e62e2adfso1613124a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 03:35:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfIWlZTJZlBKRZ1uZEOQrGgFu3jbz/269iQPVJnSXnl8ObY0co
        ugDpfAaK7TT0d8fG4IyQAEx5lVnG6cu0sXUCnJw=
X-Google-Smtp-Source: AGHT+IFUV/NXZB4KqBA8SC2/mgkfqBDBZAwimOPKq+E2inNmJ6igz0FLCiIE0kAumDhkWscIXbV0c9iADRyDtBKK8sg=
X-Received: by 2002:a17:90a:72c7:b0:268:10a3:cea8 with SMTP id
 l7-20020a17090a72c700b0026810a3cea8mr965292pjk.9.1694774114809; Fri, 15 Sep
 2023 03:35:14 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Malte Schumacher <s.schumacher@netcologne.de>
Date:   Fri, 15 Sep 2023 12:35:03 +0200
X-Gmail-Original-Message-ID: <CAA3ktq=Vfik2BA4pYcrRqvXWR6WDLZPVtM96_oW2tmaXe4-eAw@mail.gmail.com>
Message-ID: <CAA3ktq=Vfik2BA4pYcrRqvXWR6WDLZPVtM96_oW2tmaXe4-eAw@mail.gmail.com>
Subject: Addendum to last email:
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-NetCologne-Spam: L
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4439311D85
X-Spamd-Bar: ----
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

root@mars:/mnt/btrfs-raid# btrfs dev stats /mnt/btrfs-raid/
[/dev/sdb].write_io_errs    177062143
[/dev/sdb].read_io_errs     88533832
[/dev/sdb].flush_io_errs    479

All other drives are okay, meaning zero errors. The latest drive is
only /dev/sdb since this reboot.

Yours
Stefan
