Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E896CB269
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjC0XcD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjC0XcC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:32:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBEC4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:32:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f22so5877702plr.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959921; x=1682551921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fNEczN0672QN/RMb20IlcIW8cCEXe1UxR00CCFgmLY=;
        b=IB9NkwSe9JOio9TPyh9zvgMoNWxTA3mqFueBcMJO1UPfRJhj2qD57M88v7SjQ6AWiK
         K3vjEIV+oGgvpg6o9HUFmyw2Rk81bOFqwWniPAYee6AUVMGPOoQCynGz+Tq8yKtNTRr3
         zOqejmEg9a73aDLAf72/ul/sdwaIFsHIzkYntQkBe3xvdwIJnOqjBo3/e6wXShA+pLcA
         0NOGV6X3KdpR1OoaV6jClRrcYbd/LrenVZyEwDkTonaVBkvpO8HRy1PVSN9SwjzP/DOy
         XFSN69DyQWMqu6H0h6IwrnlWEe2WMA89s4CtFYXsYWzXFVYIBRoOHctGsp7Lf1EXtrQ6
         UbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959921; x=1682551921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fNEczN0672QN/RMb20IlcIW8cCEXe1UxR00CCFgmLY=;
        b=q0b/Jo8t96dB4LAbTT2dIjZDrwtvF/RqDsgK78nYyKRUBD14xjVQc0FbUNZ6kkPqce
         G5y7QNy9BCNey4AUUjCVcqL3S5IHPj8hCst9YPQyJan3BrxQywHtmNJiyJQh4PK80sqf
         tjILSasFmwcBF2sYvrPycZXsj0SNJKIexpXAFVf8rO4Xy0rag32DaiAMX9oQCxHZc/yD
         fqKqdzW16g+lw8yEGSGKaQyT5X0Uxq95tOATBbXeLy+KHWXXxxVjYW6c9F4Lshe8ulTp
         vAUtKBrH8drgMZAx02zbMIDDFEJTu88EVcY5tIsmONLUnFF3DE9ez2+de7R3ibRWSe1K
         3tRQ==
X-Gm-Message-State: AAQBX9dRSgrOd4gLMzJOXhla4oHG2lqguVq3LDDtqo3bI+D0fMarvkir
        EUB5pOXlIUopApOJsWL5EHX51Q==
X-Google-Smtp-Source: AKy350ZrnxjWitzUXvbXCVXzkggLVEWs7Lm8X3GSwM6NbKVoEjP+pFkWfFlo+/Ive7Q4Hjn9710BOg==
X-Received: by 2002:a17:903:685:b0:197:8e8e:f15 with SMTP id ki5-20020a170903068500b001978e8e0f15mr11157002plb.6.1679959921175;
        Mon, 27 Mar 2023 16:32:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b0019e88453492sm19837760plb.4.2023.03.27.16.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 16:32:00 -0700 (PDT)
Message-ID: <ed386649-90cb-8cfa-c2e4-95807cdb8810@kernel.dk>
Date:   Mon, 27 Mar 2023 17:31:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6/7] block: async_bio_lock does not need to be bh-safe
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230327004954.728797-1-hch@lst.de>
 <20230327004954.728797-7-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327004954.728797-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/26/23 6:49 PM, Christoph Hellwig wrote:
> async_bio_lock is only taken from bio submission and workqueue context,
> both are never in bottom halves.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


