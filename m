Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796905F73CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 07:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJGFDF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 01:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGFDE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 01:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C687BB070
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 22:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665118982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OSdMSmKz2+8FohR2BeL0lBuEHTByXbSkcCGSK/zZns=;
        b=JwbCJEkHM6DpytBewWxjHehRFBdsjXKA2PSItPnvvm1CiHgFWwDsQYrcITPQ3LrH1R7TWh
        3j+ipd8g6mMIEZSY98mKZq5CeZPfP2n6uegockzno1Z0SAQqFdICnctlFN6UjnbnDqHxSs
        ooGXfgTvcLIqEFLdV7lrRuxUVpnM9hU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-EZqP9JRHM_mc_m_5QcRPJQ-1; Fri, 07 Oct 2022 01:02:53 -0400
X-MC-Unique: EZqP9JRHM_mc_m_5QcRPJQ-1
Received: by mail-qk1-f200.google.com with SMTP id bl17-20020a05620a1a9100b006cdf19243acso3026490qkb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Oct 2022 22:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2OSdMSmKz2+8FohR2BeL0lBuEHTByXbSkcCGSK/zZns=;
        b=x7ivxySNzuKnZks4e2U7Lg1qSYuNIVil29qE0PxYWpu+ByzvZNhDaasP9Rt5cA3Lsb
         5AUuJ1IR3J1gxFd3SYPO8ZKxQ0X1oPbXIaXrUwf1WaCYp4CyNpRKvcuT2NvZ2Twkb5Hr
         cXrWlZXiaoQ01wtcpfDxBr2FUVh1SVdjGzYrENpuPLjoDTxCrFId0uacrdgOTgBSi9V/
         JxoN4s1wguKAYnxoKPIJ40qukek6SemCIrBxxovNXGtVgq6v205LlggyYM4/6x5oA25O
         0FVcdlrG3+b9ii90w3QR3s/nFgZfLZr/fO0nd2ibXrFCVNVs4lGlL8veYrshkIRfgrud
         hqmg==
X-Gm-Message-State: ACrzQf1V7RjUT7d6TbYiVAwWks4IakWIX56qzW5CXBdtGlvRmj7ym5FM
        JpcGUo1tOPtbM2aHYcP0cAb2sJOuAsZy5TXTwu0SKKtrE3jXUhYaxvphXVCpMmbplyumReQKJ4c
        xSYCEboDpU3xRqUNz2VgQQvM=
X-Received: by 2002:a05:620a:3:b0:6ce:1a87:dc6f with SMTP id j3-20020a05620a000300b006ce1a87dc6fmr2611492qki.73.1665118972979;
        Thu, 06 Oct 2022 22:02:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7D8F7Eb08yusEtIIJQQoTnduUY+fn2NcCN2qC9KkNJa47taIe4SdiVCFeJWksFUqm2vEAMHg==
X-Received: by 2002:a05:620a:3:b0:6ce:1a87:dc6f with SMTP id j3-20020a05620a000300b006ce1a87dc6fmr2611483qki.73.1665118972766;
        Thu, 06 Oct 2022 22:02:52 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u28-20020a05620a085c00b006ceafb1aa92sm1048053qku.96.2022.10.06.22.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 22:02:52 -0700 (PDT)
Date:   Fri, 7 Oct 2022 13:02:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: test active zone tracking
Message-ID: <20221007050248.kagbkgfbqrkmv54g@zlang-mailbox>
References: <cover.1664948475.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664948475.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 02:46:42PM +0900, Naohiro Aota wrote:
> This series adds a test for checking if an active zone tracking feature of
> btrfs's zoned mode. The first patch introduces _zone_capacity() helper to
> get the zone capacity of a specified zone. It rewrites btrfs/237 with the
> helper and use the helper in a newly added test btrfs/292.

I have no more review points on this version now, will push it in next fstests
release, if no objection from others. Thanks!

> 
> Changes:
> - v3:
>   - Fix import of common/zoned in btrfs/237. 
>   - Use _fixed_by_kernel_commit.
>   - Cleanup background dd processes.
>   - Rework error handling.
>   - Fix indent.
> - v2:
>   - Rename to common/zoned.
>   - Move _filter_blkzone_report() as well to common/zoned.
>   - Drop _require_fio as it was already unnecessary.
> 
> Naohiro Aota (2):
>   common: introduce zone_capacity() to return a zone capacity
>   btrfs: test active zone tracking
> 
>  common/filter       |  13 ----
>  common/zoned        |  39 ++++++++++++
>  tests/btrfs/237     |   8 +--
>  tests/btrfs/292     | 143 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/292.out |   2 +
>  5 files changed, 186 insertions(+), 19 deletions(-)
>  create mode 100644 common/zoned
>  create mode 100755 tests/btrfs/292
>  create mode 100644 tests/btrfs/292.out
> 
> -- 
> 2.38.0
> 

