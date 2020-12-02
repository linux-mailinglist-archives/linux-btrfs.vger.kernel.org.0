Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DA2CC52A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgLBS3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 13:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgLBS3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 13:29:51 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E34C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 10:29:11 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 1so2208553qka.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vIemTzbZoT86zpPT+F5Fue/iG2vajm+y7xywGlIcQTU=;
        b=T73uAyQj7MStxmitu2VIWYsBpk3suP0K0kL80maXVkmuLc9304s51VlvRxahO5YFaR
         pCCt/MBiiQgNHf12vUC8Hs71kPhs6v9Tq4U6sEUuty8kaF87wceFn9LsFzx8rDGjl37B
         RGklOXug+lwDVMjYSkQjLCM/1scnTZfufmPJShsCXVUA3L+NOLlnDFqjpUdVayuLkNOp
         rc4VtJ4l1lwmy0CrW7nfBwrUiHAXKPIqtGm9uFvssdZ77TZNeAPWwWPTLXbFysYAySbs
         o405y0/wYR2uTmfraCREhM9jbCpd3WU80e5xD2ZhFxJhxHkMOtdNglMbqH9yk9evcTu7
         MAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIemTzbZoT86zpPT+F5Fue/iG2vajm+y7xywGlIcQTU=;
        b=jyoeaFKF+OqE4w0EKTWxOQUVh5RLoufRQoQnBN8tf58HC9diU0sr+YvTvAodQvrdwo
         CnbX/Y+ndXKEIMUzqDFUVsw2nEy7e79TCtsLSqYEZnXrNGOH1O8NNvMnKtVCC6HKcA9T
         oTEnlDHlfFG6LhAcPJG85FWl1rR3tbilDapxAE4o0YzuvC6UHlWWGwgRQCbMYQJrK0cS
         9k8AYjuOBqCKnduJvGbaVJK9ELOMhjpw5NLwuSFg739447BMw5g7U7fNMU3gqAcjwqxN
         LeXVZiU3rGA/mzjkBxUXf21RHz4cJNtSFaOAJYE6enQBOPpaAQhOUbXBxdsvieiGId9z
         t22g==
X-Gm-Message-State: AOAM531HowoFXOYKQp+ZhDFBu6FZFqC0D4YAho5utBl3Ij4zVRUwrgdZ
        SVsm78RbttjRl4fPPmRxp27bd22giLFX0Q==
X-Google-Smtp-Source: ABdhPJwMioMTCqBljZ4R3EssQQF8iMgnq1COhKNhX8i/uzz+L8TByOQYxVWHwRyQoGbFOH4pe4hwtQ==
X-Received: by 2002:a37:9ec4:: with SMTP id h187mr3842219qke.154.1606933750722;
        Wed, 02 Dec 2020 10:29:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1348? ([2620:10d:c091:480::1:f2b1])
        by smtp.gmail.com with ESMTPSA id i21sm2483726qtm.1.2020.12.02.10.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:29:10 -0800 (PST)
Subject: Re: [PATCH v2 37/42] btrfs: handle __add_reloc_root failure in
 btrfs_recover_relocation
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605284383.git.josef@toxicpanda.com>
 <330382a46504f48eda1aace141dbf5c53d81c28a.1605284383.git.josef@toxicpanda.com>
 <718465a6-8149-092f-71c3-334cbb805877@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ddd23440-46f0-dbca-b9be-f09db60c9afe@toxicpanda.com>
Date:   Wed, 2 Dec 2020 13:29:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <718465a6-8149-092f-71c3-334cbb805877@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/20 8:26 AM, Nikolay Borisov wrote:
> 
> 
> On 13.11.20 г. 18:23 ч., Josef Bacik wrote:
>> We can already handle errors appropriately from this function, deal with
>> an error coming from __add_reloc_root appropriately.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index c4b6eef70072..e2994fb15f2d 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3951,7 +3951,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>>   		}
>>   
>>   		err = __add_reloc_root(reloc_root);
>> -		BUG_ON(err < 0); /* -ENOMEM or logic error */
>> +		if (err) {
>> +			list_add_tail(&reloc_root->root_list, &reloc_roots);
>> +			btrfs_put_root(fs_root);
> 
> Do you need to do the the put_root, since
> free_reloc_roots->__del_reloc_root->if (!list_empty(&root->root_list))
> will set put_ref to true and put another reference?

Yes this is for the corresponding fs_root, not the reloc root.  Thanks,

Josef
