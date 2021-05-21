Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F241B38C863
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhEUNkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbhEUNjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:39:49 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6CC06138D
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:38:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c10so15247036qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DwigQaZ7gQIRn/EmaGQwK9Me9qqYVCO1xTd5otcihnU=;
        b=qgQhODIqJV13L+FydHyBTnC7PtJ1j9h3FxK1dszCqtQRSZItoq3Ln8areF1SKGgIrZ
         iCbWz2182nJiD3AXzUbxtHY+X5KvXq77rDmbFwtyLzVyTT99EDRRvKkNXfc8rWXQe3fW
         54zM/J4wMo1j35Vq4KBsrKBoyl8YFVJeCK8do8rmw8fhCLUSsiehih7ApFlLRprIrkMQ
         RSExxvUv8M6MseRrrDw8PuDzkPdo6+Bu8pkGAKN/z2Fg7labKlM5WtXRShP4PiytMBNx
         /ENwDFKEtcHv/sl3Lw3cDeMy6e4POSd5QDqq8Jvis0HLIDnwgmQntbTzNkOPPE19JZbR
         uVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwigQaZ7gQIRn/EmaGQwK9Me9qqYVCO1xTd5otcihnU=;
        b=arX4Av5Dqz1nhYwp/edbefeN1e2M4/KO0H86sSRTIDYfdHMrGTBn6r1uvRr/vpizZv
         pCOOn+wok0ftYn45l88ZGJKh6nIWRGBIWwYdhNTPyiAHXJmvRMFOkR54VIK3jIyBJdFD
         ti557ZNjYMuzfOWwCqUcR7njcGPS0Cx9kzTDOh6VrdMzgwliHo+1oiXaY+Ww7HA6kxvP
         zuWIZrp5Ce4mwUb8NyvTEbKV068cOzWi8D8uCkj8biNFh2Kq3Iq0jp/8JL9/zwZSUanI
         ch4mtT7ybPARuHKx+uz1nHFEIoldbw0jJcWgRqmr6Ua/M4hOu+zBiTp/gjuVW6rXUVNq
         vcMg==
X-Gm-Message-State: AOAM533BAoX3YysMkuz+hMao3wAEKDpl0GZ+GFSkSuA/aNoSQvFlA/ZH
        sh8TmvTDUGMdWRevTzddAWCX4oiq96tTgA==
X-Google-Smtp-Source: ABdhPJxhaQRpb6Ii62kIuiIGrCKQdNCiGxlupRhq6AnTSnInmR9vgwIlDRCaHEjjpvvivJsSwworzQ==
X-Received: by 2002:a05:622a:174f:: with SMTP id l15mr11509556qtk.141.1621604297963;
        Fri, 21 May 2021 06:38:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id v10sm4429353qtf.39.2021.05.21.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:38:17 -0700 (PDT)
Subject: Re: [PATCH 3/6] btrfs: introduce try-lock semantics for exclusive op
 start
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f345721-d02b-fba2-9f4d-0ec12580b520@toxicpanda.com>
Date:   Fri, 21 May 2021 09:38:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 8:06 AM, David Sterba wrote:
> Add try-lock for exclusive operation start to allow callers to do more
> checks. The same operation must already be running. The try-lock and
> unlock must pair and are a substitute for btrfs_exclop_start, thus it
> must also pair with btrfs_exclop_finish to release the exclop context.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
