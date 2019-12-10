Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830D3119268
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLJUrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 15:47:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33027 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJUro (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 15:47:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so9708499qkc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=brfDeAvapVs1IWQAYvqzmBX7BVOnnV+rFYp3VtF2OSA=;
        b=I5QEypMiWNt3ukq/J3p83EeOyM1WrwFB6VFJj6VsPiz4PgM+VdvTJA6SgsjrzlJ1Yq
         JgFZT4iDSRXBKeSckqvePdZzu4QUiYtiKckF4bT2pzjrjk7gn6RqTXONfM1pN211RrXJ
         J4MjdhgEuEylmBSl3VUWNNZWyT152HhqsfEBylDYc7qJk2Fo27BmgPHtT4OS1A9P1Fyv
         l+Mr6EtqGhNAAitsTlgnZ83NzVhV7WHDSTWmlAQ4Pjt0b73Tz92q5t3t+db52qXM++aO
         oCg0ZnqEXDvkwomCM47pV4+pn9SK4Ak0JY8R6xM6kedPVicXd1e6E2q0CoHm48ONVegf
         iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brfDeAvapVs1IWQAYvqzmBX7BVOnnV+rFYp3VtF2OSA=;
        b=VXLYCtJIiJH9rCTBjYj3oogCbHQAzkiQ5YEwa+vJUNuUXT8m0CTQsDNjLDJFI3Z1PL
         ENVj4cjDReXfWqWzt0X1va1yVzpbUwGccBxrac0WgI3B918E7hqQ1VgzVOB+ZtcbMkM1
         JXp+tJGKFFmbYT1Cff2QSicnnqd8RbZH9QXjbjk1/ek2GYvHpie+O+U6GF2twwWH/YtU
         7oxCTpo5d0Z+wghySoj4Ggstu1yG70ntTO0WzL+Klu4hu0vbvT62V2MFSuYZbKRgIc/t
         kxiBhPeLJLG34QqUwMmTbhUH/dW7BaLxG4Vcuc9ASdOl/9vcSWOLe1KmJ0xXtDrJtnqL
         fYdQ==
X-Gm-Message-State: APjAAAU8eN04oPayvhg0JaaGavvfnJ3jYNJZf7dqt865LLGjDsB16RlD
        Pxpk6cEkyOQSCFkxHf/phKvhbw==
X-Google-Smtp-Source: APXvYqwuOeJY4G/7Ncu0F/iN/4LvvesywqyI7RFGsixjVMyTieOnTgWzsky/fnnkJV85WxRfXcfmXg==
X-Received: by 2002:ae9:f003:: with SMTP id l3mr3880877qkg.457.1576010863399;
        Tue, 10 Dec 2019 12:47:43 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h32sm346951qth.2.2019.12.10.12.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:47:42 -0800 (PST)
Subject: Re: [PATCH] btrfs: fix format string warning
To:     Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210204429.3383471-1-arnd@arndb.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <215ae20f-7528-6866-bddd-65ef3f73abe1@toxicpanda.com>
Date:   Tue, 10 Dec 2019 15:47:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191210204429.3383471-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/19 3:44 PM, Arnd Bergmann wrote:
> To print a size_t, the format string modifier %z should be used instead
> of %l:
> 
> fs/btrfs/tree-checker.c: In function 'check_extent_data_item':
> fs/btrfs/tree-checker.c:230:43: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Werror=format=]
>       "invalid item size, have %u expect [%lu, %u)",
>                                           ~~^
>                                           %u
> 
> Fixes: 153a6d299956 ("btrfs: tree-checker: Check item size before reading file extent type")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
