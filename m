Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48C135B3A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 15:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgAIOVG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 09:21:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgAIOVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 09:21:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so5949431qtq.9
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aCWyEQHuCSmYBYYioy4T8O0w/EjGBe1CcinkqYBtKgg=;
        b=vEQal/Cre4tYwMPKNnyvz11nAkCm1E49bdozPsuC07flx/qQ0g9A7cB/p85AESv4cO
         wZBdECBHOO55ZNQ7ZDucJFm3ocRGeKTeLMqj3bR3X99WODVx+tjU+MzwH2ugadqktD7T
         LX4H/kF76CfP8UfLM6VlZGU47SnO2MdUkWxEEVnLv2+uv0I0VSGAxYhSQfmgjEp+5czz
         Qjf2UG/5slLhx+oYSdCsS0JvVILFCa7ZIsMGCmU6//KgVCxk+HQOJ6v8Ka6m5JGuOQQi
         zy4T1uSAllo4Iro2s0T/Djrg6TnDnkyIHd03EBpTBKT0jTgG/INE37qxjNgHwpkGf0Zs
         xSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aCWyEQHuCSmYBYYioy4T8O0w/EjGBe1CcinkqYBtKgg=;
        b=nPmyYpO1u9CJrJdexSRtjRX0eQ9GOregQoyDUYAG+xB2ILJGRPr8zKUFeSNzL1dNt3
         laT0W4P+hNB+MFqTRBizCl1HWnKoxlTZTaOz6DAL1lxfwtaMi/EY5F8MkN/gMbcYewgl
         zmxJDdltZh6ANsgaKQSm5ULZQNH3vLUva/QyEox7T3pJmQYI7cjXrO5bA6VAYRt5VGQD
         ocqAPYy4eqSAA4x3Yqou5mHgd0EOfbopUxoNvnEJBGYskQ1h/CwrIwruDcnQUD351L0Z
         NB8aParc4lrHupHdacB7HhcFngkobP15e61RjB6a1xeeORVNC7R8XPc8lF4ZyuWJO4OV
         8acw==
X-Gm-Message-State: APjAAAWK6TdDUTYIMclJH+0onGd6a7tmyPFUqJ3nd36QtZF33A2FKK7q
        sTRM1VjcV2WfScb7Tf+qnD2MeYVBVn1nlA==
X-Google-Smtp-Source: APXvYqylZe1Xguv+P5QB3RFrVXG/mJmPeiw7T0leUFAM9FXIOgak5/0qTxzG2ATQUN7urSCI9CuAvg==
X-Received: by 2002:ac8:3853:: with SMTP id r19mr8317944qtb.69.1578579664948;
        Thu, 09 Jan 2020 06:21:04 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o9sm3146010qko.16.2020.01.09.06.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 06:21:03 -0800 (PST)
Subject: Re: [PATCH v5 1/4] btrfs: Reset device size when
 btrfs_update_device() failed in btrfs_grow_device()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200109071634.32384-1-wqu@suse.com>
 <20200109071634.32384-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <69c68e8f-e2f0-0ad9-5c3c-3376246322cd@toxicpanda.com>
Date:   Thu, 9 Jan 2020 09:21:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109071634.32384-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 2:16 AM, Qu Wenruo wrote:
> When btrfs_update_device() failed due to ENOMEM, we didn't reset device
> size back to its original size, causing the in-memory device size larger
> than original.
> 
> If somehow the memory pressure get solved, and the fs committed, since
> the device item is not updated, but super block total size get updated,
> it would cause mount failure due to size mismatch.
> 
> So here revert device size and super size to its original size when
> btrfs_update_device() failed, just like what we did in shrink_device().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Did you test this with error injection to make sure nothing else wonky came out 
of this?  If you are going to fix this I'd rather it be in a different series 
because it's not necessarily related to what you are doing, and isn't any more 
broken with your other patches.  The thing you are fixing in this series is 
important and I'd rather not hold it up on some error handling shenanigans.  Thanks,

Josef
