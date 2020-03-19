Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20618BAD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCSPSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:18:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42626 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPSu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:18:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id g16so2079578qtp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+apOdkW78KcQVxWtkfxuqW1AkQfi9YYdOpwPEezHCK0=;
        b=WdzhFF8/Q73pF6fkuHFo+hRM/mxc/JTm5ZdeFwaXBKGlDEp714fquw1r9sPM52LLuf
         DZGfAX4YmrjzBM9/t82QhAWVMITv/b5mNoFhWqY3SOpdTyyrhKzPKrEExLZ/V9BiCkGr
         2Xy4248CYYwQGPc6H4b0ksvQFQ0eTG9PXv/1xDLTlNyPeGgikMIspUzn8AwIQBdsj8EY
         ppDTGD8GyPmT2rP8OdFy9balgHkpYCoeQ7L4A6zvTgIB7sfUKUJjvI8lTnUaLhXhV22J
         quihms1NbDZZOqZ37BAZvMA1L8S3Bv0uhqCsktU6qx8ghEDs6b4mtU1aH2s84Qa55jM+
         vjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+apOdkW78KcQVxWtkfxuqW1AkQfi9YYdOpwPEezHCK0=;
        b=ihXsacpOKfBBhEyae/L1r3yzOdt89YTyRh00OS0rk1bWZoLIv/fZSgmubjJBGDnyI+
         JZncajBi58rQ7t1zjiD6QYS5BZe1kyg0KB+LuLik/yKnxTqGAM8uG/UI9bGrs66sNA7a
         Ei/yu2UzFWuMcSUhC923HA0+B7scLHQHa4WHGjBshqc+mQ4D9JlqrBMr8mAYFGmmsLi8
         FweoHes3p46RcV2bOPwPEDDPzCspslpuEz5NnfRDXR3pJWUBCEJdSkB4nVPwH7k+8OVv
         ufWuoDbVvecwUwVGvWMp1szFiNCwGMfl1CpmWl136cC6vgfDrKOL7abDgGKQFJGPlMJI
         /IYA==
X-Gm-Message-State: ANhLgQ3uAQ3wVO3zepYouvtTgcC1JRhGoWK2dvh02YQo/chOvbIBvfzg
        eBslKQ++Skr0GPNfcctGbVfTiQ==
X-Google-Smtp-Source: ADFU+vvgs42/nNeGF3dQ2QauaXFnMgK2fbFtpr4j6uvkfprJh4Mp/DoOCoFkdO0IodXJNKNkLzAzlg==
X-Received: by 2002:ac8:7956:: with SMTP id r22mr3438790qtt.282.1584631128238;
        Thu, 19 Mar 2020 08:18:48 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s2sm1709848qtn.84.2020.03.19.08.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:18:47 -0700 (PDT)
Subject: Re: [PATCH RFC 04/39] btrfs: relocation: Rename
 mark_block_processed() and __mark_block_processed()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f576d5a3-0de7-a7ab-c6d7-a28653d89929@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:18:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> These two functions are weirdly named, mark_block_processed() in fact
> just mark a range dirty unconditionally, while __mark_block_processed()
> does extra check before doing the marking.
> 
> This patch will open code old mark_block_processed, and rename
> __mark_block_processed() to remove the "__" prefix.
> 
> Since we're here, also kill the forward declaration, which could also
> kill in_block_group() with in_range() macro.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
