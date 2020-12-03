Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A42CDB9D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgLCQy0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgLCQyZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 11:54:25 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87859C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 08:53:45 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id p12so1811542qtp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 08:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GkQqFR4y5GeTGo/UZyOHoZvWCQjAePwZWO8dB3azQl8=;
        b=rJ7NgaN6f2Y5+1NFFCsi+BxtEgiUHF6E+2MPcmoryrbYzC8iGVu+ZxWejpUl2P4qQm
         HuTU0LfxGw9cX9cozJDod/qtNQq4ESYfcP8Wuhm91AdYqOs/uAnynb+/q5sWU9cvwHf3
         CDwKXXW7hPfET2lZxf8hSaM4gobuJJYQQuJRX/uAJ2aaymfq3rCz7wudeN2ruN//hQ/V
         wSbw8Bux53vQRjG73FB7RG7UWakkZ6n0kyhOBkYF3619WzO03EHuB3FMDvk1F0cPth6z
         Gbif4XS4aYJh3qtHBUcjkaYhsi+zE+wSlIBovqLnLDxQRmSBHEEWgYhyKMQoRISePWEz
         c6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GkQqFR4y5GeTGo/UZyOHoZvWCQjAePwZWO8dB3azQl8=;
        b=c53yEf9hy3nVNJdHXUDAuJGd7FF/7Pb3lGQv+KaA3a7+1F3gRj8JZ/vF7o9ebdfDGU
         LaC9dfaRNBvz20PU53puWY0bvq6vynzoOdCPRw78s5LPETChVv2iEW6tKz3hIEgqXPm3
         upF3nISkusYrJgO4D0Tvd7aa9Vrc0egajvEN6SCzYYN6i3hAWcYPRZ//wZlczWOyiNMW
         +igYy/BA2W+D/0a6l82hgfm09o1hpfG6zD5iVMNEjc8yMv9ucxMjSbvXBb79hwjqkdLn
         FhPsOCrm2HN6K2jwbq+31xQqp9oNE3toRYs2yMLvymROVPjEN44linJVmNY9WQfEXl91
         TlZw==
X-Gm-Message-State: AOAM533dVT3TdL+OgIZbuaKHp81z+7dnr62w9TrFU0fbJvrJ4OL/km0j
        soYlrNaYJJ0edFx30QfXWpD0fQ==
X-Google-Smtp-Source: ABdhPJyg+CI7F/ksyRJIiRD/jae9aHtf3qvqx8Qbl0S0DmzzbB/pHXiyi1lXE+TTBxxye19Y+FY2Kg==
X-Received: by 2002:aed:2297:: with SMTP id p23mr4203566qtc.140.1607014424173;
        Thu, 03 Dec 2020 08:53:44 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c6sm1778569qkg.54.2020.12.03.08.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:53:43 -0800 (PST)
Subject: Re: [PATCH v3 47/54] btrfs: cleanup error handling in
 prepare_to_merge
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <6e41922428a5b89b5ef0d7d47f8274e11468ee2c.1606938211.git.josef@toxicpanda.com>
 <2c507955-c50e-8206-8d99-00b99c176258@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <80825d8c-33a6-e127-3fa9-4b4506035eb5@toxicpanda.com>
Date:   Thu, 3 Dec 2020 11:53:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <2c507955-c50e-8206-8d99-00b99c176258@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/20 12:39 AM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:51, Josef Bacik wrote:
>> This probably can't happen even with a corrupt file system, because we
>> would have failed much earlier on than here.  However there's no reason
>> we can't just check and bail out as appropriate, so do that and convert
>> the correctness BUG_ON() to an ASSERT().
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> The handling it self is kinda OK.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> But still some (maybe unrelated) question inlined below.
>> ---
>>   fs/btrfs/relocation.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 695a52cd07b0..d4656a8f507d 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1870,8 +1870,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
>>   
>>   		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>>   				false);
>> -		BUG_ON(IS_ERR(root));
>> -		BUG_ON(root->reloc_root != reloc_root);
>> +		if (IS_ERR(root)) {
>> +			list_add(&reloc_root->root_list, &reloc_roots);
> 
> I found it pretty strange that even if prepare_to_merge() failed, we
> still go merge_reloc_roots().
> 
> I guess we'd better handle that first?
> 

This is because the cleaning up of the rc->reloc_roots is dealt with in 
merge_reloc_roots().  It's kinda shitty, but something I'm going to address 
later when I rework all of this code.  I tried to limit the scope of this 
patchset to purely the error handling, and then I'll clean up the awfulness in a 
more complicated follow up patchset.  Thanks,

Josef
