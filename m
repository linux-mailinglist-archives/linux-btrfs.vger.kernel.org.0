Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B04FA596
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Apr 2022 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiDIHjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Apr 2022 03:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDIHjN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Apr 2022 03:39:13 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9333B1014;
        Sat,  9 Apr 2022 00:37:06 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id az14so5303590uab.8;
        Sat, 09 Apr 2022 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gP0HSqV1BPP2hnHJJSIVwulWD40qBqjNUo5/F5WUJ2E=;
        b=lC/20A2H4ewWck8MRE7sgdRRrdeJE1N9jpjg9kaG51m7SU7u1LcTk83vsD6EsoTFaQ
         o83LWeBx96W3UHCx9lffyprOP8OByVrb6y6LeDQg1bRD4oIRMTrfy1eS0Kj3W7laZxbE
         cQAFvredScs/l/qlGSY1SlZEe35vATs3vkkz4iePODxvf7BIzcBxaqF7rWHmbjRqYGOv
         m//T5UjV3VY9l9jZLOAlbjNZ5L2iNDnLyMT3B1iQ6V32kyrXWj29GumFw8XYr6nazBYz
         rcsWcpBP3Em8MWkgKJZGoYAAmmWH2NNcw5ytwUmgyBfcFM+JUDPIiLnkGOo+SflAvWQE
         eSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gP0HSqV1BPP2hnHJJSIVwulWD40qBqjNUo5/F5WUJ2E=;
        b=kbxF0yNP34yfh/eKJ2dr887Y7rVWyR0M97K9T30tMtCBpL4sqVVo6NaEdsmN9m7KMB
         E4IFw8SRHaNgpEjwtb0i84C4GKQLWntx6dArpMm3xc3ZCIIfqK8x7AkazRyDMLFDrDCk
         7eUu++CVot6VKPo+xiRdjo4jfSh86/6J0egmNsCsdGx9ZRy18x7kSe1HU09cgBMpN/O9
         Nx+hVEzgU9yCC3MmpSz9zjWiNcjWdyUZrgiyKGUNeEh9xt/Oc9FDOETzFWgr9ESzvxFd
         HpIZ/H681/aXX87zcQ3xgZIDcdzcmuvQzUcoDAkecepuNtaGCpRAGkV2/JQGexoMUccf
         4e/Q==
X-Gm-Message-State: AOAM530bIViimnm9BAdy44uFKe2guR0NGmYA9ui2U3Enk8kZomN3Knu8
        sHZDDU0JqTnQpq32APtNCOYz4rA9UlUZKqg4Lz0=
X-Google-Smtp-Source: ABdhPJzEWISu9Ys30lXt0FoeSXqBob1j1HwdxSkSS6E/3tJtIKzaC8oq1tDpoJJC4Pogm9czRRvEYTa8r8BRDCyLfbQ=
X-Received: by 2002:a9f:360c:0:b0:34c:5bd:c4d1 with SMTP id
 r12-20020a9f360c000000b0034c05bdc4d1mr6222271uad.61.1649489825657; Sat, 09
 Apr 2022 00:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220408181523.92322-1-schspa@gmail.com> <20220408184449.GB15609@twin.jikos.cz>
In-Reply-To: <20220408184449.GB15609@twin.jikos.cz>
From:   Schspa Shi <schspa@gmail.com>
Date:   Sat, 9 Apr 2022 15:36:54 +0800
Message-ID: <CAMA88Tp26+AWtcgU5yN=3Q5B8MSxqWMt=BpigQ3XADRJdOrpiA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zstd: use spin_lock in timer function
To:     dsterba@suse.cz
Cc:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        terrelln@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba <dsterba@suse.cz> writes:

> On Sat, Apr 09, 2022 at 02:15:23AM +0800, Schspa Shi wrote:
>> timer callback was running on bh, and there is no need to disable bh again.
>
> Why do you think so? There was a specific fix fee13fe96529 ("btrfs:
> correct zstd workspace manager lock to use spin_lock_bh()") that
> actually added the _bh, so either you need to explain why exactly it's
> not needed anymore and verify that the reported lockdep warning from the
> fix does not happen.

Yes, I've seen this fix, and wsm.lru_list is protected by wsm.lock.
This patch will not remove all changes that were fixed. Just a little
improvement
to remove the unnecessary bh disabling. Like
static inline void red_adaptative_timer(struct timer_list *t)
in net/sched/sch_red.c.

Because the critical section is only used by the process context and
the softirq context,
it is safe to remove bh_disable in the softirq context since it will
not be preempted by the softirq.

BRs
Schspa Shi
