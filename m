Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4C52506AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHXRjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgHXRjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:39:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153CC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:39:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so4137214qvb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RilyBMZb6TJ16yywQ9wg0q9ccrrb02c+WHDeAy1IS68=;
        b=Hw5PyTyX4Tx/uaL4hGqzTwd13Dk6agD4W/pr8wyAtOwr5FP7WxTdWJwvMsjVNxkm7C
         41+mu7ISYBA+YQuF+xJCWC0QzN3t/Dff8NYnyGf82eG9fVCCAvfIrT/OiRr+x7nyuat+
         rvZtCdrAsF4WjD4Rzx5qIkpWtks6kjWp6OgDTXG1HAbzqW7msMKTniyHJtIsqY/G5e4q
         X8Vj7LpYkTom2+PXU/t4Jz0YQ/uUD088E5Vp6lVuHQ+UbSa7828LpWnW19QDX0zlNQ81
         UPbRTY7mdJfWFCgN7cm41nOEW9VQgcrvccyQgTejTqQsTcJt26EFyZHPxkSXshCEcE8n
         wxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RilyBMZb6TJ16yywQ9wg0q9ccrrb02c+WHDeAy1IS68=;
        b=pNx6vh6CPwjMNq7i0AxpRWHrWdyI4A2Umj2INLqBHDAu4aO5jxriClW9mFWreyj1R4
         bNLyLcGIsQsAT3MD4Umr9RiKQqRznpPnEOKB35dP8LaohwO8lBlX3O8JMpvhSUik9D/k
         TLQlTIClvsyoWGXx94GI1z+BZuGVd33nLmBbmq5vAkvvwTtOX0/DL4bzmHwABT9jG5AG
         iGbE/6zpJE0BmqDM1gp12ZuYJc8pbb15qX/NOXNMRhJyU++1VkOMB4dM8BntjcG24F0B
         4FGpIV9pKpPBC1y9fwuj9Q8gE9lswyiU8v9ELGEvVu6tOFAKY0FcrwVonWWzg1N2qA24
         zZag==
X-Gm-Message-State: AOAM531Ao4BqXMcydIX13xi8ARW6Zt8DW3qAmbMacxkf+gt3LlCpjFwY
        74w/JM1jCp13oM2YBL898MwvEQ==
X-Google-Smtp-Source: ABdhPJy1Wleo5/1Zh+g7nwB4n37bgTMzGd5R+K7bGx/2jfvzQMko146F4SEE1PYRWjvZa2N3pLflOQ==
X-Received: by 2002:a0c:d981:: with SMTP id y1mr6011397qvj.124.1598290771416;
        Mon, 24 Aug 2020 10:39:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n4sm10762390qtr.73.2020.08.24.10.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:39:30 -0700 (PDT)
Subject: Re: [PATCH 1/9] btrfs: send: get rid of i_size logic in send_write()
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
 <16f28691ff66e8aeb280532cc146c8ee49d6cda4.1597994106.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ecf2245e-a488-6f2e-9e64-ff8cd81e025c@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:39:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <16f28691ff66e8aeb280532cc146c8ee49d6cda4.1597994106.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> send_write()/fill_read_buf() have some logic for avoiding reading past
> i_size. However, everywhere that we call
> send_write()/send_extent_data(), we've already clamped the length down
> to i_size. Get rid of the i_size handling, which simplifies the next
> change.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
