Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1320815C29A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBMPft (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 10:35:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43803 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbgBMPb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 10:31:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id p7so6027102qkh.10
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8F6/huWpEjMmTpZmLnALCncdUUWSazxZLlRF3iqnI54=;
        b=k5TTuP6JzDZY4y7f5wQwhoiAW+VFfTlKD++jxYjb7FgbPs1LjlHw6N5G49hScBEn/B
         iunbl1XdDTLEZZHT9kZKWWDEzpnt4tLnwgYvi/zeVNY9elkyfiJEpeAUmPHqj8HkQBTz
         8zHkppNz9f6kLSm4DWPVGMGsdLSQsw6a9Q0rQYxO8XwJTr0uJkr1gm5oqXarajGkPf1L
         CEVu73Q9cA6Yn7C1p9ZTtKuMhXA/kqGM/RkZzEZzRV7JElDMLE6I11kva4343pYH6fwH
         K1lNxJXUfzxR0G+1mkbCHLlkwAFBaOeVqhVUrFEwSo3Q9D6sKYHSuNIYQB6b8es3WI/i
         KWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8F6/huWpEjMmTpZmLnALCncdUUWSazxZLlRF3iqnI54=;
        b=ie/FaecGYelypvQ273l7BzQDfA9FRpcA9BKJpRtdOQ3fsCMI2P4/h+GCUb0jEAjPgd
         CJZriDE8I4mcZ4kfY80VA3U6XxDPhvMQS5XZPIVvJWQIMZz3YCqYNl1zS02RTbY4mM26
         yes7drdEVjtDnd772sJWsPlPQ2RIIM/REnUtcRf35L704vwLHPBeQVAONXlOVM9y1fRE
         ZKFwh0gZ8Y062CbRCr54wcSObZpMaWG7VR8ZFVIssAO/UDi0TUKgxQLBYfT/tFJZjfJo
         f1JcaXD/qx7uUc+2SkLtZ9MW6YVP2FYnMOF4mSFDUpfOF1McTy0vST6y9D+G4F3X3pJX
         azDQ==
X-Gm-Message-State: APjAAAXpKDHgv9PLXnH9/qosQ7s/EXCjVas1S6R8IUKY/HQrtCkeEv2y
        sbR4CwFfRVhqqqQlMMlDa7/iCqg/rAo=
X-Google-Smtp-Source: APXvYqxL6UaqfhOSR2vhLAuOmojTSYL9w1922MxLFIz5YBO8XC0NwgvMxEkA+crFDHwvIJi4a8HYmw==
X-Received: by 2002:a37:de16:: with SMTP id h22mr12634717qkj.400.1581607885101;
        Thu, 13 Feb 2020 07:31:25 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k37sm1710575qtf.70.2020.02.13.07.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 07:31:24 -0800 (PST)
Subject: Re: [PATCH 1/4] btrfs: set fs_root = NULL on error
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-2-josef@toxicpanda.com>
 <e1ec6363-0b6e-bfbb-5fde-f2824d758d20@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ca02dd70-3332-14e4-0719-09f75cad499a@toxicpanda.com>
Date:   Thu, 13 Feb 2020 10:31:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e1ec6363-0b6e-bfbb-5fde-f2824d758d20@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 5:48 AM, Nikolay Borisov wrote:
> 
> 
> On 11.02.20 г. 23:40 ч., Josef Bacik wrote:
>> While running my error injection script I hit a panic when we tried to
>> clean up the fs_root when free'ing the fs_root.  This is because
>> fs_info->fs_root == PTR_ERR(-EIO), which isn't great.  Fix this by
>> setting fs_info->fs_root = NULL; if we fail to read the root.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> 
> While looking to see how ->fs_root (git grep "\->fs_root\W" fs/btrfs) is
> used I realized we almost never query it through that member. It's
> cleaned up via the btrfs_free_fs_roots which queries the root radix.
> Given this I fail to see how the presence of a bogus value in
> fs_info->fs_root would cause a crash (it's certainly wrong so your patch
> per-se is fine). Can you provide an example call trace?
> 

We do a btrfs_put_root(fs_info->fs_root); in btrfs_free_fs_info.  There's for 
sure an argument to be made for getting rid of fs_info->fs_root, and just using 
the radix lookup.  Once all of my root ref patches are merged I'll take a run at 
that.  Thanks,

Josef
