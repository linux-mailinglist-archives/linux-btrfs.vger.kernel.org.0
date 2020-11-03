Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB02A5853
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgKCUrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 15:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgKCUrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 15:47:36 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB98DC0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 12:47:36 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id a64so13118367qkc.5
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7QsKfQ5N4ZcMiNYAkjVMD30fYGq7/BZLzRY1r2X5Hcw=;
        b=nQF8eY3elgrJuAG8MRt94bVptdrsLTckbLoJpbxNPPUlPdmIKEGwacSy5ak3isk6oJ
         TCPhsXKPC1oOdZm47/r6NDRBYYPbqmRQrKiF0iCY66m1+d3gvqOdSYtRsFPDDcTg+GHy
         RwqjDHsv2ZB5Guptu2kj6ClgegJ08b7/nygB5OdWwKX2Y3Ywr9EoLjCF2xM5uK9UhVDR
         4RhgSJ8GWm9OZzbdlLrVQeMi2KiqhXPr6Wnw8ZGx6EKJwW67uF1G/PbbRZnmLMrQjzIT
         Je0dxhPYVuxLdih3CpTa4BmndW01u+Dsjc828t3C620SwpVelVHLwhivHyKb2SHGHQft
         2Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7QsKfQ5N4ZcMiNYAkjVMD30fYGq7/BZLzRY1r2X5Hcw=;
        b=QY2x4kERi3gwvxJDk3tFyVd2YMdWfAwordQlydaw2dCDT78C89ublhpkatzsFuTHVW
         a5S+XQIW34TjL5XDkyS7RPnPFBEsbG8ZO5EOad7IUXgcClr4L9l4HB4atmtgQWlTFuLV
         dojcgajAuYRix3Tks2dYYHxXlbu7SHjatz4wFh80cht0jN4GOKu45A+0HdVoeASpbrua
         MsOUaxYDOJ9Bgrsbb7X1qHVdVreH5GcIlk9tCJqAwtXoaL/vqu6tZHH64H2Y9rTX6LnZ
         eIOxnlV+eGYcW07weWngHJJ4K9QBIfa70KqpAhS2RfchnGjducJpIriOUWz2XpWPyywE
         hf/A==
X-Gm-Message-State: AOAM531FR0p3Y1BjotLvtJJY24uevI/+TcUZ1SjnJ5C3JzF8WDkh7+Tl
        77N8kCPzir/K6Dc5f3Dqp+HdF1AhAqMCbW72
X-Google-Smtp-Source: ABdhPJyRqhbGopF1G8UeFVbOfglEgfNHge082uHU3G4lkllJXMPNyw61GQ98Q6A258+namBYawfOEg==
X-Received: by 2002:ae9:ef56:: with SMTP id d83mr22017290qkg.83.1604436455833;
        Tue, 03 Nov 2020 12:47:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j17sm9610007qke.49.2020.11.03.12.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:47:34 -0800 (PST)
Subject: Re: [PATCH v9 38/41] btrfs: extend zoned allocator to use dedicated
 tree-log block group
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <6640d3c034c9c347958860743501aff59da7a5a0.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eb8f83f2-fb59-2b65-66e2-18cd0ecd1e02@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:47:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6640d3c034c9c347958860743501aff59da7a5a0.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is the 1/3 patch to enable tree log on ZONED mode.
> 
> The tree-log feature does not work on ZONED mode as is. Blocks for a
> tree-log tree are allocated mixed with other metadata blocks, and btrfs
> writes and syncs the tree-log blocks to devices at the time of fsync(),
> which is different timing from a global transaction commit. As a result,
> both writing tree-log blocks and writing other metadata blocks become
> non-sequential writes that ZONED mode must avoid.
> 
> We can introduce a dedicated block group for tree-log blocks so that
> tree-log blocks and other metadata blocks can be separated write streams.
> As a result, each write stream can now be written to devices separately.
> "fs_info->treelog_bg" tracks the dedicated block group and btrfs assign
> "treelog_bg" on-demand on tree-log block allocation time.
> 
> This commit extends the zoned block allocator to use the block group.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

If you're going to remove an entire block group from being allowed to be used 
for metadata you are going to need to account for it in the space_info, 
otherwise we're going to end up with nasty ENOSPC corners here.

But this begs the question, do we want the tree log for zoned?  We could just 
commit the transaction and call it good enough.  We lose performance, but zoned 
isn't necessarily about performance.

If we do then at a minimum we're going to need to remove this block group from 
the space info counters for metadata.  Thanks,

Josef
