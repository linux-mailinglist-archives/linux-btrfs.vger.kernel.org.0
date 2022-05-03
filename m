Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70F5518005
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiECIth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiECIt1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:49:27 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3C2B277
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:45:53 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 825DD82F50
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 10:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651567551;
        bh=hb4zhpu2+fc6dzwn+NOxDrldBDGxd+4jI57VODZ4/6U=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=UCVRD7+4//zxXEheyPopMSRiKHwdkkFAqdJb+hp3+CN1HbIbMC2CU+aidbXP65gUO
         tfOLbpXMQvXsvpjJUtPnzbP8eSmnU8xWU03NOKOdABm7DYa0UVNRt4h/VnsvKx0p8o
         cPl+bWGcEusk8IskdvC3jlehn9nuw1UIHHjISsOpkE5p2iIG3Qk/481s3fbVS0wOac
         78MibEPadwKzj4FPEY3scPpwlqrnH/0aPwvog5T2vhXtf3qbPHmFKB5/OWuerZ9Jv2
         0AL8FAka/DzP/aHk4uxicci0ruiS+E5a7/gytaNHwe8D2uOaptQzv2js/IU7zTgCuy
         xjSCy2Dk50AJg==
Date:   Tue, 3 May 2022 10:45:50 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot mount btrfs root partition
Message-Id: <20220503104550.16d2465877beb89f713485c2@lucassen.org>
In-Reply-To: <20220503083206.GI15632@savella.carfax.org.uk>
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
        <20220503083206.GI15632@savella.carfax.org.uk>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 3 May 2022 09:32:06 +0100
Hugo Mills <hugo@carfax.org.uk> wrote:

> > New to btrfs, I try to load a btrfs / filesystem WITHOUT initrd but
> > it ends up in a kernel panic. I run lilo, boot from /dev/md0.
> > md1: swap,
> > md2: / filesystem
> > sda6/sdb6: btrfs raid1
> 
>    Generally speaking, if you have a multi-device FS as your /, you
> *really* should have an initramfs. In order to mount the FS, the
> kernel needs to know which devices contain which parts of which
> filesystem. The tool for doing this, "btrfs dev scan", runs in
> userspace, so you have to have a userspace available before you can
> mount /. This is what an initramfs is.
> 
>    In theory, it's possible to use a mount option to specify the
> devices explicitly, but in practice, that's heavily dependent on the
> device enumeration order, and can change at any time (between one
> kernel version and another; or even simply between one boot and
> another). I would strongly recommend against using it, for that
> reason.

Ok, but I see the same problem using a single /dev/sdc1 (non-raid1)
btrfs system. AFAIUI, that should work, correct?

I know devices can be renamed, but also tried to append

rootflags=device=/dev/sda6,device=/dev/sdb6

as written on this page:

https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices

I have no idea if that is the right syntax, but that did not work
either.

And I know: it is also there: I should use an initrd, but just eager to
why it is not working anyway...

R.

-- 
richard lucassen
https://contact.xaq.nl/
