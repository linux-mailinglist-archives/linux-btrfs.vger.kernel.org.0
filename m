Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63E1401A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 03:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgAQCAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 21:00:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43126 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgAQCAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 21:00:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so21255398qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y9e+dvFkc9nrlvzoLhiDzvZuk1/Hhbdhtj74rVNXCF8=;
        b=Sks5inxsFD+goddKiQlmtXSEV2lYwhgIlwETgkusFLJof7pMlUkzKNKLc5bB5pUxTs
         Dzdwd46yCZWiFvwPHIELmrQarFB+kXw1FDGoP9lOXaRIml4ML7U2mMe7/zPEGizYNs1W
         K6cq/xp8rmXB3Sd5SDZVe4IUxDdDkdUK559eijfqiQBz2J7Af6qh6o53vd5Wn91f/UnA
         vlF/FOt5K2Sv1RFabOtVPj7+qekw544A41sVGo4R2DPe1L7EAgH9jpAwreIdYg6YrEg/
         n9oL19y0hbqXDLzJOvsPnMt5PueeznaRPNd9/BkdHT05ObfuRZpNAWsQQmXK4gkbeEy4
         ReEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9e+dvFkc9nrlvzoLhiDzvZuk1/Hhbdhtj74rVNXCF8=;
        b=ugIwYTk+/9tL3FHSdMhFcP/JCBS7AjXNkaf5FeHPC1ePKhw6Wwr1Odx89pFJa+FYtj
         XmhX7pI1qhUzyDwnCewNd0rJlX0vvRBlvZzgM6FYf8NKRXPJLhRVBTBDKiQBeMFX6E5W
         3opRCsNXzSH3BA7yQ/gTMqzdPkIQvFfv2HYR1AUModxPWpJ1cOjkgTXGmUZyl0w8TYNN
         F15ZWltwnyTL2ZiC3dBhE0zWJQArrRJvPB4rmU/mUDYbF3JlMTa3K1heWqEnUQ5okIxQ
         nd+SQ6rgFyDPpl49wouXyx6AynnINz8/SFT5L0tt9vB6/EK/IuaqK+z8T2xX6MgTudbw
         4sMQ==
X-Gm-Message-State: APjAAAVKzYnN58rBM4/wEsVyiSwO265THeaA++dU8zhVR2etF2KCdBpf
        3/QiNNZM/UeGn5Ko3t4TpgUAOj3yfLAX6A==
X-Google-Smtp-Source: APXvYqySA4OaquotAQNCbsD3ohFZF4M8vToFExOQzd9OU3RGu5fYz75GE7bRydgPvErn3DAwhSHerQ==
X-Received: by 2002:a05:620a:849:: with SMTP id u9mr36297972qku.414.1579226402960;
        Thu, 16 Jan 2020 18:00:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2e8c])
        by smtp.gmail.com with ESMTPSA id 3sm12254471qte.59.2020.01.16.18.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 18:00:02 -0800 (PST)
Subject: Re: [PATCH v6 1/5] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200116060404.95200-1-wqu@suse.com>
 <20200116060404.95200-2-wqu@suse.com>
 <49727617-91d3-9cff-c772-19d7cd371b55@toxicpanda.com>
 <3818d217-b64a-5f44-c80e-c49521bb3698@gmx.com>
 <4380a833-eb7c-cabe-3a97-9346d803873f@toxicpanda.com>
 <525d34e8-1c14-b13f-bb03-91754e5882f1@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a2a08770-3d51-871f-b00f-95a274907710@toxicpanda.com>
Date:   Thu, 16 Jan 2020 21:00:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <525d34e8-1c14-b13f-bb03-91754e5882f1@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/20 8:54 PM, Qu Wenruo wrote:
> 
> 
> On 2020/1/17 上午9:50, Josef Bacik wrote:
>> On 1/16/20 7:55 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/1/17 上午12:14, Josef Bacik wrote:
>>>> On 1/16/20 1:04 AM, Qu Wenruo wrote:
>>> [...]
>>>>
>>>> Instead of creating a weird error handling case why not just set the
>>>> per_profile_avail to 0 on error?  This will simply disable overcommit
>>>> and we'll flush more.  This way we avoid making a weird situation
>>>> weirder, and we don't have to worry about returning an error from
>>>> calc_one_profile_avail().  Simply say "hey we got enomem, metadata
>>>> overcommit is going off" with a btrfs_err_ratelimited() and carry on.
>>>> Maybe the next one will succeed and we'll get overcommit turned back
>>>> on.  Thanks,
>>>
>>> Then the next user statfs() get screwed up until next successful update.
>>>
>>
>> Then do a
>>
>> #define BTRFS_VIRTUAL_IS_FUCKED (u64)-1
>>
>> and set it to that so statfs can call in itself and re-calculate.  Thanks,
> 
> Then either we keep the old behavior (inaccurate for
> RAID5/6/RAID1C2/C3), or hold chunk_mutex to do the calculation (slow).
> Neither looks good enough to me.
> 
> The proper error handling still looks better to me.
> 
> Either way, we need to revert the device size when we failed in those 4
> timings. With or without the patchset.
> 
> Doing proper revert not only enhance the existing error handling, but
> also makes the per-profile available array sane.
> 

Alright you've convinced me.  I'm still not a big fan of it, but it's not the 
worst thing in the world.  You can add

Reviewed-by:  Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
