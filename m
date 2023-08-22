Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F3784842
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 19:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjHVROv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHVROv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 13:14:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C464B30EF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 10:14:48 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34ca6863743so3448545ab.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692724488; x=1693329288;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=kNYblONfReRyJq7g7OEhF+TlYM4YdYvXCQGHeDUi1wCgD92KgYK7PY9CARP3Bdh5VP
         PDMrjdPCUfLYHxRAET0Jc9pERReaAINB1FppoNqKD/blZw6POWTHU6KDNhWA3jEHLVY+
         hXiNAMhRIJcnwQbNU1O2jV5bKfAnPdtF1Y7UOYDqSLdE0v9C0sYzWCBM9j/zTkJw2o0D
         TEPF5WH8NgyHXviHK/DFVxGII/dXs1KaLjfnbWIZP9NAnfmufK8SJU0ZD5lIG4EUUDbo
         WDLmHytFO+kkOpp9LWmumwW2sfqENaAEKUTYTx4atB5J3nrgqDOQI5VnRi788UFXUfoy
         7H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724488; x=1693329288;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=OKdt/vTprFN/Otz+Gb1Kvb3ZWTEsuU1sxMPjs+7TJysJ7jA8kXyKGtz3fQ9zxoMFBZ
         P1WOE1x2MPxDw1juDL8+/3VFN0PpygrDtBQsUTSKmnXKSuwYMnCQ229Ff75k8mKG9ggh
         VNjtM2B1dK7WqrTwllaQ5NwF4Yv0TNI1Eebkd5kCSVWJP3y7PnNyAJ2VI9E+8mtKhMWd
         SgV3/meCHifXVm24TJpKAr+ZlVVvNv6Z5jEmhr9+CCN/ysq+MVwBhIXAt+Da8F3cUUBW
         dz8TMdUVwJY7gVrjq8l8+HmdpHMXmzTiw2sl8g5TiJII4CuuIx5pM4/i72YLb2BfijNm
         K6/Q==
X-Gm-Message-State: AOJu0Yx9nzLTaRpnyiUKycO9ZomqlOnXRDOqaXKuJQcRBDnCps3i6P/j
        3Q2zqgMROMt88QQoovBfvTggUw==
X-Google-Smtp-Source: AGHT+IFAlCaF9ctMT0Esl3E69mMUSWRJhC0j0UNBoNDQoe1XqnKm7ErzikmB56GFeh1KLdeV2HOZTw==
X-Received: by 2002:a6b:3bca:0:b0:791:e6b3:cd0e with SMTP id i193-20020a6b3bca000000b00791e6b3cd0emr12728757ioa.1.1692724488193;
        Tue, 22 Aug 2023 10:14:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t17-20020a05663801f100b0042b2959e6dcsm3191395jaq.87.2023.08.22.10.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:14:46 -0700 (PDT)
Message-ID: <11084f04-47ae-4aec-b9cf-572029e542b4@kernel.dk>
Date:   Tue, 22 Aug 2023 11:14:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: fsstress: wait interrupted aio to finish
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230821230129.31723-1-wqu@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230821230129.31723-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

