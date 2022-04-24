Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79350D515
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 22:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbiDXUfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiDXUfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 16:35:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F66156E23
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 13:32:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m13so324918iob.4
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQ2h3j/qkvNw+0MpXoG283y5gQdyW9B84gddX7KR3jY=;
        b=Jafy1gDskMkIthkYe20zrbq+Ii2xl26gYmeMOULLaKnZHl4M5380hzTQLnqFZPNaFg
         +5o1ujDLIMFZbk1sAT/NzhYjHYqfdcfQM5pD72ReeYUKJQIcjYvfQEJbssiW6DGCSgRo
         w6tLkGG2s6FLxr7NcENgn/GYMvIjEwQg7i/+yPYrncar6GNTx7be75cZK/M1wfj0M2zl
         D6evWYq/NUUQJMTzv2gFVmCdADNbeQRw2+bBWE9+FEjkj+1w8nDVdJz+6vZIL7+m9MQg
         stf77m2//IJoz6rIu5aJfPTB2QvI4D5qh1ZeUesdrzmUjvJh/BnMX0GvlfUOuaCjqLqs
         5j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQ2h3j/qkvNw+0MpXoG283y5gQdyW9B84gddX7KR3jY=;
        b=JLXkabUKkIsngci0N0giiHOvmcVXilOyshi6nfZQqIC7UzsmydttASEz1O9IjiC95U
         rHHsLoLQwIIWLZ1G2zfRwPejdURXj7gdBEkgha24nfW5OW7oqZMsQnrRD9jJsEorps06
         MuE4zE96VO/K3bfF+4C/JO1TUXoDRBZlSXDzAXoxjuqBizFEzD0RYV0emgIgpmkyg4r7
         x9XqQz5Ua+iCllBjZ9/TeJcMnu8tzQtuVWHBmkDS/5u1eT6vDiCV2vHOzQZ9Mw0zen5J
         MR/PB6/7v/hMqEHEdiSNsDl1vLWYSPP/Q1483N/bbFfKaxycv2zHEx6WyMoWgQvDVC7c
         MycQ==
X-Gm-Message-State: AOAM533MiFXv9NUSdllE1rarIwjnsUlBKPlOz+YVrHRB/jspyx2y36gm
        1l4jOwFUfedA+hsz4jWpm+CZsTG6QThf6yDp49jqP+0Szj4=
X-Google-Smtp-Source: ABdhPJyqM73/bJ3ri5yd4jorcdH8Ns42+jMEaU1KEFsBUIH5Hx4rAJbP0J56AxXnlDC7WxxRaOCuT6/woY/dSmuf3Ic=
X-Received: by 2002:a5e:8416:0:b0:654:9404:ffb2 with SMTP id
 h22-20020a5e8416000000b006549404ffb2mr5911599ioj.166.1650832354133; Sun, 24
 Apr 2022 13:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220422200115.GV11868@merlins.org> <20220423201225.GZ13115@merlins.org>
 <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org> <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
 <20220424184341.GA1523521@merlins.org> <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
 <20220424194444.GA12542@merlins.org> <CAEzrpqeY_BAMLdL7NQmtC7ROBkZLrx=FHr=JC4KHoPF6Kwn3Kg@mail.gmail.com>
 <20220424203133.GA29107@merlins.org>
In-Reply-To: <20220424203133.GA29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 16:32:23 -0400
Message-ID: <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
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

On Sun, Apr 24, 2022 at 4:31 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 04:01:34PM -0400, Josef Bacik wrote:
> > > (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > > FS_INFO IS 0x55555564cbc0
> > > JOSEF: root 9
> >
> > Huh ok, it's the UUID tree, weird.  I pushed, can you re-run
> > tree-recover, you can stop it after it does root 9, I just want to see
> > what bytenr it thinks the root node is at.  Thanks,
>
> (gdb) run rescue init-extent-tree /dev/mapper/dshelf1
> Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue init-extent-tree /dev/mapper/dshelf1

Sorry, I need tree-recover, not init-extent-tree.  Thanks,

Josef
