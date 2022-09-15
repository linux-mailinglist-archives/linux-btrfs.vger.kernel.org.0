Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1465B9612
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIOISI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIOISG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 04:18:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01996FC3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 01:18:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 9so20347446ljr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=3rSA2Sr1NltBNqE4AJF5Kpc6LvieUzduYLuwAs3T1oM=;
        b=UTEODm7lTFX8jcYTapaVfFwg9HXE3U2no8SUojEIDTy9eQzyVNGM/UQLTn4OHQHcJE
         ksVmHVrJ2Mw/jg1+WVFncr7VsoCKKY4EvdS81ug/2KCmyZbU3acXHKPkbGCzV3daWpRL
         OjDtyXFDsfEPVHHhBffIgY8eBpEISY9vDy+UL/uwKjk5EbMRtVOqNJiq0oFTba6YAOLj
         8IU/rm5kFgapqdZms1Req9Hxhtnxcsn6NSXAd5OZL5bhRG2LabI3aAI6fwpDvCJ/maf8
         WorSK6Y6iG9QjSn57WcIguRlNrHtA1r9nEUQrBw+aGjb+7fDLVy7WaZa8VlbRxjF6scW
         uwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3rSA2Sr1NltBNqE4AJF5Kpc6LvieUzduYLuwAs3T1oM=;
        b=HcePxukqBctdpT4SpY2/75Voej58b0pjW8TqWZWVIxv8P5kUO8oi5H8cYTia1RRuco
         lMX255QGXRFlKXGFY4wggFIFxCZOivuqOJ1vJf3vCIT+LiykH+KF355DgGqF5Hn0wRxj
         e3orRlPJDKdmMSCC32yRlYKDyijAvovLtfhugD6FTOC25FE/Pf55ktxbLqQPoqy1Zd1G
         J02Q0Udn3t6d8txloi9bwEUhW3k8ORFQwhBH8WsWfD4YxoWPkYHkPJYwCKTzfwC0mRWp
         vSjqROUERcIv0RZZRaG9qemgFiOOvE7jrhEfTsKP8NNtl2RxZTlX62RxhV1dzligXU1d
         CjFA==
X-Gm-Message-State: ACgBeo0P0/BRu+VJkCWNOR3aDGTkCPidziMhXJh9nRBmeqhd8NzC9B8t
        Z3uvUgM146dhr3D4m6q4pUJolRH/zRrIYO0vKW9YOYfCzC2EIQ==
X-Google-Smtp-Source: AA6agR6z1iOA9hHivhVoQcDHaLER3cWqBkHzKEFaIgj4B29qx6153jNwHFPIfoNTsa/D5QeuxgqZ/zdHdeIuSE5xWwA=
X-Received: by 2002:a05:651c:626:b0:26c:9cc:e094 with SMTP id
 k38-20020a05651c062600b0026c09cce094mr5686872lje.409.1663229880741; Thu, 15
 Sep 2022 01:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9941:0:0:0:0:0 with HTTP; Thu, 15 Sep 2022 01:18:00
 -0700 (PDT)
From:   Touhid Muntashir <touhid.team75@gmail.com>
Date:   Thu, 15 Sep 2022 14:18:00 +0600
Message-ID: <CABW00PjDe1JKzA8du1Sfi1rNRZnH5aE+GiW=exG84SgfJJUESQ@mail.gmail.com>
Subject: =?UTF-8?Q?Franz_Schrober_w=C3=BCnscht_sich=2C_dass_Sie_sich_den_Link?=
        =?UTF-8?Q?_ansehen?=
To:     linux btrfs <linux-btrfs@vger.kernel.org>,
        Lars Wirzenius <liw@liw.fi>, lool <lool@debian.org>,
        Pierre Habouzit <madcoder@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SHORT_SHORTNER,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:235 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8576]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [touhid.team75[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [touhid.team75[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.4 SCC_BODY_URI_ONLY No description available.
        *  2.0 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Bei Ihnen wird es =C3=A4hnlich sein, wenn Sie es ausprobieren! https://bit.=
ly/3DlBmnX
