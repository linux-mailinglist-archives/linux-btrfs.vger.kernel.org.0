Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3C4D530C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 21:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbiCJUYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 15:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiCJUYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 15:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A557AED943
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 12:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646943809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bH4/6OdCxrtunb44tPOYHwdgjcfhX0Qz09OdOxJro7A=;
        b=ZQvbwiz7SvhOr6l1qQUOy+XpVWV7lwS2CjhhfmLNj/riHgVEfFVmGPzy1WlF9HTR/Wgxkh
        BV7IgCXbWtDZOZ9PpJgLjjmUwJnc3V8kIBOcKVl7m48f9GDlyVisjsm7aLNjLpctjzkOjO
        DUDZlzUhkN4kBba99xbyG3vOSd8l6kc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-KocwMxMbPae8pIeFmVLBMA-1; Thu, 10 Mar 2022 15:23:28 -0500
X-MC-Unique: KocwMxMbPae8pIeFmVLBMA-1
Received: by mail-wr1-f70.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so2075143wri.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 12:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH4/6OdCxrtunb44tPOYHwdgjcfhX0Qz09OdOxJro7A=;
        b=bePF63gSoHyGWcd3EUoVK0HV9IX812Ey5PEs8WFCImG8kSSMSaF1UrpUbyLhEO1a/S
         yNCs1lOjP6B967Fdlm8oysc99T6OgfAwNeTH0DUUt+wI80banyYa/vR8JrXLXCqNRxlX
         0Bc7qHRVG1o1ZdVVQNz8xnJxH+CrIfSdvhDbh1cyqoEiTDt6BftRGPymGNAcaZ+PThxc
         Xki+PAXQF+e7gsLjaSAsOf5QSglnvYQoGUYhwEke3EfXMt48syTDTO1RfZ81oQoSrxtO
         mGeFkrU3GpvjZWQdkVyW4dcd8mgJpgQd0dPpr9jPsNpZn/TnAWsDIH7iWyqywOXyfecj
         FVDA==
X-Gm-Message-State: AOAM530Dhthk4t/4AmKTPESoGFINWqv7yDflkWC8RW1Maxgblze+cV+g
        JNVaYliReZm30oJdw09Rwd1SyxshAdqlZrRQZv7rladui8svLU6He5VklNLSxr34G0mAZfKitJP
        c5Jz7hdcKYHfvCpO8RVgTVJaFpfephO46bNtKdio=
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id q10-20020a1ce90a000000b00381504eb57dmr13019518wmc.177.1646943806972;
        Thu, 10 Mar 2022 12:23:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw16FQLbDeS9B5CsJlBEVWqDdzz2Nkgq70FzZQX/iF5ZEZCXMvb6pDLIp/taw7qbW1c3cqimkE7lh0EQM6JeRk=
X-Received: by 2002:a1c:e90a:0:b0:381:504e:b57d with SMTP id
 q10-20020a1ce90a000000b00381504eb57dmr13019507wmc.177.1646943806851; Thu, 10
 Mar 2022 12:23:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
 <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com> <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
In-Reply-To: <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 10 Mar 2022 21:23:15 +0100
Message-ID: <CAHc6FU4pH_OKppo0n772JoDtXy=pmhApSSjN7emv4D=sdCSzWQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 10, 2022 at 8:56 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> It's out as commit fe673d3f5bf1 ("mm: gup: make
> fault_in_safe_writeable() use fixup_user_fault()") now.

Thanks!

Andreas

