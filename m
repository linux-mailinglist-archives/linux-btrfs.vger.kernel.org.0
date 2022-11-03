Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B30618AB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 22:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiKCVjT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 17:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCVjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 17:39:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82C1B9DE
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 14:39:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 130so2832175pfu.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Nov 2022 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fSaPBM2WbQHD62OGBqtVD15O1ebfKWbx/yFp2XlV+Y=;
        b=ljSNeGSYwnwuQXRV5bT6ZOaWTsAhYhXQzlAON8NCvyhj5pelTf3FDJoCQZ+8s5+26l
         mHq/dy0GszdzrSkYMUphmoIDzaoR1bnXTlskYB1J5U6wBECxBWZlmlHsw4KCTu4Fj9o/
         d8MpGfZv7xPpLcBd9cnX0eh60rlOB+bXjuz8v9CPXDgPtErwI5MgtPQ1EQfF8O2k+hZK
         1xTIz4tmsE11R93ysWclnU38HyE2qzMgA8ZhwFKv4o2Wj608TxAd9KSn5NaoHVmsFaaq
         NvkmV/EJQ4EbcvQX6Z8Mv6dp7bj8fsmt/1McMFRiPky4QT4Irg60QsloOWloh2FECaOb
         h2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fSaPBM2WbQHD62OGBqtVD15O1ebfKWbx/yFp2XlV+Y=;
        b=hdwKkcfLRMBqelIvaRAXC3uvYKDWD6VrhxL4U13Y0pQtytdSgfHlQliL1oBljIzaSs
         dl2ESL2bsay6K8E4NrXi/iQCIOza4u6+QQFOn+nY0J6CEQB5fXccaryPukg8L6yE7s64
         5uZeCHjpRsBuLhqBbRWSuqQfEYYuoaCXIwHsFpKUCGy0/7GFn7DjcQePq4s2kAffHunU
         PZtBwdchf7BWzzoMHRI8mzXX28gzoDoHhXwkzlMt8dquXmEnD7pRVuKkn1NfeoA1MJgT
         FZbBJbt8cm9Bx8kXZKypllYu0vBcyoG0klUPgYWgCyMIsP85svHBiYTDin6D5lwDNM3v
         0dEQ==
X-Gm-Message-State: ACrzQf12DcbPB1ZHfcfB7a83goKe3asJsc5XLby1I8cwYc14/uFlzDul
        LQB+PgNOZhH+qog1xRHXicOptSu2SC0=
X-Google-Smtp-Source: AMsMyM659tVlKqCouXyFYQ+CV+NxH4hoazjBQ0dthva3k0tWEdOetHjTIKPfPL+4jcuwzlIGOzxlyQ==
X-Received: by 2002:a63:ea08:0:b0:46e:9bac:6d9e with SMTP id c8-20020a63ea08000000b0046e9bac6d9emr27614592pgi.334.1667511556685;
        Thu, 03 Nov 2022 14:39:16 -0700 (PDT)
Received: from ryzen3950 (c-208-82-98-189.rev.sailinternet.net. [208.82.98.189])
        by smtp.gmail.com with ESMTPSA id f132-20020a62388a000000b0056da8c41bbasm1197403pfa.161.2022.11.03.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:39:16 -0700 (PDT)
From:   Matt Huszagh <huszaghmatt@gmail.com>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
In-Reply-To: <20221103171848.540a9056@nvm>
References: <87v8nyh4jg.fsf@gmail.com> <20221102003232.097748e7@nvm>
 <87v8nw3dcg.fsf@gmail.com> <20221103171848.540a9056@nvm>
Date:   Thu, 03 Nov 2022 14:39:14 -0700
Message-ID: <87sfiz3egt.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Roman Mamedov <rm@romanrm.net> writes:

> If your backup is incremental and only copies modified files, you can ensure
> all other files are also readable by recursively reading them:
>
>   find -type f -print0 | xargs -0 cat > /dev/null
>
> ...for a kind of manual scrub. Unless you had nocow/nodatasum files in there,
> any damaged ones will return a read error thanks to Btrfs checksums.
>
> Or maybe you could check if Btrfs scrub has also stopped hanging, given there
> are no disk-level unreadable sectors anymore. (And after you have also
> upgraded the kernel).

I was able to run btrfs scrub successfully with the problematic drive
removed. Logs show that the following file has a checksum error:

BTRFS warning (device dm-0): checksum error at logical 10087829524480 on dev /dev/dm-4, physical 1883324207104, root 28842, inode 27543115, offset 74526720, length 4096, links 1 (path: matt/.recoll/library/xapiandb/docdata.glass)

What can I do to get BTRFS to no longer report a checksum error? Do I
need to delete this along with all snapshots that contain it?

> Btrfs currently does not seem to be famous for smooth disk replacements
> unfortunately, even if you would use RAID.
>
> I would suggest keeping up with the good backup schedule, and then rather than
> using the Btrfs "single" profile stretched across devices, switch to MergerFS.
> That way any disaster on a particular disk leaves other disks and their
> independent filesystems completely unaffected.

Ok, thanks for the input. But in theory, BTRFS with a redundant data
RAID (such as RAID1 or RAID10) should allow scrub to preserve all data
if a single drive fails, no?

I'll spend some time looking at mergerfs.

Matt
