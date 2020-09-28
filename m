Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAC27B468
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1SYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1SYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:24:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D5C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:24:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a4so1543698qth.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AX5zU4ZaC7GvxpywLfriMV9AQlSkB0apvNWJK9p8wPU=;
        b=FOtgwCMpls1udxrNO+SqTE0q2IFPeEg1lRo2rGgWQuJmHtHlwGN+VngfaVxHCztvdh
         wRpDoeTCMG+dMrCxvpzAxiuWvFE5auhT+cbihb8pupLUYXRrhTc91q/4w5kYDm252IgR
         MukYswsm1jlEp2d/lWC7uMsm97lb6qaTETmzUenKDfJggrfzOFrWw5NDfpGvIyr3civ6
         90iuK75oYgOCUC36VX5I9HX7VJviEa0nBGzStzpXC/rz3zn+o2X79IaL0W494vfAGU9R
         qDVSjYZ9NNcm62PzwuZ1O7GxVNxU9qhzPVVSPF5h5VNqYrjAOWFP3sa+In/0g3jUTlsf
         L7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AX5zU4ZaC7GvxpywLfriMV9AQlSkB0apvNWJK9p8wPU=;
        b=qJNneNDa7qVN3JcxW0FaVj9mgZX4URM1QpC2Z6VqqOusEEYo8B45G+iD8olNe4DEqT
         mSOOj1fRn9ndiSJ/00JEaaVDLZ2jGcL+gJDY8XftZZKty731nouwyw4OsA2wXo6aPfnO
         myJLDMhThWgxoNLcU2CPDewNJ6GyRPXYaYYca85wchE3O7KjJj/lwAAzvEFCQVsjAlo2
         aJm81N8YlTIquSEafe55OXMrZqd+eV0LOk8DuopDk93ZgoUMtCjtzHaipT0AQawu1e+K
         0zdla1t4/KX+ou63GQUBlbCzid+Ml19TD98YRmUC4M0FQwKHwn1M0nwnlLQNdEfrWFCe
         hsGg==
X-Gm-Message-State: AOAM533V/1Z0aDcraM4VYeWvc8qj/2VQ39SAAiOQOkCIbSsE89NTd2+H
        gEJdlqCHyaIXrFA/UyrbTsuzLg==
X-Google-Smtp-Source: ABdhPJwTOdpJU9f3PIfgNGSseM6enV1BTDB3ihILjs5YcMkyPJXiEJfmvmA1pdsBcA0/Yc8qwg9hqA==
X-Received: by 2002:aed:2907:: with SMTP id s7mr2763170qtd.321.1601317482818;
        Mon, 28 Sep 2020 11:24:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t10sm1847303qkt.55.2020.09.28.11.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 11:24:42 -0700 (PDT)
Subject: Re: [PATCH 3/5] btrfs: introduce rescue=ignorebadroots
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <b7b5dfb5542c3eb965cd2d8a9baa2999b6bae638.1600961206.git.josef@toxicpanda.com>
 <b6710997-5150-d082-e260-9fbbaee74e4c@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <355c3b88-1bb6-e79f-b06a-6aa684c3ed67@toxicpanda.com>
Date:   Mon, 28 Sep 2020 14:24:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b6710997-5150-d082-e260-9fbbaee74e4c@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 8:47 PM, Qu Wenruo wrote:
> 
> 
> On 2020/9/24 下午11:32, Josef Bacik wrote:
>> In the face of extent root corruption, or any other core fs wide root
>> corruption we will fail to mount the file system.  This makes recovery
>> kind of a pain, because you need to fall back to userspace tools to
>> scrape off data.  Instead provide a mechanism to gracefully handle bad
>> roots, so we can at least mount read-only and possibly recover data from
>> the file system.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Mostly OK, but still a small problem inlined below.
> [...]
>> index 46f4efd58652..08b3ca60f3df 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7656,6 +7656,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
>>   	u64 prev_dev_ext_end = 0;
>>   	int ret = 0;
>>   
>> +	/*
>> +	 * We don't have a dev_root because we mounted with ignorebadroots and
>> +	 * failed to load the root, so skip the verification.
>> +	 */
>> +	if (!root)
>> +		return 0;
>> +
> 
> The check itself is mostly for write, to ensure we won't have
> missing/unnecessary dev extents to mess up chunk allocation.
> 
> For RO operations, the check makes little sense, and can be safely
> ignored for ignorebadroots.
> 
> Furthermore this only handles the case where the device tree root is
> corrupted.
> But if only part of the device tree is corrupted, we still continue
> checking and fail to mount.
> 
> It's better to skip the whole check for dev extents if we're using
> ignorebadroots rescue option.
> No matter if the root is corrupted or not.
> 

Yeah good point, I'll fix this up.  Thanks,

Josef
