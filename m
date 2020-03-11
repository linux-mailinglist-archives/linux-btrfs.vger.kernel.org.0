Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A31182067
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgCKSHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:07:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41228 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:07:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id b5so2991378qkh.8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jci8BtT7DsRqTJwWKYtjEdW8iO+J6Ezqihfo7hupte0=;
        b=wylegr7+bKDEuupvDZ+5fCsjp6zg9nW/NICQFEx/RjXPztHL7NhteoDlIsbNAqhuW1
         OdN2Ro4oMtJ4a7dLY3m490RhjPPTSosdzgkbueZOgWeR7qFIIts4K8WwuKf9KD05WiJs
         rebyEw4OLwFXySk0hkChCsgWQdKUIysA71P0Uz/m+OBxzZffK1rct+rU+++A61iHYUBq
         drpQwIyUvDo960V/x0PUqI5Uyhq11+1EsetmSCztV4kQv6rr1XW4lhJ0rBYiWH69PmzO
         qOh/J9Z4pJ1kN2IAKD82Rrh9Y0aGM+v4Zf0wKflYks+icQyEa1OZ0aUaXB1HTFDcQtv3
         NqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jci8BtT7DsRqTJwWKYtjEdW8iO+J6Ezqihfo7hupte0=;
        b=Lxraj/7zNomgfJcWfKgcP0cxzqDt83YkMN7LBnN3/oun+hyAQckRXwIEvBdAKnG/8X
         +hPn4mQOQ3+NGKdoM0CWXPlCjIn9AUFPXJcA9zXRDeXf6iyG+1e3DdXfA6LzxTswdKtu
         tdvcO0TSeDLRrBRYUPmncig8TNTpaGK2Ev66LMzJhMswWRQ3Jiq5IAvj3XAfEAFxKL2x
         7eBF0vcKKFUFAiVLuwNsrJpMrT3iYtNtFI7LYDjJIkJ06QiKZ7ZS+GlW5r/oK3Yk2Ghz
         DTabaqQBkGxufr3HjgJZcgV65KuCXBiI8BYuSPF8K6O8LLfFPC2V4Mj3HxbvSph83qzF
         9xuA==
X-Gm-Message-State: ANhLgQ0jrcekq4GVgDjJMZ2vbEtWYO0elJBjt6Hc54Cc9BqgWO4dRdib
        j6X9yMpAE9acledE13rvqX3J6g==
X-Google-Smtp-Source: ADFU+vskd22QnNjAch13aYyLbnauqf5BC6uHHKzT+xArPx6ewLHr+er/5NPjZV0xqHLB+cH26dpM6Q==
X-Received: by 2002:a37:ef14:: with SMTP id j20mr3871043qkk.43.1583950070493;
        Wed, 11 Mar 2020 11:07:50 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p73sm7198169qka.14.2020.03.11.11.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:07:49 -0700 (PDT)
Subject: Re: [PATCH 12/15] btrfs: get rid of one layer of bios in direct I/O
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3a96cc47-c6ab-e2cf-bb11-4d9a73b7b46c@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:07:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In the worst case, there are _4_ layers of bios in the Btrfs direct I/O
> path:
> 
> 1. The bio created by the generic direct I/O code (dio_bio).
> 2. A clone of dio_bio we create in btrfs_submit_direct() to represent
>     the entire direct I/O range (orig_bio).
> 3. A partial clone of orig_bio limited to the size of a RAID stripe that
>     we create in btrfs_submit_direct_hook().
> 4. Clones of each of those split bios for each RAID stripe that we
>     create in btrfs_map_bio().
> 
> As of the previous commit, the second layer (orig_bio) is no longer
> needed for anything: we can split dio_bio instead, and complete dio_bio
> directly when all of the cloned bios complete. This lets us clean up a
> bunch of cruft, including dip->subio_endio and dip->errors (we can use
> dio_bio->bi_status instead). It also enables the next big cleanup of
> direct I/O read repair.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
