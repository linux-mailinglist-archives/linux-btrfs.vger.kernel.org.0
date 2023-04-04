Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61466D6DEF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjDDUVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjDDUVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 16:21:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6E3C2F
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 13:21:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so135541081edd.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639704;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VkkAPQ7+MbEN0yKVWEKAsNamEmzYQFKuTB4CJqa7Fv8=;
        b=Yu92E5pGLcu7aZjA1ToN0hgDLkbSpcRZ94Ns+4wnqfNpUb8rRke73m5a+v3I4HHDXn
         uzS3XIjkUc+0mDj+jtKtRi356GTl/Jb9vZrmbJZqCO8XMEcTJHIksoM9RTmDJewlP4xn
         ZsEUS0R/iLHxPiDJXGVKx/z5sKNrvXZuejOkAnMHSltTIFwt5ve/2GuApn9dT2kvek/s
         aspfPiJbTmEispyzTHinwazGYQsYBiz4Q/IgpB0Jnd5oP6LKheNIeQ0pNVOXEYtkIDt5
         9xFn3Sjkai1uyjMM/YrO8dAjXuCZCJsmc97Twva8jkDcVND+OoM3IqSj4eUgvoRDz7UP
         vC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639704;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkkAPQ7+MbEN0yKVWEKAsNamEmzYQFKuTB4CJqa7Fv8=;
        b=6TKGDKS2k95mkL3KjqMcZ95kpr6SZICf6x/pss8sDGvPuFB6H70EL87+rXiZJqbX8V
         ywQEAgf9/j+4nhlwkqZnFVY/ALIXjli1FkqrpYiFyscKhjZ1Q61r8pAQfykcC1Aslyz3
         lHJhiYc06VNCkGC+/R9yhj2fY4tAO4/dJ8ntC4KDx7QqUcQh7YSR+k327nWrrrlVr8Rt
         0/chu/oImq5TAQX4xRDGZDlL6F06O2ZBQp6sZKL5iwVTd1B2KiZLSs3gyhjoccslGHBx
         JOunH1RzGurjGB0+lnPAReoCrFvyK6lIMHqWOIQRI3O0Ydb5CqMsPW94uzr0iRbIEeuo
         gq6w==
X-Gm-Message-State: AAQBX9d9QMt9lN4/uVdbAHMihNDXgToXT546AzRrj1LSpJLDVf4pmbUM
        pJJgjFQNuItM0QfCxQ/0QNvuRcFiXpkSBR774nStavkzzeSt3g==
X-Google-Smtp-Source: AKy350barVgoUNcN27Rc0tlFeZtDIZskHLi8/Pxoat+VqQgxuDUiq4MGVeoh8Wc2DT7AXqv6NHSHUBU1Sh+tog6T1vw=
X-Received: by 2002:a17:907:8c17:b0:8b1:3298:c587 with SMTP id
 ta23-20020a1709078c1700b008b13298c587mr421845ejc.2.1680639703558; Tue, 04 Apr
 2023 13:21:43 -0700 (PDT)
MIME-Version: 1.0
From:   Torstein Eide <torsteine@gmail.com>
Date:   Tue, 4 Apr 2023 22:21:32 +0200
Message-ID: <CAL5DHTE6ffo2PUdOEeN1OqaCen_an15L3suOXS4cNkz__kPzXQ@mail.gmail.com>
Subject: [Bug] Device removal, writes to disk being removed
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug with:
-  `btrfs device remove $Disk_1 $Disk_2 $volume`

When multiple devices from a volume, it still writes to $Disk_2, will
removing $disk_1.

## Command used:
````
btrfs device remove /dev/bcache5 /dev/bcache3 /volum1/
````

## iostat
````
Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
MB_read    MB_wrtn    MB_dscd
sdc (R1)       225.00        27.19         0.00         0.00
27          0          0
sdd (R2)        94.00         0.00       105.56         0.00
0        105          0
sde              324.00        27.19       113.06         0.00
27        113          0
sdf               322.00        26.75       113.13         0.00
 26        113          0
sdg              310.00        26.00       108.06         0.00
26        108          0
sdh              325.00        27.19       113.06         0.00
27        113          0
````

## uname -a:
````
Linux server2 5.15.0-69-generic #76~20.04.1-Ubuntu SMP Mon Mar 20
15:54:19 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
````

## btrfs version
````
btrfs-progs v5.4.1
````
-- 
Torstein Eide
Torsteine@gmail.com
