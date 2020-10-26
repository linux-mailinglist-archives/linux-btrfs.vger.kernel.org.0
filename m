Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C3298F14
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 15:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781295AbgJZOUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 10:20:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45135 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781292AbgJZOUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 10:20:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id m14so735999qtc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WtB2wypnMgsogox+zxfd8JJo4sHANMEVHjCvcxPuk9Y=;
        b=mdihdZm0HFuyAgrqFvs4uBTUNAgSKG1d0hFXfgNS8pL4fsswjDgdnwLef3SnPVCoYV
         VLcyJcluJ3yKZqM3qwQeNYVViTLa4kNBgXcfUqzalVoOqILIIIqJGv+dl1F48wUmbaYW
         Psfw90PdSaWttPtqwYrdqHZrJVXmZL/ckZ6sST+N60nITNWrpnxBMu5TWe8trJvElG7Y
         a9OsoN7PLgKDIihBj2AUQ7CAwsmkGj0GpKp4RXI+eKwfyL0hbb0q8EWmNp1efFBfRNmr
         2gK8OxLGP44HNhVDA5yr1ZCzufqGqgzw0JI0lhJ5IqFnAwqW40dbgbxG1AzcyEIhbvnp
         oUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WtB2wypnMgsogox+zxfd8JJo4sHANMEVHjCvcxPuk9Y=;
        b=JEV5ScQpM7TeM/pU0Gg4CBoRid3xjjUyH+XIS6R0ywgRXKepPKgPLlPtkavgvaHECH
         gq5H5nWcs3Vk7VwUeXJFfs70KgoWKF8M31Qy/UR5MWhoIGVMjHhuUx+B88O/5K+zuy5G
         4dugda+QYkl3Kqb1LCwduxudGoZA1mj7eofGQl+0xeEpkCYsJMUiz/g6UNg0BS8KVY4X
         pb17jyg9G5T4BBk523T0iRem+yHCNZq+IlkQi//QWXLpc4muNsgbHY1HWIJphg343FiM
         XOk6S5cpNUrthp4EDpOKoc0IANxtKSW/ranWR8duQ7yEc5WVHlUBg+J+rsVM5NdqJOXu
         L1WQ==
X-Gm-Message-State: AOAM533TDnDaiVEebV9ArKXrLiUHbdKrSIwnnHbIKAoQ5OGMF/VQ4lbq
        I52W4diVkrOoju72ieBWiS1ktxuiPCVTAZDM
X-Google-Smtp-Source: ABdhPJxjNbsKfq40RHOAhFRWTXjqE9LHbDpaFuASXmB+7Z8hxYq5R1Ze1G7iQ4BcApsAOis3SRdRxA==
X-Received: by 2002:ac8:5c82:: with SMTP id r2mr17230570qta.195.1603722014114;
        Mon, 26 Oct 2020 07:20:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y125sm6359598qkb.114.2020.10.26.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:20:13 -0700 (PDT)
Subject: Re: [PATCH 2/8] btrfs: scrub: remove the @force parameter of
 scrub_pages()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201026071115.57225-1-wqu@suse.com>
 <20201026071115.57225-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7eef63bf-9162-6a6c-a04d-e52c13a175b1@toxicpanda.com>
Date:   Mon, 26 Oct 2020 10:20:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026071115.57225-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/20 3:11 AM, Qu Wenruo wrote:
> The @force parameter for scrub_pages() is to indicate whether we want to
> force bio submission.
> 
> Currently it's only used for super block scrub, and it can be easily
> determined by the @flags.
> 
> So remove the parameter to make the parameter a little shorter.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
