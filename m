Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0643D67C7BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbjAZJr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 04:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjAZJr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 04:47:56 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238A193D7;
        Thu, 26 Jan 2023 01:47:54 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id x18so1108031qvl.1;
        Thu, 26 Jan 2023 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APkxpFjkHy9aUzQmvgrxYSWiu1YJOzPgwdV41ID/2nc=;
        b=E0PfS+UOvVynwJtCJQd7jtZepFE3khRvSPHq/PQzlDOd61DH7tWxn0G0Vl5Si625sZ
         yGrDX5K8Spn5kVlJa+cG1hV6JPMya80xC6ShPbpueZs2kJ4ADc32wsvgfJVLAHW5m9AD
         mZl9Vl4mo0xvQ1RtuRDmMA9cSzgsTLWvqGjRA9Ij18ReftpgDGwTOBAUU2bV3A4yow77
         R3OEeHAHMZXzxqJlIpzpxouf7ihnkRcnyMIeKYWesM3eRbVBzunH3GChNXh0m18sjs2g
         VevL3lRm4L1udFUphpmx9M/4Rg7ZWZsaACiJDLxr7Mc12Ki4Tci6BO2v03hD3dPR15G4
         SZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APkxpFjkHy9aUzQmvgrxYSWiu1YJOzPgwdV41ID/2nc=;
        b=BZUCInfzsEouSk9VtD+BDwA/jkFGgQ6oTYhxC/gzfqjwJ3lSfkqAbUCkPzi79/+Sz5
         IU6WxR9DH7LuhDUsv1RenwPjbj4svitMQeug1SIZqLR5qC5iUjQtksq3ToHbhVAaYod7
         w7zA9uj2S2pb5JY3ccFgnPWfoUlPfVJ1QuQa/WOLxk4i9frEPJmE2jWxm250u90HT12E
         BHxz7k342xoYcrP1QHBBjDX2SCIyduBoSaoxh7NSvb0irqhJxN7WVg2C/fXiMB1MP8Fw
         tqRKF1Pplz553gw5wJieKC09sVADAXUEUF3yGyDtO24/KWIwVkx172FSfouj7UihDZWb
         9ymQ==
X-Gm-Message-State: AO0yUKXC7fEKvf9MCt9MSeKiGZumNBy1uDhN0HNOhJr+sJBaW1YtKCvo
        7fSJMt2PlPb5g5uAmaS5EHNAYzeq9muvtf5aenY=
X-Google-Smtp-Source: AK7set+ZD+LhIVr9zWlp16hzcgj7kOxYisxdQ9lCVNvaTAswU0fpPLO7g0kjdlKvqZeR16vrit71QUsUbFQ8+IVS1Lw=
X-Received: by 2002:a05:6214:e6d:b0:537:7a25:2111 with SMTP id
 jz13-20020a0562140e6d00b005377a252111mr229158qvb.32.1674726473045; Thu, 26
 Jan 2023 01:47:53 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz> <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
 <20230125171517.GV11562@twin.jikos.cz>
In-Reply-To: <20230125171517.GV11562@twin.jikos.cz>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 26 Jan 2023 14:47:42 +0500
Message-ID: <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     dsterba@suse.cz, boqun.feng@gmail.com
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 10:21 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
> > On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > > > Hi guys.
> > > > Always with intensive writing on a btrfs volume, the message "BUG:
> > > > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> > >
> > > Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> > > tends to work.
> >
> > Hi,
> > Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
> > low!" again even with LOCKDEP_CHAINS_BITS=3D18 and kernel 6.2-rc5.
> >
> > =E2=9D=AF cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
> > CONFIG_LOCKDEP_CHAINS_BITS=3D18
> >
> > [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > [88685.088124] turning off the locking correctness validator.
> > [88685.088133] Please attach the output of /proc/lock_stat to the bug r=
eport
> > [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
> >   -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
> > [88685.088154] Hardware name: System manufacturer System Product
> > Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
> >
> > What's next? Increase this value to 19?
>
> Yes, though increasing the value is a workaround so you may see the
> warning again.

Is there any sense in this WARNING if we would ignore it and every
time increase the threshold value?
May Be set 99 right away? Or remove such a check condition?

--=20
Best Regards,
Mike Gavrilov.
