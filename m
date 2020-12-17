Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A562DD49F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLQPwo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 10:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQPwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 10:52:44 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC48C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:52:04 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id u21so20363857qtw.11
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=985rH4/LjgpieGz0cOs42UeUiILqaUjiMXa7WUd1ZRA=;
        b=F1mf+YeNUpBrI38ILKTkHCn7rmq/K42lTSxMNHj/zrqW1Y7vyZXUpDPJnk0f4NTg/2
         f9eb/kdWy/T3R9xZKDbBwNe/+DUS6AbWrJPLpG8Ee8E5jQNdfuNT+kW1Hcv5bpjmzzPf
         NZVZDhvdo78w9URrI/L0ZLqahQpXTs2B01KVRsgTfJfpM5gJ0QbZNE1fe97QPQ1yHxVj
         3X7L0XD9+ovx9ltE2A/Tj/91nr21m1GEzj69cy+PBpCulYNTtu+UL3tBzjY2MCnUV3y1
         VFPNvlyodTqce+GlbIp5nCrCBVW9xkVSWDHb8v1Cl3nLOWmzNVDhpIQfT+KqpxQbw27k
         rU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=985rH4/LjgpieGz0cOs42UeUiILqaUjiMXa7WUd1ZRA=;
        b=hcWK4zzQB5mtbrj6cqPR5m+T/07uC+UALTmBT5Zna71OUZpvySQkOh+k+xLFWqCpXV
         zzPsZO+chpu80XQkaGw17fnMUGVHpYq9bd3exUGw/oMKRACEmyf2spQ4NqTtJKVhPs1P
         4z40vgDeUm2RFLZEVbdKGqvNZEnlG2j/Q353Q+r9br7Au20AO0rT1UzOpT0LTu0dpTva
         YXrS6Jr8gA5kUfHW+wJfCGCE7QDyojQFaBx209LLV5fVxqGVMLWRbsT9hID5rI54PLbz
         C8F5GT+Z2x/TiqZBRS1zyT8bASosAmbQZDK7V6GFKT5W7hzQ7wkDkmTrQpctiyqcjtdN
         RCzg==
X-Gm-Message-State: AOAM5328nQA45LE39Od1/4QDW84ONyptY4Tx230CH8zHTjpZkfyyLApI
        k+yWhGMkiRrs3nNDgZmL0xMYXA3V3TIop15z
X-Google-Smtp-Source: ABdhPJyV5uYLXEM51KgLVW5XjjVFdzSRzEeZkWDy6+nlVdRD5zcIO4KqaxMxJ+Y30/Xop655XQ4OyA==
X-Received: by 2002:ac8:5802:: with SMTP id g2mr47577071qtg.383.1608220323050;
        Thu, 17 Dec 2020 07:52:03 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b12sm3558962qtt.74.2020.12.17.07.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:52:02 -0800 (PST)
Subject: Re: [PATCH v2 05/18] btrfs: extent_io: introduce the skeleton of
 btrfs_subpage structure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c31e2fba-61bd-eb08-6d40-4e2b43c6da43@toxicpanda.com>
Date:   Thu, 17 Dec 2020 10:52:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 1:38 AM, Qu Wenruo wrote:
> For btrfs subpage support, we need a structure to record extra info for
> the status of each sectors of a page.
> 
> This patch will introduce the skeleton structure for future btrfs
> subpage support.
> All subpage related code would go to subpage.[ch] to avoid populating
> the existing code base.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
