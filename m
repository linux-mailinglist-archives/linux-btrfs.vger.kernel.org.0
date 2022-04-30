Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A5515A0B
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 05:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382121AbiD3DQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiD3DQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 23:16:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCACD0818
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 20:13:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g21so11493737iom.13
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cJgXHEJOkTmW6jvhLr42DIGyz/QbuvWUGSktqyi0gY=;
        b=vzbX5pENdMbObAZFeKUFjDtGzbliIJEUSdb99XcR1MXoCwYDi25+GfMM3y4HrHiYiW
         WD+tySoMDceF3QnAKvmTGsqQNl5egHzqoVsTCwAh5rXhz1zERLV8W3ysh2pujeZqE7G/
         0oGqEZdmqHB/0RBqsM0FUC/y+BZPUfQr5JZis4vyYgZJG6ConAERM8FseFRT03Ma2b6b
         3sj/FDGU/l95q7QendB9cpGbp77YVkD2GItmTDlDNyYOyn2ef/Y8qRAAsu9E/CpUis3v
         eJcgDMHeq89jUcaCGs6odlvnOJ3dzhmH/sWcZ0ANVSxK9C9yXJl20lb6CEOotKwFAKod
         zn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cJgXHEJOkTmW6jvhLr42DIGyz/QbuvWUGSktqyi0gY=;
        b=MJbcaj8u5vhGRy+4PnX0RwPzDl38oOxIHT35PzsMWEvS74XwCjxtaWElEBi+hNQ2gz
         s80S3/OS60wgTEgqs3lLuw+ifwZa54qG4hw1mn77y9kNjl0VDVhL1J1kLSCNKhMBMQrd
         gY379hsQkcCt74Sou68NJpE1aPq8QmpXyZ+dI8KUAknMrCoVe6yr98JTWceC4hlbQAs9
         hPfOgyU92vq6FWO1CbdLyg7+Uk08Hwohdx7dwFs0HgDA5YXPmlOaZ8VCk1HTKtIR5hoN
         Rl1tVc63cjgk3I/+YMIe99YOG7qs1o1WSqFUOqKMWyIUrKL9qwRSI7h1+qFmat4h3g6j
         x58g==
X-Gm-Message-State: AOAM531UGS6E0qMxhOiAehuOi+POVbnxLHoVwYsZqxD5ZWrjboTdg+7A
        byCQnDTpV3OHQf28lzUY0aS7sAcJlNn0yi7FgQdQ9yqQofA=
X-Google-Smtp-Source: ABdhPJzJJID2TtbC4cs0PAjwlwdE3c5j/3gqqYLfvAdmcOtR8AWI0jTUEkdzUg3t32cULEMVZe6TkMt64xYGhW4ZPpY=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr952640jap.218.1651288399496; Fri, 29
 Apr 2022 20:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220429013409.GD12542@merlins.org> <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org> <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org> <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org> <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org> <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org>
In-Reply-To: <20220430022406.GH12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 29 Apr 2022 23:13:08 -0400
Message-ID: <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 10:24 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Apr 29, 2022 at 03:40:53PM -0400, Josef Bacik wrote:
> >
> > I'm afraid it'll be longer/less safe for me to work out the kinks than
> > to continue manually removing stuff.  If you have to do it say 10 more
> > times let me know and I can try and rig up something that can dump
> > root ids that you can just feed into btrfs-corrupt-block to clear
> > everything out at once.  Thanks,
>
> Took a while:
> ./btrfs-corrupt-block -d "76300,108,0" -r 163302 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 163303 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 163316 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 163920 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 164624 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 165098 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 165198 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 165298 /dev/mapper/dshelf1
> ./btrfs-corrupt-block -d "76300,108,0" -r 16384 /dev/mapper/dshelf1
>
>
>
> Now I'm stuck here:
>

Hooray we're at the data reloc root.  It should have been cleared tho,
so I've fixed it up to see if it's doing the right thing, it should
clear it this time, if it doesn't let me know.  Thanks,

Josef
