Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84853F122
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiFFUxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiFFUws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 16:52:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F0338BF
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 13:42:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y85so3168894iof.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jun 2022 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv0C8gcpONxqFnyIqy16rU+SxSCdqxusIB5nVcpX9sc=;
        b=7Dk//FAPgseZWiOjFPiG71ZYXtQH0RFn3JNFRR8TRT5UeJc2ndBwxe98nDgL7XXhGc
         8clNrJL9WTUzJn3S1HMS31oJJkSoFoaJeJFijMJlANBIF78QHuyzIUs651YJ+jCp2QS1
         6haAqC1NhjUHGR6lrxKRQxzv2OKPPz3dCPY/9Eg0KD/8yTCFtMJonRs6V1FAmelAYtMo
         7+H/wjLu3+e/lS2IqYP8XrS4oM++RhpejI9Dqqp5ImFLWc0D6YJ9pTdcKVwcoAfmOC65
         3eWbeSHZ/MMZ5AtbF8WpvjdfkxG7+bMtGCw88AUqULTf759nj5/7XQ6SXgZiu4j7ryhm
         n6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv0C8gcpONxqFnyIqy16rU+SxSCdqxusIB5nVcpX9sc=;
        b=hqIHfAr0qApGFH3uEKjsTTGFyKy9pZEWtz8VbnBG6eWI6FEG7TOHZ2Dt35vOVHMr2P
         8vr1pGOd9pWt3MSuE8+U+79OwIWfIIXSASIFdkMqIJldI60AFtz7+02NnPzW46syuxr1
         /uM6A+sXsanyUTUhG/VE+EjwLFSrzwJ+FDnDUThAncIRLdlSukzo3BxQj0r0QYzVsSnS
         UrigsfbwKYAlgi51ygdDFGfbBUCiIys1ruDzH1/Z2KdqQ03Bb0xAxj+dz6FO42L0sv+s
         FTfgTwYpoScRwh9kAkt0x+FiNJVPO6bUortEjtXDLlUlq+rmRM5qhJvB1Flj7j7R+HWD
         w/NQ==
X-Gm-Message-State: AOAM5304pqXK5tnNfiqZ/v+ILBGmU5e7iv42YYUOvpU8RVDOCsEPtujW
        pyDVRrSXVnZnFTJKIuLPRBH979uFktAW15pCbTbdVXmbCkE=
X-Google-Smtp-Source: ABdhPJxsn6Weawf27N0pzs2lOcMz4f8D7wcgZCtrJJFdyGKdeRgsNGm0nxSXsQDB84sOw9biT7hWAlImdxUw8b/uIlo=
X-Received: by 2002:a05:6638:3784:b0:331:7f89:287c with SMTP id
 w4-20020a056638378400b003317f89287cmr9194225jal.102.1654548161463; Mon, 06
 Jun 2022 13:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220605001349.GJ1745079@merlins.org> <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org> <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
 <20220605212637.GO1745079@merlins.org> <CAEzrpqdFEsTNPAqqrALcMLpeMUbc+H4WJZ9buSZMKSQ-YS1PVA@mail.gmail.com>
 <20220605215036.GE22722@merlins.org> <CAEzrpqeYB0gC+pXr4UxL9TVipWDE2MFsg1tyrd7Nk+wEvV-zQQ@mail.gmail.com>
 <20220606000548.GF22722@merlins.org> <CAEzrpqdL6rK+-OUhW2AR3jXhK8TTsTM77A1CUkh=-+Y7Q1av9Q@mail.gmail.com>
 <20220606012204.GP1745079@merlins.org>
In-Reply-To: <20220606012204.GP1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 6 Jun 2022 16:42:30 -0400
Message-ID: <CAEzrpqeOb4XnGxbeMXNcDHn+wMNC7sBS7eFdsTbUj8c7BUgcuA@mail.gmail.com>
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

On Sun, Jun 5, 2022 at 9:22 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Jun 05, 2022 at 09:11:28PM -0400, Josef Bacik wrote:
> > On Sun, Jun 5, 2022 at 8:05 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Jun 05, 2022 at 07:03:31PM -0400, Josef Bacik wrote:
> > > > I wonder if our delete thing is corrupting stuff.  Can you re-run
> > > > tree-recover, and then once that's done run init-extent-tree?  I put
> > > > some stuff to check block all the time to see if we're introducing the
> > > > problem.  Thanks,
> > >
> > >
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# gdb./btrfs rescue tree-recover /dev/mapper/dshelf1
> >
> > Ok more targeted debugging to figure out where the problem is coming
> > from specifically, but hooray I was right.  Thanks,
>
> searching 164623 for bad extents
> processed 311296 of 63193088 possible bytes, 0%
> searching 164624 for bad extents
>
> Found an extent we don't have a block group for in the file
> file
> corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 root bytenr 15645019570176 commit bytenr 15645019602944 block=15645019586560 physical=18446744073709551615 slot=38, bad key order, current (7819 1 0) next (7819 1 0)
> cmds/rescue-init-extent-tree.c:197: delete_item: BUG_ON `check_path(&path)` triggered, value -5

Cool, must be in balance, lets try this again.  Thanks,

Josef
