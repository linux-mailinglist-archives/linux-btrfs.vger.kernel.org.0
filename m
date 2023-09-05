Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D069792CBE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjIERwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjIERv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 13:51:57 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A305A76C15
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 10:37:15 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-760dff4b701so38829539f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693935055; x=1694539855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhgUyOYlzs50wPwnVa1NJV5fMVV2WbYk1NVnh8F+sSY=;
        b=W39ADkLeoDAGskfKqsq+erOALjjpFivZZ1Iy28vIEhJ/KOId5Sa8qKq0bLofGAEYr8
         mrucB/tKNUzIy02AbE5XSAuF20X6lGutMQkx0xZgr82POJ2j84CblX+DRw8SMR7VZ/r8
         ErltWwkNexjh2HygDGxd9g7M+mk5ubpb3tW/57ObzlftxfDDFGYGnpI9PtWxPsiaOrC9
         Vo1b9F2mnoXjSmVav7x4KxuUQswlmKpW+XhvPgNmB6TqjWAOoV4C+zDG7Gfvlt5B7utK
         EYgYPpOzx+70DPwigiEZ6JNHAnENy6dj49DtcruulKIy8vhKID0wvepj7b4ZaR1kQBte
         KwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935055; x=1694539855;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhgUyOYlzs50wPwnVa1NJV5fMVV2WbYk1NVnh8F+sSY=;
        b=feKs8oURF/oZT/Hnxo+dBweMOB/agEw9DTwVkrJFyiGOO08mwgx+q7TlJLA4h8AXuU
         /+AoKbkPEhDqqisgCOiWCMXE5jSndFmfgleL4lf/NY7CUdPBz4K+8AKSLyGoAYHrU1Zn
         esW5/f5G+DHNPqLfmiTomcxwbcOy8UqVnolSDMbUbdCB8L2kF2nmmNcVZpsu7An8M8xE
         VMYzbz26pmVeTSrEs4kKlSJXVRJihVPMBhKC7nefusMJXGjnQQq//a0M2xKrBnrqgX8Y
         h/c1fxbb07Wk+65EDmXn1wWsRXaipoYvajR3D73k7APz4bzYYnVQyDhg909IWPKltXW0
         mUfg==
X-Gm-Message-State: AOJu0YxQNAZyALKtv4OH9EjG08qPvYbOUedkhWWPc8y0ThWvF0YG3kLM
        lWwhsbuou/HQdYWvL1g59NAoeA==
X-Google-Smtp-Source: AGHT+IFxNBeDMIO3ay5dJIruveOgIGCbwp+khAehFYmNxYPYoLOzPNLhXp4Oanjz4dj9j4D6ep0jlQ==
X-Received: by 2002:a05:6602:14d2:b0:792:6dd8:a65f with SMTP id b18-20020a05660214d200b007926dd8a65fmr16334329iow.0.1693935055659;
        Tue, 05 Sep 2023 10:30:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id br19-20020a05663846d300b0042b61a5087csm4056486jab.132.2023.09.05.10.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 10:30:54 -0700 (PDT)
Message-ID: <5e387913-aba3-4445-8eb3-50b1b94fba30@kernel.dk>
Date:   Tue, 5 Sep 2023 11:30:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: make sure to initialize start and len in
 find_free_dev_extent
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1693930391.git.josef@toxicpanda.com>
 <3223c8646dd74cc0252e3b619a7a2cd6b078d85a.1693930391.git.josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3223c8646dd74cc0252e3b619a7a2cd6b078d85a.1693930391.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

