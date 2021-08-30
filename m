Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A263E3FBD2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 21:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhH3TyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 15:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhH3TyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 15:54:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51582C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:53:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k65so30408748yba.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36/3avwMfnyw1R9hQyng8zSar0SsKdSGGOxgdNEbrqY=;
        b=EfqeF8CfWJ/ESMfvgrdh1X9qMTXXQwi+nxud/XEPLhWfUdmITY/RJsjnKwnLFBkLQb
         /GeahvL49d0Bohf2GZfCDWsEK54sKZLW41U1pbcL1L9okZurSK5PJc3hIP8Cs9yxqdfw
         p/1C1+RgAfK1TREVgoESyfSm0ytZVexU6azxI1d787oVh38yVWMq/QJVWRJ/yYXc5Ef8
         A75CfXC4gXMC2uWA4ViTdggQnBrsIyt5bCoB945qgc5L89nUvYFEYThJMaGOvnQPvCfj
         5y+2N/dmEHtcQ+s0g9Y7u/ahxA2PcUoqdO7ealQ1d4Gk3e/BHnJgAox4/WuymfpC/feU
         +pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36/3avwMfnyw1R9hQyng8zSar0SsKdSGGOxgdNEbrqY=;
        b=Zoiwcax98BhaJSeBXka/fjZcaoZYQEGLPYIs0RaCK1HgOmInOTM5H5WW5c+Y92X6bs
         psTXzHb57XqGh7M2XWCc1Mvu6aAFG4C32yys0LV6g7EQhYQRytuuPG0D0wHQjvAm29RE
         aoMDK6nVAb8epJIy6AJQjeVcz5C4b7EnYySnUkjKVoDW4a4Xhw5TUobhV1BmaMOCmp6n
         aQZw3KcifctB63p64mM+kflu3eWgIennxt3hOC4ZrnSuyK+CEwYShvRS5lrCLaeH7r53
         zsVHUMMpCWWnFibmVs5MFRnU40jaXHyYZK/MBHR0bg2szU2aJ/DfTwZ5gg4227RnYRIZ
         Hs4w==
X-Gm-Message-State: AOAM5321HkO5TmxWMSUVHwXAVDi05H1FlW2UJeLeE70e0qCbmhXsaYgw
        wbLzZyuTdXnxhIweAK7bo+4LQCfxfSd+eMNnJiHfJ9g6GEYSy0OY
X-Google-Smtp-Source: ABdhPJz+T+P08SaOVorAnjbbIhB3fjrpSSVv2Nd+Ea/lpYlN2noux+eIyCbojABr8PcbmbszEkYXTYa+hvhTY01f84o=
X-Received: by 2002:a25:6cc1:: with SMTP id h184mr24580854ybc.240.1630353194623;
 Mon, 30 Aug 2021 12:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSXKHSToLeOOconR_nKeuk8RjGjT7_z2QvV9=2zHfYB6g@mail.gmail.com>
 <CAJCQCtSjuEg8LAedxaqpRCOEq5BgegB7=QVJP8Sq3iZUFWn1rw@mail.gmail.com>
In-Reply-To: <CAJCQCtSjuEg8LAedxaqpRCOEq5BgegB7=QVJP8Sq3iZUFWn1rw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Aug 2021 13:52:58 -0600
Message-ID: <CAJCQCtQPvw23CGvR307L-VyPSpZi3ovC3N+xp7OaMNrxSWir_w@mail.gmail.com>
Subject: Re: 5.13.8, enospc with 6G unused
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mount options

/dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835 on / type btrfs
(rw,relatime,seclabel,ssd,space_cache,enospc_debug,subvolid=257,subvol=/root)
