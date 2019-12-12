Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7711D7BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 21:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfLLUQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 15:16:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37160 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbfLLUQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 15:16:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id m188so2702989qkc.4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PwOtkCQ0EU+X8nv+fgjaYQ3XAmjgThjZRgqTHikICJk=;
        b=makzMCAq5DMjIwu7WPNgaIR3phMa0wYDdZza1XRxLpwgDVJWDH5uvBLOV3cNNEQlO7
         r4gDXaiwCg1TcQY0uoN7aQzVkGdyG+aI+9JFES4ddkvWbQG7goGp0U9jgfrPPQZVuks9
         puP/OLbI+z+4EGFwJzj2rRApjxfxNuvTm0FscoXAuduQWe7fIW5LxfK3mWR8MBifDLkx
         9LoAvORnXAemyLDEFauVlDhKiF/3qhy3Uw4Fn4auYN93UzGwytG+71McWQQtKCnwvL+/
         8Yk20eDhAJ3fCTKDfJ9a+BCGTSVqpHRsdC0Kj8kF8QIQo72L8sPnse/YwMCwB1ER3z/B
         R9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PwOtkCQ0EU+X8nv+fgjaYQ3XAmjgThjZRgqTHikICJk=;
        b=aPqvm2hKIHXAIsigJ1aGoMtq91cGJhtW9WYLHXNiVKCGaUfNoBXvAuJcgE7OKTO6NV
         HKB/763USeuCGXD3hPZ4mEVZNMzoJ8Ysy5gZPEQVn44MbApipJfNxGe06WMBgIVT6YLs
         ldrg0enX8V8WTzGTvkEog7qa5aw3251rVeiquq8ZILppZ1tBAEc0W9UeLdL/hXx1d7sm
         3Ltx5DnB95+PS3MfDl7lX95Hq74q1hIUTQO+wlcoHaP/lWn/vI55KEYSAXsHU6e8JU4V
         ndKpxqKxxKpZkaHzqxCNh1H2Zl5FXxppBLJZmQDvXJKpj7rAmPaCup+0zw0Egkw99bFE
         ApkA==
X-Gm-Message-State: APjAAAXQ50FdEptlkRzlvCv6gs7CylVb6YXlA3Fqc1P1XLfS7ihSGSEq
        p1sGW/KH/NlumKk8EEY3DLNvbg==
X-Google-Smtp-Source: APXvYqy92fBkJeMSKaY8exs4q7XhJXGuHLRQbW+wTe6xtiMNnL7lJNIArDhswluisERiFMt2d9yAng==
X-Received: by 2002:a37:b2c7:: with SMTP id b190mr10347307qkf.329.1576181778535;
        Thu, 12 Dec 2019 12:16:18 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7783])
        by smtp.gmail.com with ESMTPSA id b3sm2517504qtr.86.2019.12.12.12.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:16:17 -0800 (PST)
Subject: Re: [PATCH fstests] btrfs/187: require 8GB scratch dev
To:     Johannes Thumshirn <jthumshirn@suse.de>, fstests@vger.kernel.org
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        jth@kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20191212074543.30628-1-jthumshirn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0cc6f157-0416-bce2-296b-d01a813199fd@toxicpanda.com>
Date:   Thu, 12 Dec 2019 15:16:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212074543.30628-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 2:45 AM, Johannes Thumshirn wrote:
> In my testing on 1GB zram devices btrfs/187 usually fails with ENOSPC.
> 
> Add a requirement for 8GB scratch devices (empirically measured).
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
