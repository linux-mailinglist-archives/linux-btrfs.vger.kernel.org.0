Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8424F70DA8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjEWK3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjEWK3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:29:45 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDBAFD;
        Tue, 23 May 2023 03:29:42 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1995152e87.2;
        Tue, 23 May 2023 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684837721; x=1687429721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWUyqe1Hx0qJvTJ8mr6ssQT6TVvbWeNPeCd8kj4GkHM=;
        b=hOve3PIgESzmA1/VwP9qwbqQQJq41+7E4NS4NExcIxi7kGA9xY3KUSYUgZ6E2CR6eu
         teZIz2BZSliKnG9iC/5e0txWLNlb5yHuQnuIX2GotfaWc8z1S1Cg08mETbuGrWqoTNlh
         jHw4vTN0K3+s+UbHSaa+o5d2EVBvI4YssvxDkYVk5/3gB/tRGJNfi1/S2VtF0tQDKV1D
         q/s/OeGc8Tfr0XUc701qADiqbWwX9QX0RsryuvcjBY4d6iLh+DKD0RBZALAsoFKZk2/s
         3duS0k4z3T4Z2W2RBHRM7kEfryP6nJLWdN77HgkrIRDel9hXu5CFr8T3k6nA+D38ken9
         BAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684837721; x=1687429721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWUyqe1Hx0qJvTJ8mr6ssQT6TVvbWeNPeCd8kj4GkHM=;
        b=IKV0wPwjU3VaO0wAHHHSE0aivHr+CwQvI//xoz5Anuf70pujf98Fye1aE1t5vNPUUY
         3rVP8jivpQMuLyalqEoZQsEoLA0rKiAredo8nS8DxZdQPOz60RlF2kSykordWdBpJPlp
         c/oZulDNELNkZvZxXb6eU1XCCs1HmJ+JNZ8bGFQnc/EEeWfX3rsytsZ9qswsOta4STlB
         B97rkzgzKvS3SMMLNF/mdEzarNocbN67gkl6A833ukh4QUKyzrmru09bVDEQg3bsiKJ2
         Qj5TvXkTGn7dPRhAe4+2AMnIYySqGHB1C6z1oC1ikOP9qymA9mX7PcD2Wap8IC+zIwp0
         BURQ==
X-Gm-Message-State: AC+VfDxeGhayfqU6aTqYB4l5SiI8iQ9ZxF+suOi5e2IgN3v7Z3CjMKKr
        KWB0YvMKy3g8NY2qLav8Ee/l+HMAd1xRsuH7
X-Google-Smtp-Source: ACHHUZ7FKsiuoxhPaIQ8Yvpa5bGSvahqza7ModaNmEwxSScEs404CydwamQ+ox/0Y2qLDp7NTdU9PA==
X-Received: by 2002:ac2:555e:0:b0:4f3:880b:285a with SMTP id l30-20020ac2555e000000b004f3880b285amr4572686lfk.29.1684837720546;
        Tue, 23 May 2023 03:28:40 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id t15-20020ac243af000000b004f121c8beddsm1297639lfl.124.2023.05.23.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 03:28:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 12:28:37 +0200
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Forza <forza@tnonline.net>
Cc:     Forza <forza@tnonline.net>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        urezki@gmail.com
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Message-ID: <ZGyVVQxnw6Tn7Xb8@pc636>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <fcf1d04.faed4a1a.18844d8e78f@tnonline.net>
 <ZGwcVTpQNBoJHBB+@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGwcVTpQNBoJHBB+@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 08:52:21AM +0700, Bagas Sanjaya wrote:
> On Mon, May 22, 2023 at 09:04:05PM +0200, Forza wrote:
> > I have a similar experience with kernel 6.3 where vmalloc fails in a similar way. I was able to reproduce it in a QEMU VM as well as on my system. 
> > 
> > https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/T/
> 
> Thanks for your similar report. Telling regzbot about it:
> 
> #regzbot link: https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/
> 
It is good that you can reproduce it. Could you please test below patch?

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 31ff782d368b..7a06452f7807 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2957,14 +2957,18 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
                        page = alloc_pages(alloc_gfp, order);
                else
                        page = alloc_pages_node(nid, alloc_gfp, order);
+
                if (unlikely(!page)) {
-                       if (!nofail)
-                               break;
+                       if (nofail)
+                               alloc_gfp |= __GFP_NOFAIL;

-                       /* fall back to the zero order allocations */
-                       alloc_gfp |= __GFP_NOFAIL;
-                       order = 0;
-                       continue;
+                       /* Fall back to the zero order allocations. */
+                       if (order || nofail) {
+                               order = 0;
+                               continue;
+                       }
+
+                       break;
                }

                /*
<snip>

Thanks!

--
Uladzislau Rezki
