Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD24124916
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 15:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLROIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 09:08:35 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:35448 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 09:08:35 -0500
Received: by mail-io1-f50.google.com with SMTP id v18so2110711iol.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5CI4H0UC+C+slMTYVaI9EawOjea++ff6/BzLrhLKMEY=;
        b=k4RjHRHwC/lo/Yt1RnAII7rmfjFOr32CCABKqSmzUQkelwDX5CBzYm3j1O8DDaHhMy
         D2ysT7WL1HsuukLF/jvyrobNFbQ2y29ulYndRgXK47ITJkCbA2Hh373bdkiwtelxYk1x
         /xRgqOCy7+B/ELtMsJJ+Dc4UV/NM+ZvjpdYbR5gVkGCQXOLAKtRrAs4sG4ll3lBxB2hZ
         X3l1HvdI6eYqBC7XviNXtiF4Dr8MHzZq8GfIuiym+f1SuLKAJtu6L8EB+uApEU9POoZF
         tTOahyx65KdnWKdStgbt4yn04Me5vSTj5qXpE9YP1D3EnnayF38gHDKtT29cRiSNsh45
         q6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5CI4H0UC+C+slMTYVaI9EawOjea++ff6/BzLrhLKMEY=;
        b=n18+KFjqUw5KtDEzOgwBOtD0cYCT2sy16WRLw2Y8CUCmJGxuwGS8rWcLrygRBM/9pl
         asJB+W1KdvBAP9EbxG99KmDGSK7UkJfCCk6+UT19uMznWhgQXBwm7VPS275lCdG6JpK1
         R0YAhSJV4ZiKIXzWRqdHfO4wIgfIizBMMnj6ElFRVP8/f90fbXnYrarqp+cgqzFSOEf4
         F29oSv2hf4LKGIXsN3e2k9y2241aQ5YqWGGRWNJdrfzX/g18XwDkwMt2kjKJLbh/faUE
         BbF9lrQ4qkkrX4VRpPC1rYKADseXklMK+m3/59/2IQ/A8HZ0xaW+7M5jHjniMPm6I9Qc
         KXyA==
X-Gm-Message-State: APjAAAXcuA6EQHBIMHAFMP2rDUlgWxWhrb7o7KIaEyylDTCi7DWEl/Vb
        hSSWqrf623IRj0d7uWAyK2cMGRxqI4EtfZtVn3vAio5IGlM=
X-Google-Smtp-Source: APXvYqzzm56lAcG8Bn7QWu3oPr1t6i7YGFvuFrhVPnWxuHACalMtQnp/zOMaxzWUqDJBD5KVP4G+w7Ks3NpRGPOdK6E=
X-Received: by 2002:a6b:ba06:: with SMTP id k6mr1824227iof.70.1576678114702;
 Wed, 18 Dec 2019 06:08:34 -0800 (PST)
MIME-Version: 1.0
From:   Paul Richards <paul.richards@gmail.com>
Date:   Wed, 18 Dec 2019 14:08:23 +0000
Message-ID: <CAMosweh1AsdGg2CNPiA7uUYS5FMUkTP5c6RcNdrDwu+VkmfV+g@mail.gmail.com>
Subject: Btrfs wiki appears to be down
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm not sure who to route this to, but the Btrfs wiki pages appear to
be down.  Various URLs are returning HTTP 503 for me.  Tested from
different machines and connections.

https://btrfs.wiki.kernel.org/index.php/Main_Page

https://btrfs.wiki.kernel.org/index.php/FAQ
