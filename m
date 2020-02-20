Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8964B166105
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBTPeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:34:16 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36703 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgBTPeQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:34:16 -0500
Received: by mail-qv1-f65.google.com with SMTP id ff2so2067018qvb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3RbokB1Yu4/JZVnh2IStG+htBxqkiA2Y/kOGW82Wa10=;
        b=YS4QJhMZ/mIFZDASgmdIaMlW0/77lP792teWAYqLNd4zlyqaBjZtpv5pCdZ9lRvCba
         FLacUAqjxvK2HDc+1g5LDtwTQldLSKMUw/TcBZHFNmdjfLhfDm3B/zXguONSY/T1ldhi
         /ki6l7P7ir69aRV2uLDGe0VfRhpP8kecF9dylaeSp7kxgyBoP3Jpl543hAOsu9dk08ek
         msMPBSg0Zux+6axI2Buu1t3eQWzmhNxgBCMoCO5BTWOwJ9Q8VwbwmcDtyCwSDNTemfKU
         XRA935MCW9FAmrceHr5uhfFBMUXI7XA7dhS26LFvL6St83tt88NOJXE/8VJTsk6+5T7N
         UV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3RbokB1Yu4/JZVnh2IStG+htBxqkiA2Y/kOGW82Wa10=;
        b=KO3P3NrgSIAGto/sSTKpBrTtwU2VqfhOt+g3/QhqqAcbHADbOC5rnu4+TzZqcR1BH3
         0oWaTjpzIlbFfcOZx4U/3PT6N8Qb9yjWExG173UEGcdaI57a+gJbfWE6IY+CccspW/hT
         8q6YOLZrjIFkGYhm69M75c/JA/ZLF2uoPU91kH6H51VnUsaDF7wlqjIt3dVKZFym8hXK
         jOUncI3iLAoNcCa459MNlOTt5mX/cNf6q6g4cDJboyUrrgdx5wTJof6yduX88ZiwRlSB
         Kd12FcKbSGPa1pZTXgv8Z8kibhHiiGzaVCYpTVykpD/BlshkKdbonFsetceOYbNP9c1u
         s/eA==
X-Gm-Message-State: APjAAAXookO/KbaUh0sWiLCfyzCJW5NeZpRImpQwYJKQYjy13q1hRApg
        R+KbNe6YN8+JTDlWoQFJbIb8wg==
X-Google-Smtp-Source: APXvYqxMmDv7PDvr3WCGrSqJmK3y6q77tWb3e2nPVZnpVmuAe87UEtDDW06vWHNgM+2WGpum6HSguA==
X-Received: by 2002:a0c:f685:: with SMTP id p5mr26463361qvn.44.1582212854095;
        Thu, 20 Feb 2020 07:34:14 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f7sm1879566qtj.92.2020.02.20.07.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:34:13 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: add test case for newly supported cases of
 cloning inline extents
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200219140641.1642570-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c426284e-64c5-6020-e8c7-eedf2dde9ca1@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:34:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219140641.1642570-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 9:06 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test several scenarios of cloning operations where the source range includes
> inline extents. They used to not be supported on btrfs because their
> implementation was not straightforward, and therefore these operations used
> to fail with errno EOPNOTSUPP on older kernels.
> 
> This currently fails on any released kernel. It passes only when the patch
> with the following subject is applied:
> 
>    "Btrfs: implement full reflink support for inline extents"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
