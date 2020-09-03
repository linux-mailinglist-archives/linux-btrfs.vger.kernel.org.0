Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B427025C591
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgICPme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICPmd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:42:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C367FC061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:42:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so3419296qkn.11
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VnRq1/dOcFksQZzXHx2R7rL0Ab33hIbT4n7ZP4+8Evc=;
        b=LVL2CZa33gDgSQHgchOADYPZMBPMyl1tRHs1ymEIcZYSSdSYFqTGCkGglNB58/wYmh
         93Ol+CM4RFngs+uFINTGb3D0JUeW1Hc4QV2W5VI83e8So4FkEqPNbCbL6TjqFeVSzTOL
         HOiOAOVOYtOrrkoZZmBrw2uEExLeLWIfpGAUpyxcvwcqmm639iZVCfV/bd8tEXvuFdy5
         yv+rLxDP32oAhjEMM4jriyPa8iRPtvjea8UWH1pPtDL//VwbudPA0xy+e6JE+OvCQz+q
         Cqq9Mg4FqjDmXuGUHvIDvc4hzhxZNEYQ3AOIuO5p4Vjf1WsZYe78u05ZYtOGPWzrE2Mk
         KX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VnRq1/dOcFksQZzXHx2R7rL0Ab33hIbT4n7ZP4+8Evc=;
        b=jJDxhO9fmO7q2MGW+3vbmAEwmO2Wk/zC7exH3mDLvGVjRpGU7JrZm9EUPMbVfJfWmQ
         sDjbm0k77Bfbxy6GymTuuJs9ICfLDQRvCnA/KCRDi17E9IJCXCNQuJvhTZwSVJo3PCh1
         kI6+jqPkbnrRmOf/nUj/iOng3AU9Q3YNpMtd+zZilK1bRiiDvYTyqHx6Zz8qW2EiaMWh
         DIkEF7gGgSIzq2GlINHyDVw5VoqM0mh+7r7/YFKjwdNEIMwDRGSF0z5ABHKunwVCJwfG
         G+Ba9BCvusjDSy8ViLqn6U8aIK2MBWtjGZnzAwKGbpOTz0gygZrIeLXWLgPMoithGCzR
         uNsA==
X-Gm-Message-State: AOAM531hQjvwGW6JHhlYU6bOJJ1gWHD2VA42PFlaQhQnWUi2l6YEreLD
        +H73ucuDYlu3Ko9V5KJZo/vA8A==
X-Google-Smtp-Source: ABdhPJwZoOVK8Fjcxh/pq59Xiq9cnUKYQ3Tu7s/vVRcJpQ85rCyrFODDpBKr7n0hLE3QCmfPQ2jKxw==
X-Received: by 2002:a37:794:: with SMTP id 142mr3743812qkh.114.1599147751647;
        Thu, 03 Sep 2020 08:42:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u18sm2329770qtk.61.2020.09.03.08.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:42:31 -0700 (PDT)
Subject: Re: [PATCH v3 1/15] btrfs: add btrfs_sysfs_add_device helper
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com
References: <cover.1599091832.git.anand.jain@oracle.com>
 <30dc9402060e4361c15082fa52e1470746a2a04b.1599129529.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3adb4bd1-fa0e-7e79-44c1-c69be9bf2566@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:42:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <30dc9402060e4361c15082fa52e1470746a2a04b.1599129529.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/20 6:46 AM, Anand Jain wrote:
> btrfs_sysfs_add_devices_dir() adds device link and devid kobject
> (sysfs entries) for a device or all the devices in the btrfs_fs_devices.
> In preparation to add these sysfs entries for the seed as well, add
> a btrfs_sysfs_add_device() helper function and avoid code duplication.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
