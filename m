Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083131C4B8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 03:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEEBcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 21:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726482AbgEEBcB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 21:32:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226FC061A0F
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 18:31:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f13so709954wrm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5CYpCegXlQbtl1zN5GJfo0qhdAWvCsr4w8LOw+5vf/8=;
        b=qf88p9bBrJ8Eq1LpE1Qq1fizn6YGSYKOisWUI6R4zXbt6HNJdRRtHmtOTmqCxbdhYo
         yoJ0h9I1iuUL0/lLS5uWZUdZJhM/HIALdwrakfEB9wy1A+ll8LqtOD+qztbRzFt3wtKw
         np04zr73+HxLYQMaN+gkD5rim48TYhkEzvSqF6LemSHtZaZMzp6Nyc8EPLXhd5h/AQoo
         jFmVX/zuDzDH2R29UkTLXEMN44k1+0/HSaJNhBC0RLvX6unDcDIF6hQD1WWrHAoGScv8
         AipIZEPWopkcFjYn2XoxpW9YyWCmcgzHvnnVcraraB58wdL4uhsSbR2KRX7XJ7EKZvhr
         4kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5CYpCegXlQbtl1zN5GJfo0qhdAWvCsr4w8LOw+5vf/8=;
        b=NNHfqN8lLfQQtJCNhSw+siYXCK8J+XfVBPCmV2cTCPdWrYmnmSJWkc+TimRJAJz52x
         mEef5RJ1HCLaHz4qF5g9Zp97AIOeCd/Kct4PICE7jZcCv/k26flfib29fqQeBmXqKTdZ
         YQKBT2Qn7F81sZ0B9m5D7ONv8cEoIX6DIe94Ip+Q5rHZzpx7B35qI56seUjXMmKRRTPk
         iuRQVJEUpWSQs0K1aec0U+ZhZAninlF41nsukAlGUljJXexakmjLuiUonaUd3yW7qZLA
         NLeG3L/BsIdcWkQ6LXxFVj9kcIlRAuZlrlV1xMIcjGfekz4tBXK8o/3Zf0sLPDOShbM6
         o+3g==
X-Gm-Message-State: AGi0Pub1vkf/rTeT7URqu70lKHn4B7ZAOzCDyFaWGWcemoeK7d4Lipdo
        LdPi+s0g6rhlHG1MRj5uYWX292MWtHZOE/ACB5fpFhKQ
X-Google-Smtp-Source: APiQypI4SZwvM9J31qrkiJLtpE/gAfPZ3Bv65R8HlEmYhp9IDAhm1ygQWT+mzwOS5KsZGJkb/wZwAip0zDt1+4httZo=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr748435wrc.42.1588642318261;
 Mon, 04 May 2020 18:31:58 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 19:31:42 -0600
Message-ID: <CAJCQCtQSevDB5kaGTSS1TfQKen+BY5krKvHUZc4MKVPZCypiPg@mail.gmail.com>
Subject: supporting zstd fast levels on Btrfs
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks like since zstd v1.3.4 there are five negative levels (also
--fast levels), that looks like they'd be in the ballpark of competing
with lz4. That might be useful even with some of the faster NVMe
drives, ~2G/s.

Any idea if it's possible or even likely?

Thanks!

-- 
Chris Murphy
