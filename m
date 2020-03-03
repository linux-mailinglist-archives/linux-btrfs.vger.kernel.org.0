Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B871769CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCBD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:03:28 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36523 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCCBD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 20:03:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id f3so1829860qkh.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 17:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FBordWqZua0AZqOabwjlHLfZeRkKBnJBmxqjWyazqfA=;
        b=a8m8Vn8Y6OJNkQBy+nxXxA8fOC9V/TEC6qpLMLN9V3rf0DbM6i+n2az6HkEI/AuJyb
         R1x2RImlWfFgav35n6pEs+BRGpoz5l7SCG5Ngom2hQ2z4XU06rYOLT6if7O67dnTCpEa
         qx5HKfPxTWdib5Md0xi41WH4SvBV7h1mwpHhBVebIx1YtKFVok2oYOJdrrIqOWZotVfy
         rKxFh+LslTM++d0Az2bPeAAktQoK9PoNhKKS9P8DXWWbmXQDD1UwA+5Aod71myWBvDTE
         oK3KZlgJUaJz73ZsiRNcg9Z5E1LrLK7r1ztqrAI/J8iSlR8APRugW+TCa/QZ06ACD2aH
         9/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FBordWqZua0AZqOabwjlHLfZeRkKBnJBmxqjWyazqfA=;
        b=egd8J6h7bF0lN6Bj0+g3UyCz26dvurRA0EyO/VPTbc6wU/+Irszkfs7YgoLCYhvjZS
         CJFgSRRfDy+Ic6SQBwjkIDyNsisE6jEuF00FVYkDFLovlaEiQ/nsHVWH5+Mt/54HgF5U
         u0nQfyA6RkfkhEr+tAc4srBMkBDVoBApXe4IHbb9WedYUEFKstpRxCRA/ymVCJ3cLrjd
         Cwrtgfv5d7j7drQ2H8epQ+0ipzdJT0uMmsu2/bsFP18zWPviVONLJ7OmxqlZf794Qo0e
         bGAWjvdijwZWeJ9xxcVG84UJpcwvJQorLmvKVVpyJ+qD3uQjgnzrxRIsgBQJGi/hjkil
         5Y1g==
X-Gm-Message-State: ANhLgQ3BSvgJpzNuJK+Q4Ch0o6bqKUMCqD3qDnEUHmIHFVVg33+a8ywM
        FNOqP0yxgjPCMXXZmn5dqwPT7JkqKVk=
X-Google-Smtp-Source: ADFU+vs0ZKSOFgK1x0PZQC4PohwI5L5lB5FP3SxMDMHmzL0T04Ta5PcfKntltZleFC6Qldmx5v2whw==
X-Received: by 2002:ae9:e202:: with SMTP id c2mr1957835qkc.224.1583197405923;
        Mon, 02 Mar 2020 17:03:25 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z194sm11192106qkb.28.2020.03.02.17.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 17:03:25 -0800 (PST)
Subject: Re: [PATCH 2/7] btrfs: unset reloc control if we fail to recover
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-3-josef@toxicpanda.com>
 <27afa0d3-e030-b53a-0033-674f13199c68@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c6f1b946-6efd-83e9-7013-92f511cdf294@toxicpanda.com>
Date:   Mon, 2 Mar 2020 20:03:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <27afa0d3-e030-b53a-0033-674f13199c68@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/20 7:58 PM, Qu Wenruo wrote:
> 
> 
> On 2020/3/3 上午2:47, Josef Bacik wrote:
>> If we fail to load an fs root, or fail to start a transaction we can
>> bail without unsetting the reloc control, which leads to problems later
>> when we free the reloc control but still have it attached to the file
>> system.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 507361e99316..173fc7628235 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4678,6 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>>   		fs_root = read_fs_root(fs_info, reloc_root->root_key.offset);
>>   		if (IS_ERR(fs_root)) {
>>   			err = PTR_ERR(fs_root);
>> +			unset_reloc_control(rc);
>>   			list_add_tail(&reloc_root->root_list, &reloc_roots);
>>   			goto out_free;
>>   		}
> 
> 
> Shouldn't the unset_reloc_control() also get called for all related
> errors after set_reloc_control()?
> 
> That includes btrfs_join_transaction() (the one after
> set_reloc_contrl(), which looks missing), the read_fs_root() and the
> commit transaction error you're addressing.
>

It's already doing unset in the join_transaction right after calling set.  These 
are the only two missing paths.  Thanks,

Josef
