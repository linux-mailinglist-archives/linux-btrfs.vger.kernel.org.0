Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A90405CDE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhIISaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhIISaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 14:30:00 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8BC061574
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 11:28:50 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id k18-20020a4abd92000000b002915ed21fb8so843829oop.11
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Sep 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u1vaDVfVAdpuX8QxrhVcUDZxcEnN1F1BH0SA1NrQc1U=;
        b=kDcXqIjmQe6T2Omv8bcRuE8jGSSMJNhWHa/v1PYQM/H8Xad/vV/mSN+OUdMXWEWiSy
         w5nfY7Fj3Kx0d+EniokoLRJ6SI5gdYD1w9NSeoSRKAkbe3rEBHppN3A8bxcKCqPSZP6o
         IF7uni4ccD6BVh/eXS4hWCh+HlDQX3XOaQ/BvS27xV+vbZ1JyifjOqUaYNIS+4yGW5wm
         Dm+hp2uPQusjWooZLtm4yvIUZn2Vvgzcvxy52lRzPRX6hh600+18QxbksilCu7zFYfAm
         UGwHpJPnXl02iF3h2D6bjk4htY6zArbMjB11ttLemnoQthh9TI4eTuP6G6Py2oQfvuCg
         KZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u1vaDVfVAdpuX8QxrhVcUDZxcEnN1F1BH0SA1NrQc1U=;
        b=hmviZZxLj7WLJQXsOe2n6PPfLcM/JmsUFnK85EV7VdYBcEvHq/FKI4cgMpu3MeYUvF
         ntSq/NZtk2qk0lhC5fisGge50adJC4PP2MdfX1h4FG8+x5ZwbYZ7L1x/oA0PZ0BWTcMD
         +FDczqJhN3emNwk9VhxmkrKuKqYj+y6BDZPrndUXpyE9JojDR1E4OghBDV/C8sdzNnBw
         YE/6U+od6fkQECQlOv/yEDVddGm434KexqsfLgHPNS6rir1UZlGRAtoCQRtvY18icf7M
         0hYrYihgj89ZKoTy+c1j41I36pwi6J1BY1/AkigbFrQMIEge3Jf1qtQQxeRc15fdJe8E
         PPqw==
X-Gm-Message-State: AOAM5330etWle9StvBqkCIPIMOIhIS+fMz9axafo5KB3faIqOdgxXgl9
        24blFxr+0IE8UTtoE/Vf3yW/omJwGCy5L85qq0zUj3xk
X-Google-Smtp-Source: ABdhPJySCJyVRPc4LHF8tREu1HK+oeKrd95oHxu2brr+SdQmt43nrwM+fTLEo7t9iPK6aFdO/AZ5p8s0JXsAKi4PwFM=
X-Received: by 2002:a4a:d9ca:: with SMTP id l10mr989228oou.33.1631212130022;
 Thu, 09 Sep 2021 11:28:50 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Thu, 9 Sep 2021 14:28:39 -0400
Message-ID: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com>
Subject: seeking advice for a backup server (accepting btrfs receive streams
 via SSH)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello. I have a server on a LAN that will act as a backup target for
clients that use btrbk to send snapshots via SSH.

After my initial attempt, the backup server became extremely slow. I
don't know the cause yet, and I'm starting to investigate.

The first thing I would like to know from this group is whether there
are special considerations for configuring or managing a server that
will receive many btrfs snapshots from other devices.

For example, do the general rules about limiting the number of
snapshots on a volume still apply in this case?

Thanks for any input.

As a somewhat unrelated side note, I had a large USB attached storage
device on another server and it got up to more than 20,000 btrfs
snapshots in one volume without any apparent issues. Some of the
snapshots dated back about six years. I no longer have all those
snapshots, but it was an interesting experiment and it succeeded as
far as I am concerned.
