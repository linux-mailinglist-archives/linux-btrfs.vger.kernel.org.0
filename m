Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3049411ABBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 14:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfLKNLT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 08:11:19 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:39235 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfLKNLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 08:11:19 -0500
Received: by mail-vs1-f43.google.com with SMTP id p21so15690046vsq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 05:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=lLB1amWTZxejNJfvq/lcztpfsDKzS0fQLMbJmRgEbBA=;
        b=MRTaWXjDkVQu1+/9cKeva1CIflONkLVovkJ9xsOnkWdUgYdkzesBCz9CFyPQTH417C
         ngsNnoAVjNqGQS9k5aiwpydiG6rdf4uybMbj/BiCaPWeAN3+aKeBz3cr9/bhhQfEJ45x
         FG+KQtf1ARiyCEYQDSzF2zjkqOaB0onmwWkYQjDeg+amFMSHe+YOGjgFPbQKR7tjzbxh
         5jF7mhbINvrabnErDu3pFrvReLQd1AcvZIVWkedZ0vdbERhZ8p4uPZIE1+JOaHCtFwf9
         S0difa3IINjw4njXZIwPHEY3FoLykpHZFHEUO2HG4yyAMu5zU4n7ESgn5kPZAU4HFEGa
         /J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lLB1amWTZxejNJfvq/lcztpfsDKzS0fQLMbJmRgEbBA=;
        b=EwRxExdLBKKguJH9pqu9heiyFx7LvtSG2dfIQrmM3j2g1MN0itJjmtsrpWafEIvcKY
         fW0KLog9Szii1iKse3CUlDd48bxQaaGMwM+0Kp3dQREbMXw8bn2vL+7TCxGmlmLo1MJw
         LcAwjmBdeqeDPOg0zQ4IFqjFRaeNEYBGZYNnQGvkp2H5Zw0Kp42qQ8oy4aTRyikBdrIn
         TQBuOmawAhddtUxrQ9vZkTNrgxMSzzDMmKyxSTZPTeonUj+LNrVezVxkBKbv/jOmcqjn
         w8/3/pZTE28Vnp1eWh1jf/0EzLemU/I7dpm+iNmMVk+SvYJTbrFnO7rcZ3j3UMkRFbDH
         UAmQ==
X-Gm-Message-State: APjAAAWkLCvYsRC31Mpr+zeMc2GlGUSRI3EQAEzzkhw2j8HT9p7TsSar
        ZHdLsto7y/zPWiSDLo+mHb3hN9sKNkvog39eME1Mr1+3yOA=
X-Google-Smtp-Source: APXvYqzySVeQuHUudEwUZtf/63q+8lUVZMyeZotprXdY4seopcpy+MO4wvQGQRLmQtVpPxnRsCez+a4xHeJ7bUFQe5U=
X-Received: by 2002:a67:af15:: with SMTP id v21mr2337352vsl.161.1576069877025;
 Wed, 11 Dec 2019 05:11:17 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Wed, 11 Dec 2019 16:11:05 +0300
Message-ID: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
Subject: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the second time after a year that the server's disk throws
"INPUT OUTPUT ERROR" and "btrfs scrub" finds some uncorrectable errors
along with some corrected errors. However, "smartctl -x" displays
"SMART overall-health self-assessment test result: PASSED".

Should we interpret "btrfs scrub"'s "uncorrectable error count" as
"time to replace the disk" or are those unrelated events?

Thanks in advance.
