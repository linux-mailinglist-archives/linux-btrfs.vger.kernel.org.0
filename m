Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C533D2C01
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 20:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhGVR7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGVR7d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 13:59:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E3C061575;
        Thu, 22 Jul 2021 11:40:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so101673plr.9;
        Thu, 22 Jul 2021 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5bwPh4/SG5Is3ZmUD4q2FFYMSdDYfhVtUgR3DiH/TBs=;
        b=gVPRYw4kDLqfJXNklmaLjldwfA6sQztZEchLWfkBjAvqmYwLSbAVWUmC8bHXpvOMe4
         JmaE7Fr4yjpwVxZE5ceEy28bm8G4ZedypVOSoau6W8uVJpHHgyP/di8fdPFFQioSKElh
         7rdZsNsxy/rJwbgMiBMtFIjLTapgMjlnzclSIhJw/AihVLGeno1E8nu54LAg32Na9QbK
         h25WhSoSY5HgCoBwJQeRdMsiUmhhRfWBY6MWgqO53qv61V75PlBZ0pZ337ox0W5VZMvy
         rVFAZmAS55xzPd2Y40XA4Aug0plDg1mBWub6ffKkXyzs51TwrzRtpvp2/T+GMdAeAz1P
         grJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5bwPh4/SG5Is3ZmUD4q2FFYMSdDYfhVtUgR3DiH/TBs=;
        b=DkQShywtniiM5O310e6wSuAbHg8Ox7ex7aeBEZqb3KmTHkq7iKkKJHIVS/ZPLO2Wiq
         wAZ+jsqjmjo9O6T662FOQ5cRS6IKRB8GFC8ggGdmiN+cKWhkJkgNNL/zFEbk/fO0zXYO
         9qKu9EbEl2ZVfIFq52jUueBF7QuAUcs8dVCNKCSMqAA6uvDJ2oik5+KR7uhIsxEuAEnE
         LEQNmFP7DVasfHPhiIisWgF/YLeKgY3AgZLo6CpDU944RBSxEbJFGZ61mzTGP0KRyc6H
         1F7YBe8/kZMJE3Z03FHFpxVUxL8WMHJwiXn3+K6BeGWm9ghO+a2HXUuAEi1scEwJZN+u
         VW3Q==
X-Gm-Message-State: AOAM533AOrhXEYenVMFgNPvLamD7qvtB2NmUAsMXm4trlmSUf5JUtbXA
        ZA4quQ+M3Y9V1UuPijxSszsuJWa5LJ0+LA==
X-Google-Smtp-Source: ABdhPJx2zDlHRsCRkzeMZ3lHbq0iyMXwR+hCIb74LQx4/twMvM0ilVYeQEfXdIMa04arM5DR4UbOAQ==
X-Received: by 2002:a63:338d:: with SMTP id z135mr1258103pgz.265.1626979208086;
        Thu, 22 Jul 2021 11:40:08 -0700 (PDT)
Received: from [172.20.10.6] ([172.58.22.135])
        by smtp.gmail.com with ESMTPSA id z5sm4664360pgz.77.2021.07.22.11.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 11:40:07 -0700 (PDT)
Subject: Re: [PATCH 7/9] loop: don't grab a reference to the block device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-8-hch@lst.de>
From:   Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Message-ID: <b6d4f4e0-133a-39dd-a2ed-d0b2f5632431@gmail.com>
Date:   Thu, 22 Jul 2021 11:40:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722075402.983367-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/22/2021 12:54 AM, Christoph Hellwig wrote:
> The whole device block device won't be removed while the disk is still
> alive, so don't bother to grab a reference to it.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Josef Bacik<josef@toxicpanda.com>

Reviewed-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

-- 
-ck
