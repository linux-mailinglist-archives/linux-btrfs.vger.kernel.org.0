Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A1126E234
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 19:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIQRWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIQRUt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 13:20:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459CC061756
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 10:20:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so2845851wmi.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/W2tWpMILIr072M8aCIG+3DmK9mlRTEehMci+PZlong=;
        b=oaLH/ENOpODbDud2+IrLF/6srfkZprhfXncYgUeZr1MBHeCXpzy1rJ20ILxMZR7ZYG
         fuopn11Hj5P37rGevjTOXZRLFKGVhNE+DZF1N1IQq5XtCc0MS7JHboGHQ4JPUNNeci3x
         IaTiXRJi5F5fjsVmrTEx1MomEX6g1RTKZnzaEJRD1F2QR9NhekPywesDKCpzs0eCMPsF
         EKy7C5LXjk/zF30Q+DplpHy3HeCtXFtwb/xtGotWZSbWk8Wnes0gTVT4Edv3CIp/4lfW
         MWWUQT/jC2AdMXPGTsRuNH9avnWnq0sDyahXurhlheTWes5TAL1/hkvSd28a1lG9AjKA
         qC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W2tWpMILIr072M8aCIG+3DmK9mlRTEehMci+PZlong=;
        b=WXj/op8afJwAUQR1sQw2jB9D4QWGhNsJ2Lw8g2BiQ2ypk/9Em5rReHas1myeaqnlKr
         kGdGMCV6hzzsh6koQRVTac/pp+mL4Nfud2AHDikDjryDfWrKzfaDMF2AMy2JvoafavoF
         qDmxPPlWPbDnjrhvf+7qNqFriugoJq7SjA9iOd2ayZEbaDYxxZA9tDiLQTCxOcKrh1Yr
         tefna9d8uHOaIa2TeUrziMBul+xVeNPT9w/18WhugcNoy3FHqq7iu3UeaztpCIBZFecW
         nKNUH2c/7k6qWz8MyjtLQlvCKFeXg6STvDBEBjWplvbI3PfJyF9DnAuYbbJBiV2Tiz20
         RusQ==
X-Gm-Message-State: AOAM5320I7i+QvfVwZPgAf9/wI0M+aghYhZFJ8QaLUbLySE1HVhdgx5s
        T2kQbWVB1gDFCKCaFPBiMS/a9UnzC6J+IuUKm9HlJQ==
X-Google-Smtp-Source: ABdhPJzytTCRcWz9qGzIbIDLoQ+VSgx6tXvDUwPXts9wdrJ51N9lc2vtdgW4fJCuiq+8WvvkpMPsMa7osFuuhgRwi/4=
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr10940224wmj.124.1600363238888;
 Thu, 17 Sep 2020 10:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz> <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz> <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz> <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz> <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
 <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz> <CAJCQCtTYAg-uNpk2WYv0QDWH+prfnDN5oKyKmvTVHjARu_w0Kw@mail.gmail.com>
In-Reply-To: <CAJCQCtTYAg-uNpk2WYv0QDWH+prfnDN5oKyKmvTVHjARu_w0Kw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Sep 2020 11:20:23 -0600
Message-ID: <CAJCQCtTkgaoOTHnUDHNUxZXtOumPaq903=84r1-6LT5c3UP2nQ@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Vojtech Myslivec <vojtech@xmyslivec.cz>,
        Song Liu <songliubraving@fb.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The iostat isn't particularly revealing, I don't see especially high
%util for any device. SSD write MB/s gets up to 42 which is
reasonable.


--
Chris Murphy
