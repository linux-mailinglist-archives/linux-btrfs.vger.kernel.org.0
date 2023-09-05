Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79529792CBA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjIERtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbjIERtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 13:49:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B4425BAC
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 10:32:52 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7748ca56133so15090539f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693935072; x=1694539872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhgUyOYlzs50wPwnVa1NJV5fMVV2WbYk1NVnh8F+sSY=;
        b=RaBpmFszQRWQ/dSL209u+wkQc9F32GfkX4QlW471MEtOWtGiXAkb71owj/UdHBDp9I
         wX+NuTPBj0JJ5+WkcEaLCaTn9Iypxm0wXx2GGT5nPUHYWefMcj5fXhVjCoQCsynez7gb
         kCuOGQRQcojaU7J7Q8ypAuKTB4NF+qGnjtWJq5AEVsyDitnVcMyqDmzN/mEvk0sUM4Tq
         vF51FKvM26BLnxtzPxg/vacdOuFcktzsA5KrJ1rwSqPZHHgNDEC4/uUJAicJ0t1aD1Mq
         9joMRe1WSUAjmNw+g4LycL2vV42CqraXF9zXES1JlGzThpOJWd1lVD/nv8UI2e6P9oRp
         cP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935072; x=1694539872;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhgUyOYlzs50wPwnVa1NJV5fMVV2WbYk1NVnh8F+sSY=;
        b=kK700X+bjyQZ6CX8urOCgph+x8MCsqW/rSQqzsKD7RrwrgA2jFSIBHE7PuFj4kDzCz
         JAnWXb6uqebZ8ymG8Pc4TTGzqd0AA99mBwo8aHvOazSDpPzhE5ZvIBvhY5J0zjhIBT7X
         TGfajSCpFoY8tcYGGfN8TXHc9uzg+kd3zfibrZiZNG75wHBLlva5QG7XWsRvlEA6uk5m
         Ej4rFawRO2R+lMJH7J4bEYW6jNpQ4MIwThN7osYGt2dW5fKk10n3+G68tRQ/0H+9lyWK
         yMINLpgelN9hvDfacLJb+nkNiOTT3mkDq+TjgIWtM+XF9YvsLf1V7MuFs7VWyxDXNoUj
         De4w==
X-Gm-Message-State: AOJu0Yz5U0SNMh7pC+O9lHnr5aP34YYw7hx7MTp3DHjGalNLcJq5ckxi
        t4HN+1SAFBoWs7Hu9cElkWQGTA==
X-Google-Smtp-Source: AGHT+IGnDwkbQAnXm4wt9w0mJIZbFBanHlgnZuYj6UMhUqawO8M7qPrUyynOgXt3qoYJvGcUQgYuvQ==
X-Received: by 2002:a05:6602:27d6:b0:792:8a08:1bf9 with SMTP id l22-20020a05660227d600b007928a081bf9mr12032072ios.0.1693935072178;
        Tue, 05 Sep 2023 10:31:12 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id br19-20020a05663846d300b0042b61a5087csm4056486jab.132.2023.09.05.10.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 10:31:11 -0700 (PDT)
Message-ID: <98b932d0-4ddd-4af8-8f98-4a2ca27ad4ed@kernel.dk>
Date:   Tue, 5 Sep 2023 11:31:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: initialize start_slot in
 btrfs_log_prealloc_extents
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1693930391.git.josef@toxicpanda.com>
 <e0192694760936031cae7b4633ba738506eacdc1.1693930391.git.josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e0192694760936031cae7b4633ba738506eacdc1.1693930391.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

