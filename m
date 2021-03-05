Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1132F120
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 18:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCER0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 12:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhCER03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 12:26:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91568C061574
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Mar 2021 09:26:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e23so2130944wmh.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Mar 2021 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zilLAq3MkYTbIuxdR2QTnm2P/vmGNCdO/s0WEjP7+/o=;
        b=hJuPLE7Q7cNOPQcMBOgObyE0gEJSzcBo2jhttcsgJNxjXcusaABlOd7aA6AqV9Rwed
         4X5eLhJYpo6WDqdpXR3/OLBpxmRH1P4I7jyrR5xd0E2sSEZ3qvKlBBBXMArcbHt4fQeI
         bDzwFFOICo+RoY6Tt1iCr+rdUfHmxGXp7E5WzBZ+/44nK9/g4zZQmmaa3NDJvgqprdG7
         i4M7Iz6Gg57PaK3tjhq94wYZ/mGQLax0V39vYRBFbcIdgDTbTpBSO8U+bM/U8gUZzOku
         rBTiMGrg8dsqOlUMj8jmEezKaSWRQSKNWJEBpL2VeLuluQh3WzRtdjXi7JwpALp/h9vy
         oFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zilLAq3MkYTbIuxdR2QTnm2P/vmGNCdO/s0WEjP7+/o=;
        b=fpLxVCWRaOArWlEeKbytBnvtW1oxDQlGcf+wGn4fM6jevBE7+jcCrSQ8AV4uF44z+l
         e/WCMW9M7l+5ugOKScGnAiH+Szm8+IJ05Fd2+BmBjTItjpvMgsrFnQCgdmrjUGuePrsh
         cpjZ3Ce8KdeZhmZxeEsLY0X5ITq7GZxuwn8jHFab2zpgXzAjMB5Zr0JljQbfr8059r0j
         mjNVensF1sqUXdZllJZi/VfedyAiHVydwN+NduIYmSVohpkYhXlPFvbhnfD3nd7qbBFz
         8AlsCXghIAnFLDcd+463DJQlS+PmfeKZWixmLZjqrZ87JfWDvaXX25E8oCK27LYQBQl9
         AKig==
X-Gm-Message-State: AOAM53347JscmrPX1r8hVBhBuzx3BZJrAuaoXSunRltR7EPMST+BiNyD
        ENhr5/fPXcD9zvP/bwxkqEOZAtHwITmtLTA0yMsGqurduWnUJ9cL
X-Google-Smtp-Source: ABdhPJzsy/VbT8TVezRtUs0/OkC8HeCsQZyKDD1dntbNMOVTA8urdo6wP8h+Bb93dDPBMiNzkbtcojwDXaR7c3Mpdnw=
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr9966175wmj.182.1614965188122;
 Fri, 05 Mar 2021 09:26:28 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Mar 2021 10:26:12 -0700
Message-ID: <CAJCQCtSv7BD-8RKhHdD_zhkqH=YnFqsCqidFXRSyWrCNoaBpeQ@mail.gmail.com>
Subject: convert and scrub: spanning stripes, attempt to access beyond end of device
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Downstream user is running into this bug:
https://github.com/kdave/btrfs-progs/issues/349

But additionally the scrub of this converted file system, which still
has ext2_saved/image, produces this message:

[36365.549230] BTRFS error (device sda8): scrub: tree block
1777055424512 spanning stripes, ignored. logical=1777055367168
[36365.549262] attempt to access beyond end of device
               sda8: rw=0, want=3470811376, limit=3470811312

Is this a known artifact of the conversion process? Will it go away
once the ext2_saved/image is removed? Should I ask the user to create
an e2image -Q from the loop mounted rollback image file for
inspection?

Thanks

-- 
Chris Murphy
