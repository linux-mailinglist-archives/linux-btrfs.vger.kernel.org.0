Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB701F7D29
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFLSvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLSvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 14:51:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D0C03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:51:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c12so9938281qkk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UQO8hGkfcfnxEFVmm6l9C11b9ZAZGrni0hJRWj9H5Ds=;
        b=lPN/psF9di2o2VLixYmHhVK6yrw2Y/O/rIatHWEjegHfXLyMc5bkU8vKUrXbOyEy/W
         tvVON/dD/TMBJjb8dhGkFJrddTj4Ux9rfMJcJg6J/s9v3OpCLVICNA7qiyo9V28TRHUC
         QDX1LKSjUGigt6R3c+dXKaNJAelGXkjGIbkX76LTDSs5RvWN5CAGzcLbwKoUZqxUcLBe
         vb7uBjemaO3aaXT5M7GM+ETb6XmkII6kql2Iws3RK/oVveJgfRaJYHcAN8krmgm/pJ2r
         1kRli8kWh6FMwwxoGVClrj8HFYz4u3ZsJmF/4fgqq0yC5y3nxgieTmTIh7/hqIrqc0yM
         hNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UQO8hGkfcfnxEFVmm6l9C11b9ZAZGrni0hJRWj9H5Ds=;
        b=HB+wCRFsxHmBAOEfVYRqVLCl6KD//UFmIxx/KMsjm5Ddk3VHu1FkKL4fIyjtf8xR/J
         8+p8pRLogT77zlUUq9CcLqZpeOWIH4FQSHkCogGjL0YqsDx4V9HG52ni6fF6jko7JQe8
         z1qiAlpEf/3RiAJ7mT8ARKK7/9soFEnLZFrddJEWbZhMjHe2jgdLllSozKmZO4DF8ChO
         rJc6Ayukyv2DT6IFXNbVnz1qK5Sxv+MR9C2MS7FgwbCjJY0aJMSnpZXc55juQn/ez9/I
         TejAHfQHk4xVUxSZbbuzSqQBCtkw2ciVOhSyYzu6waczX63pRz/unpnOK+RCijwcEKc1
         tqCw==
X-Gm-Message-State: AOAM532a97DN72cuy5krbjeTRWwwEcDI+ueezfhA/G6Lrv8rJYhyaaC1
        YAR8XW5TX7+1ncLLE6Kht+jq9vbvZQ5eog==
X-Google-Smtp-Source: ABdhPJwGSWKR2vsJJuG2Os9P8H9NP24TNncxPCq6fnSzQjFomHU4awuUMS1ub3nx5h52P5XerkfuHA==
X-Received: by 2002:ae9:ebd7:: with SMTP id b206mr4544030qkg.372.1591987876009;
        Fri, 12 Jun 2020 11:51:16 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::11c4? ([2620:10d:c091:480::1:487c])
        by smtp.gmail.com with ESMTPSA id g5sm5817279qta.46.2020.06.12.11.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 11:51:15 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] btrfs: qgroup: catch reserved space leakage at
 unmount time
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <28897eb0-4bb9-9411-f803-48b3f88e3f46@toxicpanda.com>
Date:   Fri, 12 Jun 2020 14:51:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610010444.13583-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/20 9:04 PM, Qu Wenruo wrote:
> Before this patch, btrfs qgroup completely relies on per-inode extent io
> tree to detect reserved data space leakage.
> 
> However previous bug has already shown how release page before
> btrfs_finish_ordered_io() could lead to leakage, and since it's
> QGROUP_RESERVED bit cleared without triggering qgroup rsv, it can't be
> detected by per-inode extent io tree.
> 
> So this patch adds another (and hopefully the final) safe net to catch
> qgroup data reserved space leakage.
> 
> At least the new safe net catches all the leakage during development, so
> it should be pretty useful in the real world.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
