Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B156425C597
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgICPo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgICPo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:44:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BED9C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:44:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t20so2234620qtr.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+lD79q8n7/o+x5RETjSRyjxlKN7Jv4jjcyL7xNrCJUg=;
        b=lHITXdeQgvwSN//gtMg/G2EG9hYURnOt52Me6UN9fYEz2shVjGGDDggvK0xQOrCnrD
         XvS+b3ohtmrHTGC0xp5xEFpf79BKS5FV/TqAypVkB3MRiD39jftY0djceQjAYtciPTaa
         LAYMkXfYQFo7xKLzStsMUA1kITDmKHdSuYzKEl79Qk6rq7t6tgPFa4XYdXbT8qaB2f5c
         DszA3YfT8xTfc6zX6dWsSgQpNQwm8IPYWWLsrzz+cWVvl3qd7YHAACfZyO50ySC/FRXt
         62tJFDudX2eaMfQkFnQo5doIf7GsK1/2lUXJbiYPAC5gqkK4YouxcFzs6hgRfF9szx9F
         hG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+lD79q8n7/o+x5RETjSRyjxlKN7Jv4jjcyL7xNrCJUg=;
        b=FkYrtieyl8L8GVzvps7Ay4PqVPWdUr4qmI405YrAIPNyBwupW/VESdeJPSm1csAsko
         pidqMFlMHSw2XpAz4dM8lYOKkYPslfnnT3GDMyzYqhn7Bs1f4ChvUVbThpRDYmZETabl
         JZbgn+lRiFLebNJ/w+wvuMnqPPa2BcV1iwLeiEQvziNv5RqWKEf3rtQbfaKPb2pWTMhk
         qaHic3h61pOrKLNXlvmWav7PFcSRVJoov1S1YtVai5Hx4hXofR3/MIgliYAd2LfkKSLZ
         Qghp72TZePyr4Bdko30plHYEPcNqaSfvLGz7ZiwdNDN+LtFbX1pL5XwCyrpR9SXzbbo6
         XUBw==
X-Gm-Message-State: AOAM533GbtOoayqYOACcPFGrue49HYZGpOCybXf63o2T7CgiY6uP5Msb
        ilnaZjFZvUblUWmirwumL8LBgxFJlbPH65uP
X-Google-Smtp-Source: ABdhPJy3JipHApggtc7ghJBxX6SGo+DYumvz4NYIGp6vhyHwAcB8I4cZmmR/dD+VmCsd9MOnLLdIhw==
X-Received: by 2002:ac8:c47:: with SMTP id l7mr4232628qti.112.1599147865533;
        Thu, 03 Sep 2020 08:44:25 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g45sm2308564qtb.60.2020.09.03.08.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:44:24 -0700 (PDT)
Subject: Re: [PATCH 03/15] btrfs: btrfs_sysfs_remove_devices_dir drop return
 value
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <5ff561bc46063a3fc7eb12a51600fe754b12ad0d.1599091832.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8351b005-a162-38ca-5435-cc6e49147b7b@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:44:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5ff561bc46063a3fc7eb12a51600fe754b12ad0d.1599091832.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 8:57 PM, Anand Jain wrote:
> btrfs_sysfs_remove_devices_dir() return value is unused declare it as
> void.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
