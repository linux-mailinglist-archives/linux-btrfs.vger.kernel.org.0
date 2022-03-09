Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7384D3A30
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 20:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiCITXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 14:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiCITXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 14:23:06 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573E7C7A6
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 11:22:06 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso2478394ota.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajLEFScnY86/X/EB8VAWpPjqAUDRsUx1SOK3GF+S0iU=;
        b=Cuk6Sng0QFnBDMPD4pR668XwH3FXBI3EMDZfCqt6dtxF/NuSWNh3h1+I3HfiI2pGYQ
         c/SsCOHPaJEvqcjKMav3VmIw6hIsfBUZ4mCARDwrbjXf+7pyS5TGRdG2tVkLYWv5OqXN
         shhUSQZ5Gtzf+yFxJCIsagC3oPy0PNljar1IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajLEFScnY86/X/EB8VAWpPjqAUDRsUx1SOK3GF+S0iU=;
        b=jN8Bilix6t6VLqYNFCBmHFXhqA2NJGzZvWbRpb+LCC9MpJuYp4155ABQG0AvvnkT8G
         mKmhGxBFK9IAayAkXQG7nBPusSTuP0Sdh2obtwX1srJxPm+ofYhd9l4WaWYEuEqzUGnv
         x4NOKAYze3cG7/7gbiwsDxwAGy/uN/t/HIK3fCAE/CfpO56pD1JXh+a0vio4XCaFfWPz
         zaDH+E6Nsia9O+6XYiOGwVVDXZ6Z/ZPEYmnL7l2JO75NhNdHD1z8hjUbybdqkKluyF5N
         h2PjxLAhII4lD/ZkxBGfrkbCOJYTgHNRSTzq3iEFNJvDBN8TgSnJ7JwmWeyKL4HUVYiU
         goMQ==
X-Gm-Message-State: AOAM531xRvazqqKh7eGt/GIJmqdicaFKeWP7nUccu+9sBzu4cMPNPply
        Yxqa3kAh5C8aSWSlEgXZGiVsy2AH0PF/otNqrro=
X-Google-Smtp-Source: ABdhPJzQzlKjSbiZB+46nsEQYlUj3J5/RBgjyfRFluBk8R14fYjZLY5jlndaZtApV28qSGMLGw+UyQ==
X-Received: by 2002:a9d:f06:0:b0:5b2:37c7:40b9 with SMTP id 6-20020a9d0f06000000b005b237c740b9mr718474ott.74.1646853725537;
        Wed, 09 Mar 2022 11:22:05 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id ec47-20020a0568708c2f00b000d9ca2e1904sm1389195oab.45.2022.03.09.11.22.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:22:03 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id s207so3652216oie.11
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 11:22:02 -0800 (PST)
X-Received: by 2002:a05:6808:2209:b0:2d5:1bb4:bb37 with SMTP id
 bd9-20020a056808220900b002d51bb4bb37mr702760oib.53.1646853722554; Wed, 09 Mar
 2022 11:22:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com> <20220309184238.1583093-1-agruenba@redhat.com>
In-Reply-To: <20220309184238.1583093-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 11:21:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
Message-ID: <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
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

On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> +       while (start != end) {
> +               if (fixup_user_fault(mm, start, fault_flags, NULL))
> +                       goto out;
> +               start += PAGE_SIZE;
> +       }
> +       mmap_read_unlock(mm);
> +
> +out:
> +       if (size > (unsigned long)uaddr - start)
> +               return size - ((unsigned long)uaddr - start);
> +       return 0;
>  }

What?

That "goto out" is completely broken. It explicitly avoids the
"mmap_read_unlock()" for some reason I can't for the life of me
understand.

You must have done that on purpose, since a simple "break" would have
been the sane and simple thing to do, but it looks *entirely* wrong to
me.

I think the whole loop should just be

        mmap_read_lock(mm);
        do {
                if (fixup_user_fault(mm, start, fault_flags, NULL))
                        break;
                start = (start + PAGE_SIZE) & PAGE_MASK;
        } while (start != end);
        mmap_read_unlock(mm);

which also doesn't need that first unlooped iteration (not that I
think that passing in the non-masked starting address for the first
case actually helps, but that's a different thing).

                 Linus
