Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AAE53D8C8
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiFDXKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jun 2022 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiFDXKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jun 2022 19:10:30 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52029835
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jun 2022 16:10:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y16so9745233ili.13
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jun 2022 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdpVn73dKfiyPEnEdgo97sXvv+gDj1huuF072Fr7UPs=;
        b=rFPhpsULyLrX5Jaj2+TJDUUpE1Rq+JOmjZ116x9OE4xhFSW8Uf5a0Mv61VH4mDvwGo
         FtR4aKdZhK6RZoN/IMCclZVMoPZ88005rqhMLkA0rbvL00DqYZwCT7T6dDxNhEvwh4od
         AAPck0bUbhGkhzzUa56O123wB5Y2rFicft6ftdlS4X/hCBrD4y+N9w9D7J5TH3J+gLWO
         j0OmBIRyE0VFvBkhtWRyM/Yt36/kUIjlTCigD9LKXcU0t/JdtXByxzsE+O3qQbsph6P4
         wloHSv6mcvmli0/g+9Fy5Rtg+6aNuj9Fmt2MkeM+PPEFgVERCTBgOjdP6rEwpIm7joAy
         dLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdpVn73dKfiyPEnEdgo97sXvv+gDj1huuF072Fr7UPs=;
        b=c9L+ilperSp9nggEa2iV29hmk5s6zdgqdQUqUJXmGUf2QnAvvSzRc6qL4Wp7rah9+f
         a0QWRcdXx+VWrd4YiCy9MisXmidFxZ9mTQZ+kAxgWTzbvxKF+ayS3PowU2pqzkCf5XMQ
         Q63aiN0drjU4fH3IHw3TYmciFOP/xC9B1Z6vw7sLm5WNjaKVZxVM8m4yhnxqVkz2fTFs
         J6U1hrrow0BTkVKPRSyfkWpOw7CicPnZ9jxXHj1SHOtrjw4jWETk+kRwjVgxr72kilxr
         A90zUXtdMn6t1o5WCHclxgWcFA8qbesGPYxIOGWtjMbHpPr0bXz8zgWWodNbZw3ClmtE
         9utQ==
X-Gm-Message-State: AOAM532abnNvIz13SCE4NGs9GtVcvxXqGi+ANpNyase/g1jWt9WANvKi
        XIzuU2GgyPEFwycqwDmXweoPk7p9FIZmwfjuKdqt6T8pDmY=
X-Google-Smtp-Source: ABdhPJyach18WU2JanJJvcsGk7JYclgRGurvmNFsqrOYcjyBwAgKwZdH1n16Qi+AcaSaTQYESqVXyrncNd9f+W7p0wc=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr9929444ilg.152.1654384228232; Sat, 04
 Jun 2022 16:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org> <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org> <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org> <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org> <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org>
In-Reply-To: <20220604134823.GB22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 4 Jun 2022 19:10:16 -0400
Message-ID: <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 4, 2022 at 9:48 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, Jun 04, 2022 at 08:49:44AM -0400, Josef Bacik wrote:
> > Ok we're finding the corrupt blocks and scanning, but for some reason
> > we're not getting the updated root?
> >
> > I've pushed a debug patch, can you re-run tree-recover and capture the
> > output?  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x5570a7eb6bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x5570a7eb6bc0
> Checking root 2 bytenr 15645019668480
> Checking root 4 bytenr 15645019078656
> Checking root 5 bytenr 15645018161152
> Checking root 7 bytenr 15645019488256
> Checking root 9 bytenr 15645740367872
> Checking root 161197 bytenr 15645018341376
> Checking root 161199 bytenr 15645018652672
> Checking root 161200 bytenr 15645018750976
> Checking root 161889 bytenr 11160502124544
> Checking root 162628 bytenr 15645018931200
> Checking root 162632 bytenr 15645018210304
> Checking root 163298 bytenr 15645019045888
> Checking root 163302 bytenr 15645018685440
> Checking root 163303 bytenr 15645019095040
> Checking root 163316 bytenr 15645018996736
> Checking root 163920 bytenr 15645019144192
> Checking root 164620 bytenr 15645019275264
> Checking root 164623 bytenr 15645019226112
> Checking root 164624 bytenr 15645018718208
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> scanning, best has 0 found 0 bad
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> checking block 15645018718208 generation 2588157 fs info generation 2588157
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> trying bytenr 15645018718208 got 96 blocks 1 bad
> checking block 15645019684864 generation 2588156 fs info generation 2588157
> trying bytenr 15645019684864 got 145 blocks 0 bad
> checking block 15645502210048 generation 1601068 fs info generation 2588157
> trying bytenr 15645502210048 got 146 blocks 0 bad
> checking block 15645019471872 generation 2588157 fs info generation 2588157
> scan for best root 164624 wants to use 15645502210048 as the root bytenr
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> Repairing root 164624 bad_blocks 0 update 1
> setting root 164624 to bytenr 15645502210048

Ok this looks like it worked?  Can you re-run tree-recover to see if
it uses the right bytenr?  Thanks,

Josef
