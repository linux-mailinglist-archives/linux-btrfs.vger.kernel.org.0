Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BB53DE47
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 22:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiFEU6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiFEU63 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 16:58:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E81CFCB
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 13:58:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r200so4545889iod.5
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jun 2022 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0FaZ9Qpf+XWBvko26XmrX11Co774Ybc1xQfE0l4dBg=;
        b=2Ehf4gJSy6t902u3gEAEipNYJZRnBLUBLbEsnHgWlpcir9GhwGlWpr0WtG9smoEVlM
         OFjge/hv9NuY9PZlWBd3cwwDegNH9hgYh9P4T9Jmf3+J0YpGnM+SpVqp2iO+8lGC9CTf
         Tc+ox3zfgudrB/OdFnQhz3YFmWpqHUIpd0zAJKAfrk5lh7JOSO9w0fzR7qo7InRB4D+B
         woI1rUo3CUIw8fHr/Ao1UJx+K3dxXdB2daQXSL7gq2mva8i7DcI/5kTS528M4H9lPCe+
         A6WMO7s0mfmzNy2y7SbtOtReVcJ8fiXB7jqFi0P2wIu3ex9oDef8wlf/5LDbwFf2LLa1
         Td9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0FaZ9Qpf+XWBvko26XmrX11Co774Ybc1xQfE0l4dBg=;
        b=7g0X7jC22vDhXbFP8ynF/YeLhdNT1eoK/+xc9xYIaqLV+hBbOcBsXFKU3osvxpiGgV
         snR4ib/bJljKNiHgu448jNxh+6ja3o1tMGJ6RZUZbTXUwhiEhEFDX77Q0RHMYERc+xDn
         K8hIoJSKYD7z1CoatSvsS6VwBxRrMEZuNntCRl1MrzbCQr126mUTrYPk36+07Wi+eifK
         QmT2uQRtV40H0J668xiJUbINjbR5Ln+N1z5EK9Rlxnewutgn4hzTn+PeMEevgNH8bH4f
         MsmH2+Ggu7xAYNa7wUbb+eD30obt17Y+WwDubNuYa90UQd5aJKSoXwPJ9489sMIcQB8s
         Vgag==
X-Gm-Message-State: AOAM532ZjKARyzLpMWNO7nAqflgbVV28ADSJblvYSVM8BRNAJOc/qsuQ
        wOoEzSGb2RnQxcJhDvyHRHNCNY1yUKLBmY+VE9+sUced5Ac=
X-Google-Smtp-Source: ABdhPJyxvIlyArPAOSfS9uRqTy7rnJ8Qe002fdFU/Q9W3YdsHifOLmxyvbfpcs0kRzWVaRAcZ6AnKCsxHfXW4f3Elaw=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr11273551jal.46.1654462706408; Sun, 05
 Jun 2022 13:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org> <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org> <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org> <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org> <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
 <20220605201112.GN1745079@merlins.org>
In-Reply-To: <20220605201112.GN1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 5 Jun 2022 16:58:15 -0400
Message-ID: <CAEzrpqeW_-BJGwJLL+Rj_Eb7ht-A_5o-Lg+Y-MYWhgn0BqKHEQ@mail.gmail.com>
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

On Sun, Jun 5, 2022 at 4:11 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Jun 05, 2022 at 03:37:23PM -0400, Josef Bacik wrote:
> > On Sat, Jun 4, 2022 at 8:13 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sat, Jun 04, 2022 at 07:10:16PM -0400, Josef Bacik wrote:
> > >
> > > > Ok this looks like it worked?  Can you re-run tree-recover to see if
> > > > it uses the right bytenr?  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> >
> > Sorry I've been in the mountains with terrible internet.  I'm home
> > with a computer and real internet now.  I've pushed more debugging,
> > just run the init-extent-tree again, it'll spit out the root info so I
> > can see wtf is going on here.  Thanks,
>
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x555555650bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x555555650bc0
> Walking all our trees and pinning down the currently accessible blocks
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055555557103f in generic_err (buf=buf@entry=0x5555557a3bb0, slot=slot@entry=38,
>     fmt=fmt@entry=0x55555560be80 "bad key order, current (%llu %u %llu) next (%llu %u %llu)") at ./kernel-shared/ctree.h:2135
> 2135    BTRFS_SETGET_HEADER_FUNCS(header_bytenr, struct btrfs_header, bytenr, 64);
> (gdb) bt

Sigh try again please.  Thanks,

Josef
