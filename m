Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD93221B8BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJOck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJOcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:32:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BEAC08C5CE
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:32:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so4556172qtt.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NgJ+w6Z95BjqaF5AlxxrEm0wJaR3Rks8FWk07osp1zg=;
        b=omqIF/G2FxkXVgdDZyir6rby57AigIsmTYBwfHL/8H546oVmPdvP/U3KAWPC2k/NL6
         p4aQ/lEfW+eU7kj4AH3/8e2O+jTr6fcCFj8uJFnnwenY/atDyJ5VoNS2250jZmNKrmXm
         EOqaAWb7IfPTQDawmLb8IjjVmwxAEC4ooChXQgslwWxy8nJ0KPWG1wlypOIJY4e/wbmq
         cDQMHvBnnm/MfBC22I0HONHB1eallnR/q7FyngXQKhGh55UICr2+rEMKSajpTUncpi7j
         D0xjVRTIGKyHIkSp9sfN553CRXsvB7VjY/MRPhg4m0s89hfPDsd66vov1cOVhzcQgAMC
         LbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NgJ+w6Z95BjqaF5AlxxrEm0wJaR3Rks8FWk07osp1zg=;
        b=fYmilJg8/O3aEoWWzC0VKYvbgXMICopaIxvEDYirT3fU1ZW+Iddx6KYQV+Hi5uwOOU
         ysqodvi8dUdO7EycDk60z9pkiZmxVY40xob4Rbo+krswlm4EXSXRUKiTloNk4XNFGWHm
         D7tGnYhS2Yq9/MuUovAJGxk0IBcm5l0qPpSC5mNx/wmkveh23b31eLmTnj6jNCieqJLk
         cliTuY5A8+u+1OmwWNi7zZ7DA0CKBeBNgLuCMAt2r/5ZF1b9G5Obn6bue06TltuRsfe1
         q9kWVu6Ex0eKUC8BzjiuUoC8VvbaMtl4HHCpMJWFj9116s4aNlYoWiZPzfDqgwyImEJG
         sTpQ==
X-Gm-Message-State: AOAM5320AOxZpl6OJpc93Hqx/Q9XF8RxZH4mDtSXUpQrRlv/alpUm5xX
        qrd7c3C+HMkiPIRD20GJ1fi6vHrggjse/w==
X-Google-Smtp-Source: ABdhPJwpHnWTYAQAwdC4CCJkdxX42N2/rp3qDFUbZPil8tyyUG9MvYU4cIFfe1xi3Z6WnJjX56tSEA==
X-Received: by 2002:ac8:4b47:: with SMTP id e7mr73257699qts.242.1594391557443;
        Fri, 10 Jul 2020 07:32:37 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d136sm7505652qke.47.2020.07.10.07.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:32:35 -0700 (PDT)
Subject: Re: [PATCH] btrfs_show_devname don't traverse into the seed fsid
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200710063738.28368-1-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <68bd59f6-8817-f682-1570-ad2131086ac8@toxicpanda.com>
Date:   Fri, 10 Jul 2020 10:32:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710063738.28368-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/10/20 2:37 AM, Anand Jain wrote:
> ->show_devname currently shows the lowest devid in the list. As the seed
> devices have the lowest devid in the sprouted filesystem, the userland
> tool such as findmnt end up seeing seed device instead of the device from
> the read-writable sprouted filesystem. As shown below.
> 
>   mount /dev/sda /btrfs
>   mount: /btrfs: WARNING: device write-protected, mounted read-only.
> 
>   findmnt --output SOURCE,TARGET,UUID /btrfs
>   SOURCE   TARGET UUID
>   /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
>   btrfs dev add -f /dev/sdb /btrfs
> 
>   umount /btrfs
>   mount /dev/sdb /btrfs
> 
>   findmnt --output SOURCE,TARGET,UUID /btrfs
>   SOURCE   TARGET UUID
>   /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
> 
> All sprouts from a single seed will show the same seed device and the
> same fsid. That's messy.
> This is causing problems in our prototype as there isn't any reference
> to the sprout file-system(s) which is being used for actual read and
> write.
> 
> This was added in the patch which implemented the show_devname in btrfs
> commit 9c5085c14798 (Btrfs: implement ->show_devname).
> I tried to look for any particular reason that we need to show the seed
> device, there isn't any.
> 
> So instead, do not traverse through the seed devices, just show the
> lowest devid in the sprouted fsid.
> 
> After the patch:
> 
>   mount /dev/sda /btrfs
>   mount: /btrfs: WARNING: device write-protected, mounted read-only.
> 
>   findmnt --output SOURCE,TARGET,UUID /btrfs
>   SOURCE   TARGET UUID
>   /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
>   btrfs dev add -f /dev/sdb /btrfs
>   mount -o rw,remount /dev/sdb /btrfs
> 
>   findmnt --output SOURCE,TARGET,UUID /btrfs
>   SOURCE   TARGET UUID
>   /dev/sdb /btrfs 595ca0e6-b82e-46b5-b9e2-c72a6928be48
> 
>   mount /dev/sda /btrfs1
>   mount: /btrfs1: WARNING: device write-protected, mounted read-only.
> 
>   btrfs dev add -f /dev/sdc /btrfs1
> 
>   findmnt --output SOURCE,TARGET,UUID /btrfs1
>   SOURCE   TARGET  UUID
>   /dev/sdc /btrfs1 ca1dbb7a-8446-4f95-853c-a20f3f82bdbb
> 
>   cat /proc/self/mounts | grep btrfs
>   /dev/sdb /btrfs btrfs rw,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
>   /dev/sdc /btrfs1 btrfs ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This needs to come with an xfstest so we do not regress this in the future.  Thanks,

Josef
