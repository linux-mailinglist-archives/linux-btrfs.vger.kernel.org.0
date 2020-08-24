Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9D25066C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHXRc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgHXRcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:32:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2FC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:32:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u3so8147531qkd.9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1u3TlJZ4UImA2cbWChJFyoRX3eOstanuvwLWeQsX/s=;
        b=fahMqvsB7D/zB/rr2lhzbRbl+kuO7Qbhi11ZyYMkZwB+VjCuoQyFP0uYaPF2F55H3X
         xBzaFdpQ0Px2POwbB23Xb6GcRCy9Kg568oM/BlveRLm2hzR84FS4E7z3oNIh5vIwLMqt
         b5ZXBFqau5dg7tYhfKEcaxtM5kTT0pYTyhGmcVlpL9XlyuRlcq8ZzKW4lQIEwCvt4y6O
         fkcpg408qxCoGwX3xBdGvU84rEq9C617r4zrzKPYrUcYOjhbP91zL9Hqw3pNzY34QzuK
         OrxoHaYqeHjnyksHoiYMIh68JFxwaYRMEVZqBezDfu5IbkIMGQRb3cPlyXt5RGx3F4HO
         +PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1u3TlJZ4UImA2cbWChJFyoRX3eOstanuvwLWeQsX/s=;
        b=hVsWfuLN8VtIMaHW0L7/Nc8/pFU7RdfQ6bbvEfM7Hpn71c27LdPp5kWXtM9j0PspLN
         zLBkRMPvUqcJKWlLkxytU2hdf3sF19ws0dSRlt9pIdL0Yemk2P+61BKKw84oLbH0uIF9
         rw27tcOYBJLj42yuA8gUUdSHIDalekCFaj5zWoS8K6UVsprrxVG+oiRL5cZirk+dsvgr
         T+nqKXsvuS76LzsOsulUSk2AJGvjeZlp7HDTrBDq+DZuN+3b/+GJ1BwR4/jvZT4dF446
         jIbx2S5Hoq8JCLDeOK0ZiydND3yT1uFlS/YFPKXXLTxhJuLKi5RfcGSF8Qj02SSETqZU
         /HZA==
X-Gm-Message-State: AOAM533FjpDzJS/QO7OY4V1M54U/WNTEg0f5wfV8wrRi32hCvsOc84Dx
        Eubaa1pa11jezbyZvU/wQo2a0+R0mxw5tZZL
X-Google-Smtp-Source: ABdhPJyhO/VMjHie2qc4p5z0bfFndnmbAd1IyhDwk/tsq2ic8krgNo9KUDRfRpMAarwK97y9vmoGmA==
X-Received: by 2002:a05:620a:15c9:: with SMTP id o9mr5783104qkm.8.1598290369306;
        Mon, 24 Aug 2020 10:32:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w20sm9941219qki.108.2020.08.24.10.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:32:48 -0700 (PDT)
Subject: Re: [PATCH 8/9] btrfs: send: send compressed extents with encoded
 writes
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
 <8eeed3db43c3c31f4596051897578e481d6cda17.1597994106.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6585ccb9-3528-e451-bb31-ffdd186b13ec@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:32:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8eeed3db43c3c31f4596051897578e481d6cda17.1597994106.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Now that all of the pieces are in place, we can use the ENCODED_WRITE
> command to send compressed extents when appropriate.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

This one doesn't apply cleanly to misc-next, the ctree.h and inode.c chunks all 
fail, and the last hunk of the send stuff doesn't apply.  Thanks,

Josef
