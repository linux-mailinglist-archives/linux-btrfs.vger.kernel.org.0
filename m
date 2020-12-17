Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0573D2DD333
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgLQOpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgLQOpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:45:12 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF4C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:44:32 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id i67so18998738qkf.11
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dRjS/SzPBIxFE+JBd6voANsrrjtdQyCItcADll1H0Zw=;
        b=AO7PNY3yz9QtqInMET7uOq1e6fwlv5tdXdUf1UimRYCczdJ96V7EI9Sq9Q6HpU69Ez
         89z1LTSlAmvUqvWsDYAMogIxWe3ql262cilH99uDKpGCEtxkkEVn/ZZ2nxU9S2CxcDyZ
         G5YK0tFCISSvYqbq9g99UwWm3ltP96mVmCQSzUnZsQaK7+U9DaWzKXRAXrAe7QVvZP53
         +KU1p/9Ss2Rys9i62rYPVpoNmiX1xCkBQ3UxGOP7SLR2uisD9ufheEZkWFvtVTkHWr3H
         +VDp/XAAj9ruaK9Ovk5ECSqPeVDK6E45LVw/8+vTNpEN9dH/rt7LAwXZfRrPxfvtUgdF
         E0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRjS/SzPBIxFE+JBd6voANsrrjtdQyCItcADll1H0Zw=;
        b=hoxGyP6fPJMmMFIzi9xc/ynd3LqVw57TCBZ10nucNI7avht10bX6389SYYOHVxY5rV
         HLNRoMbFioC1XFmoXIvqHHqXkr3spbyjeH8T2nF6Q+WdHx8tefwAnOFBWLl+uOFnhWF4
         r3v4rahbYk+bpLa66PhMlvEEu2I87XeE1YnFPDohqZfF6VvsFpXITJOuuoRYAALBcdge
         021W9WxryXBkdIwG6b6wCuXbTe3lEiUZzxjJcSKycfSL3CqisU9eMaHxK60lffJ8Jrtg
         /czNTB+XxNmaLYu9zTm479JqKwYL35huC9yf4duIereAyBhPkga6sKhflQqhEBwbfcVq
         c6iw==
X-Gm-Message-State: AOAM531oO7YI9oafedXfuAC6tE+VblnkhU0BXz0mc2iQqaLkIYeSgE2R
        nnndxVf2qaSOqxOOlAMlYkpXSkOj4WE1r+mh
X-Google-Smtp-Source: ABdhPJyQtq0XhtnZgXgVqnJEOFKQ9OdV7+r3JaOKDX2wmf2Y+bRLG62O6DBajQxa2eKSnRqXxS3c+g==
X-Received: by 2002:a37:6c03:: with SMTP id h3mr50065162qkc.219.1608216271620;
        Thu, 17 Dec 2020 06:44:31 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z26sm3236073qki.40.2020.12.17.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:44:31 -0800 (PST)
Subject: Re: [PATCH] btrfs: Consolidate btrfs_previous_item ret val handling
 in btrfs_shrink_device
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201217132116.328291-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <911d913e-fa0e-e98c-8a34-50aace475b7a@toxicpanda.com>
Date:   Thu, 17 Dec 2020 09:44:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217132116.328291-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/20 8:21 AM, Nikolay Borisov wrote:
> Instead of having 3 'if' to handle non-null return value consolidate
> this in 1 'if (ret)'. That way the code is more obvious:
> 
>   - Always drop dlete_unused_bgs_mutex if ret is non null
>   - If ret is negative -> goto done
>   - If it's 1 -> reset ret to 0, release the path and finish the loop.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
