Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514215046BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Apr 2022 07:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiDQFRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Apr 2022 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiDQFRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Apr 2022 01:17:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684EE0D0;
        Sat, 16 Apr 2022 22:15:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r66so13474953pgr.3;
        Sat, 16 Apr 2022 22:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bj6euzA7DWSefgUbpzS1LfvhC/KobqXjsuL9e8GbpVs=;
        b=byKFwQgnQiFHv/Stsp9HRyqovOxd4jd0VbbwXYhnzTqV5D6LBZdmxJy+aqYNuJUwNH
         e8xstuw5vE53dh94yS4o9yRT/C57FXVs5l1iGsY4F+x9k4I5IULf0CQ4+df67hAw5yUd
         UAzsU4zKgSuc02i5G+/O7ljgjQyzemEW59vXNq9a0FyGYqS03x+cFdLKLsXSRGK4XDL6
         FqAcUQr9CUTL43EsokSSA3Q2Xfldo14Vya8vhql9L/jXt+66VXwZW4pd56waxUeCac3U
         moWFb8VAP3gBmO+puiu3/PCmsrJvq0TiQTcBIgkOl5b7J45frrtnWzCpXrmCmj6LvMeg
         cppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bj6euzA7DWSefgUbpzS1LfvhC/KobqXjsuL9e8GbpVs=;
        b=CXfrIDvIXa4XBc84ncfcQTJgKZJWeG+/sehRM9rM++vmSK9XSnJxdXfbL4TT7Gejhq
         1legGLBnPeNkPnsNRVDCVqUgdVB+TeZm/gCJT2mhq6oYUQd2JqNNTA1LfKcfUifWSWk9
         EFPKt9j0G9OKttzNHYf20c687QUkLWVCgk8hyRLa8okTpwrrYOtNdUc12jh3EBM7O8hd
         HO6p8pWPihseTONJ8ryyK1to6k2oq0ZVacKEh33oxnrVis6aAn6bdtxnK16k85kLV5f4
         JOhQ8UOv2xmgEdfbJFE5++0S7InJ4tlhmqbHemkzn//7MFQlw1L7J0wKxAZDF/3mnI6c
         ylRQ==
X-Gm-Message-State: AOAM5321w0KcCKq09MO+lE4f/kVDrnAW9HI8F4JC+/ItWZ0TgJUB6+TF
        27t2CR/eZsqieKgImsjvkpk=
X-Google-Smtp-Source: ABdhPJxbYDPCVeRb6S1Zxw8PcQ1E/8iBjW6mF5pmQWDZ/KgNK1nlAGTtRLh+3Z4VSVbFn3FQ9O/YuA==
X-Received: by 2002:a63:f743:0:b0:3a6:6786:30b1 with SMTP id f3-20020a63f743000000b003a6678630b1mr3813576pgk.243.1650172504522;
        Sat, 16 Apr 2022 22:15:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-9.three.co.id. [180.214.233.9])
        by smtp.gmail.com with ESMTPSA id p8-20020aa78608000000b005082c3cbfd2sm7477399pfn.218.2022.04.16.22.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 22:15:03 -0700 (PDT)
Message-ID: <8a0524b2-dc76-ff96-4304-b1f8ae574e9b@gmail.com>
Date:   Sun, 17 Apr 2022 12:14:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs: zstd: add missing function name in
 zstd_reclaim_timer_fn() comment
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220416081534.28729-1-bagasdotme@gmail.com>
 <YluGmERvtQY9ju7Y@casper.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YluGmERvtQY9ju7Y@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/17/22 10:16, Matthew Wilcox wrote:
> On Sat, Apr 16, 2022 at 03:15:34PM +0700, Bagas Sanjaya wrote:
>> kernel test robot reports kernel-doc warning:
>>
>>>> fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but
>> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> This is the wrong fix.  Static functions should not have kernel-doc
> comments.  Just delete the second '*' at the head of the comment.
> 
> Also, btrfs developers should be testing with W=1.  That will catch
> these problems before the code is integrated.

Oops, thanks for reminding me.

-- 
An old man doll... just what I always wanted! - Clara
