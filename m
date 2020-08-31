Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48803257E3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHaQIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgHaQIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 12:08:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8CC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 09:08:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k18so5087462qtm.10
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CpzB9FkPdU1V+VkZVHuEtGjiOjXnhv0AXUTpY7kie94=;
        b=Ev0OzXLgZ9cEInLo9vph+hENnLtBxgBoh/QSOvO7Bv61wMmfoIp/qZH3TGKbg41/9+
         /yJ887NaoCmXI3xn4pwGpivnKp18la3fgRKUJXi5Uwt0Zade8ZAMWy7Fn6gR5zcOBdX8
         TNGBcAMpBkngaSvb67op+k+cu3VY68L/hos1ZkYT+YLdI5YZVmk46trVk3Imp1zv/GkG
         QbHCQqwTaezBTyeQHkxiYVo9hvOl6QBkhtaD97qR9ZM4l592rPeQ+hwQLeQrK4bC39HF
         MYPPxWXCHsI5zqALTYSb7G/bkJVrA+/2FAu+6nPQhOgyIYFStUATRmo7CwdEfd2+/rXS
         p1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CpzB9FkPdU1V+VkZVHuEtGjiOjXnhv0AXUTpY7kie94=;
        b=skjUhV1yvKBFDZoN/nvSeHUQ9m0kJwCxzJ5s67zrGV35tQuDMvrjtWHQgzee+zlBYX
         9N2688OrH4bx9hFChCEJNel4zD/5q0JvWeKtTX9Por7PAam6vTkXaImsAtcv5nMr9xAO
         hwQGjdAiuX8TLhGScqllHqSn/f/q2jh85fqDGzivXER31nZW19DExXlkwXzIBDHjreOO
         Ku/KlntPXBHtARTg8LRgiBv2c4oUDcXnhlO0NvUc4I+IqSZjv9Mucd0tEfLtcGq3N9yc
         OWMGeB/Wpkx+Iz3KS1tsbcGiL1oFsxNUF4KtV0fwe2S6eCAd/J2abIzpK2nbMF8mcjwT
         QH+Q==
X-Gm-Message-State: AOAM5332CSC7ndz28DcDVSKoBmk7IgFvS1c6QulQXLPu/TZTp4OmDR0H
        vm4OxPkGh/4gZpNbuKRwR4qETg==
X-Google-Smtp-Source: ABdhPJwoNc+kEAeBIUaw0C4uVKMmBaT0F+U4GurLO7tipARgMWwiHhzKPijfj8/OEbbvjI2xQPadCw==
X-Received: by 2002:aed:2742:: with SMTP id n60mr1952658qtd.74.1598890130593;
        Mon, 31 Aug 2020 09:08:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 95sm10683077qtc.29.2020.08.31.09.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 09:08:49 -0700 (PDT)
Subject: Re: [PATCH 04/11] btrfs: reada: use sprout device_list_mutex
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <b5ad15e6583f4e61cfd44344ef17ea7a93f6bb57.1598792561.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aad607a0-89e4-27da-9d01-ab7ac95761c0@toxicpanda.com>
Date:   Mon, 31 Aug 2020 12:08:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b5ad15e6583f4e61cfd44344ef17ea7a93f6bb57.1598792561.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/30/20 10:40 AM, Anand Jain wrote:
> On an fs mounted using a sprout-device, the seed fs_devices are maintained
> in a linked list under fs_info->fs_devices. Each seed's fs_devices also
> have device_list_mutex initialized to protect against the potential race
> with delete threads. But the delete thread (at btrfs_rm_device()) is holding
> the fs_info::fs_devices::device_list_mutex mutex which is sprout's
> device_list_mutex instead of seed's device_list_mutex. Moreover, there
> aren't any significient benefits in using the seed::device_list_mutex
> instead of sprout::device_list_mutex.
> 
> So this patch converts them of using the seed::device_list_mutex to
> sprout::device_list_mutex.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This doesn't apply cleanly to misc-next as of this morning.  Thanks,

Josef
