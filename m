Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CB076C2BE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 04:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjHBCPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjHBCPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 22:15:33 -0400
Received: from box.sotapeli.fi (sotapeli.fi [IPv6:2001:41d0:302:2200::1c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9C268E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 19:15:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E151E7D949;
        Wed,  2 Aug 2023 04:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sotapeli.fi; s=dkim;
        t=1690942523; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=oaHjHFFTm3+DBsn4Xj+xQRam8IdmEj0l4aehR8mXaBg=;
        b=xwf+npPy3xnfgdot7w0EhW6WqFJ3yc6jweEZnvX9xTI2wgWtqiWgjwccUwuXViXdig38Zi
        oq6I6+XZcGzxBsBQ9/97RWxQ1PcnunsgpdscmrtsmhN7FY3q3xrf5R0khL658iBjkSR7FN
        WHkr7yWWDJlmCyvd39Vt/vaYCMG5U4St2MgY/10pYqT0pFXKzB/hY/ngAczFdai1hwuwg9
        U0ptlq7dvoN3pDFV0rqBWvWF3Ddqr5t3sV4g3eYqkAFu0UoGYGbWqE7bFWFxgM8DLvXKjn
        kx/9qoxhJ2R2tx5Z8qWmFIqK1e/bkvfhRSnV6jCf3TaDGqDG0jmZpjEmv4NJkw==
Message-ID: <a4ed97f4-5b9b-3958-8432-e45e7701ee1c@sotapeli.fi>
Date:   Wed, 2 Aug 2023 05:15:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] btrfs: scrub: improve the scrub performance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1690542141.git.wqu@suse.com>
 <2d45a042-0c01-1026-1ced-0d8fdd026891@sotapeli.fi>
 <48dea2d4-42ba-50bc-d955-9aa4a8082c7e@gmx.com>
 <ffd7ece2-6ee1-7965-ba9c-47959c1f5986@sotapeli.fi>
 <021d0dbc-344a-2515-f819-3905be15b4d9@gmx.com>
From:   Jani Partanen <jiipee@sotapeli.fi>
In-Reply-To: <021d0dbc-344a-2515-f819-3905be15b4d9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 02/08/2023 4.56, Qu Wenruo wrote:
>
> So the btrfs scrub report is doing the correct report using the values
> from kernel.
>
> And considering the used space is around 600G, divided by 4 disks (aka,
> 3 data stripes + 1 parity stripes), it's not that weird, as we would got
> around 200G per device (parity doesn't contribute to the scrubbed bytes).
>
> Especially considering your metadata is RAID1C4, it means we should only
> have more than 200G.
> Instead it's the old report of less than 200G doesn't seem correct.
>
> Mind to provide the output of "btrfs fi usage <mnt>" to verify my
> assumption?
>
btrfs fi usage /mnt/
Overall:
     Device size:                   1.16TiB
     Device allocated:            844.25GiB
     Device unallocated:          348.11GiB
     Device missing:                  0.00B
     Device slack:                    0.00B
     Used:                        799.86GiB
     Free (estimated):            289.58GiB      (min: 115.52GiB)
     Free (statfs, df):           289.55GiB
     Data ratio:                       1.33
     Metadata ratio:                   4.00
     Global reserve:              471.80MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,RAID5: Size:627.00GiB, Used:598.51GiB (95.46%)
    /dev/sdb      209.00GiB
    /dev/sdc      209.00GiB
    /dev/sdd      209.00GiB
    /dev/sde      209.00GiB

Metadata,RAID1C4: Size:2.00GiB, Used:472.56MiB (23.07%)
    /dev/sdb        2.00GiB
    /dev/sdc        2.00GiB
    /dev/sdd        2.00GiB
    /dev/sde        2.00GiB

System,RAID1C4: Size:64.00MiB, Used:64.00KiB (0.10%)
    /dev/sdb       64.00MiB
    /dev/sdc       64.00MiB
    /dev/sdd       64.00MiB
    /dev/sde       64.00MiB

Unallocated:
    /dev/sdb       87.03GiB
    /dev/sdc       87.03GiB
    /dev/sdd       87.03GiB

    /dev/sde       87.03GiB


There is 1 extra 2GB file now so thats why it show little more usage now.


> Sure, I'll CC you when refreshing the patchset, extra tests are always
> appreciated.
>
Sound good, thanks!

