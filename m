Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D081715CBA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 21:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBMUEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 15:04:01 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:34526 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBMUEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 15:04:01 -0500
Received: by mail-pj1-f49.google.com with SMTP id f2so148634pjq.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+YLDIGV1EDCG0aXSQd/7YRwVOIowrm7elS8qBLVtRuU=;
        b=12h/K0VXeLDvcOe4HvJbeBjLEKUmOkcCw8LQvjRhQUCdpMS7k750vRbMhhrFgyKbhh
         9zlLoxcYEfrInFOZ1AqXyp2fnUxIot4Qbv/7Q8EA2RrYbdBoBj5RcrjrRh4fBSeaowQ4
         1Z3WlG5dlIglbLdOlAyJebh1/BITG3+czXi2jK8MH8n7uJMcyZ0x5wH9tmtkRMSlOAbn
         k1DieCOmbOfmPsARmcap7I7tmdWulsz8rU5OSkQ6v2/ac2drG0kMRVnyPEYrLj5gSGS8
         m0UHtpFdgOO4SivzxjHJkdO1I+PThrR833+W6BTuBOsckcEo4cfuoo+XkRbRR/8Tido2
         ORmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+YLDIGV1EDCG0aXSQd/7YRwVOIowrm7elS8qBLVtRuU=;
        b=RuMwv87sI50x2/ylrRSqrlY1gAeFf/xeFXVaG4Y5QjnYb6U1Ti6gQ5gUFUh2wv8XO4
         jBYpE3zvml4wBKesmnAP6g5xQR/G0pJyDafIynnyRU0ctdaTH16gv9TaDaiBALQVkBak
         YJwYmBrzF71uksnDbXxeUjYN6272ryAvo0vf7jv23qIDxRq8GYtgUuoeF4rvwnmUYnWZ
         p343MJyWEYv8pBbn3hTw6RC9QR5jWNP+iI4ZmY48y+O6btF0dZdYbAUADeBA0lSkOFcC
         mgQ6q0cpRfZ/0Bpk9UTHVbRXf1/eG59qvvU53jNlOdqIZuO6WTbrpyW0RRkc8cN+Kp8t
         xBaw==
X-Gm-Message-State: APjAAAUw94YToO0fqUXCrVws5rfyoVh8RqwU3qg80zuoE9ZvXoqEvuk9
        nA2ZUwyJ1oYFCEY5ZXecoSTIUUH47pQ=
X-Google-Smtp-Source: APXvYqzdh8hq2L0h2p2esWkHzGtfYexjuOWOoIm8YjzyuiJjLMROL1UxRelmFixH2PQq1q82Neb/rg==
X-Received: by 2002:a17:902:740c:: with SMTP id g12mr31469004pll.166.1581624240160;
        Thu, 13 Feb 2020 12:04:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id b3sm4032480pft.73.2020.02.13.12.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:03:58 -0800 (PST)
Subject: Re: [PATCH v2 2/4] btrfs: relocation: Check cancel request after each
 data page read
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200211053729.20807-1-wqu@suse.com>
 <20200211053729.20807-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c9f33ce1-3e9e-b12e-a510-610f8533bd6a@toxicpanda.com>
Date:   Thu, 13 Feb 2020 15:03:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211053729.20807-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/11/20 12:37 AM, Qu Wenruo wrote:
> When relocating a data extents with large large data extents, we spend
> most of our time in relocate_file_extent_cluster() at stage "moving data
> extents":
>   1)               |  btrfs_relocate_block_group [btrfs]() {
>   1)               |    relocate_file_extent_cluster [btrfs]() {
>   1) $ 6586769 us  |    }
>   1) + 18.260 us   |    relocate_file_extent_cluster [btrfs]();
>   1) + 15.770 us   |    relocate_file_extent_cluster [btrfs]();
>   1) $ 8916340 us  |  }
>   1)               |  btrfs_relocate_block_group [btrfs]() {
>   1)               |    relocate_file_extent_cluster [btrfs]() {
>   1) $ 11611586 us |    }
>   1) + 16.930 us   |    relocate_file_extent_cluster [btrfs]();
>   1) + 15.870 us   |    relocate_file_extent_cluster [btrfs]();
>   1) $ 14986130 us |  }
> 
> So to make data relocation cancelling quicker, here add extra balance
> cancelling check after each page read in relocate_file_extent_cluster().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

If you respin, can you note that with this cancellation we'll break out and 
merge the reloc roots, its not like everything will just be left over to be 
completed at the next mount.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
