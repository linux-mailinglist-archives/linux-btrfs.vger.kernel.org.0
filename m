Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495B6362324
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbhDPOuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhDPOuP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 10:50:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA774C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:49:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h3so12767286qve.13
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ggQJc7eTaDrjBDOObOyQq1DkYIJva07asX4DqgN3TA8=;
        b=RyxMPhTMpmug8G1kf+838ihHhn3F1WXfW/YSoH1H6F9m6Izoq+zlVSs3DvyHbrRARF
         HoLFiyIxrlxKcbAD3jBmARlOC8HclbrIkWDwwQRKK2/G6KAg2wb0f2OiwJB6fBuC4FVT
         cd4qk4ZzjGU8U1iGL4kRFz+w6nyktNSI7+2DvcFPe2lHjuXHyKj8fz7j/lRh78FrKJzP
         LxUrrhxd3pqSEwQrh8J+tzvD8VLmFs8RoOwYEVC7II7D8IWak2YpJ1MAaMlK/6fdkySp
         GMtz94LhfRXpJIgzOc+RMxZIL8WFXXb9KbRtYaD7x2RVYm68/6yxEzGYxjiCBcXvBNDk
         ZGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ggQJc7eTaDrjBDOObOyQq1DkYIJva07asX4DqgN3TA8=;
        b=LeGp67eroqorK6IaMQ3vszJsIuOkU3JXjuRyi9TkQUol6oqOuCCUru1wsXtAwaq6nw
         WDBOlWJMnBVFlrGeCW6sK/j088BjzVpnNEEfRrjZRKAvHORT2N3VC78Rh2stBFLTKPy8
         Z9vdMG54FCdJFPKBYIu6qCvTEAwbMOEfBrHzpfx70XmzkHd9ysZ7vOD3R07vfdlW0t/D
         emLefImRj/IM1+5ZPcK5ucl7k/Dc8Mo5RmTjtuG3wC5j3quSqTS64vO+vjE7PkQo9/w5
         Rod0kguc/MI+uhV5Thae+tuKhOtwWsw5Z/x6qP3N7w/uR+1L8E9LkaxcUx11w8Lv5c+0
         q6rw==
X-Gm-Message-State: AOAM532at3vcu+4i3CExjiXm4majbXJ1YwNm+Vg+DJBBKOCT7+/hH35B
        QGvt4GU9/13k/3taJphVoDKuqWfpkb/C5Q==
X-Google-Smtp-Source: ABdhPJzXWA4e3XlA6XC4sCCXlnLeudAVEmmHnxlgKEghO+rLYVi3TtSFRw2H635l0qVTd0IwGfpMHw==
X-Received: by 2002:a0c:dd83:: with SMTP id v3mr8778667qvk.49.1618584588850;
        Fri, 16 Apr 2021 07:49:48 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y26sm988152qtf.66.2021.04.16.07.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:49:48 -0700 (PDT)
Subject: Re: [PATCH 13/42] btrfs: rename PagePrivate2 to PageOrdered inside
 btrfs
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-14-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e9ea1492-ea4c-5d62-c492-17f77d241448@toxicpanda.com>
Date:   Fri, 16 Apr 2021 10:49:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-14-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Inside btrfs, we use Private2 page status to indicate we have ordered
> extent with pending IO for the sector.
> 
> But the page status name, Private2, tells us nothing about the bit
> itself, so this patch will rename it to Ordered.
> And with extra comment about the bit added, so reader who is still
> uncertain about the page Ordered status, will find the comment pretty
> easily.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
