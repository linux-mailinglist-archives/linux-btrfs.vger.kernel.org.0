Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C953BE73
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 21:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiFBTMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiFBTMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 15:12:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA73DED1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 12:12:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so9251962lfg.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaSOu34FQwcJLnxkCCirnci+plWVzUh0gHcrvuglh54=;
        b=Zy5eksrqlembUlUz8fFz4m9g8qj4TPLs8BfJMtpbl12F2SX0bkW9HUKHDwGxX+g7dj
         y0g6r6X0zv9j6Pne3AlbCWE7wpIVQd5arc3ctLYDhmUU8KkKs1X+osmBtFOPVBEhGB7v
         WT79KxuPMcbxGwJTbZW4sgl8z46UdUxgqREHJisi27IEoykliAOpweJZz+tsqfBYLT1o
         eobSMH/aVCm9VzNLZDzZYeEiVv7XYt0hYiPGk1aoloLb/oPwRC01pE8DDY6JMw7Z5QNT
         85N12clW8Kh6w6l+9I9uctLI0ll2Pa3a7Mqt8fNi8sSu3oYd/1bNBlnihy35GNvoWxbY
         gegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaSOu34FQwcJLnxkCCirnci+plWVzUh0gHcrvuglh54=;
        b=dAVeTADjj86Yg8YvyAY2CSqaZ033l9WC/4q+aIClm4+ZJGq3lZz5TQZjwnwPMVG3df
         4M+hvL1O+iJvthQNsPFDe4qkyS0X2pzVnd9N+8R9+5nNaAJ03zb3N9ntK5hgJBOyaW4+
         1ERX+PIyTvkO9tDCYVK/aSUd855nxODW+/M+9vGGGctg932+llc4SUI9ksFq6Ofjd0FV
         tgnnalds6NXLcvPcMC6WXQZCJTctkVymaNiUfpp9DbqXjrbwIjvsBr3RvhdzAPhtLThP
         CwtZOMNyHG8/FE1qvJlCRsyU3komVCgSYW9kt3oFAF/FvqhLGurtYHznLCuSyBfQ6U6s
         ULDw==
X-Gm-Message-State: AOAM531wZphEnCt0ArQxyOkUzZHVwWwxnEdRsRJ9S3FRKjP+A+QJjqAf
        7Vh5zlf4bMsjgPEQ97bJCokwiVwCnbFxGKt+vIey37VsRa+KGcN0
X-Google-Smtp-Source: ABdhPJw2i8Zx74xkhkZQbUseOteb5tzAx06vrPxzsOeeUHhabyEVK6MM0NuGaEL66jnSgG/mD24HTQWbNu4P8gf2cPE=
X-Received: by 2002:ac2:4294:0:b0:473:e5bc:7a64 with SMTP id
 m20-20020ac24294000000b00473e5bc7a64mr4640830lfh.84.1654197164304; Thu, 02
 Jun 2022 12:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
In-Reply-To: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 Jun 2022 15:12:27 -0400
Message-ID: <CAJCQCtSBoseoCm8vY+UoS_oC5sOBBRp7fV3mU-bJnUTZWJWRgQ@mail.gmail.com>
Subject: Re: Manual intervention options for csum errors
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 1, 2022 at 11:35 PM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> I have FS which is currently not in any sort of raid configuration and
> occasionally a bit flip will occur somewhere on the disk. It would be
> nice to be able to tell BTRFS to recalculate the checksum for that
> specific block and assume the data is correct. For instance, I just
> had this bit flip in the csum for a non-important file which I have an
> external backup of.
>
> Jun 01 15:58:04 planeptune kernel: BTRFS warning (device nvme0n1p2):
> csum failed root 258 ino 63674380 off 208896 csum 0xa40b3c39 expected
> csum 0xa40b2c39 mirror 1

The csums are off by 1 bit. That doesn't mean the data on disk changed
at all, because had there been a single bit flip in the data block,
you'd have a completely different csum, it wouldn't be off by one.
Looks like the data on disk did not change but the csum is computed
wrong somewhere - either it was originally computed wrong (bit flip)
and written to the csum tree where it's now persistently wrong. Or
it's transiently computed wrong on read. Either way, it's most likely
a memory bit flip. I suppose it could also be a memory bitflip in the
drive itself.


So yeah you really need to do a memory test, and unfortunately the
available memory testers can still allow bad memory to elude testing.
In the best cases, it'll find a problem in a few hours. In rather
common cases it takes days for it to be detected, so you'd want to set
this up for a weekend to maximize the chance of finding it. There's
both memtest86 (not libre but there is a basic no cost version, pretty
sure they are UEFI only now), and memtest86+ which are back in
development as of last month, your distro should hopefully have a
build. These have the advantage that only a tiny portion of RAM is not
tested, the portion the test utility takes. Since there's no OS, test
coverage is maximized. I've heard pretty good things about memtester,
which is a user space test program. The disadvantage is it needs linux
running so a much bigger portion of memory can't be tested, but
chances are if the memory used by linux and the tester are
compromised, you'll get some sort of catastrophic failure. Probably.
Maybe. You can run in single user mode or non-graphical boot to
maximize the RAM being tested.


> This is a very clear case of a csum bitflip and I'd like to have the
> ability to tell BTRFS that the data is correct.

As Qu mentioned, the easiest way is to get the file out using the
rescue mount option to ignora datacsums, and the remount without that
option and rw, and copy the file back in. But with bad RAM you risk
making the issue worse, and it can hit metadata at any time and then
the problem is much worse. Hopefully the write time tree checker will
catch it, it often does, but it's not guaranteed.


-- 
Chris Murphy
