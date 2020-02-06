Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9023D15486D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBFPri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:47:38 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34319 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBFPri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:47:38 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so3065210qvf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fUviPoffa4xlnXF8ElkhP3XofIfwyDG+X8bi6P0i8IY=;
        b=nNcUOaA4xGyRlPaHmICd5gl8of9jh4XrVdi5NFxEFefbCkjxoEpXyiIvdhw2fdXan8
         61+Ele0ojKO85X4wj6v7jjDlGkbn/FgdBWGZjPJsc+mjtiwgDg5sQ0y6BDimoQicLZiD
         mkHG5Pqzc2mdGS4e1AQw1OIBW56jZ1OGP8eBhXBkpNj4MiaL0kr/KjUeS47GsTQojmGo
         VAvUeNbt9R6ysnocs5Lb8shUlqqmWOwkmRG0F8Dn+gpacKWaULmRlSPO9ttr33T9oipl
         bD+Y4qXL7yygSPNQrZDZsXG4Mn3pp0IUYFnaVF241gmw6wM216hTLKi8eJpWgUa3kq9R
         5YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUviPoffa4xlnXF8ElkhP3XofIfwyDG+X8bi6P0i8IY=;
        b=AG4KimICzgnLKO0OsG4NKNgbfHHSgYlW6/7tvzrtCjfqc7Wfo+IDDG27+A7iTqY5wH
         YUJuiKckNzFXIALiQ6csHd5KAhcZ8gBSoE1li9Y+rTTcPP9kKvrkhDm6fBFYUNomazSC
         hWLLWp8B0EnKUsaG2AjUQBoAV5D1HD+xEHCTtJq/RNp4SEdv6p+bogS1ws7iMLRmlHS6
         E0CjDLUgOflR7CI43YpCtay9/vIABryyRk6Xizxao7d6/p4Ns1RT3rLKruZigvDg6BAm
         i3FKtn0+2lW06RDs5JiGFL4xaVEBpvDXLf15UWbihoN8llZMmc1I4PFeR4zvmbLvNLBG
         /MEg==
X-Gm-Message-State: APjAAAUXy8H2qpT57MWe6OJeB0jq1RJ0VE29m0WG7a+Rlz6LVEeh6ejj
        j7mu9H83KAfsYkoSQzDIrJNA5bAIwEU=
X-Google-Smtp-Source: APXvYqxnKDR4BFR+JflzReERr3YgbgBrTlj7ZIAcHqIpT/tNLZzk4c29m4n8Qhp+OgCeXBSaLridKg==
X-Received: by 2002:ad4:4a69:: with SMTP id cn9mr2950839qvb.218.1581004056244;
        Thu, 06 Feb 2020 07:47:36 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y188sm1564117qkd.10.2020.02.06.07.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 07:47:35 -0800 (PST)
Subject: Re: [PATCH] fstests: btrfs/022: Disable snapshot ioctl in fsstress
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200206053226.23624-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e3c530b6-af9d-97de-7008-5bc02c77e037@toxicpanda.com>
Date:   Thu, 6 Feb 2020 10:47:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206053226.23624-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 12:32 AM, Qu Wenruo wrote:
> Since commit fd0830929573 ("fsstress: add the ability to create
> snapshots") adds the ability for fsstress to create/delete snapshot and
> subvolume, test case btrfs/022 fails as _btrfs_get_subvolid can't
> handle multiple subvolumes under the same path.
> 
> So manually disable snapshot/subvolume creation and deletion ioctl in this
> test case. Other qgroup test cases aren't affected.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Why not just fix _btrfs_get_subvolid?  You can use egrep to make sure the name 
matches exactly.  Thanks,

Josef
