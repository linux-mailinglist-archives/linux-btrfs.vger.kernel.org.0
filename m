Return-Path: <linux-btrfs+bounces-3680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F588EF89
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 20:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243381F3291D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0A15216E;
	Wed, 27 Mar 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UA6SJtJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839951E52C
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569076; cv=none; b=o8qeIq8CbESRWKhfAx0djqdj7PvNd0cD3y6yLoHQ1zab82hoEVi9+JEPqQItk/6Xrg72fGpsasjGbHgEuqobT84JRyWEs3pObYSsJckozY3ZNAHMq30pWH6VWP1gETP9yXaFrk+2SmcQ0c5G4ko3tUOg++RPCV0uPK1a4R6jADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569076; c=relaxed/simple;
	bh=JO1PuXqWqX4yUuXIME1M1zgrbMSYqBLM+QqUbDfjUag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEWvEvqfKkn37nhBU3s0jz8+nvfYONIGfuOPk54jUMb7rjEP/chsNOxyvaQ/H6TPKBFqPckat05/XhbJdqeCF2FCFg4yQR1Z/BgBnluDtzPNxG36ON9GPKGb9S2NJpQZ0DVv6trQ/PF07325JPmOUBAGlfKL1RrteggFy4VBuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UA6SJtJ8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so7861555e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711569071; x=1712173871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8qCE9KtIXnSJg0e8fWKVE6zAwwbsf5RobrnWawLyVqk=;
        b=UA6SJtJ84vm9zR1LRyIsf8sXvuZlsFDo2MsvK53u32nciY7FW2ME4BsJGuG0SCroO4
         pdFX7PV2Tume1bBtchdO2FS29Qh6c9QYweBVlAXyLPfMq69PlChxqIzuKr/Bd7JQ4Hci
         s964dyWPiKDORoa5LHWhgx+tnbzirtdlYMJ/vnqX2OTC+G2spYFugdcf0ab6H+YDszdZ
         rA9hMkpdkS38CHDQ0/qTYtHpzYhsC1K1xntDbmvBuTo0WFyn9dPlrVaJ7RTozXgRSqBt
         VRCo85lTVcXsL3/vf3ser1e6P7zHz3O1DszE01536xKwfuhUIEORNaMwYh5iVWwktYdU
         ERug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569071; x=1712173871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qCE9KtIXnSJg0e8fWKVE6zAwwbsf5RobrnWawLyVqk=;
        b=h6HbnbxrNAQAEIf8XfavdR5JiBJn3SLv1y4eWRlnBBBEq119uxeSzKh+yPfIYjj2zg
         yxoSDYaCIGJc7zccWgEH9GKwRBaX4VTGT9AmRI95xagFDqCk04zU316/HjagCv+3hbsJ
         MOu9ekluU+AJ9+F0jI0ftkoKKdONUcVLHEgTFZUk4i4wvJRb1SyAZPEGWxyRXjs1TyNy
         XFTu2hr7XAS6yh42FqnwcmLc0bAGsMZTedlLuUU4HlfVfs22XTuXTLr24I6YxsIo08Is
         xbdUUjmoi/nZfjFBXxNp35sQEnOIQgMGjjpYOvZA9FBit+BDG6sMN/Vx/M5mWyGw+/2o
         Hgrw==
X-Gm-Message-State: AOJu0YwcIQLTFpj1XpAhnxFXEG3EfPeDz57JDYuhlEXYnzRyeEMq/NL/
	raIV4Tn65ChiisgRaLzBv3uvCK1S6yLBmk1exEb5Wm9egU03IDp80Vh5Xq/YkpY=
X-Google-Smtp-Source: AGHT+IGhv2Nha/tvFn6yfe+WF6g7ulbH8/0UaegE/HMUw7Pe6ZNKCcPAknYgHBaln0BwlnT9y5aeyA==
X-Received: by 2002:a5d:4ccc:0:b0:33e:c0fc:5e4b with SMTP id c12-20020a5d4ccc000000b0033ec0fc5e4bmr232977wrt.2.1711569070750;
        Wed, 27 Mar 2024 12:51:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001dd55986b75sm9373299plb.183.2024.03.27.12.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:51:10 -0700 (PDT)
Message-ID: <fe0c22e7-f886-46ab-8225-596f4182bd37@suse.com>
Date: Thu, 28 Mar 2024 06:21:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] btrfs: free pertrans at end of cleanup_transaction
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <1697680236677896913e26948a76a2dd01dad235.1711488980.git.boris@bur.io>
 <78f3a17b-4b74-4b8e-b7c9-fa8a5eaecefe@suse.com>
 <20240327172234.GC2470028@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240327172234.GC2470028@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 03:52, Boris Burkov 写道:
> On Wed, Mar 27, 2024 at 08:46:39AM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2024/3/27 08:09, Boris Burkov 写道:
>>> Some of the operations after the free might convert more pertrans
>>> metadata. Do the freeing as late as possible to eliminate a source of
>>> leaked pertrans metadata.
>>>
>>> Helps with the pass rate of generic/269 and generic/475.
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>
>> Well, you can also move other fs level cleanup out of the
>> btrfs_cleanup_one_transaction() call.
>> (e.g. destory_delayed_inodes()).
>>
>> For qgroup part, it looks fine to me as a precautious behavior.
> 
> Since the call isn't per transaction, do you think it just makes more
> sense to call it once per cleanup not once per trans per cleanup?

Yes, just like what you did for btrfs_free_all_qgroup_pertrans().

> 
> Or would you rather I refactored it some other way?

Just an idea for future cleanups (moving all global cleanups out of 
btrfs_cleanup_one_transaction()).

Thanks,
Qu

> 
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/disk-io.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 3df5477d48a8..4d7893cc0d4e 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -4850,8 +4850,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
>>>    				     EXTENT_DIRTY);
>>>    	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
>>> -	btrfs_free_all_qgroup_pertrans(fs_info);
>>> -
>>>    	cur_trans->state =TRANS_STATE_COMPLETED;
>>>    	wake_up(&cur_trans->commit_wait);
>>>    }
>>> @@ -4904,6 +4902,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
>>>    	btrfs_assert_delayed_root_empty(fs_info);
>>>    	btrfs_destroy_all_delalloc_inodes(fs_info);
>>>    	btrfs_drop_all_logs(fs_info);
>>> +	btrfs_free_all_qgroup_pertrans(fs_info);
>>>    	mutex_unlock(&fs_info->transaction_kthread_mutex);
>>>    	return 0;

