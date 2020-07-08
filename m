Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACF219420
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGHXOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGHXOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 19:14:32 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B54C08C5CE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 16:14:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w2so70401pgg.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXlCDNHI0ZK15y0LOuAYzGPtynusnw7LtwDb5Yj2OtE=;
        b=cMbzoT4XhkOdRuftJN/OiPsYT9RozDw+GuQh01xrUOP3mEW5tEUjydfcb4W+DKVzne
         TFfUTMUinXgvBqCBfHGgOVgQJzkXgqOGy28APv540LEKujTVtjrvU97kbdrHqETQKtaw
         RxfU1Mj6GTpbQeKCFE4jR13nkdUzsgeldvzxXoT9HJ1fzXpuM/Ep2USaPDxgdcyvZAzd
         /jZjEoDC//LUR2Vf0Zhf0IGE23c90oPClyOfNFgWvDrq1zo1M5Bgvo6f9IqIwZwMBEpc
         Bs9RuI54YBgJOxg3wIrkIpXX8DSkg4acxak06jwvZXv2M3RmK5zy1eWHCosB7prsXkuL
         YrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXlCDNHI0ZK15y0LOuAYzGPtynusnw7LtwDb5Yj2OtE=;
        b=rCiZerC3FBrcy5AlAJ3TZRLUVvW0o6RRiOkX8cthsvuM5VRI2zVX+/rs1zeF1Gw5dv
         iD3TzEevxhMGegcsQcATQZmF8EoaxrdS81DjSXITloUMRIlEpikcF1onCvhWNTGkUHz9
         cJZVLarGW3gqKx28fiEE41MotbJluTMAk+wPRN40JF3DRw/00nHZBsWvfKtPBq7blMUP
         ooX6APCieju/ts8hk0YD/1n12DU9qdSxkWKlq1sbbGDth4B8f523CIFwYw9DsNP5kO34
         qEgCko3QiPgS0ze5+IqG8YFFtaYxEmQWabxWj+rRpA1pFS62/YdvdRkFuQZCEP/QmTZY
         oiZw==
X-Gm-Message-State: AOAM531/AK1gl9sf/Acje92Imp29Tsv0r4tXtFI2pb3UiIl0YbMpOnvA
        PItrhXyNi4MWzjN+EqxwoO51Vw==
X-Google-Smtp-Source: ABdhPJwxXRU58dnJ8SaVTE59SieM0UMi6WQspGfeG513juta/gCc2a5inFjMHD1HHOikaeJsZTW/MA==
X-Received: by 2002:a63:7741:: with SMTP id s62mr50514486pgc.332.1594250070946;
        Wed, 08 Jul 2020 16:14:30 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n137sm721427pfd.194.2020.07.08.16.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 16:14:30 -0700 (PDT)
Subject: Re: remove dead bdi congestion leftovers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, dm-devel@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200701090622.3354860-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5d6df17-68af-d535-79e4-f95e16dd5632@kernel.dk>
Date:   Wed, 8 Jul 2020 17:14:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701090622.3354860-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 3:06 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> we have a lot of bdi congestion related code that is left around without
> any use.  This series removes it in preparation of sorting out the bdi
> lifetime rules properly.

Please run series like this through a full compilation, for both this one
and the previous series I had to fix up issues like this:

drivers/md/bcache/request.c: In function ‘bch_cached_dev_request_init’:
drivers/md/bcache/request.c:1233:18: warning: unused variable ‘g’ [-Wunused-variable]
 1233 |  struct gendisk *g = dc->disk.disk;
      |                  ^
drivers/md/bcache/request.c: In function ‘bch_flash_dev_request_init’:
drivers/md/bcache/request.c:1320:18: warning: unused variable ‘g’ [-Wunused-variable]
 1320 |  struct gendisk *g = d->disk;
      |                  ^

Did the same here, applied it.

-- 
Jens Axboe

