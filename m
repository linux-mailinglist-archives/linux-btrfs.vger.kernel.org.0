Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DDA4D1F3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 18:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347792AbiCHRli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiCHRlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 12:41:37 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B40532F8
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 09:40:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id n19so12450818lfh.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4HcIA5ZURFOUl98GOVrefN75djtXjyZm8o/dMFbKz8=;
        b=XUxN+P64bilcPljqWgWX3wqVnw3FZMXB5ZH4wIfuAfuPKU8hucKGsVwl/+klugjHvC
         xd1iG9Sq95/OIhQAcijP56EOmxpcFGCDgrpONQjnZ4xtLxScBr0K/bZ22n0j5UyeCIsH
         RdkV3T99Y854qU87ErGuLfUzTChN5wVlQfXLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4HcIA5ZURFOUl98GOVrefN75djtXjyZm8o/dMFbKz8=;
        b=C8frztFi5X6cRBmzOoH22aM+X0lSKrffFspGfJXc3tOUU9J8/4NiMGnnvv90qqtIEM
         0lBcOG8zUbWZ9DoIeCSHcm62I47LhVvsgQN10lv+kCLcc4PHMSa2FjHwQERxNMDwSm9u
         h49f2crMKDbe2dWsj78GEu1DSVFdKxt8odcsGWSwTrI42pq3iqDsQ0HE/1+JNWJVSZyj
         yBd0oWmR0DqrMH68Jm9lA6Y26g1gDxq10gwov/vGr08Za9N5wDlV7hqQrD8tHnhkC/h9
         CaNU5+tPuv/Es0V7hf/VK1OGAz/m4fb9ZZP2jFMKMvVx3CHOlBKiftyzwiWF2NaFF3kW
         cJxA==
X-Gm-Message-State: AOAM530cQCb/dabEZ5cixK1wrYaQsElxSd0FXghMe7hU/yY8VY2QzOyW
        VwM+ogX3hWOASs8m3laPwqIw98pBeX78h6PJwcc=
X-Google-Smtp-Source: ABdhPJzDfbjBpX2h7oOt12kWXIGtz/ZlWISvyRL5PptRXVJ1girsursijnMQ1Z1wZPEmmCvyetP0Lg==
X-Received: by 2002:a05:6512:2304:b0:448:46a9:7263 with SMTP id o4-20020a056512230400b0044846a97263mr2099997lfu.309.1646761234694;
        Tue, 08 Mar 2022 09:40:34 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id v18-20020ac258f2000000b0044840dae5d0sm487423lfo.215.2022.03.08.09.40.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:40:33 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 3so14923976lfr.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 09:40:32 -0800 (PST)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr8519640lfj.449.1646761232492; Tue, 08
 Mar 2022 09:40:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 09:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
Message-ID: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 8, 2022 at 9:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Your actual patch looks pretty nasty, though. We avoid marking it
> accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
> but still, that patch makes me go "there has to be a better way".

That better way might be to make q() not use GUP at all.

It doesn't want the page - it just wants to make sure the fault is
handled. For the fault_in_readable() case we already just do the user
access.

The only reason we don't do that for fault_in_safe_writeable() is that
we don't have a good non-destructive user write.

Hmm. The futex code actually uses "fixup_user_fault()" for this case.
Maybe fault_in_safe_writeable() should do that?

                            Linus
