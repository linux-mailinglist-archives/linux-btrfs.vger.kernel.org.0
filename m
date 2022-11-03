Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E19617577
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 05:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiKCEZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 00:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCEZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 00:25:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8966C1145A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 21:25:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so788124plz.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2uLKlWyEoLkzU9HLh77uRpqA3LANs5kgoNna0usxuY=;
        b=QiR2bROQmMTcNVNrqYA6nz0jcDnZUZ6Wsonu2lWUrNhH+Wz0hEUyQUmXuxt28eZcTZ
         GmKY1CmsO8G2Nz2f34B29UenTTGlDstR3rUsSdHzihPS+oTY95kv/UZ0Go+OKYw+4sPm
         ikPDkDiODyT0s2vcDUcA40/5496CAwp3k/iKCK518gsAAWRByDmTSfFAq/ko/Kc3QufD
         wnsLsyeKThLiZbsQQxs72KDn5/MVG8s2DfL5mK5g+tBdUC+7siKGkAu7xamoOv9r82ZF
         /XGhe2x+tJV2dzd3DBNwl7ajHhCuKZ/4SPEm5l19zqLQAfeiXWkngfnqF6N5bqLm+0AR
         vCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2uLKlWyEoLkzU9HLh77uRpqA3LANs5kgoNna0usxuY=;
        b=a+wN++Usk5okrTpdQBwyzv7nXGra0LmCDWdIq51R9S7ixZ83tLSkC5GpRsoBld83jL
         dOUd543L0H1DjiMozY+tjehyg9lSjoHVCHL5WTGSXpUTZVRSoLTvYHqUIilIwkquRGPL
         NRL4+xSZLrDNUg6Vjb0H2IKxYgtEwFrdcqsprOez6Eg0q+/4DCE9xkzjpslSVCXIA4P7
         +M7gXG/s0hy2XRRRpBn660ez6fzPkCSJOjZnm3JCQnmQxAIoSjk1WEI/e040koD7ah4r
         yh9ypUc/wPOv/2tL24dYoWXwiUD8tbjECNIcdeFZSH2ub7v8je/ycV4bJwTzTkZsBb8p
         67og==
X-Gm-Message-State: ACrzQf0eSAEOnyy2a+djdz2FzfbLwAcqKHKo+0/1jpvMg4IhW+Of1nAF
        nc46G9oCN48cDtIXgU3nJfVhxOgwxp4=
X-Google-Smtp-Source: AMsMyM4plJxtlrVOAOaUPBs23gwKOCAK1m6OJWqPIS2T7J7NDfwUEVS99/aAi/PUsVj0yFFSIrTo9A==
X-Received: by 2002:a17:90b:4f86:b0:213:3918:f29e with SMTP id qe6-20020a17090b4f8600b002133918f29emr28650547pjb.178.1667449551482;
        Wed, 02 Nov 2022 21:25:51 -0700 (PDT)
Received: from ryzen3950 (c-208-82-98-189.rev.sailinternet.net. [208.82.98.189])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090340c100b0018855a22ccfsm238883pld.91.2022.11.02.21.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 21:25:50 -0700 (PDT)
From:   Matt Huszagh <huszaghmatt@gmail.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
In-Reply-To: <0c66a75a-2cf6-2944-4423-7183804c7ad2@gmail.com>
References: <87v8nyh4jg.fsf@gmail.com> <20221102003232.097748e7@nvm>
 <87v8nw3dcg.fsf@gmail.com>
 <0c66a75a-2cf6-2944-4423-7183804c7ad2@gmail.com>
Date:   Wed, 02 Nov 2022 21:25:49 -0700
Message-ID: <875yfwekaa.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Andrei Borzenkov <arvidjaar@gmail.com> writes:

> You have RAID0. Scrub cannot help in non-redundant configuration. Scrub 
> can repair bad copy of data using good copy of data, but in RAID0 there 
> is only one copy.

I believe I addressed this in my original post when I said "I was hoping
to use this to confirm that the affected files are confined to old
snapshots" though I probably could have been more explicit. I didn't
expect scrub to repair anything, just point me to the affected
files. Either way, I would have expected scrub to do something other
than indefinitely hang and prevent itself from being terminated (I even
had to cold boot the computer to shut it down).

Matt
