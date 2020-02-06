Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4125154937
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBFQaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:30:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39460 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgBFQaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:30:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id c5so4948422qtj.6
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MJOzgHJxL54ZrT0rLqRtwPdIKB/XnJsGgj0LMId+D4c=;
        b=VBnoIAehaydo9qRMPKqirSBtAYBB3bCM/SFVMaf/M97CITYBLVupMxiU8HKw6gc7dh
         eTXduPPU8znmZB17XgOAEmmW5r+fbNwXFe+ezr4WSzKolQD4k2iAQkjTnfK1As6yACVS
         8UOUIdxGKyg4ypK+xAOruA5SB8H1hUrfg5cL9BAXjJor2qqmPh8S7slaTVqHd98PTHQM
         TP5rMjhN/68RLhdryfydZfUjWdkHeC1SLzo70Dz+lTRRLYe8SXHw5H3GU9jEJWEViHKS
         KYJUrqsjlJW86mp3tIy+Q+b6ZWDddhZ9lJZ7Tw+I2CcXRbLcRCigBO/Wz5Qf6scvnxuj
         YvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJOzgHJxL54ZrT0rLqRtwPdIKB/XnJsGgj0LMId+D4c=;
        b=O352sRmEiiLVb0EK2U1PTTL9sNZxlnixgLvG1z/E43TsfgJOIrMz+FSac4jB7gBSqL
         WPXKkcWxAEghMD96xHezg2mWMzY09zjHavzzq8J4Nmrf3gcDV8kxawYDA0+lSJTPJjB5
         c79NoRvTys1xcIL39e+cie4qdSJULshFk+kVQ+NborIJLnMes1E5jRNrRgBVjnqbAqkp
         wUUoKZu5dPG7UB3DKcip0o0ubJfU7sV2XbyObzDN4u6J/Ms9MMwczqm64C99vroE9bsL
         8fjpZM5uutDqDnMr4RGg8bHQJFpQJzbHfo266C1ETU26AAmBGoeXao4vlwEWHFBFYTLK
         h+8A==
X-Gm-Message-State: APjAAAUMEcCwKZ1kIobybstT8SRIRQEAOqoqrcPDnYkNr0jf1QVDkGxe
        DS/LaFGnypnnhUiHMB/y0vksw4G/cXY=
X-Google-Smtp-Source: APXvYqwgqzNYVjstz8ZUzrsyGPKk8WbmUuZUn5OF2qSoaxKpiUp1kRTOdHhHd8aqCiWTXNSGF9fxaw==
X-Received: by 2002:ac8:349d:: with SMTP id w29mr3426419qtb.386.1581006605243;
        Thu, 06 Feb 2020 08:30:05 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b19sm1619387qkj.99.2020.02.06.08.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:30:04 -0800 (PST)
Subject: Re: [PATCH 27/44] btrfs: hold a ref on the root in
 btrfs_recover_relocation
To:     dsterba@suse.cz, kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-28-josef@toxicpanda.com>
 <20200206162619.GZ2654@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6be9cea1-942d-6f55-4f52-fec93be7554b@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:30:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206162619.GZ2654@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 11:26 AM, David Sterba wrote:
> On Fri, Jan 24, 2020 at 09:32:44AM -0500, Josef Bacik wrote:
>> @@ -4593,6 +4593,10 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>>   		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
>>   			fs_root = read_fs_root(fs_info,
>>   					       reloc_root->root_key.offset);
>> +			if (!btrfs_grab_fs_root(fs_root)) {
>> +				err = -ENOENT;
>> +				goto out;
>> +			}
>>   			if (IS_ERR(fs_root)) {
>>   				ret = PTR_ERR(fs_root);
>>   				if (ret != -ENOENT) {
>> @@ -4604,6 +4608,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>>   					err = ret;
>>   					goto out;
>>   				}
>> +			} else {
>> +				btrfs_put_fs_root(fs_root);
>>   			}
>>   		}
> 
> The order of IS_ERR and btrfs_grab_fs_root is reversed but then it looks
> strange:
> 
>    4637                         fs_root = read_fs_root(fs_info,
> _ 4638                                                reloc_root->root_key.offset);
>    4639                         if (IS_ERR(fs_root)) {
>    4640                                 ret = PTR_ERR(fs_root);
>    4641                                 if (ret != -ENOENT) {
>    4642                                         err = ret;
>    4643                                         goto out;
>    4644                                 }
>    4645                                 ret = mark_garbage_root(reloc_root);
>    4646                                 if (ret < 0) {
>    4647                                         err = ret;
>    4648                                         goto out;
>    4649                                 }
>    4650                         } else {
> + 4651                                 if (!btrfs_grab_fs_root(fs_root)) {
> + 4652                                         err = -ENOENT;
> + 4653                                         goto out;
> + 4654                                 }
>    4655                                 btrfs_put_fs_root(fs_root);
>    4656                         }
>    4657                 }
> 
> Seems that the refcounting is not necessary here at all, it just tries
> to read the fs root and handle errors if it does not exist, no operation
> that would want to keep the fs_root.
>

Yeah we aren't actually using the root here, so strictly speaking we don't need 
the refcount.  But in the future read_fs_root() will return a root with a 
refcount so we will still have to clean it up.  Thanks,

Josef


