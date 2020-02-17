Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7871613BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 14:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBQNoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 08:44:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47004 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBQNoJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 08:44:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so15670523qkh.13
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TYXdHQr8WSt1HLPlCTUDRjqZbggHrhcZ3Tw/ZsWQ0Ho=;
        b=WWL9zWObWR8vGjGULH37I01x8SZ029wS2e1Q+RexyfddS6I8QlnyRSCUpHCbzTsnk6
         +dlHEyz16gLO9TgM0fdbaEyb6fsSy3SAAOM0nkBx0i3m89qvvjhY5rtDXZojIPFUmoGS
         CVfQNLN9nbLNvT8Zzgs8CyJuf/M0MgvYTkGCtHbb76dArygt5ePzp/GYKn/S5v+WA9if
         Q0ntOfr6+l5mbru4jGYxG1oC1MbR0Xx3SvRMkYGOU8sw1FywubhJhrwRtRof4IrHvddi
         /iq6kUKHgq1UPYj/161iJqpfEM+ri1H3x02hES3Xz1O8oJVyQRj6ADyCn5WE2cwtaIjZ
         5RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TYXdHQr8WSt1HLPlCTUDRjqZbggHrhcZ3Tw/ZsWQ0Ho=;
        b=lAyqPIv0hOcwTK0GaWxeEOztYKn2jBe37rqvqPzC72PH43h/2L8iy4bJtp6UUjc8nd
         jvlOx78o5qm9eZLvpQfl1Z7u3LBNlRRoapLdSQxipgyySGBkZJYAWkpzVCsPDSes+o2R
         KNOr0OJl0nj04n+Pu1ENLUnvvljDtkLYMSeUdnwLmkt9s4hmNzhiCpRC+jDoSs70c8yr
         mGqtnQjz6+qUvRsDvMzlTpayOGy6dfx5Apf5DJaq1mYlQmpIO13xXiRJ7lyTa3ziHSaM
         s2PsGf5TvxA38jXb5jube6FI6rzz6k1E6xWKD+3APoIFl7uNe58FeDX61wGeoLwAlRfM
         g5ZQ==
X-Gm-Message-State: APjAAAXPY3hETQLYu9fW1cgbj2D0OavtUxNxgV71kLzAyhwncu6cXtl6
        sFWqG3rdX1Hk1ltynbXCRag0qLH4WNj7/FgMA6vjPFvy
X-Google-Smtp-Source: APXvYqz0k0BGoBHTMqKA9Oh7dV5su2vHgZVoGfHLRcgW8g3g9QPPalWVzYlMGR/H0u4K65gKKQ2Zak15kBwchjGhURs=
X-Received: by 2002:a37:7245:: with SMTP id n66mr15150704qkc.202.1581947048131;
 Mon, 17 Feb 2020 05:44:08 -0800 (PST)
MIME-Version: 1.0
From:   Menion <menion@gmail.com>
Date:   Mon, 17 Feb 2020 14:43:57 +0100
Message-ID: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
Subject: btrfs: convert metadata from raid5 to raid1
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all

Following another thread, it has been explicitly advised to avoid
using raid5 metadata scheme with raid5 data due to very high chance to
being not able to recover an array in case of full disk loss.

I am running an array of 5x8Tb HDD with raid5 for data and metadata,
with 5.5 kernel and btrfs prog 5.4.1

This array has been created with Ubuntu 18.10 stock kernel (4.14)

What is the correct procedure to convert metadata from raid5 to proper
raid scheme (raid1 or)?

I think it is wise to state this somewhere in the wiki also

Bye
