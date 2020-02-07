Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78156155089
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 03:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGCJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 21:09:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44780 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBGCJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 21:09:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so730260qts.11
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O0CBq/56D0+K1fC96UPE9jCeddc6RxcWot0DdNZr0Sw=;
        b=H888Es7oDBIH41b5KqN35iQiWEqLb1JEGLYAw/h8QUCtW0sJoGy3/mvgLq5sWoq/vm
         T1FjLkAQrcNLAph6FYnjj9eWAY3Dqqk+nKH2YYoTFhE8eSQgrY0OY/HzTL1oAv1CBC4s
         N2dCEJOGGzUdor1ZbUMjrgVYDpWcdH1IY/KS7a7GhmBKFv3rlqlb6LQfG7vgu7gkcUj4
         QqnkqxmA25yJkeqH7KSxy7K+c7dhu8OTF8i2GkiyZwGCw8Cirih2qnKAzX3S5zOABX3e
         JIg1aC4Vukc/Wtcf5TLDnqaUIRVCl9yJ6E2Zic86ylbFMHEWEFmZH1uFfbvlnl3MZR29
         Su1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O0CBq/56D0+K1fC96UPE9jCeddc6RxcWot0DdNZr0Sw=;
        b=OJTcmSLFFnonMBgGOZNoyLSneAV7wmZxa4LmFm/Sn2uJs9cHg9TV72zhU6+qT9fr3m
         lDZq6Bzen3NVM3UiR4P5h7gtOEvQBADak012VG6M1NWROMF4VeAEi+na1lt2lmV7pa1P
         rKIpDqwV5S0yaHCjP9NqKkhdYsYdpF15chWHiP3FxWzMX3OotoKYUC4pvU/Vmhqc233V
         2+VM5ifNg7wTDmQhtvVY7wT9l9cER/YeK7OxBn5blrI+Q1+qDzJvbTR1aFtgL1VuuDC+
         zU5v0gdeb0R+8qw2prnJbcgaqPFBbwkAH55lTImvIdvfQXTy7OWeyRTtsM7mBuS6B+49
         PJnw==
X-Gm-Message-State: APjAAAXZ38euDeOBGjwFB6fd6faHdbrWkW+IkAXTrHB7+tA4LXzHrpRI
        HWs9oFmz87Urba7AYYEVHZ4eUSuy7dI=
X-Google-Smtp-Source: APXvYqwxkJK0Pa0EwwdSQEHeT5ZSQEE/4CiXf6knsVakI24Rm1GWNv5LqozCEUZ/DHMK7XuTx0vPGw==
X-Received: by 2002:ac8:7243:: with SMTP id l3mr5318414qtp.139.1581041376233;
        Thu, 06 Feb 2020 18:09:36 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v18sm596999qkg.67.2020.02.06.18.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 18:09:35 -0800 (PST)
Subject: Re: [PATCH 1/3] fstests: btrfs: Use word mathcing for
 _btrfs_get_subvolid()
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2b676a46-96b5-c461-667a-d85ae6e8a70d@toxicpanda.com>
Date:   Thu, 6 Feb 2020 21:09:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207015942.9079-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 8:59 PM, Qu Wenruo wrote:
> Current _btrfs_get_subvolid() can't handle the following case at all:
>    # btrfs subvol list $SCRATCH_MNT
>    ID 256 gen 9 top level 5 path subv1
>    ID 257 gen 7 top level 256 path subv1/subv2
>    ID 258 gen 8 top level 256 path subv1/subv3
>    ID 259 gen 9 top level 256 path subv1/subv4
> 
> If we call "_btrfs_get_subvolid $SCRATCH_MNT subv1" we will get a list
> of all subvolumes, not the subvolid of subv1.
> 
> To address this problem, we go egrep to match $name which starts with a
> space, and at the end of a line.
> So that all other subvolumes won't hit.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
