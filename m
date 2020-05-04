Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63441C341A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgEDING (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgEDINF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 04:13:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745EC061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 01:13:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f13so19739136wrm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vs1Fkqs74WNhxJMVUNfFnzefCNY6RU5V4RQ9mwuHd8w=;
        b=H0ptC/RIKHBqQtw8wQO2+FwJ4LExTYRArtsWzBfqbOFwbqE9RhhqDmSMam0jzDDYJ5
         mJNKis4dGsSWRX6VecH2mFFiukHzZ6MLDNcpo5IkWYXLNVo6CLLhgYKQeG/Ic6mK64Ow
         tbTY7i+u0xtj+LA9seLbQmCL3nM5RPyMA893WPRHCEAHgR6zAxh0jnTCryRUGpVdtaZE
         1FRWhFxJ4QNn+Osxutk35xUoaBNKA5VdPGBKMsXkyCJJSjtyReCW+cMfVzpW0rGsnnjI
         +dMHvhpx8Ut/vzocHew9WmcL4x8D92uPzKHcj6s6cKbjLmguwLYtpRznXhgrOz9gpYaC
         xVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs1Fkqs74WNhxJMVUNfFnzefCNY6RU5V4RQ9mwuHd8w=;
        b=W8kIQvcrOFxMs8QvPfShatw/65WI4A12MANaLlDQp1+rlF6nLVPVFUWv9sNj39+EzO
         nUxoVD0Wbjx6Rqszu64KGbavufb6uxMe+S9HD2akAq/MaPX7g4+YsDTGQsacIYp+xITO
         kVgRmcU9JngPfAEAmxjBF71/pdM0IuzLdwfO/ZZmg9fCn9YtvChHet9uqH/ZjD+f0x9D
         s4Wwxp0+Kb7JUXeW88yUKQ5HyDtglQ7BBkqzPG1jA6vg+cZUIt90AblK/+niH1sfkEv6
         RoUrh+DkU/KPJee7opcytLxYLDV9tUe+e8asr/B4QuTeL7dKy/8/21xEXKamSwrZdKGK
         fdsQ==
X-Gm-Message-State: AGi0PuYozu21L30c2+LtLrvE5wcuk1SlPJkvU3ZAdpnjWT9VYGO7PXQZ
        IiB1AwhTtI3ev7fOrtUU0MY07jNn9snTLNGPhieXGg==
X-Google-Smtp-Source: APiQypIk/OO++QiQTUv1JEMO7Kgma3zrvimvHwbkydBxgWsFjYOpNbiyuZ/NYkzy+SI76zQjIBGDad9DRmcynU955fo=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr17656637wrc.42.1588579984376;
 Mon, 04 May 2020 01:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
In-Reply-To: <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 02:12:48 -0600
Message-ID: <CAJCQCtRpF4DLY09aS7We5Cexrwy2eWTVX=jYnkhONp6SC2F+Mw@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So far it's consistently improving the performance by 3-6x just by
running perf top -g -U.


---
Chris Murphy
