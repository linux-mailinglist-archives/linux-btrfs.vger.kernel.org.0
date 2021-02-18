Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF8D31E464
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 03:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRC5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 21:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRC5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 21:57:02 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7590C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 18:56:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 75so234214pgf.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 18:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=979ItoC1M+Q2ItcKEURqGBn/awTt+Wwx4aaUWJdDmz8=;
        b=fcXTlZyJqAzbJbbIGKrRMNdw1eyMbejuXBT0bn90pA1qiBnoC7fLp3rmuA+/G/MPiF
         yGjpJ49XWO0ACMVpOxZy7br7bO+1uTxVeC/kJ13yXNcTz8qfBd660MgkbWP012F7cV6J
         qPJL5+M9Dj9ZmWQ7/uVGh1BnX1NvYM0jqdTdpHqXACwquyAxSC0GXcIkHh1Fq42hJJDO
         wkneTWDRgFCtg5nb4MITa5KZYcUY09Tqu+YA7rDLRghFFSjJ9XPfvmdOwUoui3eJ3piw
         vKu6htHxoLKn87e4rjWeiMFyPLJS2ayjyyzEd5DX+Sr3FfxGrBqi3l8nHk/a+AIqfEwe
         E19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=979ItoC1M+Q2ItcKEURqGBn/awTt+Wwx4aaUWJdDmz8=;
        b=HzJlOymoN7VShLgTj4LKRGbRi0OO/rIYARlHQH1nnVkaB1CUCZ/QRIsysCTp0+nBvE
         X4iWxofpFb2JcYllV8Ua29SeclQOIHLlNayXf8HNR7qqj+SiHQKbdPrr+qH9+NAStH0C
         /jlFsbyT8rVAg0A15oHYdtu2Buh9ReYm2mHTg0mbQ+xsEUcYlnUfQlWECUutcig4+Wg7
         Cbt0wydTkLOPXMYglALcIeIAq8GBZfczHCLxpvvmjTnPHPnycGhq2C6NsvL/XUHdGHlS
         IfRCBQyiW96B5HhgSxg0Rd909pMv9PLcbAQ3eh32hRYCnQqB4H5xUO0EKwaDf3Qv2DA6
         13NQ==
X-Gm-Message-State: AOAM533LXl8qAwbloI8FBL1pu/70+mht0Q+soF3d+AE+ku9bzNyv36I+
        BGjBUYDUAiz8tK7HoxuYMcKct+LQt2qQeQ==
X-Google-Smtp-Source: ABdhPJy2q3K9cRPD3NFzrcgeEASYEB4P/tt1qzpqcVNp6wnxjEoyZ1chS02sJOKL+SX4C5RYZiRQ3w==
X-Received: by 2002:a63:1d01:: with SMTP id d1mr2107410pgd.361.1613616982209;
        Wed, 17 Feb 2021 18:56:22 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id fz24sm3501559pjb.35.2021.02.17.18.56.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 18:56:21 -0800 (PST)
Date:   Thu, 18 Feb 2021 02:56:14 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs-progs test error on fsck/012-leaf-corruption
Message-ID: <20210218025614.GA1755@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I found some error when I run unittest code in btrfs-progs.
fsck/012-leaf-corruption test corrupt leaf and check that it's recovered.
but the test was failed and demsg below

[   47.284095] BTRFS error (device loop5): device total_bytes should be at most 27660288 but found 67108864
[   47.284207] BTRFS error (device loop5): failed to read chunk tree: -22
[   47.286465] BTRFS error (device loop5): open_ctree failed

I'm using kernel version 5.11 and there is no error in old version kernel.
I traced the kernel code and found the code that prints error message.
When it tried to mount btrfs, the function read_one_dev() failed.
I found that code added by the commit 3a160a9331112 cause this problem.
The unittest in btrfs-progs should be changed or kernel code should be patched?
