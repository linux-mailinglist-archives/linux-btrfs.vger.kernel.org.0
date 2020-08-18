Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DBE248898
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHRPCm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgHRPCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:02:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F972C061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:02:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dd12so9687699qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=or9u6ItDC9yhArMMD76ngraDrcd7RyZfwr5sp31kc+A=;
        b=Ya7a1N/Zi5/xIKTEoP6kp9iqDS6nDUvZZ7Jyq+VZpEAuvqTljURLDwQQMpvwTPh0Bq
         CTt9u7GR0N7pa02gpninomkvMPixjzTKyLRK0Ce6qNrhtSqR3XMNjt3laW9iKK+2LZc2
         2l6BCorOkA7UxhB47TLCtDDMhc3GAmiTjo/qSEIbt/jopHiql+2kTMzU+h0xsgf1epwS
         gW4GVZOtfGRt2muYmTw6hwXj7MO+XxfeHJx5lWLiZ7L4XlbI8K+D8cfCnC8pu8CukMht
         CRq0+yJ8mLJIqJxtRyVS/SbrmUmCmdrHlRhDTxi/Xmcfp6BIL+KDypL1tZcUrzEeHS6q
         zWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=or9u6ItDC9yhArMMD76ngraDrcd7RyZfwr5sp31kc+A=;
        b=gdqSBHrOT7uJ8ZhlDiJtvvnZYbBQrKpFZ/HZPMHRv6syjw4t4F5Flsx0E7SIdsidcK
         ogtsTIL9ynfn9wT1Qok7POzE7pXFmFq+yAtskNrWJuTGVka3ZaeWmJuIiQGjA0fhI4rW
         85TjIuar2115/dNKxnIsAnXB/Vq284s3UyEhZB+A/E+T7HztNh1YBFz7E1tGHIakyGFj
         cYIU23DqdyVj6xpYe2HV3e/qaykP+CFEWjeFvA9SevBYakMqDhqaQPkS4CtuAp4jwBGo
         /lh3aIhcCMOWupSC4Ca/LAhXRl14K72MhA0B1lt268WPPGEMdqwXpA6k5cOwoj6yHw2M
         D4LA==
X-Gm-Message-State: AOAM531Oso69WirnVbOFS75mucp1sIWqDq7C+WoKwNFmz1UD/uZU+OI+
        d3iMi3z1fj4zqneOWN/0LL3hBJxGxI9YGaXv
X-Google-Smtp-Source: ABdhPJwPzbYMcT3Mz7yGim9DCMVVscYV7MEK69l2MkMa2x4CqJvOPniIykuPtLVLeDT7OWsb7SdjGg==
X-Received: by 2002:ad4:49aa:: with SMTP id u10mr19515569qvx.27.1597762957647;
        Tue, 18 Aug 2020 08:02:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id w44sm25054847qtj.86.2020.08.18.08.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:02:36 -0700 (PDT)
Subject: Re: [PATCH 1/5] btrfs: Factor out reada loop in __reada_start_machine
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fd1a5b91-b0a8-a1f0-f1b7-64387ee929c9@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:02:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/15/20 6:48 AM, Nikolay Borisov wrote:
> This is in preparation for moving fs_devices to proper lists.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
