Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B44F2117
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiDECtc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiDECtZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:49:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF261786AC
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:55:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 125so13526859iov.10
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQlicjGQSFFgDDW/uBKuvesUM3ZK7JxGJ22yLUymqos=;
        b=BIGPEaoPMLCReFe3iRgtRWU22zq3/+TF02iiPA0Kk8MCmbPB15kXHz5UUX09D1rdwh
         DDfdQrRVO0tOuLYzmkhTKboznLOPWEqK4lF7KFKlTAqWfsv3KNCKryELXUk3k307T/vc
         sX1vgiC36IvuLM15E838FmDowF8+kb1wE7/lJW5PHVvIn1jZtCPcXm3ldfrWb7aerrtH
         3JKL+UPyyw8za+fOb2xKE/5NR9QBfCqZ4o3wCaatG3KDKREOl/5uBP/Jxy9NGwFl8ZYZ
         IbemsP+z33NMTg3//q7zuPOt3DETuIkgiAJdvV+JRA0ch++dI24mm4EzDiwf7Cd9pBXG
         O1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQlicjGQSFFgDDW/uBKuvesUM3ZK7JxGJ22yLUymqos=;
        b=gh78wF0gy0altwKxav9twYjBOqYQbmxoMxMynT18ncLjDPjdozQisoqNA0ga3x8lFK
         dQW0CTTJ3FSqOaJfWctZN2kFD9JTSIW3G8ae4eVgCG+niGiveKr/2/75NvAh0NIi5Exo
         NFjm5vuLoaJzDiarusT/ym+0RkkAnx0vVlr4s3bqQdU2jdWD/c3wK278kLcolJodS6zk
         qyYCAYfAob17MyQN8rZGLrh2Vn7c9oJh+4uEuB/BBgCnNDUWo+NFCNAjSaiTRFTlCdpg
         Z4EpKsDKqbCAZ6OCazCsIoKcXc8+DIagopgrEWHBLmR0/NFIEvMWOZyZQjq81KTrD6GL
         q+9Q==
X-Gm-Message-State: AOAM533FhmFauYMNMIdxIoPA+Cx670VLrrAWneomZ0AcDmuvA93WEPRq
        +Do/n7awz6vfqDTT8uJ33W7GzkYjgCQJEnUaJLIGAtAb49U=
X-Google-Smtp-Source: ABdhPJxIwQ7QWUPqTc81k4cNBdPzXJ/QXNngReVyZQDYkNaB4ISM0qc0Vvb1UbVowveH7YMI8o1bLh89ETGoHjWJJO4=
X-Received: by 2002:a6b:ea07:0:b0:649:f07e:9c73 with SMTP id
 m7-20020a6bea07000000b00649f07e9c73mr632125ioc.10.1649123752411; Mon, 04 Apr
 2022 18:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220405001325.GB5566@merlins.org> <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org> <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org> <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org> <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org> <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org>
In-Reply-To: <20220405014259.GG5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 21:55:41 -0400
Message-ID: <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 9:43 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 09:22:26PM -0400, Josef Bacik wrote:
> > Ok lets try again with -b 13577821667328, and if the owner doesn't say
> > ROOT_TREE try 13577775284224 and then 13577814573056.  Thanks,
>
> EXTENT_TREE, FS_TREE, and FS_TREE
>
> And shit, I got distracted and sent the text output to
> /dev/mapper/dshelf1a, so I clobbered about 30K of the device.
> I'm assuming there was probably something there?

Yes the chunk tree, but your FS is DUP so we'll find the other copy,
it'll be fine.

Do you have any subvolumes that aren't snapshots?  I think I can
re-create everything without knowing what other roots there are, but
if you have snapshots/subvolumes I need to be more careful.

In any case I'm going to go to bed, it's been a long week.  I'll start
working on a tool to re-create your root tree in the morning, and then
hopefully we can go from there.  Thanks,

Josef
