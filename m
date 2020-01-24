Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010C7148B3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 16:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgAXP1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 10:27:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32966 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgAXP1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 10:27:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so1805872qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0NYd7e8NlG4HjC1NmHH6i2TFFJaLnGAT9c1C+1tUy/0=;
        b=mSjwynmUZ5+scJHbnQcjTwFooJrSV3h5cbsS9DaupZdpFf7vf1BLouxKy4o9RAXvoD
         sVLON6L08s5HLGx+Kq8ahouaDy7dsTChiOK3TsODyD4YXK4V273HxOQVn9dCBDRTOklI
         0oSvpjdhUL/wv8naha0yK7tMLRFO7SHHN/Ebe8cJfMPRLdzJnE9ZWuKKcqu78djopeek
         HYPW1RgYVNCWXkDzCbHZCVWpEM7ZZR5Ev+O2hkDoyxmKL/ooo7NCV42mvC6fg+pp7n7N
         1Y+c4jeQL8lqWL7eZOWUTvseeh9vw9GjSn6pkr6pcjxGOoMsLrYvjYSFTyYcED1ILlFC
         CRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0NYd7e8NlG4HjC1NmHH6i2TFFJaLnGAT9c1C+1tUy/0=;
        b=AZsDd+OFW6N5PBwMxGNV8YWjAkoWUBLbLmiOD/5DpytY1EBZz7PoG7yDkFa9fBqLdZ
         ffFKPrp5+4pdn61n18heG1WnrQEEDMH8faFmkBlxeS5V6FOV47CXZ6Db1tocTxxthRFp
         l2qA7tRyQpvk5LFwYTyOyrbHm5Rx9/R6BjqC9SErEHHe9TakKaXZ1uDPstxhMvTEuWKm
         LLhawciGAd5Zj6RaFn+Wt1itqLtqZEwvC0FFEW6ye9XfLbeab9mczGuMb3UR3GGfPw7r
         XMZewOmiCMGluBj/sDsgMyuZdZ9uh/7RzoG0YIF5aY4XmhcPBcl0k8lCq3DZpNuaMbOg
         H/gw==
X-Gm-Message-State: APjAAAVz1GhN+H7r3cvAjsmnuJqB6TOSaDKPVwLFQW1NAOMseyBXLKo9
        gc0e71eZ3kTy31/NpTXWxxC2Qk+tCfkpmw==
X-Google-Smtp-Source: APXvYqzmX2ejwzXo+HUOybQskl5vm1epVJObxRVDqYKB67lcfNpYhuujbm2r5Wq63nowceYbyfBiwg==
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr2571215qtw.9.1579879667510;
        Fri, 24 Jan 2020 07:27:47 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::8493])
        by smtp.gmail.com with ESMTPSA id x3sm3479892qts.35.2020.01.24.07.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 07:27:46 -0800 (PST)
Subject: Re: [PATCH v3] btrfs: Use btrfs_transaction::pinned_extents
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200124103541.6415-1-nborisov@suse.com>
 <20200124151830.25984-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1be76c71-9b3f-f407-1f2d-ba598911bdb7@toxicpanda.com>
Date:   Fri, 24 Jan 2020 10:27:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124151830.25984-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/24/20 10:18 AM, Nikolay Borisov wrote:
> This commit flips the switch to start tracking/processing pinned
> extents on a per-transaction basis. It mostly replaces all references
> from btrfs_fs_info::(pinned_extents|freed_extents[]) to
> btrfs_transaction::pinned_extents. Two notable modifications that
> warrant explicit mention are changing clean_pinned_extents to get a
> reference to the previously running transaction. The other one is
> removal of call to btrfs_destroy_pinned_extent since transactions are
> going to be cleaned in btrfs_cleanup_one_transaction.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
