Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346D7725983
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjFGJHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 05:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjFGJHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 05:07:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC1268E;
        Wed,  7 Jun 2023 02:06:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-970028cfb6cso1182855666b.1;
        Wed, 07 Jun 2023 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686128796; x=1688720796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1yPBwGT+cE9xc3w7Ie4GBXa4DqL39GefXKyCYfp7sc=;
        b=G13vVfv2s4+jbiS40NG5KXlo0wZxHuL1McyNyiyJSXbO7UKKecj1ga33sqRb0tEUUR
         Q9PmJTGmDRaUsxZjhhniOfWSPjidgTX2/fSFgPX8h/sUsvYD33WEkZORIvj5lR2Pu7sf
         6JGCx2jt1ScrWBpE8ziZoat5XZj7/cnW8Ui/r4N2Up3bjfFuEghhEJik57N4DYwJ0obI
         zxj2YE7e6oaYd1ZeQ9WTya4VPgyQy2VynjgknzHFeIaCMGEWdU/Xd1eImUELUoFIa/Cu
         V/0mldWzbyRO8wrj2zeS1k4aj77lx2bJoZnKO6x0ys3ehbW+WoVAUnHzrH6TCNAxb/uY
         FkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128796; x=1688720796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1yPBwGT+cE9xc3w7Ie4GBXa4DqL39GefXKyCYfp7sc=;
        b=EI7/v/ISQKjypSq2bbJyN/2hWm8+EsR0JBZJeqDzxhJYNVAWvEzmW2QrZ9LTQdbEOm
         2oCa20qywoEkRgzEQqHmxeR+099FONTBiy9423UANtz1KcwB0WR0FZNZW7Hs5ZlkZ5RC
         JVPB0SWV7AhCmbZqonnM+JpJZdjhjhcV7iiVxlhHqvNnTybcrU3XhOzBTXkQeU8AE2ks
         GfMves9zSihSODTLqmU5wVQyICXnXo17qAVEuTJapqREttnk7IxDimRUFzCj1mphjvHJ
         dWUD3x/ZJjYWLGzAmLZHCKWsmmdx9R9wnntb3LLaS09Qd3BN+AHVmsbrboXmWQJn6n1S
         L/fQ==
X-Gm-Message-State: AC+VfDz8LFKphtIS1Rr/rLRDAXX2SMwWUMt6wcs0OgxjumieyNrSL36Z
        ReHfWZ+pn6zYVGx6WndKafM=
X-Google-Smtp-Source: ACHHUZ5WzoU4UWUf+EtpfSUhNP0tIHdENFW/vh3iFUKUX/mDlTP7BvVvbn2bjMji0qwe+c3ZocWFog==
X-Received: by 2002:a17:907:980d:b0:96f:a891:36cb with SMTP id ji13-20020a170907980d00b0096fa89136cbmr5652727ejc.0.1686128795700;
        Wed, 07 Jun 2023 02:06:35 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id l5-20020a1c7905000000b003f7f475c3c7sm163166wme.8.2023.06.07.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:06:34 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:06:34 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Forza <forza@tnonline.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Message-ID: <6b954be8-c7be-436b-996d-92b0469ef74d@lucifer.local>
References: <20230605201107.83298-1-lstoakes@gmail.com>
 <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
 <f6b42d95-09f1-48d6-8274-e6145febb31d@lucifer.local>
 <2a6fa9d6-53b8-93cd-16c8-309ce2b8e3ac@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6fa9d6-53b8-93cd-16c8-309ce2b8e3ac@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 07, 2023 at 10:58:40AM +0200, Vlastimil Babka wrote:
> I think I found the commit from 6.3 that effectively exposed this warning.
> As this is a tracked regression I would really suggest moving the fix to
> mm-hotfixes instead of mm-unstable, and
>
> Fixes: 80b1d8fdfad1 ("mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()")
> Cc: <stable@vger.kernel.org>

Yeah, ugh. What's irritating is that this is not incorrect - invoking
warn_alloc() in such a way that it does literally nothing is not right, so
that fix was required, but it simply exposed another issue.

But completely agree this is technically a regression, and yes Andrew it'd
be great if we could move this to hotfixes and append the stable cc if
possible thanks!

(We definitely need to refactor a lot of this code!)
