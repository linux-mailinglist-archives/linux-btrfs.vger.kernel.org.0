Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D81115CB7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBMT5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 14:57:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgBMT5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 14:57:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so3693042pgk.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 11:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HroJCVAK2QgQbRJKwmFvGeDoKKeCye+UdDehpLpM+Ac=;
        b=WEqmnX25hojSrgCJpZOwq/OtCsWgG3zZ0mZvZanYV6Klh9GlemcYQTOl8cLGvqRVxa
         mk5tYg3//aXYJ3MOjM+/QhgZVWxqTdO+suIWtTioWIoR7bTvWNee0yzz05Um/ALDbO/H
         hpYKwnq7O171QjBT65lJA9hYoIjx2Y8Mst4y2iV7gsV0LWHvXJfvmuhrMxXQQfwj4ltf
         dXK4d34nVqMn5+NqrhnwMmu/5AnFmxTioEk9nd8lQC1OvbrAAahwxkk0cgBNheLL9XN8
         mOaN0TSvmtjtZK62Nd+hnTfSjmwFg2rijsYpvrjra3xAMuC/wG6s9P4B2Vad7cglIrJe
         Z43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HroJCVAK2QgQbRJKwmFvGeDoKKeCye+UdDehpLpM+Ac=;
        b=pssMGeXyQwmlDr2VrkpPBt651X3Hur47iHatjmtp7IM58NS8wLRbw11bYYSBQe+yBt
         UlrSXetuKl9gBGBHTyCwls6s6g+u4MGwdDzEYDAwThV+Tt1vCOcrgJf7ei3lPwWdo6UP
         roVnTPE1Xj9T9YoEzxuXNaubRLPwjSqjEgh4R5n7Keq2RU+M3V0d5mncaXOEHa65NQ++
         9SqUr4rBm8wMINjzDW3tav1j62NF0uKTVFYRYTyxGFa7WM4F44O23FTH5k5YYxwpj9Hc
         isKdfh4Sprsx6cGEKYHU8h4MhVUkcrtHjXCMV3MERKoVvKsUuNGGeOK0WdG0sFqvbrWA
         lGCg==
X-Gm-Message-State: APjAAAXBdFsijrNJ4ynt3J3TBGtc4s7CXok2y7kTi9hGjA2ua80dttE2
        hM9y/zhi2jxqEoDuNi5kQ/Y5cA==
X-Google-Smtp-Source: APXvYqx5lMq7fIi5z36Aa6xuqOFNQKraAnapKvEwEO5Y4n8qiR28sutSl536kftQFfbKIqRAHHYcCw==
X-Received: by 2002:a63:7207:: with SMTP id n7mr19880604pgc.253.1581623832448;
        Thu, 13 Feb 2020 11:57:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id s5sm4308985pgc.73.2020.02.13.11.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:57:11 -0800 (PST)
Subject: Re: [PATCH v2 13/21] btrfs: move vairalbes for clustered allocation
 into find_free_extent_ctl
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-14-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7a7f40e8-582d-b40c-66ce-9e9c67822554@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:57:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-14-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Move "last_ptr" and "use_cluster" into struct find_free_extent_ctl, so that
> hook functions for clustered allocator can use these variables.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
