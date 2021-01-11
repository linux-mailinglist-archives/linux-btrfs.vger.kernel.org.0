Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F52F1A15
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 16:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbhAKPvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 10:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbhAKPvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 10:51:14 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286DAC06179F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 07:50:34 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id a6so11485228qtw.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 07:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yeojcisLuU8d2k0Ck4Gduo97wdZD2Oi9SWZI2+gN5ks=;
        b=LJEqAESOWAWKgSTL3qmGOgSp1axVNU0dX4rrzSrlcT2dWI+O4Dsz6Y5Vzk5W+OjlbS
         ZvpM6YMPIA1e8wvCH7GY7tzyDv65jjMt1TIqTrWTxQczHRFyl7DnYOfZMFv+ojkbMm1h
         6EAjuOyEy5HfR2FLa42Z/pYJOasBEtQezonMcxxi8yMqIVEoyq6tO5EqFHJZepxurSrW
         +wuHSUiNjdGbk58YDyayB0LSisS+u3PksntCj0AABb8VgITx0aS/ZhkNTgIMDRgV6rfF
         xMPWvCnS5Qo3VcDcJsOyOQ57gL2WHRr/3S51sV0ARYTMSAhG9x8CFSZvCMLjVezXfM4c
         cs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yeojcisLuU8d2k0Ck4Gduo97wdZD2Oi9SWZI2+gN5ks=;
        b=TVgrc1zggGnls3kyohgLqM3YIEYGDWes0F+QWETNIwKyBgG/FpX0+ve8yn5AXFxV2M
         /eOElq75Q3/UCLuJTdbrjGEfJFqCZhfwfuqTCbIYfcUhLJHrvphN/SnMmLXFZmBwvOy3
         h5vVdzAcIPXSUi4TIIl9KyJ/i8b67cbQykoJWqqI7nA/l86we5XwHA74TqlSEMitNcre
         HWBIimB4UVKGGzbtKEtmVFcPfel/PNSiNcvo1LuppTD9x9G0nETCm1w673IHjBITe06A
         QKGdsVVkuSS2b3kwGUeBroGwnLMYLkFJMj5rRImr7WOglCG0FgucQWsX2JMbMPFmtljy
         ebGA==
X-Gm-Message-State: AOAM53205NnrPS694mgRQt443e4TScUhlmJpne0+ZFbPIyJcrZNbTINl
        J3kLIpQe5s1fijKAv0N9WwBRj1dFilTEm4nF
X-Google-Smtp-Source: ABdhPJxncpHLjrhCJavD03O85IrojkW9zJz/q1eqZqCZ5IVKeTh3ufpEJw0uPiXLapGLfqlimOlFbQ==
X-Received: by 2002:aed:2ea1:: with SMTP id k30mr261289qtd.32.1610380233077;
        Mon, 11 Jan 2021 07:50:33 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b11sm2090239qtc.5.2021.01.11.07.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:50:32 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Add test 154
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20210111091742.393039-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a0cdd790-288c-8631-ec01-d0ac61b5f7d0@toxicpanda.com>
Date:   Mon, 11 Jan 2021 10:50:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111091742.393039-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 4:17 AM, Nikolay Borisov wrote:
> This test verifies btrfs' free objectid management. I.e it ensures that
> the first objectid is always 256 in an fs tree.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Will you add this to our staging branch so it gets picked up by the nightly runs 
as well?  Thanks,

Josef
