Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05D4D511D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 19:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiCJSBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 13:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiCJSBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 13:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17B3197B54
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 10:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646935246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDJX0xDz3mzKMSilMItog0LpILbVyzwdCnzO5jpxac8=;
        b=IZUgXCVX4OVc2TP27mnf4bHGTs9q9vaqXRhsRPz3AJPcvR/4i4dZcVEYPvio8rZ8F0vTED
        C50h/ITUc/W2fg2+cMJGXPBFk0T/Bk7pB246S7t68X3TbuuKuxAWuvq6fOn1O2crdHk1yb
        cPxraiTTnNOJbMQCBv4C4mDaENbYnRk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-_1FjNPjXOMyGvTH8XM5Xww-1; Thu, 10 Mar 2022 13:00:44 -0500
X-MC-Unique: _1FjNPjXOMyGvTH8XM5Xww-1
Received: by mail-wm1-f72.google.com with SMTP id z9-20020a7bc7c9000000b00389bd375677so2577929wmk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 10:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDJX0xDz3mzKMSilMItog0LpILbVyzwdCnzO5jpxac8=;
        b=C3lVucdreZ/LHBqsLH2YXwGsv0Xu5JU3ju8M80x3duLYrKVI7SLlq5ij/B0eLkerHD
         NvCE9mGIC24wFR/dffRyMOf3Km1TVOppcADT2QSU9TVRvpoCMCfTfEsNUOh+giQYZFiB
         tT0YliJIU6u5bCziPWN2cuiQYM2wdp9+ENb4WEeWCE4oxs0sv1AP8cIiI2YDY8wN5hEE
         aOgm8Ov66wudWrUVb0a73Jj+5Zfmz7IJHaQJHy9/feVaRfYLqoie3rWob1cLaoDap84O
         BgPdpx8RfmPQyq0SLLuV+6n7SW/RwuWErCVgsqjb/wwpfMeMDn2F6/xSkGEuZt1TmovK
         5yZQ==
X-Gm-Message-State: AOAM531o9ql3Tii+q5o4bYXYamydixZtVHPN+rMeTEVPiT0UWchAXT0w
        tOdcJ4gh9mrvpkUQCjz4knmPuNfKuauFpl+dfR9ViPqu7C6f+UNbz3a7Fscdrg5lPnPGr0gaSEY
        xSFR6jnnPIKO7GbFtWqKFdiAULBEJ0jqjBO7kKuQ=
X-Received: by 2002:a05:6000:10c6:b0:1f1:e562:bee2 with SMTP id b6-20020a05600010c600b001f1e562bee2mr4462495wrx.654.1646935243653;
        Thu, 10 Mar 2022 10:00:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6h+yWNd0DE//pCGjzqYuSv/FVk6BVA6aiZwKiI0R6R6JjBtjKjPJy8mCZVuV3axvW4bM3405mckF+LKcT5DI=
X-Received: by 2002:a05:6000:10c6:b0:1f1:e562:bee2 with SMTP id
 b6-20020a05600010c600b001f1e562bee2mr4462478wrx.654.1646935243378; Thu, 10
 Mar 2022 10:00:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com> <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
In-Reply-To: <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 10 Mar 2022 19:00:31 +0100
Message-ID: <CAHc6FU4ZXh+Co=__KkRzbSEJCiQnKdRayopgib26KQGbS_bbNA@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 10, 2022 at 6:13 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.03.22 20:27, Linus Torvalds wrote:
> > On Tue, Mar 8, 2022 at 9:40 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> Hmm. The futex code actually uses "fixup_user_fault()" for this case.
> >> Maybe fault_in_safe_writeable() should do that?
> >
> > .. paging all the bits back in, I'm reminded that one of the worries
> > was "what about large areas".
> >
> > But I really think that the solution should be that we limit the size
> > of fault_in_safe_writeable() to just a couple of pages.
> >
> > Even if you were to fault in gigabytes, page-out can undo it anyway,
> > so there is no semantic reason why that function should ever do more
> > than a few pages to make sure. There's already even a comment about
> > how there's no guarantee that the pages will stay.
> >
> > Side note: the current GUP-based fault_in_safe_writeable() is buggy in
> > another way anyway: it doesn't work right for stack extending
> > accesses.
> >
> > So I think the fix for this all might be something like the attached
> > (TOTALLY UNTESTED)!
> >
> > Comments? Andreas, mind (carefully - maybe it is totally broken and
> > does unspeakable acts to your pets) testing this?
>
> I'm late to the party, I agree with the "stack extending accesses" issue
> and that using fixup_user_fault() looks "cleaner" than FOLL_TOUCH.
>
>
> I'm just going to point out that fixup_user_fault() on a per-page basis
> is sub-optimal, especially when dealing with something that's PMD- or
> PUD-mapped (THP, hugetlb, ...). In contrast, GUP is optimized for that.
>
> So that might be something interesting to look into optimizing in the
> future, if relevant in practice. Not sure how we could return that
> information the best way to the caller ("the currently faulted
> in/present page ends at address X").

Yes, this applies to fault_in_iov_iter_readable() as well, as it is
based on fault_in_readable(). It's probably not a super urgent
optimization as the buffers faulted in are immediately accessed.

Thanks,
Andreas

> For the time being, the idea LGTM.
>
> --
> Thanks,
>
> David / dhildenb
>

