Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49A4C36C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 21:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiBXUTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 15:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiBXURq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 15:17:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDB57938E
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:17:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id bd1so2802750plb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VIoQPvwHqFXtMAXE8AKCkLiEbpc0ZIKiqGrsuvIzD+s=;
        b=tk7jCJjg1+CUdYaHqNbciARDK8dfm6TepRBLjhUKgQM0CtIrgyTuICuE2Lsn723Gza
         EXY0qT0hPfDJOuJd/GR0VFQJEcGxj0+VMw8UR9vZJXJ8VIgdAl0cWtet7MraYRn1nCjM
         rdkvFjsQepqXyglMqp5mXi23JrdltsqogRns4pkN6ZxgE5WitpE+XPlGEHq+u4eIsjnD
         q6kwVNfqxe3a9xRgdJzR6AOV7qGWFjMwbBiADU0lDjxg6XDS43DZ9KPOo/nOMgLIwJvB
         +xohKsi/b9O1GaQh1BwCseDhIdkcFhF5vNPr/ySGWV9ynd4hlz/RDBManBb9jcHE42t9
         l5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VIoQPvwHqFXtMAXE8AKCkLiEbpc0ZIKiqGrsuvIzD+s=;
        b=Vb+WmVuCIjLOkxjlALt2ElLCijIBj4GWHm/4IA7sis9cw+Jnom73CM4L5KUaIfVLP6
         L1YXZdZNGVXaUgYm2ufXQSkrIN28pZomk1LQWnRr2PFEyGX8koOxDBR+LUmgFam8Gx2q
         qSqnXARRHykWihPDG3//hfqEg1yhwOerCUuIo96jb4glsgNHHVsQernhbg7Q4wkJocMs
         dMvSu70/p1CYcv92XRorAUbMMh0Ti/yCNVHf9fOWhePLeewrxoOkOU4KT3+fILopqPXc
         4OzN1rq1mFtEjoH0RiI8Q9BpQOOd02Rw5QuERMJDjjRXwD6WHnmrq00nmp7fTGgUcSZT
         scbQ==
X-Gm-Message-State: AOAM530aDv/7SxRJ9FqGPHc0wsJH4dJE1WcOf9gXNAOI+EnB/px0QUgV
        ny16vmdaN1pu0vLTbbJDJyGE3w==
X-Google-Smtp-Source: ABdhPJy4DAaoL+2eDM6IAlpIbHkBTBRxpHyXtyOv9u8K7XTUIccliARsqfykcfASTj7CwdFEJRLY7g==
X-Received: by 2002:a17:902:8f96:b0:14e:bd3c:149b with SMTP id z22-20020a1709028f9600b0014ebd3c149bmr4259267plo.172.1645733833457;
        Thu, 24 Feb 2022 12:17:13 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:64b1])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm181429pjb.5.2022.02.24.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:17:13 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:17:11 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4] btrfs: add fs state details to error messages.
Message-ID: <Yhfnx21q51xSBl32@relinquished.localdomain>
References: <a059920460fe13f773fd9a2e870ceb9a8e3a105a.1645644489.git.sweettea-kernel@dorminy.me>
 <20220224132210.GS12643@twin.jikos.cz>
 <284ccc08-8de7-9188-19d8-20f4eda56cb4@dorminy.me>
 <20220224184231.GZ12643@twin.jikos.cz>
 <20f14d85-6a07-e66d-4711-c16c6930c2a3@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20f14d85-6a07-e66d-4711-c16c6930c2a3@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 24, 2022 at 03:09:08PM -0500, Sweet Tea Dorminy wrote:
> > > All the other interactions with info->fs_state are test/set/clear_bit,
> > > which treat the argument as volatile and are therefore safe to do from
> > > multiple threads. Without the READ_ONCE (reading it as a volatile),
> > > the compiler or cpu could turn the reads of info->fs_state in
> > > for_each_set_bit() into writes of random stuff into info->fs_state,
> > > potentially clearing the state bits or filling them with garbage.
> > I'm not sure I'm missing something, but I find the above hard to
> > believe. Concurrent access to a variable from multiple threads may not
> > produce consistent results, but random writes should not happen when
> > we're just reading.
> 
> Maybe I've been reading too many articles about the things compilers are
> technically allowed to do. But as per the following link, the C standard
> does permit compilers inventing writes except to atomics and volatiles:
> https://lwn.net/Articles/793253/#Invented%20Stores
> 
> > 
> > > Even if this is right, it'd be rare, but it would be exceeding weird
> > > for a message to be logged listing an error and then future messages
> > > be logged without any such state, or with a random collection of
> > > garbage states.
> > How would that happen? The volatile keyword is only a compiler hint not
> > to do optimizations on the variable, what actually happens on the CPU
> > level depends if the instruction is locked or not, so different threads
> > may read different bits.
> > You seem to imply that once a variable is not used with volatile
> > semantics, even just for read, the result could lead to random writes
> > because it's otherwise undefined.
> 
> Pretty much; once a variable is read without READ_ONCE, it's unsafe to write
> a new value on another thread that depends on the old value. Imagine a
> compiler which invents stores; then if you are both reading and setting a
> variable 'a' on different threads, the following could happen:
> 
> thread 1 (reads)       thread 2 (modifies)
> 
> reads a into tmp
> 
> stores junk into a
> 
>                                 reads junk from a
> 
> stores tmp into a
> 
>                                 writes junk | 2 to a
> 
> 
> Now a contains junk indefinitely.
> 
> 
> But if it's too theoretical, I'm happy to drop it and amend my paranoia
> level.

I agree with Sweet Tea here. Even if it's very theoretical, it costs us
nothing to do the "correct" thing here.
