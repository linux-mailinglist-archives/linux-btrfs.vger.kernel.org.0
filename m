Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716362A99DD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKFQwD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 11:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFQwD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 11:52:03 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47CC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 08:52:01 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id c27so1633340qko.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jfpPPtgirsmC1cpI2lD2w0HZR5dgOEys4zOQywxpDgU=;
        b=JU6qyMJ6uQNLW+jzK3U8GibI6JIr+m2gyjTXw73A+ywXvsD8SIFXgnizp4xYtmZ7ya
         GVzw7u11OEaV3PelrQ+hRo/h+WwqYyhUfoV6wJWV3lNMIBGjqktsaUn2IDk0LX8zU7Zd
         RrWcqv3QubLmF/1MbOrnwHtS9Z0LtpkkVfL3zefmbyTaehHIJS39OGog6sUvCGkWrRQg
         QQ6468JK12Qa616HMvRQj2OAcA7y0uYEFfWwrkLUVeUx647TEuMwH1TqAArcxh/4VlfI
         A6vQYBbZSABVvh4OYiw3VtXFP3YTxaHzdiQwY/7dw33jq7MGW6iw+8d3lzlq4+M0SNa2
         a4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfpPPtgirsmC1cpI2lD2w0HZR5dgOEys4zOQywxpDgU=;
        b=UtM0U5kJowidDjjKFO5Yg2GPIS4hbUuNF2E88fcTvNNnsr2D/aJb4yXa0EvmMUhhd7
         CEMPTCl9pvcC5yUdKIwurJZR+X62Xhb24ZmDm/I1gna+xBLHmhv2nIDyTSEj4Y7nHjGw
         37XYnoFKHWYe0xjAHV260Ae7q4P20/ISAaKhQ252eZi8LXZCXxKOMBRdIDjNhPivEr1x
         gedIkfxZVaFOIk+ot70xTnWb3siL/7PDl/oPF6nYFIXYkVevf38YFxRgssujk6fjLMbG
         VbrNJhbuvMinywN/Ifo/9w49i83Gjrjf6ETMpT0aEav6DzfhJJNWE6DEG4Rk9gdgQ6aJ
         A2CA==
X-Gm-Message-State: AOAM5324qQ3wS118GUEXuaqazdMTXpoPIbhjMKCeBVsxe/NS5tsYMKO2
        1NVsd/mOiet7ENvGvd3Vqr/dBM1Iu4uL2NjJ
X-Google-Smtp-Source: ABdhPJwjdUmI7lt0Fo8GhLht2MaIuU55BYH0rZC1cYtf+/v7BZIWm9ATGhVHJjMidaLKSz3ggUTG8w==
X-Received: by 2002:a37:6697:: with SMTP id a145mr2523844qkc.296.1604681520858;
        Fri, 06 Nov 2020 08:52:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x72sm252823qkb.90.2020.11.06.08.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:52:00 -0800 (PST)
Subject: Re: [PATCH 1/1] btrfs: cleanup btrfs_free_extra_devids() drop arg
 step
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1604649817.git.anand.jain@oracle.com>
 <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <78d7fc4c-228c-378f-1a23-bf3e37cdb165@toxicpanda.com>
Date:   Fri, 6 Nov 2020 11:51:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/6/20 3:06 AM, Anand Jain wrote:
> Following patch
>   btrfs: dev-replace: fail mount if we don't have replace item with target device
> dropped the multi ops of the function btrfs_free_extra_devids(), where now

This is jumbled together so I was confused, write it like

The following patch
	
	btrfs: dev-replace: fail mount if we don't have replace item with target device

dropped the usage of the step argument in btrfs_free_extra_devids()

Other than that the code is fine, you can fix that up and add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
