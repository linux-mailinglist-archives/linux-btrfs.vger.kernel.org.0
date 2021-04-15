Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A9361118
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDOR2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhDOR2E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 13:28:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22293C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 10:27:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j5so23124821wrn.4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fIyGxytkckxPWJD/qCVcn3gQIRdbg8VVKM3AtEG5KZc=;
        b=u8WYWo8Eq507PfKhZmzaoWb2D6CtVuc4DWwoXjH1viVhnJnpZjmKTBBsakg+fxXRvw
         GXPTKShGwqMA9prcaiu2HmPO5y27lXZXwG+6xEb4RDVSLwBkvife8HCNprTz6AhyzM8H
         8VZexguJXuMof7GnJloRaqeWtby1ziLoP4aV7USdjjVlRphuxrcSnabPSgv2abJ44LAS
         dfdcMB93FDW46SATNDqzRxCbAYk46c82oDXr6Fl3/In8pMvmhTIM2rLU2hbVIXB3PmAP
         fFmBGWxia4zU/1uKqJAcjD1qYo9WqB8JFdul1qDhnqRyYrX7CIS2UcsmVZQnXu/OwJYG
         FJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fIyGxytkckxPWJD/qCVcn3gQIRdbg8VVKM3AtEG5KZc=;
        b=cwt9mggLl1LpzXNFqtkySqeRSLAeVYMiqBJ1N9EkfFOaNo+wzcdCFeTKpGlCktZBy/
         Jq3fmJGs1wT8ZFLCnLCS6/PJ32H6YWkxhGkxqms84P6p/NvbhC7B/xFBl5bPC00bTjoQ
         cOjhOZIxPOEA3mrynrOsDbxhwgJTU5TX3gk/y97snASYGKLoqFUB5f37ptwYl+3w5N88
         HF0fCUqi+MDzKF0ABLqAJyMObNjrSU86Nw3ixSvgMP4r1RWuUblo3oqIx/Ifs4h8ef+b
         yBWywCqeRUmhRGps3aLTHSQu7UgB/wfTFsyjh3EuuO6HlBeZ4S3O1LgWkTadKOGD7gjL
         Py6Q==
X-Gm-Message-State: AOAM533zh8YJA+2aOR3dcqZ4JzVqgmaL7VC+Sb8TxlOBQ83dJCzkJB+y
        +ahpmyVhDLHD5SSfN97VUBL9VRwpJ/RHxwm8nHZZqQ7rgNp5n481
X-Google-Smtp-Source: ABdhPJz+0BMmtAmdze4IFTfIntW7+KETNQJwnwX2YB7GXYyNafswl09pTyAxVXwG19Xu7IBU5RKNPBaY5McbtbnsixI=
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr3396365wrc.236.1618507659897;
 Thu, 15 Apr 2021 10:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <d97168fe4c9e7560fb6229fb4f971bfd@linuxsystems.it>
In-Reply-To: <d97168fe4c9e7560fb6229fb4f971bfd@linuxsystems.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 15 Apr 2021 11:27:23 -0600
Message-ID: <CAJCQCtTRcp3a-jHA_i9Tira0erdAkaw9V3Yfg_ZhAvK9PW_M3w@mail.gmail.com>
Subject: Re: Dead fs on 2 Fedora systems: block=57084067840 write time tree
 block corruption detected
To:     =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 2:04 AM Niccol=C3=B2 Belli <darkbasic@linuxsystems.=
it> wrote:
>
> Full dmesg: https://pastebin.com/pNBhAPS5

This is at initial ro mount time during boot:
[ 4.035226] BTRFS info (device nvme0n1p8): bdev /dev/nvme0n1p8 errs:
wr 0, rd 0, flush 0, corrupt 41, gen 0

There are previously detected corruption events. This is just a simple
counter. It could be the same corruption encountered 41 times, or it
could be 41 separate corrupt blocks. In other words, older logs might
have a clue about what first started going wrong.


> I have another laptop with Arch Linux and btrfs, should I be worried
> about it? Maybe it's a Fedora thing?

Both are using upstream stable Btrfs code. I think the focus at this
point is on tracking down a hardware cause for the two problems,
however unusually bad luck that is; but also there could be a bug
(e.g. repair shouldn't crash).

The correct reaction to corruption on Btrfs is to update backups while
you still can, while it's still mounted or can be mounted. Then try
repair once the underlying problem has been rectified.


--=20
Chris Murphy
