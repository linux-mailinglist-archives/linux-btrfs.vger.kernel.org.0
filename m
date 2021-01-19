Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E12FC252
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbhASV1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbhASV06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:26:58 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB31C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:26:11 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f26so23408555qka.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HsNLct/sOOQG9YQCemu0zkuoHTilJtn6aX14IEH/5Iw=;
        b=qlS4N6fveje+n1oDfL/rwbpqEyw1WIDzZO49qyMP0sL7AY40vO+/oZ3zPowF/TgVwC
         LCE1TXK2CAkxL9d61ZjMfjzUyLJwiHQ+IqJbbuOw0TNfJaBxpbZMf41hqJ8FC9DquWF2
         ZjWhT3mx71ExqBdK/ZhnUimobbTWP9LxwfVmPWoZrVnrI+BQuMj0ULTlfvZ69Ojk/ESB
         52KCta2Cgj3t9i6PSzTHfkKZCnvjTepVD+iSC3os1wMFaI+bNht8PubtSy/QYkkAvXCR
         EMTABZ4uYyjEdqo3J86IeOpsAnS5jr1Uwb61NDze2JXgtyfDXG96yiu6RVtcJao+9gbg
         oO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HsNLct/sOOQG9YQCemu0zkuoHTilJtn6aX14IEH/5Iw=;
        b=JRIgKFiDdaQd5IoSkAP6wnA6fxgttdTnfoMZhCoFEgbJd2m0uN0yN5VsXXWbqDeo8i
         So/JVKbyBym1rCKMe1byuL9bIQrEfL+FRchiiu2nbpAYHTmBYzOeOo8TJn5SPtIU02Om
         nv6Ie1IRdU2+xqqZgPrjqf1VKijslruoiQpYlyLyrz1rDagBCeYJBbOPqrMPJ3mS9V01
         VsmuGRJstl/XhCcj3wsuPjQ1nIki5oq81QzXiuzIfmob78aXb4liMeV2PgWbySV2jCEb
         obs1Q4rutzrGFW1bZZ1hVuDukXgQbUXRr1q4SJq64bMuNRVsoOwC3pGVLgQqAEakd2Jm
         3jKQ==
X-Gm-Message-State: AOAM5321l2MZbhSdW75Ei39MB56Cqrd0eparEmMY6JKrYPGPluOI2STA
        3syF3NkYePMm8m8GNWDr4nFuJikrroc0gryLjso=
X-Google-Smtp-Source: ABdhPJwJTZMulSFPksU5fUyWaVztvy9JisQl1SwLW7TLUtyjOmvNsERRIMYZ1wBNLM786FqPPFXwhw==
X-Received: by 2002:a37:d41:: with SMTP id 62mr6371792qkn.110.1611091570960;
        Tue, 19 Jan 2021 13:26:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id d140sm13919082qkc.111.2021.01.19.13.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:26:10 -0800 (PST)
Subject: Re: [PATCH 04/13] btrfs: Fix paramter description in delayed-ref.c
 functions
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210119122649.187778-1-nborisov@suse.com>
 <20210119122649.187778-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8233193c-78f6-369d-a3c9-63e02e2c018c@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:26:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119122649.187778-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/19/21 7:26 AM, Nikolay Borisov wrote:
> This fixes the following warnings:
> 

Subject should read 'parameter', thanks,

Josef
