Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4C50D4F9
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 22:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiDXUEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 16:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiDXUEr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 16:04:47 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0691EC40
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 13:01:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g21so13826897iom.13
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXavK9/zqtWT7R8YQ+vbmHoSI3ZnjrkEgnHmYBvZQXU=;
        b=LMIEcnYOPosmFZqESh22UIpStYCJzMPz8rF1eDvcVkdJEo9QGFoFpUjTmHfeLHPJcq
         Zhabau5zfQQXSFhXN6JNU3hm2S8qJtOVIAr68+o38me9udayvttfrXyFV5WlKjxwNOxx
         ZD6mUkelBWlDkAc4G8ljPNlF1S7XyhX9OnKJJCxVt/KebLR3KZQWMtjDkWJMxZWZILDI
         0dF1Txg3TLg0ixV28qcQ5gXuXtgx6Kv7/jPN23hdYlPaY+L9nI/V9P+Ch72bxMwqf+9K
         lqfolfTVxG08c3Ia864KKOvf7UiKg5HyxsSXly+RgtTKzsmYflbOBMhE76i+rLnVqUkG
         MUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXavK9/zqtWT7R8YQ+vbmHoSI3ZnjrkEgnHmYBvZQXU=;
        b=amwhOONo6xRNOhLcJWnaxPrtIDQG/frb1oO48rVMSm3BPdoZSqWk1cnM9JsT2+xaYp
         /ejkwOciiYcl02u/GxYVCPDsF5anEQ0Yuy15uHw7Jo+bap0eZvJYCSKzMwQ0hkkOT0S7
         ZW60/FLnRajAWxva0DwBRBUrpHqsDezL/E5phMnEFscasDLEyAUwpxP7w8MYUcE6Hbfl
         IcBzzcf9LFwjS2edXwq4RXpz0ryPgRO77frbQsWLEar4kL60hUmhoqqzBQ1J7TzxyrjA
         /CgqKTaW+Lit5iRFzXNiIBKaNH7/J8DtKcInAA1GWEYH7LwVz9z+VGUda0I1PEBhTcNb
         ODyw==
X-Gm-Message-State: AOAM532NnsV71WnQTvAAYKwq2yZbpBFWFXVDQPV/SPSD3ZQy7J5eGvkQ
        JoctnwaeJlafg3VNfIjWeVqJDHEqaS/Hj45kt5BtWVvW5L0=
X-Google-Smtp-Source: ABdhPJyEueMKEVTaB+PQAZMrsop0++PT643oqYQ2Q73NOd7UdJMSiWD+5sNJMf4HXNZ3X8CAkfmlslXiVH54RB7jpBg=
X-Received: by 2002:a05:6638:13c5:b0:32a:a6fa:730c with SMTP id
 i5-20020a05663813c500b0032aa6fa730cmr6060410jaj.218.1650830505266; Sun, 24
 Apr 2022 13:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220422184850.GX13115@merlins.org> <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org> <20220423201225.GZ13115@merlins.org>
 <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org> <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
 <20220424184341.GA1523521@merlins.org> <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
 <20220424194444.GA12542@merlins.org>
In-Reply-To: <20220424194444.GA12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 16:01:34 -0400
Message-ID: <CAEzrpqeY_BAMLdL7NQmtC7ROBkZLrx=FHr=JC4KHoPF6Kwn3Kg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 3:44 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 03:17:33PM -0400, Josef Bacik wrote:
> > Ok this is sort of maddening, IDK how we'll trip over this broken
> > block here, but not with tree-recover.  Can you repull, build, and
> > then run init-extent-tree.  As soon as you see the JOSEF message you
> > can kill it and send me the output, I need to figure out wtf is going
> > on here.  Thanks,
>
> Mmmh, not sure I got that far.
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# grep -r JOSEF *
> Binary file btrfs matches
> Binary file btrfsck matches
> Binary file btrfs-convert matches
> Binary file btrfs-corrupt-block matches
> Binary file btrfs-find-root matches
> Binary file btrfs-image matches
> Binary file btrfs-map-logical matches
> Binary file btrfs-select-super matches
> Binary file btrfstune matches
> kernel-shared/ctree.c:          printf("JOSEF: read node slot on root %llu\n", root->root_key.objectid);
> Binary file kernel-shared/ctree.o matches
> kernel-shared/disk-io.c:                printf("JOSEF: root %llu\n", root->root_key.objectid);
> Binary file kernel-shared/disk-io.o matches
> Binary file mkfs.btrfs matches
>
>
> (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> FS_INFO IS 0x55555564cbc0
> JOSEF: root 9

Huh ok, it's the UUID tree, weird.  I pushed, can you re-run
tree-recover, you can stop it after it does root 9, I just want to see
what bytenr it thinks the root node is at.  Thanks,

Josef
