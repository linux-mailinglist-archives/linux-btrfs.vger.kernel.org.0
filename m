Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF6231FC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG2OBg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2OBf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 10:01:35 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65029C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 07:01:35 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so22214046qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NWcwgv77k2gFBpOtme/OnNMUvTvI8oG+LwLSikUeOts=;
        b=2RgkRiWu7f6+KgNnjK3UMPpuxdEQTdfBMm5HH72ndwaO3M3JFItfJx3QKe3JZJiJXT
         ojouDAsiGb97fejmrVNQobFpYjRjWr2Zh2Qdl3WDNAVpnmCzhE1FyKmFvDOjjwEfUhaV
         qyWeHVN2kkL6v2EZWwFpP166kK0ALrhabIp5xEi18EJSct9ALlWp229g5H0d/pE2p7Hc
         wCTh0qxNIi6+aUbO/k1qCNZfeYS6SyQnUJp1wgLDj9EzwhSxAyJQN24G5CWmmbvjr3jy
         7N+ezExJBVLG3gLPq5CI+/+vsi4NCf9XQ3jKmbWTH6JIL7qgFwZQrEqChuYes5q9GgVf
         nnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWcwgv77k2gFBpOtme/OnNMUvTvI8oG+LwLSikUeOts=;
        b=Vj03OMd5lRpTCE0z6P4k5N7K2bxyUeTSYDFUSgrjc1wE53PrvSQVdItwB8ozt0zUci
         cZQPJp3X7eJ5KGBRRxVP5TJICvNquoytx1ghFVb0Xzwmv0IMjvb7D5JGNtdTyPimASwb
         nuE4331fqFTzyTfBquM2/7d0mobAgLSMdogiBDZtqvgWPym4hIJoJeYMPpK5TvGYb7cg
         j4I4GAgcqTG1VWN+2HUvEZB+hUE2XZ1MAZ8xsNBTfNz4TM3FIoZ0aDG9lcK5GyRMaHQk
         rK3uLc0zKnsA59D0hmsbnZlsNx97AvSJYkxoszCZQXBlgLnN1+Jdz59GuKk23oCb5TJA
         fhjg==
X-Gm-Message-State: AOAM5309NKMgeTxPxotWvItbHI3q7fjXg1LnnJDgtejG0On7m89l+dVi
        VYPReaNwa4arZCs9bC73JsZPm0mmMFpG8g==
X-Google-Smtp-Source: ABdhPJywOM1DWiXiWEruTaHJISmgDQQ4o1r/Ap5D5GgfzCWKZiDcJz+ssnnZGwYMWL6y6uJ3mjSYVQ==
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr34846592qke.373.1596031293957;
        Wed, 29 Jul 2020 07:01:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:5750])
        by smtp.gmail.com with ESMTPSA id f7sm1504648qkj.32.2020.07.29.07.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 07:01:32 -0700 (PDT)
Subject: Re: [PATCH] btrfs: handle errors from async submission
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e3a95f23-b87f-c7ca-6a63-bc6db9c34ba9@toxicpanda.com>
Date:   Wed, 29 Jul 2020 10:01:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728112541.3401-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/28/20 7:25 AM, Johannes Thumshirn wrote:
> Btrfs' async submit mechanism is able to handle errors in the submission
> path and the meta-data async submit function correctly passes the error
> code to the caller.
> 
> In btrfs_submit_bio_start() and btrfs_submit_bio_start_direct_io() we're
> not handling the errors returned by btrfs_csum_one_bio() correctly though
> and simply call BUG_ON(). This is unnecessary as the caller of these two
> functions - run_one_async_start - correctly checks for the return values
> and sets the status of the async_submit_bio. The actual bio submission
> will be handled later on by run_one_async_done only if
> async_submit_bio::status is 0, so the data won't be written if we
> encountered an error in the checksum process.
> 
> Simply return the error from btrfs_csum_one_bio() to the async submitters,
> like it's done in btree_submit_bio_start().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
