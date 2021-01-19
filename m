Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281942FC041
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbhASTmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 14:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbhASTmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 14:42:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C68C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:41:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w79so23061341qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=USI8gMqnOEP0NPOyscXOLLNBZa4yOXJQZOYn2OaTh1Q=;
        b=Xn/SYXuESn9TuzrTpkwqy0KF9mQlYPm/gABp230gAnCZj22Ouka/pWdRhg7kHKHWWf
         oz5hm+D0rUa7a6peP6K2LiFloZY81xxXidSuFlIRtCyCCVwuzUcqmtcCLbaGYP3Ib/pt
         6jcO4sGAGN/Qv0j1FSmANuu4Yv/NVH0xKWnVr+u4nf8N2phM+K8xW/zqqByX3/DHEVPV
         8cjyQMsYUlIfxR27wbAFOG48xOwwADlAAfeKk/dN1VWfj6X21IbaBCy6e0JMJpVNvwMn
         1UGU551IACSOgv+Ua3R2Q7UyTFcigoTbocXDwQrIom0Jt0m9QGmU3LQLT67TjIDR0JpV
         Mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=USI8gMqnOEP0NPOyscXOLLNBZa4yOXJQZOYn2OaTh1Q=;
        b=tRCoX4nGXBO8E9TslQvu2zc+Z+//sZdPHCYt+fe9qebQRDa5MLYLC4BysovvbXuxEc
         kqbSzNZJSr1ibYD8Nim7IW9xCzPlJgKK6FDxDJZ0v5/yYVwL8MbwjxP+gjQczr/T6mZo
         0+t2Mdppox6+PpYo94MhQm77j+DTnKfdOQhyr2b/OhVinKy5WDU1gO1WhlSEusQlj8Gn
         zwHoch5FEJg6lVv/FvK5Hncco6gFZCjE6sAsULurobafnh6GUfk72pi8P1Kn+jX+O5Vw
         PE0dCWgTI4i1vB2KABlZEzJwGjq8iHdhGTTVxXBI7jthEBgbCA+oA/SQsjPkcSBcv4E8
         OiQQ==
X-Gm-Message-State: AOAM530KXR6pLl+KRt6HziRdn1i0d2kRyklhhSS9IvtwAQTvzW+1F13S
        jKFSMdfyMgHu3TCQc43ha0TVdhZ6tXZtlJNdvbk=
X-Google-Smtp-Source: ABdhPJwgT474ZlHCiLLeRzU9doYA7RxaXdu98dhPwluQjnv88ZTOTVvdaD7GEXWPMvb3CIlUtlcy1Q==
X-Received: by 2002:a05:620a:80c:: with SMTP id s12mr5864833qks.248.1611085296139;
        Tue, 19 Jan 2021 11:41:36 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:a066])
        by smtp.gmail.com with ESMTPSA id u65sm13737141qkb.58.2021.01.19.11.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:41:35 -0800 (PST)
Subject: Re: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <8e0afaa33f33d1a5efbf37fa4465954056ce3f59.1610324448.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b0cf6a1d-bd50-dbd5-ff8e-d24ab547e57a@toxicpanda.com>
Date:   Tue, 19 Jan 2021 14:41:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8e0afaa33f33d1a5efbf37fa4465954056ce3f59.1610324448.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 4:41 AM, Anand Jain wrote:
> Add round-robin read policy to route the read IO to the next device in the
> round-robin order. The chunk allocation and thus the stripe-index follows
> the order of free space available on devices. So to make the round-robin
> effective it shall follow the devid order instead of the stripe-index
> order.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> --
> RFC because: Provides terrible performance with the fio tests.
> I am not yet sure if there is any io workload or a block layer
> tuning that shall make this policy better. As of now just an
> experimental patch.
> 

Just drop this one, if we can't find a reason to use it then don't bother adding 
the code.  The other options have real world valuable uses, so stick with those. 
  Thanks,

Josef

