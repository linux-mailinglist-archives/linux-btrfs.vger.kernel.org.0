Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5549241FDC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHKSmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgHKSmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:42:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977EDC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:42:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so12591773qkb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=biUgBrITrrgneSDCBwjyEpigfSfAXIWn052iWOCvVHk=;
        b=y4kDXMAuAwdeDmo6Nk6LOUCY33G2XGlB2oI32JbaVUTyozZVN2Cdunr+GjAl6PQ751
         62y+52P3jIc0b7ZZ3XbAbpP54JP7nP8t74mtefTJGjLD23JIN7vF8WI/NMoN/8qPFP+D
         KDgibuuSg0mgY1c7NLFNLui95PhGp8YYoY48HcLq/+E/NsUWZjXxa1tlfiIHt6DCtpeG
         Mdm2BqxfDm9reQy/4mSMylzAJoplDpjqTIYgzEhvHXg2XlnpKE/ewRVadEkD/VqDthuQ
         hAqqgYkPeXgvPojzo187Rdo5KrREVyA17YGKIK5MkEwwfYG8zn6/kSkvsdlis+TdnBCy
         e5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=biUgBrITrrgneSDCBwjyEpigfSfAXIWn052iWOCvVHk=;
        b=C/nP5Lt3juh9KZRmTQf7argM9h4LWsM7x5Lfp0ffMEWzmM3LgijXE432mjkCGK6OO+
         MZ+szmynlHrTxKdzk83NyqyH86INIShhFREnsBYGe/1csCCDoQE+eZ+So8ZSxb+pxnpR
         UZFR3bpA9kWrPENKDjRJgGDD4FKMA8OxfkpXHdWfCbstfk0mk60wStS0Q/5C8GfTGKWi
         vkDZd6E/qnKOtb2bP7ToBHsbTjBPH4Zjor0HiIT+KN3oHQlAWj7TdgROfzB2CQ4IDHwi
         /lS1VYxMkKjA0hUDcpAjYKFSuBF42k9KcEoyvWtTT9ZHe2eNB0VGxIsubeJaZ429Wpip
         2Kjg==
X-Gm-Message-State: AOAM5316hgAddzap2G89CWIFQlaMSwndWkLb8zyDspBkQiFO7n5Ohyrc
        XFckkR7ETx56UqNAXZAxH+7/iKPlRVhI4w==
X-Google-Smtp-Source: ABdhPJwPzEMH28MAJtjDn74B7zYH+B9VAKMJNOTss9FL+bry7pghbjyRerRERocVkj7XW4hUYmG8HA==
X-Received: by 2002:ae9:e00b:: with SMTP id m11mr2442362qkk.341.1597171370519;
        Tue, 11 Aug 2020 11:42:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w44sm21598195qtj.86.2020.08.11.11.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:42:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <26d258e9-4489-df31-d919-a672002863cc@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:42:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809120919.85271-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/20 8:09 AM, Qu Wenruo wrote:
> Although we have start, len check for extent buffer reader/write (e.g.
> read_extent_buffer()), those checks has its limitations:
> - No overflow check
>    Values like start = 1024 len = -1024 can still pass the basic
>     (start + len) > eb->len check.
> 
> - Checks are not consistent
>    For read_extent_buffer() we only check (start + len) against eb->len.
>    While for memcmp_extent_buffer() we also check start against eb->len.
> 
> - Different error reporting mechanism
>    We use WARN() in read_extent_buffer() but BUG() in
>    memcpy_extent_buffer().
> 
> - Still modify memory if the request is obviously wrong
>    In read_extent_buffer() even we find (start + len) > eb->len, we still
>    call memset(dst, 0, len), which can eaisly cause memory access error
>    if start + len overflows.
> 
> To address above problems, this patch creates a new common function to
> check such access, check_eb_range().
> - Add overflow check
>    This function checks start, start + len against eb->len and overflow
>    check.
> 
> - Unified checks
> 
> - Unified error reports
>    Will call WARN() if CONFIG_BTRFS_DEBUG is configured.
>    And also do btrfs_warn() message for non-debug build.
> 
> - Exit ASAP if check fails
>    No more possible memory corruption.
> 
> - Add extra comment for @start @len used in those functions
>    Even experienced developers sometimes get confused with the @start
>    @len with logical address in those functions.
>    I'm not sure what's the cause, maybe it's the extent_buffer::start
>    naming.
>    For now, just add some comment.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202817
> [ Inspired by above report, the report itself is already addressed ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
