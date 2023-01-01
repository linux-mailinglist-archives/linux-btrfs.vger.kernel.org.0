Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1165A8E1
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 06:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjAAFEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Jan 2023 00:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAAFEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Jan 2023 00:04:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3942BDD
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 21:03:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso23374020pjb.1
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 21:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kota.moe; s=google;
        h=in-reply-to:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4NBLuza6ZevZYU9BZXyTmfjCyX5kPTFi4spLceuyLI=;
        b=Xg1AfSmPiZ2YH0AC15mgF3HmUiXsJTH4o0XGJH3ZRbLfk9u2knCPfPaQXjToGfi8Zf
         +sDY/AVr3mz5BkGZSf+x4opHTzgpdvkPapHgyXUh9hSs0AR9iUqL0Bk4vLC0gUizdv0w
         JQ1Jnx+yCaa/TmWistiRYujX1TEQRKSRwexYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4NBLuza6ZevZYU9BZXyTmfjCyX5kPTFi4spLceuyLI=;
        b=PebvwA74dSfzXrWq/mUind5JxDFbonZ7tHlZQ48XBOTy0BNCkcp9Bwgmutux6wmq2O
         Buq6h+UXiNsATQU5WJnc0CtgD+Vcjac86TZf0Fri5d735xiyDO5ZKeuXvA+LJsxgQE8M
         HuI3EyaJiww3PwaizhJStXpVqMod0EnLJsdJxArtor3qgHx6tWCgSG/4oCl8AnlUAnrG
         EZoHTByv2Umc+dx4fqMstHlbNS9cMYEcK0c1WxbMTQ3ABf/bXYHzIvktfIAQ6hO3efch
         79qEDzUE0eQTOlaWfdffHd1up0zrRg8LD0gwu1w9Y3haV6hfrpxtAndPHS53RLujqUcQ
         dUZQ==
X-Gm-Message-State: AFqh2kr+BLTBf8sQqoNzJAYXIZbJ2v4cTjh3nQ0lJmcBDBwWlwf10O6K
        HfMo53WFAuD0wkcbFGA5M65wowKEpbM02r9n
X-Google-Smtp-Source: AMrXdXt0EnMCkXaOWK0FukgqgkNIDlv29OBgiismGoYCt0WvdvywgB6UhAJCzYN5/h3580XSv9gg4A==
X-Received: by 2002:a17:90b:23c6:b0:225:c362:7362 with SMTP id md6-20020a17090b23c600b00225c3627362mr32018126pjb.8.1672549437903;
        Sat, 31 Dec 2022 21:03:57 -0800 (PST)
Received: from home.kota.moe ([2404:bf40:8181:20:4206:cfeb:365e:302e])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a09a100b00225f49bd4b6sm10050636pjo.36.2022.12.31.21.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 21:03:57 -0800 (PST)
Message-ID: <63b1143d.170a0220.9d74e.f651@mx.google.com>
Date:   Sat, 31 Dec 2022 21:03:57 -0800 (PST)
From:   =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Buggy behaviour after replacing failed disk in RAID1
References: <CACsxjPaFgBMRkeEgbHcGwM7czSrjtakX9hSKXQq7RL2wJZYYCA@mail.gmail.com>
 <CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com>
 <d13c2454-b642-2db7-371e-b669fdf24279@gmx.com>
In-Reply-To: <d13c2454-b642-2db7-371e-b669fdf24279@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Weirdly, the dmesg is not showing devid 1 missing, in fact, it still
> shows the devices is there, just tons of IO errors (ata4, sd 3:0:0:0)

> If you initially removed the hard disk completely, btrfs then can handle
> it well.
> (Sure, this is a bug in btrfs and we should be able to fix it).

I did completely remove the drive. In fact, I used the very same SATA port for
the replacement drive. See my dmesg lines:

> [1744757.386462] ata4: SATA link down (SStatus 0 SControl 300)
> [1744762.810285] ata4: SATA link down (SStatus 0 SControl 300)
> [1744768.190059] ata4: SATA link down (SStatus 0 SControl 300)
> [1744768.190072] ata4.00: disable device
> [1744768.190097] ata4.00: detaching (SCSI 3:0:0:0)
> [1744768.295895] sd 3:0:0:0: [sda] Stopping disk
> [1744768.295913] sd 3:0:0:0: [sda] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> ...
> [1745523.320657] ata4: found unknown device (class 0)
> [1745527.965324] ata4: softreset failed (1st FIS failed)
> [1745533.288241] ata4: found unknown device (class 0)
> [1745533.452246] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [1745533.453025] ata4.00: ATA-9: MB2000ECWCR, HPG4, max UDMA/133
> [1745533.453306] ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
> [1745533.454136] ata4.00: configured for UDMA/133
> [1745533.464339] scsi 3:0:0:0: Direct-Access     ATA      MB2000ECWCR      HPG4 PQ: 0 ANSI: 5
> [1745533.464556] sd 3:0:0:0: Attached scsi generic sg3 type 0
> [1745533.464652] sd 3:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
> [1745533.464667] sd 3:0:0:0: [sdd] Write Protect is off
> [1745533.464671] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [1745533.464684] sd 3:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [1745533.464700] sd 3:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
> [1745533.492586] sd 3:0:0:0: [sdd] Attached SCSI disk

I also verified that the device file /dev/sda was also gone at the time (despite
"btrfs fi show" thinking it still exists).
Maybe there's some other bug where the kernel still thinks the drive exists, even
though it was disconnected?
