Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59503B77CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhF2Sad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 14:30:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46494 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhF2Sac (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 14:30:32 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyISp-000722-O5
        for linux-btrfs@vger.kernel.org; Tue, 29 Jun 2021 18:28:03 +0000
Received: by mail-ed1-f71.google.com with SMTP id j15-20020a05640211cfb0290394f9de5750so11288327edw.16
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 11:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYgcjWPuVQQkM+ld3lTDa/zt5ky7hqz4IgAOmjoJRPQ=;
        b=CwTTRMIYreFiEadYKe0pjXqq4BaZRjCD9/CK8R9dCfmzKQUeTOtA6cZ5xKGGufZFEU
         UzxlLM/FEanpv5w73AxsFDKez8qEVLSa2VsiAOx4cYYYNuqaIqF2UZFMZ7MOFNBAn3WH
         QOW4GMGsPFmVy2YB8N/RPZbQR8e2UmCvNjtgw+u3n76pTBXMy7mgUFyG2lc0ygPcSQxc
         xpThUBptVZpMXAshcG0tffBVEHmO2xw8yD8Swz2ksCAKeFPH1cUMgMnbmtxjb+Tq+zRp
         HPuovLsozP6RrxiZqdTCnBuCXnZd888oJK+w71WtEoDPxXV1fQSZQX5YK+fbeCDClreJ
         3PXw==
X-Gm-Message-State: AOAM532ZV8eXmcUCGCK9S5TB5/g6WrWYpd72FlwflSMzHGJvP7Cqx8sE
        KxodS/MaT7eKIHsms6nwcmm8WcIQ59P9PtxcXk9YdPCLcW2glBuWNfdcq4cGOFBop9amPTztqn8
        y23UYw6aqoisakwqhjsnm1Sf+/ePPYBIbIf7OR8oM
X-Received: by 2002:a17:906:3e15:: with SMTP id k21mr5923603eji.423.1624991283445;
        Tue, 29 Jun 2021 11:28:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGLqw1AwUxKpu6bhggUbVqYJuFIfNL6mC+UNE1sLGRBFc9Q0iOasyqzGrIJbdWtKTmTRhc+w==
X-Received: by 2002:a17:906:3e15:: with SMTP id k21mr5923594eji.423.1624991283312;
        Tue, 29 Jun 2021 11:28:03 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n13sm8598198ejk.97.2021.06.29.11.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:28:02 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <124d7ead-6600-f369-7af1-a1bc27df135c@toxicpanda.com>
 <667133e5-44cb-8d95-c40a-12ac82f186f0@canonical.com>
 <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
 <2576a472-1c99-889a-685c-a12bbfb08052@canonical.com>
Message-ID: <9e2214b1-999d-90cf-a5c2-2dbb5a2eadd4@canonical.com>
Date:   Tue, 29 Jun 2021 20:28:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2576a472-1c99-889a-685c-a12bbfb08052@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/06/2021 20:06, Krzysztof Kozlowski wrote:
> Minor update - it's not only Azure's. AWS m5.8xlarge and m5.16xlarge (32
> and 64 cores) fail similarly. I'll try later also QEMU machines with
> different amount of CPUs.
> 

Test on QEMU machine with 31 CPUs passes. With 32 CPUs - failure as
reported.

dmesg is empty - no error around this.

Maybe something with per-cpu variables?

Best regards,
Krzysztof
