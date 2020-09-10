Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9DF265015
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 22:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIJT7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgIJPC1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 11:02:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B8AC061757
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 08:01:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z18so3485416qvp.6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UXwVIQMANUiXfwYmgVBOM+Gqp5W2riMQlwGg0y5YP4U=;
        b=E3eSJiTSvkSUJsjlXOBJXf5h/DDazzVO8FI+c/3UVDftPaYhlh1SCHK6Spjj9fx+ra
         KADQIf+ExUfvrmPxmBfZX3YDWBUeAGfjUf9Z2RpLOTUgBzGQwLbyDjOT1r6gda6igJds
         5MNd7CJko6flDJdyhsqBblKJRazSCwPTCXzY79Ri+kI+EnTdcBNYtgYeXIbDMKwkHTB3
         KPybdna8we+CUvxBiLtJJlwE6IfyQzg1iVNpPBjNS45TghC7Z8jclONjGSKBRDbL+kZm
         O1hhWP8kHpMChibr6PjshLeHQflkcCW944qqxQXSMAe+fN5ynABxhy9/YMm2SJb+fCvn
         vckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXwVIQMANUiXfwYmgVBOM+Gqp5W2riMQlwGg0y5YP4U=;
        b=aBN8SGSevNd3QUmKvw1tbDSqnvvxaRxromFz7SO07NE+lGk3j0V0a2YF2UOgLwsnd4
         S8dpPwBTxe0zYWTJvTfsS80kAxp7NE5gqWt0Av0a53ll87SVptf/1XG/NqkMvky5lcKp
         9hyl4HVO6T1Wbye713dLR+AH6DEO7eXrlARgligNRUlSiPRUIJkdCjmaf11Q9uAVjvbc
         B9ofQw8i8Q2RPZ/llq9NtnEoTbhmRTcuSdOvm3e/YSCC2N4DaliavkjYEflLsToSbiQb
         rpHIn0Ey/s8HInM9krHb6rZUvE6PS9oJiuquOaHfWug1Mt0UGIB/dK4LSB872X5sXKYp
         EZmw==
X-Gm-Message-State: AOAM530azuCXoLyuhConR5sf/4UIyW+HwNjALEKivTpIwmA0ukfndPTC
        wNtuqNPiKGOP4tXdKfZno2KQFOu4HO2dE0KD
X-Google-Smtp-Source: ABdhPJxMnm7DNTwrgkYCDja88lkgFLpcxzUABNiAoTwsAJ1MdHULdvdTM6SP1L659Om5IKAtdPEdmA==
X-Received: by 2002:a0c:b21b:: with SMTP id x27mr8989811qvd.12.1599750108990;
        Thu, 10 Sep 2020 08:01:48 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm7472510qtg.51.2020.09.10.08.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:01:47 -0700 (PDT)
Subject: Re: [PATCH 07/10] btrfs: Promote extent_read_full_page to
 btrfs_readpage
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-8-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <549e94fe-22b6-6e2e-e759-24d067d96c62@toxicpanda.com>
Date:   Thu, 10 Sep 2020 11:01:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-8-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:49 AM, Nikolay Borisov wrote:
> Now that btrfs_readpage is the only caller of extent_read_full_page the
> latter can be opencoded in the former. Use the occassion to rename
> __extent_read_full_page to extent_read_full_page. To facillitate this
> change submit_one_bio has to be exported as well.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
