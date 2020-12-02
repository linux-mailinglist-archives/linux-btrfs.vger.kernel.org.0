Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7412CC4BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgLBSMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 13:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgLBSMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 13:12:52 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A93C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 10:12:11 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so2122258qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 10:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zDbBdlctZ76niyvHdhBuOr2MW7BBEU0p9iCS3QDrMi0=;
        b=szZXyDZRSnmOE3/DyI2fR8lVFlfcRBmjhDw+O7RxJcAd3Lw3r97pJhn0MnLrGhxCzf
         ROSxD4ue7mpdFgxpRk8oF0v25cuFzope4oip5u/oiWNPeU6hWsO/ctbe5LEQ9eMLJQx6
         MPdMXOFqVFhfnv936m1BKeyqLww1vzhPyFXz4w4Km/FUr64s+K3W4OBDSazBNUk1P1RP
         ht4It0j8f2omIlvg5DiHj0JbCWAA22kTVdtLo4cuDeyKRq1Nvq/ySDNTHaIp+fu4Yco0
         LYjV5lGfnDvpOIRFtF4KjuJ6g7h2LEwth6WmErrrKTpBqtvUb1qDdV2Eeq0xGCtAfvC5
         lUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDbBdlctZ76niyvHdhBuOr2MW7BBEU0p9iCS3QDrMi0=;
        b=DadHuJBYOm+ncRylOIoGvbZIH6lHIWiXlpgkutgSVhkunlKkS/1ZICGIagErQjrFqO
         FtG3dJcf0rZl1/kBaeTd5gRXJ9jZHK1ePaVecgisNrRDKgUfeAGA1U8CmKC/lrJm3d/R
         vMfClilgnSsvSGoEE3GMP8atwGYXcOMYDm72YzcrdQxNsSKVayQlfoV+bYvrxBbsW6xo
         ODi97vqi9oWcXj67NXs2rmBDZYAtUuszdefWtcgbOalUTF5c7AmUap5YL65oDrg7LSTP
         6SigPBYgStHH+j4NgOiPU0Lut4LThvafkMh5W7CLx6f/mfikXjQiK+V/DukrBXURbRFb
         h5IA==
X-Gm-Message-State: AOAM53380WwDIzCg3L1+8t4gMvIkVuWoD2G+toXxY4RwBnpDCG8TAufm
        8/AyuE1nMzWpkJ9AJFlkUB7taw==
X-Google-Smtp-Source: ABdhPJzaGaAwe1YaQ4UsxOJ3egiACdRUOEAZ7tV/hTA79oHYsW+D97K3DGuqcF5B3urkJt1EPBUghg==
X-Received: by 2002:a05:620a:148b:: with SMTP id w11mr3901195qkj.424.1606932730841;
        Wed, 02 Dec 2020 10:12:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1348? ([2620:10d:c091:480::1:f2b1])
        by smtp.gmail.com with ESMTPSA id b64sm2454316qkg.19.2020.12.02.10.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:12:10 -0800 (PST)
Subject: Re: [PATCH v2 14/42] btrfs: handle btrfs_record_root_in_trans failure
 in create_subvol
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605284383.git.josef@toxicpanda.com>
 <dc7a7364fc721d327df03636cfe2dfc724f50e7b.1605284383.git.josef@toxicpanda.com>
 <6771e745-82c4-5bb7-5f2b-5296f2a752e5@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0f926a61-06c7-0a8c-8c38-f739dc49ed02@toxicpanda.com>
Date:   Wed, 2 Dec 2020 13:12:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <6771e745-82c4-5bb7-5f2b-5296f2a752e5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/20 7:42 AM, Nikolay Borisov wrote:
> 
> 
> On 13.11.20 г. 18:23 ч., Josef Bacik wrote:
>> btrfs_record_root_in_trans will return errors in the future, so handle
>> the error properly in create_subvol.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ioctl.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index a5dc7cc5d705..da9026a487d2 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -702,7 +702,11 @@ static noinline int create_subvol(struct inode *dir,
>>   	/* Freeing will be done in btrfs_put_root() of new_root */
>>   	anon_dev = 0;
>>   
>> -	btrfs_record_root_in_trans(trans, new_root);
>> +	ret = btrfs_record_root_in_trans(trans, new_root);
>> +	if (ret) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto fail;
>> +	}
> 
> I think create_subvol is broken w.r.t handling of anon_bdev when an
> error occurs since it's not being freed in the "goto fail" case.
> 

The comment above addresses this, it'll be cleared at btrfs_put_root() time. 
Thanks,

Josef
