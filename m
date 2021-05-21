Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85838C854
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhEUNj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhEUNjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:39:23 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93169C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:37:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y12so15212069qtx.11
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E4BKSmNOWbJG+DTd86qZ3FR9HzLL6TaAGZEC6D8iIfU=;
        b=S4W57a/reGZl+lgQqPpSEb418IuPI81aW0ZLhYI0Ttwu07v85VBj5+GoOqY0FbuRYX
         cknJPzofXKOjwh0Pk+Htvwe7fYiinQjxB5AhFSubjofdI9+ipAn1ipIDiaJQSnQeJq3E
         7cxtmQiokczBlZR+wfWXVQ9RqK3VZW2Ek9z3UQ4rG3FqSpKHCDqRbyA/oonQ/wZmxruS
         cinV/ihaXUMLbTXViKXmbbVpGDrci7UYkCmpddd7qUrtNRkxk3mzPtc60aEBNwP6JhDp
         br865PDL/FmrLe/JG0Gi5OSWbuUNS1bBMgRc4vXdBgXf7i9SZXezODnoWuVybk1Jm+G5
         KlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4BKSmNOWbJG+DTd86qZ3FR9HzLL6TaAGZEC6D8iIfU=;
        b=GZbMva2iPwei4C2gdDL+kGK8/X55vj3S6DosQLYTbCawNQECvXAtuzfVRVOtvPRyEZ
         Fmz6D4gmeYqf5kTh5VKZ7rxd9srIwKfVtiuLdOj+j080I2O4ylIeFmPnHDpkQzIBEfPX
         LrSEPvFlTU09omK2/gIsupHu/LMuhhb8++r76wLTHy+/bZ8hvJxMiLgr/oXZAxQiP31I
         boFoDtyGmoIg1lSONPmCtDhwMZ/KH7lXSIvpL/qWKt15QWMQRYd5NhR8JkU3gVnIvtV+
         OwHab9bOCzZhxgWWhmheXFDu3A8UlS49AvHGsEpOskxKCNEb5bnWv2RI8+sUe4DfC6Jq
         LGPA==
X-Gm-Message-State: AOAM532FEX/pLD0oLiyokMdsQh0e8bR3x6OasjrG+Xok9QL/0CN2YdNe
        A81AQjeRPvi3ZwgUWjf1LBcl/cIQVkJRfw==
X-Google-Smtp-Source: ABdhPJyRFh0znte/L7fDLuNdYyA5ey9fkkIoKOT6N/6jXMoX5QNvXnlDv/8/Wd8JpvP9nR65ZUVALQ==
X-Received: by 2002:ac8:7503:: with SMTP id u3mr11299509qtq.318.1621604278454;
        Fri, 21 May 2021 06:37:58 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id a131sm5054340qkg.99.2021.05.21.06.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:37:57 -0700 (PDT)
Subject: Re: [PATCH 1/6] btrfs: protect exclusive_operation by super_lock
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <27c5165b8de26ab98948c0345de3f8ddd955c388.1621526221.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <46481e34-958c-c055-a23a-45ded5cf4097@toxicpanda.com>
Date:   Fri, 21 May 2021 09:37:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <27c5165b8de26ab98948c0345de3f8ddd955c388.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 8:06 AM, David Sterba wrote:
> The exclusive operation is now atomically checked and set using bit
> operations. Switch it to protection by spinlock. The super block lock is
> not frequently used and adding a new lock seems like an overkill so it
> should be safe to reuse it.
> 
> The reason to use spinlock is to enhance the locking context so more
> checks can be done, eg. allowing the same exclusive operation enter
> the exclop section and cancel the running one. This will be used for
> resize and device delete.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
