Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DE21245D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGBNP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBNP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:15:29 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7AC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:15:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so21147589qts.5
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CvXK+MjD4CBcj0b9WAlDUAdeQZ635p9O/wmiwGs43oI=;
        b=CJlIj3wLfPhMPCBhoYXdTX768dtjVLKWv7c7y8FZzdnhh0C37FoDUANKqmlpuC2klp
         4Jm4oNJJ2qvjrt8bVTesW0VosNA/cSS+uDVf9V6lmwy75V3tlnG3eieFsDGMSMraHeTZ
         zmxEhXJ2Tp3C17sdz+lGGmc6rNc41tOFaXuSmpjUqC05xzrLLLMYvQKmn91/gRI61WCN
         5npK4lhYyxwloWfHcYiCEoF3Rv6wYfA6nN//0BGARiht/QNHvufO+mYXLrtK8wHX+m2r
         kII2HVeJHnNBZO8pqI1kOYTY+OBjgKo3AUbkwCqrJYO889vkgmG4IAoQ6gLf7stHxDM4
         tzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CvXK+MjD4CBcj0b9WAlDUAdeQZ635p9O/wmiwGs43oI=;
        b=Ieh751Vy0lp5ibjTzA5Ep5NmVFyxRK2bIyiB5OZM+YQl9LUPoUJyaCVZI+FXF7r9oL
         8PJ9fD7kKVKQ0uA4b7c1tFkVSLmd8pcMiU5x5NTbSjN0w6V5KGprJiJvtX2Rzy/Lod1N
         CR/u5xnfy87d+55KrYmcsFiaGPVQf0qYPAuX3ucTSp4Z1uJolaeGX6RDs4sCUbZPGMRt
         +7Sms8bRk+Axb58gbNPbyo6mDNklhlx7SDBpGxHwMBOzFjPnzHlh8+T7M4hcjng9TXCL
         7wq8VO1geY6dbAXXXfX2Pn1WZAUABgtTipMZ7tUhMWKPyWdfSuYV11X8GumxWH3KnZ9k
         eJjg==
X-Gm-Message-State: AOAM530uOBFNtRzEx7WKTXDM9wCTq+IwlDwJbgRLtHKcPRldCxfH1j1V
        Lae7tR80hOM4BbGVwgmX3ZKQpQ4ariOYhw==
X-Google-Smtp-Source: ABdhPJzMlcE5bEodMCCN3edp3qLZSaFtJKaCi66mox7YLwsxZVAKz7ymZshDLVUvrFzAhqDEnei/Vg==
X-Received: by 2002:ac8:458b:: with SMTP id l11mr31826480qtn.111.1593695727669;
        Thu, 02 Jul 2020 06:15:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k6sm3406866qki.123.2020.07.02.06.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:15:26 -0700 (PDT)
Subject: Re: [PATCH 4/8] btrfs: Don't check for btrfs_device::bdev in
 btrfs_end_bio
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4f59f477-1a7e-48e5-c875-d9926df7f061@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:15:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> btrfs_map_bio ensures that all submitted bios to devices have valid
> btrfs_device::bdev so this check can be removed from btrfs_end_bio. This
> check was added in june 2012 597a60fadedf ("Btrfs: don't count I/O
> statistic read errors for missing devices")  but then in October of the
> same year another commit de1ee92ac3bc ("Btrfs: recheck bio against
> block device when we map the bio") started checking for the presence of
> btrfs_device::bdev before actually issuing the bio.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
