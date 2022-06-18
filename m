Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9889D5503C9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiFRJE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiFRJEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 05:04:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8533A2A;
        Sat, 18 Jun 2022 02:04:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd6so6216939edb.5;
        Sat, 18 Jun 2022 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ui+mLR6kyF0wdfzo/EcLDO7dPFVHC367yFF81zcZVnY=;
        b=XAuH02T5EIzLRo+0Emlpfbzofq9bEc3nwEmEHXtoMyhPmdUq3151bfVU2WDu4nEYSQ
         htsj25WWdmJOAZ4SYEVDVCV8auPzn9wKR0b6SdmFi9X3YA2ZV3TqXuWpwyam2YWfNB+u
         YVkwHR/UnRMvfpAiybtg6mkzTx2uOP28by+Driy4oO77l6OfBq8pWFCaSWBNS+xl2FT8
         UXdtm9ifjZxCkPuhTBuIqJi9xPayl0pOE/o5vaDazBPpvWaqzLF5ON2gSW77gQqfmcrA
         7JS4XKKzPhKxHJadVjt/QjSqtBk6w388kEElbMlRHplGJmsob+Flc8AMOPA1uUzn9vJX
         qUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ui+mLR6kyF0wdfzo/EcLDO7dPFVHC367yFF81zcZVnY=;
        b=JPE1xqB78Ieg4e00PD+4yy4gOAWqrlFNgSkXJ5COfF/50JCm+IpFobwyeXa6QBJfOw
         o5C7zWT2ice+aXcvScC2qXKNGMaOyQtf8MQ4CTFGd3ZGZQiuOAcfhhu9QCXMXYEqapco
         tQaVVqVdkQzfZyJCUHcqnH6hztaUe8SH8xCxK9dsOrsYbLu0goJ6PGYesoKa/PLfCIk0
         IgNSk6Njgn1JRjo5Zui0cbxeU9b5bZmZJzsyqi2K33d+8xCh8G+yd2eN19YkP6EPlj1a
         EeEUo1ozLLOkfjLCRyP8aGkjyEzIBH40KdinO4XPXPJOZ5p06QhUcasOGJa2UW4o5t0l
         Ug/A==
X-Gm-Message-State: AJIora+sdJ2Y7UCOdgcMNYVCS8n/qQi65V5T00mAcx1gWFPRzNgCJdqs
        /YFg3DmrkxL4J/adUNR967k=
X-Google-Smtp-Source: AGRyM1vHof1f/pHCzJetgr+4SQaiNH0PuIx3ZwW5OBZY15U+SDAD1SQz9uAvNJZzVn/mNc7fWqHZKg==
X-Received: by 2002:a05:6402:31f6:b0:435:5a08:d5e0 with SMTP id dy22-20020a05640231f600b004355a08d5e0mr11206339edb.308.1655543083854;
        Sat, 18 Jun 2022 02:04:43 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b006fec3b2e4f3sm3146272ejw.205.2022.06.18.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 02:04:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in zlib_compress_pages()
Date:   Sat, 18 Jun 2022 11:04:41 +0200
Message-ID: <2057523.KlZ2vcFHjT@opensuse>
In-Reply-To: <94f8d618-ec7a-f68e-c302-2639ae3d7549@gmx.com>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com> <14654011.tv2OnDr8pf@opensuse> <94f8d618-ec7a-f68e-c302-2639ae3d7549@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On sabato 18 giugno 2022 00:16:15 CEST Qu Wenruo wrote:
> 
> On 2022/6/18 02:13, Fabio M. De Francesco wrote:

[snip]

> 
> Thanks for pointing to the doc, and that doc is enough to answer my
> question.
> 

Well, this confirms that my changes were quite helpful :-)

[snip]

> > As I said in a recent email, I'm relatively new to kernel development,
> > especially to Btrfs and other filesystems.
> 
> That's not a big deal, that's why we're here to provide help.
> 
> >
> > However, I noted that this code does different handling depending 
> > on how many "in_page" is going to map. I am not able to say why...
> 
> AFAIK the reason is optimization.
> 
> The idea is like this, if there are multiple pages left as input, we
> copy the pages from page cache into the workspace buffer.
> 
> If there is no more than one page left, we use that page from page cache
> directly.
> 
> I believe that's the problem causing the difficult in converting to
> kmap_local_page().
> 

[snip]

> 
> I'll send out a cleanup for zlib_compress_pages(), mostly to make the
> (strm.avail_in == 0) branch to call kmap() and kunmap() in pairs,
> without holding @in_page mapped.
> 
> Would that make it easier?
> 

I was doubtful when you asked this question. However, when this morning I 
saw your patch, I soon understood that it would make that task so easy that 
a silly script could do a mechanical conversion.

Thanks so much,

Fabio



