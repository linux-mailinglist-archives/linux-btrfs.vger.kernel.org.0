Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA62A4D3B33
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 21:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiCIUiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 15:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiCIUiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 15:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBB9613DDC
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646858220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tfvPp8T6sBDgCD/bU6cj7d0QWkoleA0xgC26OnRlcVg=;
        b=KFfzsgCbNlLH0ViE0M+FW3IU+TSp7nXLrTKNW1SfzoZUPC9hLj4Yudo3FZLzqb2pPmpmYA
        bnw8IVghWI73LXc9Lq292wr7xIEJWayBhoulgPfJg9yZpcxuDPjNSSMgmBdLCzN1ObBAgI
        krKSFUjNtXY8d2x8Fwr3nuEfyUY6VvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-NY-iOC1tNCewNlBw-gRf1g-1; Wed, 09 Mar 2022 15:36:59 -0500
X-MC-Unique: NY-iOC1tNCewNlBw-gRf1g-1
Received: by mail-wm1-f70.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso2124016wmz.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfvPp8T6sBDgCD/bU6cj7d0QWkoleA0xgC26OnRlcVg=;
        b=FApOiFYABhN92HIrV/HIX3ooyaI3AXCHdaio0W4H8wJK8/SqToGPrqQhpZsiy/16+8
         mk8w/UwlY3p6fntJFe60HRCIZKa4KUf46SK+ORbbGqhyFsMzWuHt/1pqBxO45wXqIGod
         8czB/FeUQFaPpGA/y6OKYuP4QcjlBffogr4j6aCeXu6lOH4F0xtKHBVbLulqoRV18+Oz
         pj/rBwWSA/MYfHp9PHqmSUuU1M0MWf4s6pg6sAvU9t1AuoISlKazJVUbrXYM/hDHwczm
         3OTgpG4ZdBSqvybmx9WjHBQ6e8NTNvzWkXaHBg16Kfh/kIizk0cdq8ixSG6nOsDTwYGH
         u2Ug==
X-Gm-Message-State: AOAM531YSPSrATo5PS7eGYIFiaROSyw/GX/jgx06tMt49ZBO8UtpYSyj
        FnaDaroLP7/980xivxmCKUW4xAfHGhBQtGr3/i1cBCyDC+1MaZQteLOL4rZdhKUYYRgdZMJn92J
        /unopSy87ZQPF7N4k2pbZROWfj6XOUGpz3XEJAFk=
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id q10-20020a1ce90a000000b00381504eb57dmr8983119wmc.177.1646858215115;
        Wed, 09 Mar 2022 12:36:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxslNgqul7CsdHPFzrY6nugLgNmi6JeFFMtWCGzEmkIP6sbUIPjlerK4tjyTPW31RtVNkdst4BOmhD7u76G54o=
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id
 q10-20020a1ce90a000000b00381504eb57dmr8983106wmc.177.1646858214930; Wed, 09
 Mar 2022 12:36:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
 <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com> <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
In-Reply-To: <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Mar 2022 21:36:43 +0100
Message-ID: <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 9, 2022 at 9:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 9, 2022 at 11:35 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > That's better, thanks.
>
> Ok, can you give this one more test?
>
> It has that simplified loop, but it also replaced the
> FAULT_FLAG_KILLABLE with just passing in 'unlocked'.
>
> I thought I didn't need to do that, but the "retry" loop inside
> fixup_user_fault() will actually set that 'unlocked' thing even if the
> caller doesn't care whether the mmap_sem was unlocked during the call,
> so we have to pass in that pointer just to get that to work.
>
> And we don't care if mmap_sem was dropped, because this loop doesn't
> cache any vma information or anything like that, but we don't want to
> get a NULL pointer oops just because fixup_user_fault() tries to
> inform us about something we don't care about ;)

It's a moot point now, but I don't think handle_mm_fault would have
returned VM_FAULT_RETRY without FAULT_FLAG_ALLOW_RETRY, so there
wouldn't have been any NULL pointer accesses.

> That incidentally gets us FAULT_FLAG_ALLOW_RETRY too, which is
> probably a good thing anyway - it means that the mmap_sem will be
> dropped if we wait for IO. Not likely a huge deal, but it's the
> RightThing(tm) to do.

Looking good.

> So this has some other changes there too, but on the whole the
> function is now really quite simple. But it would be good to have one
> final round of testing considering how many small details changed..

Sure, we'll put it through all our tests.

Thanks,
Andreas

