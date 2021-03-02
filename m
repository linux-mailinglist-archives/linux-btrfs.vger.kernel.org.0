Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0F32B29D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhCCB6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835353AbhCBTDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 14:03:12 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23710C061225
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Mar 2021 11:01:26 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id g185so2091196qkf.6
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Mar 2021 11:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2qCytR6zRNKiZWuYiRHR+WxxWR1vAMBzRaW1PCDw0E=;
        b=GeZjJQCxwgeIW4amlv5BU7igYRcwtmz+N1n+FZqQMDeaVdsf18eCOg+umC27V4rFp1
         2jdNQVwm21LQS5ideeWKHPPB14s85bzo1Ian5VhtqbGWS5xcz5OrTpyLMCunxfs+xYQW
         gkYb7YyyZgDwCrYmoZ/iKYudm+Krv2OdAfALDPgsfW0X5zrFm9yw4u0mh9QmbpuwY56o
         NX1k+NyxopdgU96kLxFzbJ3BuN0shn2hMCeiwXILt7hFj1kKT3KGUhDpKOoLYovGKJxV
         PjDEhWD9gvjpWEuFJEA2RiXxMkSiDZcMzewSRNL8ZjBrVI5vyKASdtX+Np/1PwlyV8fH
         eEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2qCytR6zRNKiZWuYiRHR+WxxWR1vAMBzRaW1PCDw0E=;
        b=EbmDy7xnEFelmP7GJAdZHMlJ70XjJDzbaT4Gf7JnlP1bRdHI38ZDdUOLpeiwvGY45K
         eVeoftzyxSIs/r7YBtBnfN24jFB/Yrsp0hgV6aoUsN07yynOU+XVeb3+4uJ4aBLJ+8T5
         apmwqtGRNMXWWjTnHBnD9DXaJduulhyqAICSiZ4woz+QHwHOtbd6uGjqko/outNUZ0Nq
         9hLr+Ru//mejYmcgUxKoothuqzVbGefSmF1f0T/c4VL9DTMoz6OMNJFRSsv6iVRlLbuc
         jU93dNd6yew1WL7PU0rhLr5ONZyFw7sL8+mUGxfq7fhCCk5i3pPrw5m2QgAWSl5Y5cKU
         Wx6Q==
X-Gm-Message-State: AOAM530AoRPIjZ36v/tEbUhoAczKB9pe8Q4dI58ec/oB91kqXLH84Liz
        hC7KWZaJYpGivfHW8QEeeyFM6g==
X-Google-Smtp-Source: ABdhPJwv5srtWHUzLdvxM7KGrcpcoCsuqzEB1q/RLowjkD06mAUZ9ZEJ4n29EWXH3HlxIehCLpQfEQ==
X-Received: by 2002:a05:620a:2206:: with SMTP id m6mr20812907qkh.176.1614711685344;
        Tue, 02 Mar 2021 11:01:25 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e190sm15733981qkd.122.2021.03.02.11.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 11:01:24 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: require discard functionality from scratch
 device
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
 <20210302091305.27828-3-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e8f7bf4b-c1ba-3aaa-a92a-a057d163d4e6@toxicpanda.com>
Date:   Tue, 2 Mar 2021 14:01:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302091305.27828-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/21 4:13 AM, Johannes Thumshirn wrote:
> Some test cases for btrfs require the scratch device to support discard.
> Check if the scratch device does support discard before trying to execute
> the test.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
