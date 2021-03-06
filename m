Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEFC32F95D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 11:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCFK3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Mar 2021 05:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFK2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Mar 2021 05:28:50 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59025C06175F
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Mar 2021 02:28:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id l7so3967087pfd.3
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Mar 2021 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XDXesKXA8o5PEtaEI+C02f8zZBrtKe9eLzBxylg+xXE=;
        b=IIPyGthGEA0OACWVdPuCi/fCv89EBs/Jkfb792+6EJ5m42GJq4AbpKjoVDCCEGPDnb
         QcfwlRbE2dFsL6v9hBx76R6JB95Qvkw2KtxroQ5MIILmv08+imnguyVYNehtLpmmuUO8
         8eZcDJyx1zx7/HIvlNsdvtfKoagCPfzLmtpQy4Ayg7zhEYSGzUXIiRRV7+gEtBfcPGTP
         AC0xg+bRFXFX76BvNu7nRf5QqOM3oFtaj0FolJZ/nqkmfspMou4+6Dye5ba4DtFu1nPn
         IKExx0VEXJ82E4LCcGkPfY4Wa0ukVsnsyZEG2eJd0tLNqY1IzGMiRNzmFysRCVmZETEW
         hJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XDXesKXA8o5PEtaEI+C02f8zZBrtKe9eLzBxylg+xXE=;
        b=p5GVbKx5lvD/i13onfzuy6eEsWNpahOEChSAtvZ6zD4G0rX9tWK7cnN/wq2/CX2fvF
         Rv8bfkR1hh2sOqjOf8JGc+4nwW9dFbtkhx8bCPKR9g994lmD8gfElwAGfmgfpqZN5rvK
         SgAGKM7AB6Jbw0Uj4ldiCCahargjYClbnbb3zsQ71OzLkBHFWpJgJNfJyyim/QwMNeVU
         wag71cT3EcjzFFl6DLul2+MSEffsgRzq3yiJcaxZ5sbLV7DmZIk6OftUda5AsTkQ6sCG
         nKp6uVqiHBBKvXqMv9kijxe3YZhFlLYrfRorIreKNJKLRr/xCBmiVIG8Ktj04Dw1zlL3
         BaPg==
X-Gm-Message-State: AOAM530gaBYUZJBxePH20AjziBEohw4LfU2eGfkJ9uW6yF7DDbVVdiLG
        qj6FKe2LwzfF5CFlIm7LexOknHOg2PspPHFR5pE7r0RIhAWg1w==
X-Google-Smtp-Source: ABdhPJwvzqQs+/rTkjZTX0vYts26FPFsaWMeGymhck5SgYYly0etBQjItLONfggLG9QlC+ZcQQtkhxcA3C3gOgTusPc=
X-Received: by 2002:a65:4049:: with SMTP id h9mr12264829pgp.215.1615026529692;
 Sat, 06 Mar 2021 02:28:49 -0800 (PST)
MIME-Version: 1.0
From:   Abe <abe149@gmail.com>
Date:   Sat, 6 Mar 2021 05:30:04 -0500
Message-ID: <CA+Xw_vCB_i5iEj21JgBY7d4RAnqV9oiXpdm+H6dq6BMFCusYSw@mail.gmail.com>
Subject: possible documentation bug[s]?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all.  *Long*-time Linux kernel hacker here, long-time
storage-and-filesystems geek, new-ish to Btrfs.

A few weeks ago I noticed some apparent intra-row conflicts [between
"Size" and "Type" values] in the table at
<https://btrfs.wiki.kernel.org/index.php/Data_Structures#btrfs_super_block>,
so I documented these possible bugs at
<https://btrfs.wiki.kernel.org/index.php/Talk:Data_Structures>.
Tonight I checked, and apparently the main page`s table still has the
relevant inconsistencies, and there are no "replies" on the talk page.

Tonight I also found one more inconsistency [the one relating to
"csum_type"].  I documented it on the talk page.

-- Abe
