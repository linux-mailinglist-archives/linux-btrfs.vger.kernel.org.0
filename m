Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEFAE1AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 13:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfD2L5K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 07:57:10 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34402 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfD2L5K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 07:57:10 -0400
Received: by mail-ot1-f50.google.com with SMTP id n15so2263658ota.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egyOG8vXcyQwSGcV0Us7I89MRRO7tUfY1J9yJF9wPco=;
        b=m9RfCesujT7Jl6CM0FEyMms0qRtTVAELt1iZmFkTWzZsbnWocDRc3R27YJGO1DAVCQ
         V3CxV8aYzfDn8RU2o8WlZFvGFYFeeQ1YC9YTzt+fksFHtGZccAjvWu3R6nQDprrjaRJy
         CxWhFvkOLolhp72BZ+/jXSxI7KEImQepXF71TXK4di5V5vDRc+FiUX8fjfr7KrKoBFqK
         boDtz/+W1See8tOiE0lidKhchR7/5RSJF7hez9PXOTj7yYpkjwPRzu+YL5+d8vkt2+Ue
         ZiHvC2k5V/D9mETeEIqGB11kVpxD4Ff1pQlr1v/71lc3DXxtt4zeO+4MtFHDMmDDXDeg
         V5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egyOG8vXcyQwSGcV0Us7I89MRRO7tUfY1J9yJF9wPco=;
        b=b08NMejL0tPknu3F3+c0aIPuLLGZdg8wXvsd4b1L51wzn0TIsYLMw11J9dslP36jPT
         r8Dn26vC1JFJ7hI/p+iMV5+gUC6gvhNkpPrBFpBuqjR878J+0II6s5PNgc+jUtVDyt24
         nuerUDAcg8AGbQg4/kC0ruBvcBRKKm35hMl2LXYhyKxdjVvczJn+FKmG+FV/Fb+dg4aF
         tCEC3CHb5HUAm+lS9kgpdn0Cnm4s4i2nDX/F0xhC7B3ryNOThFs/9iv2cGFUcUY5/mdN
         +2rARPvFnb7jRRDBMG3wDokPi6HECfbns9u8Q+jDG/piM8MZlhIIb1ai9oEqkbWD77Eu
         NS5w==
X-Gm-Message-State: APjAAAWt1XEaJc8+iRIbm0NQDbcA1u/5lgHKaBpKu7TJ+j4WeV+9bD8Y
        EpeZPsNGUKiN/f5iNT7Rof8fXdgYR7VVBJcXaL8=
X-Google-Smtp-Source: APXvYqzdVteQcVsu4KyXJIriOU1HD/Eui5qQOClY91Nn77ehW1Co3UZc3f3yTWAubvoDdjWEAJQDfjoDJWxg9iHhDlU=
X-Received: by 2002:a9d:6543:: with SMTP id q3mr14553374otl.370.1556539029527;
 Mon, 29 Apr 2019 04:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR03MB413128509989947DE4AA7DEF92380@AM0PR03MB4131.eurprd03.prod.outlook.com>
 <5e02c6d3-9024-10fa-51f0-629ff5e604fe@gmail.com>
In-Reply-To: <5e02c6d3-9024-10fa-51f0-629ff5e604fe@gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 29 Apr 2019 14:56:58 +0300
Message-ID: <CAA91j0UGPKgqu_TYKQdfnAxe5pfLLvkVaaUNgUZmEh10MrWJ+w@mail.gmail.com>
Subject: Re: recommended way to allow mounting of degraded array at boot
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Alberto Bursi <alberto.bursi@outlook.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 29, 2019 at 2:38 PM Austin S. Hemmelgarn
<ahferroin7@gmail.com> wrote:

> * If you're doing this on a system using systemd, it actually doesn't do
> what you are trying to do.  Systemd will refuse to mount the volume if
> all the constituent devices aren't present,
>

It is not quite correct. systemd will not even attempt to mount
incomplete btrfs because it will wait for all devices (including
missing ones) to appear before proceeding to mount it. And if this
check is disabled, it will actually just call mount.btrfs, it will
certainly not "refuse" to do anything. So the following may work

- disable udev rule calls "btrfs device ready"  (it actually calls
internal variant, but it does not matter).
- replace mount.btrfs with your own script that tries to mount btrfs
and if it fails tries to mount it degraded.
