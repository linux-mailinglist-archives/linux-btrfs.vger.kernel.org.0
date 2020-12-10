Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB32D5BA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 14:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbgLJNZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 08:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389197AbgLJNZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 08:25:03 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED9C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 05:24:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p187so5496038iod.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=twWqak6BbO7zUE6vgfZjvzBPgf4lL1/LoBvv6cPKi8c=;
        b=E46/CIy/s9KaLTAVBIa1mmhSz2xl7IHyMeEgK3W2u4FqoGPrLiocNJf6ypFBiGMuSa
         Vhz4NnbETyRep6BekQXfRtfu8J2qT0fn6DcPPKkVF2lRH3iYeGrW/GmlIPQ+w6KHTZti
         QijxGt3G6QPyNLteMN3tapm5JEiZeI+gMT0q/QPXJMFvyGKrENFedeEO4hGORixKugp8
         cntamW8UUF1HplkEIXScgwZq0LDGm3h3/zkLqJdlXyxTcIV2MA+MXQiMp/2C/FRrd7wC
         xSz/2aszA3BEd52BXjYniOQFE6Gvw4g4izzRhtucNgaCI684YFMVGbmyLDkdp2AfayiP
         wXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=twWqak6BbO7zUE6vgfZjvzBPgf4lL1/LoBvv6cPKi8c=;
        b=XRuCjI5Y90u+0SJGZyX46pWzcBPc7gsPjWX2ppDZzDuYGasD4iwiAwpBM90cgHd2+m
         00Hoc3RnWz7Jb18b+Gwd7xqUD/sPzQwP2Ije9yK5Z8iT7BjzTNKJUpg4lbFxYCC+AHta
         mwa+mqshXcEDsoszFTxNeWJz3dcJiG7Wf01GAT4HSiHIbLt7WqQdVjWttUxklyX8+kxx
         12SN2N6JS2xeGPsZT17S/w7YFKzIhDb9AeZ6JeOTQHjCwOpvmoY5453S4tGoSIKFU2Jx
         Ap8C5r1PxLQCsL8gSaRgpHtwDt2QL04WfSrR1PfFXjYTRkPNVdXx0sPfwcgbFy+Xs1ot
         x79Q==
X-Gm-Message-State: AOAM5319qoj7aIG+ABiKVETU0tDzG2NHETChtK56Q7QbTGfOhqAb6Oo9
        PhyG1zQHYCP/ZGzie09KlGjr8PDD5h4jFXr8+xWtLqMUZNM=
X-Google-Smtp-Source: ABdhPJznoHRhnwek9aCA8uaAUY2PM72bvZvcLvSxFNBs/2hYA4/6ilCTN5I/uON/v9qTCkcBGNv2RevuRu6nIlTZuXg=
X-Received: by 2002:a5d:9149:: with SMTP id y9mr8396445ioq.37.1607606661851;
 Thu, 10 Dec 2020 05:24:21 -0800 (PST)
MIME-Version: 1.0
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Thu, 10 Dec 2020 18:54:07 +0530
Message-ID: <CAMaziXt9PAju7eQ3yqgtCCyGysb+sgn5kQepZ+uRqi7PVMW0pA@mail.gmail.com>
Subject: How do I get the physical offset of a file in BTRFS ?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

How do I calculate the physical offset of a file in BTRFS ?

filefrag does not work.

-- 
Regards,
Sreyan Chakravarty
