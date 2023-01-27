Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99367EE1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjA0TXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 14:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjA0TXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 14:23:55 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C47E6E8
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 11:23:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id v17so3791974lfd.7
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 11:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5/+xCtrOm9sGIowe9ZjFIzHW7BpZyb7zAHuwRo2D6O4=;
        b=CJ/idXtpUydTPulVzQRImgbw+yXM80XJWT19AE8Wa3jTvz91pEepCd9Jdd9zZ8Wovh
         zuXOFMHiNDHobv6Vv2888RfZ3ch9eTjQzWyYulFAq4NeJBLLo33j/OCHpchz85EzFAoI
         WBYsoYSojHrsz/jd+YV9A+BllMVrR+GvzGjAC97yxOS8rFpTwJyOT0g7f7zR13/MT4ks
         qfPfK55TkGKj3hSqMple2xOLCEeHOjPZ6nTitYPvDcJhXWjVSFBwFt6VFO3F4FA4nHFz
         xqLgfHl5rFZndRwE88MFHPcOM54vKDVb0sjguUk3u3pn7dP+g0i8psef+i+1TwWoob4W
         GIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/+xCtrOm9sGIowe9ZjFIzHW7BpZyb7zAHuwRo2D6O4=;
        b=x+R6h1GkMUXRJ+hwjjBm9ziPS5PVKksA7IJhWOV6UTGsiDXg4H7XMR6fJg4K71VNeH
         A/JRHG/QZ4wMssJbmeyXYlbLa61OgWOPMsV6vd8umnAER6/TTmBIqb6TkhiTeyUO37Ue
         a8pfkXG6UOHDRrdb+uP96JsBwz+ls+zijbdfM2ta7xvVrdmYPG3pY2QISHdXLxLHYqBS
         ayxMMXiM72vsN/oB7OrLja0tCZseEtHx+ioWeKgJVMe0rGgdk1Zei/E6lAqn4Mypjn0r
         8SlqjIiB67f2oEU0H+dwHnaaU1IjlCb7qhTLs18b74/S9/obgA6PNtxF5i98TxDb1MAn
         lY9A==
X-Gm-Message-State: AFqh2kr+c2c2+K5/X+SGgmwpb6hJgZyXojE60zS9E4ugZixTZraI9+WF
        42Esmzt3tScKw8JaPYfaJJMFjdjQA4phYg9evm8ACZh6wqY=
X-Google-Smtp-Source: AMrXdXsEgHarLfztvUwl1phMCtiTlkN3Cv3FfpSKhR1MxBiHoSSA4RGlE1tbS6R3cApbIhzsFGvA3NAiC0MqhctWEgc=
X-Received: by 2002:a05:6512:40d:b0:4d0:28f8:aef with SMTP id
 u13-20020a056512040d00b004d028f80aefmr2328351lfk.286.1674847431649; Fri, 27
 Jan 2023 11:23:51 -0800 (PST)
MIME-Version: 1.0
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Fri, 27 Jan 2023 19:23:40 +0000
Message-ID: <CAHzMYBRfK+-cxzuw1-JyNQ+kH22d9YQLxi2YDXr10oXErgH6eQ@mail.gmail.com>
Subject: 
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Don't know if this is a known issue but I recently noticed that with
kernel 5.19 or 6.0 sequential writes to a raid1 pool are slower than
before, it used to be much closer than writing to a single device, now
it's much slower, example transferring a single file from one NMVe
device to SATA SSDs using pv:

kernel 5.15.46

single
13.5GiB 0:00:28 [ 487MiB/s]
raid1
13.5GiB 0:00:29 [ 467MiB/s]

6.0.15
single
13.5GiB 0:00:27 [ 495MiB/s]
raid1
13.5GiB 0:00:38 [ 359MiB/s]

This test was done with 4GB of RAM, so no (or very little) RAM cache
involved, this happens on multiple servers, with disks or SSDs, it
does not happen with raid10, write speed with 4 devices in raid 10 is
similar to a 2 device raid0 pool.

Jorge Bastos
