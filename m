Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C054D249A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 00:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiCHXGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 18:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCHXGL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 18:06:11 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382360A95
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 15:05:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu29so760017lfb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 15:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdVWBzgsedM9AV333S/rYqtk3kmr1dq/oz1yQG7Vgh4=;
        b=CapfjqS/d37B0jplVWACoxvj13lBDboFn1ZvDEGEk67iQmQLD/NIYP2+q4GKmdeWRR
         I2P3A7MiIikvkhsbHdjl2XKHz3d35YDe4TnwwshiRh+ejIaaD3WXCmj3ROr2bX4xm/5x
         hYqJq/YoX0ZwLXTP4JyEeVPoEBwPAvKUl2I+P7puP3TsTv+jcaz0pUZXvI6Zb6rtq9ns
         ruvfFjR070DsOSwW43lqB6HWHLjNxioduFT6+tOu8R4HIh3Y//E6FfhLFV3saNNZn/af
         NI/K3tXkzDSUGqZLturuLnFYRD1lQIAGgWyd+ngpNfM/rhwk8XJshlLj+rvPnimv/cuv
         DTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdVWBzgsedM9AV333S/rYqtk3kmr1dq/oz1yQG7Vgh4=;
        b=LyudVZfUd+VxJHVSLvQ7HPryb7M7PJxe+iipI85GlZrQJfV3GL2SNBd+yzQUFqvdAN
         on4AWAC1xi08ehVR5I3eL0rzC8/D6HHllMZd2+EZe1AxvB3/epnu81zRJsh5aXaok6Xw
         iUsyFWVIyD7cDr7d9QQRU227DT4ms7t1/O5uqesqrhDjZoH8jM2qtGYQ7pNmT8ltjTgz
         SywCgudvChYFpm/YnzJImyTtG6jIyU9Xo14VnnYksBhvyR7kc/pRidM/N7l98x17ko4r
         5Sh0BtmfTdiGa0P6jDFlb6g2++oDLtJ38+8tiS8RDqhMJxLl5RUoXfrdVILTwUUtv+sD
         bdWw==
X-Gm-Message-State: AOAM531//rr6qzZ5kQNtYwsoLerkgPdcdCj6CE0SOdo9cW9uDfxd5pQg
        rIcVG6E+kD7QUlpXk7ymxJD3JHF3TLHn2t5OkipGR/75SoUiVpnc
X-Google-Smtp-Source: ABdhPJxv8GMcmCAe0HLy2hz8zVc5RQ/vy3eg3otGMcrO3wpkl5grlcKAPasVMs+LFJYzumAptOka3lfvwOgI51f56Ls=
X-Received: by 2002:ac2:4315:0:b0:448:2bb9:f11d with SMTP id
 l21-20020ac24315000000b004482bb9f11dmr8993534lfh.212.1646780709696; Tue, 08
 Mar 2022 15:05:09 -0800 (PST)
MIME-Version: 1.0
References: <1cb1e7d9-51d0-4c2e-8cd1-6b02d045bcad@gmail.com>
 <CAJCQCtTgVyWGXG6psu2d_4BuH+y0SBm3Zxqr44qzJB9Huh__0Q@mail.gmail.com> <3a34f457-ed4e-4050-a24e-313af946d84d@gmail.com>
In-Reply-To: <3a34f457-ed4e-4050-a24e-313af946d84d@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 8 Mar 2022 16:04:52 -0700
Message-ID: <CAJCQCtS4Q7_jocLEgsxRh-yXruzOW11rra7Tsv3_TGhv6h0sVg@mail.gmail.com>
Subject: Re: Recover btrfs partition after accidental reformat
To:     Emil <broetchenrackete@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 8, 2022 at 3:20 PM Emil <broetchenrackete@gmail.com> wrote:
>
> Thanks for the tip with the overlay. Unfortunately recovering superblocks isn't working:
>
>
> [bluemond@BlueQ btrfsoverlay]$ sudo btrfs rescue super -v /dev/mapper/sdh1
> All Devices:
>         Device: id = 1, name = /dev/mapper/sdh1
>
> Before Recovering:
>         [All good supers]:
>                 device name = /dev/mapper/sdh1
>                 superblock bytenr = 274877906944
>
>         [All bad supers]:
>                 device name = /dev/mapper/sdh1
>                 superblock bytenr = 65536
>
>                 device name = /dev/mapper/sdh1
>                 superblock bytenr = 67108864
>
>
> Make sure this is a btrfs disk otherwise the tool will destroy other fs, Are you sure? [y/N]: y
> checksum verify failed on 22020096 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 22020096 wanted 0x00000000 found 0xb6bde3e4
> ERROR: cannot read chunk root
> Failed to recover bad superblocks

If both copies of the chunk root are damaged, then the file system is
toast. It's a critical tree, if it can't be read then none of the
addresses for file locations can be figured out. Most mkfs write a lot
of zeros on purpose to wipe away portions of previous file systems
that could tend to confuse the new one and so it would seem NTFS's
mkfs has zero'd too much.

I don't really have any good suggestions.

-- 
Chris Murphy
