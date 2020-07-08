Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4152189DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGHONP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHONP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:13:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2684C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:13:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so41558470qkb.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wrzGgF1zolhO7imZLJMJG0lZOCaNIENOcFsoOZV3tMU=;
        b=Xze050uw4Qln4MCXaiWfuMM93KPtMwLKM/k7TlC4f5ggy1G9KG3gk0PzvYrl+F4ho4
         1FQ+7zwOprHjZpobz61PDOH/rK88DkKovgm3rrlx92VONgHuWNYrsL0G0K0yRi8rB93c
         mAK1yEMXKsuH8X1wFa8RHRI5+qvwni2Ox0vRPKzlVax4uVHmte86LWlDscleGBOt4l2Q
         idD7oBmjoRq+J9I3CIbuZtIYd+R95LyaF02FhXL/v0K0KaTf5UyZl7TTOd5OwaEyr3At
         flBu83tBCfRx8XAfCrCS3K7pdzXb9DllER+SLt4+RRx49BYu/VFKcjq59fWva2MGrJbt
         hsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrzGgF1zolhO7imZLJMJG0lZOCaNIENOcFsoOZV3tMU=;
        b=QuApUHJsLbSo8tpRYEVgvoG0UAI8oRbBapRXAjEw5z5h0azi2w6xIBv8dJ67rTU4+a
         8VLtlBAtwo151laQ7Xhh0nb1p68m/bQf+gUhdxgO8wXAN1ifd4Tvgd/5MGaPUwuEH9Lm
         ACFPC/BhgcjhZ4VIVDPuw4q9efsDCwDlTgV53IV/dArgm+L7a0+aPttItJ8fRFt1aaXA
         cLzGgBJZ+JEnAov7ZGw1U7VyyX264/kX7Z+GaFerxzY0dIVatLf+LuUBgZubGCF/JNxX
         wDQS68Re0OBa1JFAYYKDz4u5ulRNop/FKrSmJYuULlV25q4Sj25RT7VKV8ufqB4R+p+J
         p4ow==
X-Gm-Message-State: AOAM532tiXdu0xD04O27nfprJta1kVCOJwlj8aQ+01uaXA9O+y10Eyid
        Fn99JrFajMb/vn1lye7Y83zKuzlUQwolpw==
X-Google-Smtp-Source: ABdhPJxNYjXmtAlaRMBTlBDHqgJnjPeZ1/4KJEUSJUFYbjukIaLduS+GeJMkQkS4tfuQs1QlrXZjJg==
X-Received: by 2002:a37:9f56:: with SMTP id i83mr54957805qke.134.1594217593710;
        Wed, 08 Jul 2020 07:13:13 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c24sm33042940qtd.82.2020.07.08.07.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:13:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: avoid possible signal interruption for
 btrfs_drop_snapshot() on relocation tree
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200708100022.90085-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0b168157-3dad-ddba-e616-ae82eb2d6501@toxicpanda.com>
Date:   Wed, 8 Jul 2020 10:13:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708100022.90085-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/8/20 6:00 AM, Qu Wenruo wrote:
> [BUG]
> There is a bug report about bad signal timing could lead to read-only
> fs during balance:
> 
>    BTRFS info (device xvdb): balance: start -d -m -s
>    BTRFS info (device xvdb): relocating block group 73001861120 flags metadata
>    BTRFS info (device xvdb): found 12236 extents, stage: move data extents
>    BTRFS info (device xvdb): relocating block group 71928119296 flags data
>    BTRFS info (device xvdb): found 3 extents, stage: move data extents
>    BTRFS info (device xvdb): found 3 extents, stage: update data pointers
>    BTRFS info (device xvdb): relocating block group 60922265600 flags metadata
>    BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4 unknown
>    BTRFS info (device xvdb): forced readonly
>    BTRFS info (device xvdb): balance: ended with status: -4
> 
> [CAUSE]
> The direct cause is the -EINTR from the following call chain when a
> fatal signal is pending:
> 
>   relocate_block_group()
>   |- clean_dirty_subvols()
>      |- btrfs_drop_snapshot()
>         |- btrfs_start_transaction()
>            |- btrfs_delayed_refs_rsv_refill()
>               |- btrfs_reserve_metadata_bytes()
>                  |- __reserve_metadata_bytes()
>                     |- wait_reserve_ticket()
>                        |- prepare_to_wait_event();
>                        |- ticket->error = -EINTR;
> 
> Normally this behavior is fine for most btrfs_start_transaction()
> callers, as they need to catch the fatal signal and exit asap.
> 
> However to balance, especially for the clean_dirty_subvols() case, we're
> already doing cleanup works, such -EINTR from btrfs_drop_snapshot()
> could cause a lot of unexpected problems.
> 
>  From the mentioned forced read-only, to later balance error due to half
> dropped reloc trees.
> 
> [FIX]
> Fix this problem by using btrfs_join_transaction() if
> btrfs_drop_snapshot() is called from relocation context.
> 
> As btrfs_join_transaction() won't wait full tickets, it won't get
> interrupted from signal.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
