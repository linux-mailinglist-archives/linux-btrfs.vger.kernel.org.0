Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0123873D1E7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jun 2023 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjFYP7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jun 2023 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFYP7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jun 2023 11:59:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562DBF3;
        Sun, 25 Jun 2023 08:59:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31297125334so2022256f8f.0;
        Sun, 25 Jun 2023 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687708789; x=1690300789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHlFiZs5tFIFJlBDQPU4DvtUwczU5PH/nPUQB8u9ynA=;
        b=NBsJvYr5y6vAfQybS4O4IodHezeegPVCM5raoQdCvB7dcrK1BQAcOQvwjyWUYBrZ17
         AUiE9S01t2WeoDVZkaLSdZFzSJRjl+r0rBQ8USOw0/UQZkBZ8Q0v04F45iJ3vCodobEM
         FrIwejpF5rzxJEUp5trugER+zOLjsQS/ZEDdrgFjPXpdtzcD89oUWXcUwLREyz6aW7hI
         WzqReUcp4OKSVbYN3BDTiPO5lakVCGCq3fcpX/wMIB13tIuoI7q8msYTOc+kgTfAMD7K
         VW68atjGBC2c3mv8ABYPFEnZwVRHkMfTxpINat8f+thxSuH4tv+akpSAfrHcpeEhf7tE
         xAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687708789; x=1690300789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHlFiZs5tFIFJlBDQPU4DvtUwczU5PH/nPUQB8u9ynA=;
        b=Gm4IARaQC5u51gQovaE2BedVShWNGh8P+eiE11Q0PiQzs8RcHjs+uUKRkj/t8dK1ST
         m4ui5FC/icP6FRYYrEiEOBmSaFcMuyYldU4zRXQe7Z2+DcQ3s2Hj27HXXWGdyMSwkBYP
         Y1nqrtR19d+kcdR7PhxCBtT9qkMCkukIWi0p0MaaCWXADQZVFQ18H0/m9/UHFimI6m7Y
         aZ+uWO5sN6WwDC1tGbNCdTjhpd/LACtKyehkMBnmBoFJbmHxEUjUkTuWzzpvEmQ3XreH
         BQBPGlRGHQg0qjmn9o6lyRZIfaBl6W4PrDLQbF8bA0L87T+UCfp3vrnWKGdNreITJ8z3
         KvDw==
X-Gm-Message-State: AC+VfDx9uz7Iqo4XuWVe5GyiXhUwdn5lCc5vb2NZgfiRG58hwrWymW5O
        /rbHswfsCq33+qqYNLjPjXI=
X-Google-Smtp-Source: ACHHUZ5ATvmUoOCSXJ8ImWBo56+GVeVF8ADqex2ejrdSs3fcxjADfw315UCi5HrmFvgrUkSMwjbVuw==
X-Received: by 2002:a5d:6dce:0:b0:30a:e63b:950 with SMTP id d14-20020a5d6dce000000b0030ae63b0950mr29180323wrz.31.1687708788471;
        Sun, 25 Jun 2023 08:59:48 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d522d000000b003119633ecb5sm4891836wra.88.2023.06.25.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 08:59:47 -0700 (PDT)
Date:   Sun, 25 Jun 2023 16:59:46 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Forza <forza@tnonline.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <song@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
Message-ID: <e3ce1745-0a3e-4c9d-955e-2a0ce20422cf@lucifer.local>
References: <20230605201107.83298-1-lstoakes@gmail.com>
 <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
 <f6b42d95-09f1-48d6-8274-e6145febb31d@lucifer.local>
 <2a6fa9d6-53b8-93cd-16c8-309ce2b8e3ac@suse.cz>
 <20230607093316.cdf60df195915fa9d38067ea@linux-foundation.org>
 <11b893e.86425ef4.188f33688b8@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b893e.86425ef4.188f33688b8@tnonline.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 25, 2023 at 05:40:17PM +0200, Forza wrote:
>
>
> ---- From: Andrew Morton <akpm@linux-foundation.org> -- Sent: 2023-06-07 - 18:33 ----
>
> > On Wed, 7 Jun 2023 10:58:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> >> I would really suggest moving the fix to
> >> mm-hotfixes instead of mm-unstable, and
> >>
> >> Fixes: 80b1d8fdfad1 ("mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()")
> >> Cc: <stable@vger.kernel.org>
> >
> > I've made those changes.
>
> Did the chabge go into 6.3 stable? I saw these issues with kernels 6.3.0-6 3.7. I now updated to 6.3.9 and have had no more warnings since.

Yeah, got the notification from Greg's script that it landed in 6.3 stable.

>
