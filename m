Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020CD2D15EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLGQ2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 11:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgLGQ2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 11:28:07 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B0C061749
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 08:27:26 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id y15so2214188qtv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vfshf2V9Mcqggiqw+SHJtoavU5SrU0QiwCmxfg/dJw8=;
        b=MgUEkMWGiFaIMGKWP3Mk3VNaBIo1tCHDYpYvcl0Euy8nBSqAgbzbFRrAsI24BJrp00
         R2yuBzFfyyGYWn2KTrF7CCXNHU8ynDv+Lhr1C1eHfbiOjuDsy8nIuF5OZBKy9X+PaiqS
         tHMQqd19JM24fqumAOy+HAV0qdeWi367kADXkv+x056keG3EtxJLuW2oEiA/Ocx0kRzo
         mxRAS+QDULjMuLlxMavMYaRFpopOTciTZ3fRmDlErob2G7IHCcKNs3hDgrZVkD32c0gb
         cHahKDLr3vYpbxMSwh8ztesx6cbIPujZvQiJ6YRYuatR8WBdkhN0KlW3AAmTGmqDy2Ky
         IEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vfshf2V9Mcqggiqw+SHJtoavU5SrU0QiwCmxfg/dJw8=;
        b=lUMdyRMui7BaK4SnH8/YCOobb3X/BykIqFL2eZyTaqpxhGUwiNQX50YO358G6cV2pv
         SFx1KloceV8Sd5YzDHesE/+M8xr1HUqmwxnghKO9LIQReBrXmkw93nKFo/nhwb90Fvez
         v25S7/wVBlHQ5gcjCMP9Er/KBMXWihhqk71CkLD9CA0bO7E5eMNJduo/J5JBssam27ZA
         Fn3R3CuxUhv4T2QByOboErF5LybxT7pzYnLp37eqUuaknJ2kFI4b7P7X6ai+WLbv2BRj
         dSwJok24ci/H7ydEFf2GGDgRk5698A29nYepnDpOx4PvgGIhz4wOzeya2B4noEy/nK4f
         F1Fw==
X-Gm-Message-State: AOAM531XJLvQ12TMCtNZdxMd+9y9FLWgywqmWFqByhbCjwIq1OuumRwa
        +SNAlxAwRTbs8mYIGWlXAfnYGUQSHMROST44
X-Google-Smtp-Source: ABdhPJyxegeg/Rk4eda6Q42fpxRNbC3GLReZsY7VF8uxpa0Sah9PU+26hDgcvhSBS0MGqzETd1gXuw==
X-Received: by 2002:aed:2ae2:: with SMTP id t89mr24562389qtd.82.1607358444981;
        Mon, 07 Dec 2020 08:27:24 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h26sm7498798qkj.96.2020.12.07.08.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 08:27:24 -0800 (PST)
Subject: Re: [PATCH 0/6] Overhaul free objectid code
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201207153237.1073887-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <18fcc27d-7c9d-7dd3-2c64-6dd86d76aa64@toxicpanda.com>
Date:   Mon, 7 Dec 2020 11:27:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/7/20 10:32 AM, Nikolay Borisov wrote:
> This series aims to make the free objectid code more straighforward. Currently
> the highest used objectid is used which implies that when btrfs_get_free_objectid
> is called the pre-increment operator is used. At the same time when looking
> at how highest_objectid is initialised in find_free_objectid it's using the,
> at first looko unusual, 'BTRFS_FREE_OBJECTID - 1'. Furthermore btrfs_find_free_objectid
> is badly named as it's used only in initializaion context.
> 
> With the series applied the following is achieved:
>   * The 2 functions related to free objectid have better naming which describes
>   their semantic meaning.
> 
>   * highest_objectid is renamed to free_objectid which clearly states what it's
>   supposed to hold, also btrfs_get_free_objectid now returns the value and
>   does a post-increment which seems more logical than the previous cod.
> 
>   * Now it's not necessary to re-initialize free_objectid in create_subvol
>   since that member is now consistently initialized when a given root is read
>   for the first time in btrfs_init_fs_root->btrfs_init_root_free_objectid.
>   Additionally in btrfs_init_root_free_objectid free_objectid is now initialized
>   to BTRFS_FIRST_FREE_OBJECTID so it's self-explanatory.
> 
> This series survived xfstest as well as a new xfstest which verifies precisely
> this functionality.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef

