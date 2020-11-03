Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254272A57F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 22:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgKCUt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 15:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbgKCUt5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 15:49:57 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD6C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 12:49:56 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k9so16510953qki.6
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDcRoDkLiE73WEi7gWpkshjuXCB6xBChgrb/c6z9g4k=;
        b=1l8JPLPlkIJiVCZRnyk9DEgw+1bSioCWeESQ/4tIT01VUE6v58efsJE1jAwLLjJV5o
         jHeYDyeqAsXEhEjF5yEVOb1uns49QBFO2jE/DX5TkfJpAMlSUxFAGRVbSCeVP7wiBjtA
         dXxc1Lh7Qg2ZRF/Evk9/abC7l+27nQmiU1TiwV9O/wxAwrAnOWZ1ve1FZXzpF+XA7U3Z
         oRBRKs2RBnfCR10rMkkrMBd+Ibza3hAWbdvsUOvB6X5Ys66OlcadSZJUfa8j54fhVIbZ
         6cID41znREcKPA7fiGUZWIdNMSJXBKQl8GlmCFDIribaGpZGjvD0qRWuYlEsIxoZ6F44
         aS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDcRoDkLiE73WEi7gWpkshjuXCB6xBChgrb/c6z9g4k=;
        b=EpsCZ0Ea5Eqh67uC5aVHrs5CR5qkYsrpEto8HLx871Tsm1NdB0afaFqSdH6KfNEnb5
         ri47FWGhXans8kPMx7j+d0ceJaAj5OZWA+A1r/Gna2EKVHF3fFoGxLArNc/mJns9e8St
         LQB0QfCXYpNo/eLZmr+RhGO7m56hbRmzi3+zWu2wE5ysJI3ZPywer2jM72bfmoW149Pg
         HZ7RaTp2IzgKHBAfLiubraOYPbEujv6IfE76t4GDkqB9FbxmkoQUSwXZEOkpCPyTD3bY
         GKg4ghbPeAIBXulBZ7EQ8aKRlFwAo6vBUFpBq3rB52P9huqtE6J1dpbiuFk98Y2ygcE1
         tnjQ==
X-Gm-Message-State: AOAM533qjpOCgBZu/UNY7P8dwOmpmElNlB5Uz3jv//1bJevaYT8/foIW
        DFz+v+imMdN3LnA76Y6yGxWgbkkDoZba+KKL
X-Google-Smtp-Source: ABdhPJx0kW1gc4bcDHipnKtoga65ixPAWTUqMbLn0qkMGYm3RPkfaInTiGdHeHrtUZxaM4JN2XKgVw==
X-Received: by 2002:a37:a9d2:: with SMTP id s201mr21734008qke.501.1604436596109;
        Tue, 03 Nov 2020 12:49:56 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e28sm6251979qka.73.2020.11.03.12.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:49:55 -0800 (PST)
Subject: Re: [PATCH v9 40/41] btrfs: reorder log node allocation
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <ea3f5bdd11553b1ba3864f25c42d0943eb97b139.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bfa5978e-0688-edaf-4014-1b7b3fdd3bf6@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:49:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ea3f5bdd11553b1ba3864f25c42d0943eb97b139.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is the 3/3 patch to enable tree-log on ZONED mode.
> 
> The allocation order of nodes of "fs_info->log_root_tree" and nodes of
> "root->log_root" is not the same as the writing order of them. So, the
> writing causes unaligned write errors.
> 
> This patch reorders the allocation of them by delaying allocation of the
> root node of "fs_info->log_root_tree," so that the node buffers can go out
> sequentially to devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

If you keep the tree log stuff, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
