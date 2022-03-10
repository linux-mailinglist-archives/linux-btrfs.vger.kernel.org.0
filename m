Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311124D5277
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiCJStP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 13:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCJStH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 13:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A737041F8B
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646938084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAMDDR/OlT3VUgZyoMb3yfhymErEdiK+nlypftXgzIc=;
        b=L95FzoucO5YpNZS05TLabBg8F6qfycDz21uE6iB2UbkSWPUk7coaYwbv0kq99xSCsQkvWC
        DMoWJ3CoyHxmnUBC4aeXhymRN3eIfZJ9zfqbcWrP5Aq5VnSgNC1LgOfdSOIITjReFjxaVA
        Q/7CbVepiHoiNveIgIDgJzCZtUyIJ8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-XMiMlrMsOQG_8wdGDoMSuA-1; Thu, 10 Mar 2022 13:48:01 -0500
X-MC-Unique: XMiMlrMsOQG_8wdGDoMSuA-1
Received: by mail-wr1-f70.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso1991152wrq.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 10:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAMDDR/OlT3VUgZyoMb3yfhymErEdiK+nlypftXgzIc=;
        b=bUA6t4RlVl78V5VVqnZqbnXUFixf7IVTdTBIJbLsJ5xShzCgoQh8QTXbBnJLUu4AsX
         f56XuyiT3ynz0zKgV4mSAc613iLLkfVyQ8NtkUEFQ+mXnE14Iqyt4VQh7TrkJ8PbF7/E
         RNF+Cra0bYLRZx+JoasJsBvQXSLsxBdIwf1+2Obn4UapvikzwU0EwCIdZaC7Y4JimExQ
         WfQ5d/bgvQVYtgOeEjyZ5gL7Ff9nDPM+VlarHZp+Sj4FutQIGm3KAoTFNoejgGQ5Wg+7
         sZJXW6u1IlH44e07Ch09RfPKX4qfPpa0k+30beDbjHHpqYPKSjW2W4MCfwUNxhJuwcbM
         cfJA==
X-Gm-Message-State: AOAM530hmylb+Bh60gGucZ/kKQZkz7/bJr2CQh7+1RI5j1SMOau9NN8u
        lQMmFS1MoSmnI51rS0D5uwmPofmIQAqbQkzet7HaKfJvT8w7vvyDW1MF1YMg5BKqYa2g3Dv75D9
        sy7urTUZlsI6UvOGtMAl/y7LtEP6jr5gWy6KvfCI=
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id 11-20020a056000154b00b0020375640930mr4625774wry.349.1646938080539;
        Thu, 10 Mar 2022 10:48:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1y1c4l/wYGkW+ggwZo6uKhbBm9y9Jr+TggF7K0Kz6yMLtKELmt+rxnEHc+KJK41kda9Lif0f87yrE0QOxUj8=
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id
 11-20020a056000154b00b0020375640930mr4625762wry.349.1646938080321; Thu, 10
 Mar 2022 10:48:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 10 Mar 2022 19:47:48 +0100
Message-ID: <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Thu, Mar 10, 2022 at 7:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 10, 2022 at 9:13 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > For the time being, the idea LGTM.
>
> I'll take that as an acked-by, and I think I'll just commit it to my
> real tree rather than delay this fix for the next merge window (only
> to have it then be marked as stable and applied that wat).

Works for me. This should probably still be tagged as:

Fixes: cdd591fc86e3 ("iov_iter: Introduce fault_in_iov_iter_writeable")
Cc: stable@vger.kernel.org # v5.16+

Thanks,
Andreas

