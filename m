Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BD4D52AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 20:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbiCJT53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 14:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbiCJT52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 14:57:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2613FAD6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:56:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r7so11359764lfc.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2Wz219nvat7o4Hv5So6QIXYKsJ4ceesV+enxd1hA8M=;
        b=Z32HTViBy9oMzZHj1RUGbdP8X1j5ggnctR1fE2AX//T4bqyz5C4qMQRw7jXJXt/3+O
         YsLMvkPUjdgSoAQ1O0J2kqVSv2TByYCw1aWHMwibpYpk+kWAzkfpxm5tr+PGYp4DByTw
         9Z5NMp67VygZeUC+jkmx6ezO880rKnd5Dhjjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2Wz219nvat7o4Hv5So6QIXYKsJ4ceesV+enxd1hA8M=;
        b=icrUE2204V4MetcgSyr0XnKE7SNjx7wJODf8ZogACG7No5lRraF3nNUs0ZMlmDDJp+
         N4iJP834oSqmm30aThBtrxJNQwM1m/L+6qoSy16XWTVB1ii6Idnhi18UvSpKcDLMJvTN
         eA9tUkecUAqW+rWYtTlnfdogwfD+k9J5K361LcwM1pyp5iiWlepmiAsgBPCEb4IKAYjF
         QYZ/TqoA4cwwONV5QAUoPJ7eOoJFn0TGsTBy/On/L5/7+p+11h6C7snjr91w4SEoVLb6
         WyHMCkIgonS73S6Drwm0S6L4J3dML2YDoHYvdsjTYeog/RCdkYn6mNqJV/HhlZvs0x0f
         E9Mw==
X-Gm-Message-State: AOAM531lEsOs2zOHVNl/KUXOAxi36+FScMkVGoA1w4otS6OlBmhhPsk5
        mrRj0nGd2NlpQgEr+dpv5+GVKqBsDePlCNRoN6E=
X-Google-Smtp-Source: ABdhPJxFdTn2c/azFBpdibxonv5Bcnf4zk5rxCQ/6gMAcbs4mxs/yWvMZ720gd5VntxKhLHJfyzTWA==
X-Received: by 2002:a05:6512:1313:b0:445:b77d:450 with SMTP id x19-20020a056512131300b00445b77d0450mr3978618lfu.640.1646942184705;
        Thu, 10 Mar 2022 11:56:24 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r13-20020ac24d0d000000b004483f89dd51sm1145559lfi.241.2022.03.10.11.56.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:56:22 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id z11so11271805lfh.13
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:56:21 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr3900843lfb.687.1646942181633; Thu, 10
 Mar 2022 11:56:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com> <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 11:56:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
Message-ID: <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
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

It's out as commit fe673d3f5bf1 ("mm: gup: make
fault_in_safe_writeable() use fixup_user_fault()") now.

                 Linus
