Return-Path: <linux-btrfs+bounces-69-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4F7E7D80
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Nov 2023 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33197B20BC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Nov 2023 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4131DA56;
	Fri, 10 Nov 2023 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKGm2ReK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FE1DA30
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 15:46:29 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC83B318
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 07:46:28 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778927f2dd3so131914285a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 07:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699631188; x=1700235988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ADd/M3T42KSWSW0ZN0cddGMNEq9cR/QQFUnUqankSU=;
        b=NKGm2ReK0F5AidpjXRUWCGyzBMN24XuZrNaoPlm0ZyyispsQGQF2zzYwbWIaFBIUO7
         2+p8HEvujbv4ldFv8XvFuHEJiyMojyyufFmFRqjpHZhWk+YVF/G0u3LNhAxSVx06qZBl
         WTXLhTUhjSZFZ81+dGRqIrLleHr5Q9Iuf0EuXDQ4Son0MelcYVQj0CRg9KHy48OE4bEx
         pXJD104oFl7SK2df6i2Yi2e+JgDAuG/yYDV9R/rwU+y2lmp+iKVOVYBfTv6M2prKr9cw
         g84ahGihMraax6dRW2xuIlam8KikTcRRsSOhE3jzqfEMFvYZrOZUYWme/CaMb1lnChh1
         RIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699631188; x=1700235988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ADd/M3T42KSWSW0ZN0cddGMNEq9cR/QQFUnUqankSU=;
        b=dhd4bebuYi4+kM0fpSXgbARidZGFa5iv5x6AYoHg5SogQaVmwRg/AmchafCvy/4/xz
         84kafs8wgiclqBT7KRxBWJIDIwF57seIzqR0OSXlECuPExM/ekQ9cynYywLvAedzhOwG
         2tHEiulWi9aliyczne/erq/87YZIItboc9x7jQ/0rHSo9azCJayJIC/HxOxqLhGf5Lk1
         E7lPO2XlsW+UwVmkhIuMAt5hIVIJSinACQQztYw0rEJA0kvlhxcV+V4UmlA/L/9aTA1d
         mfxzqwHwpJEIu2V7EKrHSUvZNc1asKGwiO9DBcWmfIZE+pOEBFI4MqoqJjO7P0tJuaRv
         FVZA==
X-Gm-Message-State: AOJu0Yzqxq2bOzCzug91CnZEScOwoLR3g10hPZXYoWFJ6lYuGw6JmfNb
	ln1VSab9a1xTtDXP7SBZ0BDfE6hnd4o=
X-Google-Smtp-Source: AGHT+IHPlTXJjDYpaU0CtByLCh7dbv0Uyo9rwiBr+/tqoVKWwgS2v5TNXv6o3B6DGXTdneUvUGiwUQ==
X-Received: by 2002:a05:620a:8c7:b0:76e:f496:1928 with SMTP id z7-20020a05620a08c700b0076ef4961928mr7106911qkz.72.1699631187866;
        Fri, 10 Nov 2023 07:46:27 -0800 (PST)
Received: from [192.168.1.1] (pool-100-16-13-166.bltmmd.fios.verizon.net. [100.16.13.166])
        by smtp.gmail.com with ESMTPSA id pq10-20020a05620a84ca00b00774309d3e89sm775120qkn.7.2023.11.10.07.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:46:27 -0800 (PST)
Message-ID: <b4162dad-af4a-4d45-b933-697739a3d80c@gmail.com>
Date: Fri, 10 Nov 2023 10:46:26 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs progs release 6.6.1
Content-Language: en-US
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231105222046.19483-1-dsterba@suse.com>
 <aa605999-708c-4b8c-a05c-78fd2cc6b5b2@gmail.com>
 <be0c51ba-86bd-44e7-884a-6cfccfa76184@gmail.com>
 <20231109143830.GT11264@twin.jikos.cz>
From: Joe Salmeri <jmscdba@gmail.com>
In-Reply-To: <20231109143830.GT11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/23 09:38, David Sterba wrote:
> On Sun, Nov 05, 2023 at 06:40:45PM -0500, Joe Salmeri wrote:
>> Is there a way for btrfs to remove that directory entry which points to
>> the inode that does not exist ?
>>
>> After I removed all the @home snapshots, that got rid of all of them
>> items that btrfs check reports EXCEPT for the one in the @home subvolume
>> so deleting a subvolume can remove the items, but I really don't want to
>> have to delete and restore the @home subvolume to fix it.
>>
>> And since then btrfs has created new timeline snapshots for @home so
>> those obviously have the same issue as the ones I deleted but that
>> problem would go away if I can find a way to remove the offending item
>> in the @home subvolume.
>>
>> Is there some way to remove that item ?
>>
>> Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also
>> shows that offending item:
>>
>>       drwx------ 1 denise joe-denise   72 Nov  1 22:49 .
>>       drwxr-xr-x 1 denise joe-denise 3.7K Nov  1 20:07 ..
>>       d????????? ? ?      ?             ?            ? 02179466-b671-4313-8fa5-0eb87d716f92
>>
>> I tried removing /home/denise/.config/skypeforlinux/blob_storage/ since
>> that is the folder that contains the
>> i02179466-b671-4313-8fa5-0eb87d716f92 directory item but that fails
>>
>>       rm -rf /home/denise/.config/skypeforlinux/blob_storage/
>> /usr/bin/rm: cannot remove
>> '/home/denise/.config/skypeforlinux/blob_storage/': Directory not empty
> On a mounted filesystem this is not possible, also I'm not sure what
> exactly is the problem there. It looks like the directory entry is valid
> (thus it shows the file name) but the pointer to the inode is either
> damaged (cosmic rays) or the inode is gone for some reason.

It seems to me that the issue is that this directory

	/home/denise/.config/skypeforlinux/blob_storage/

Contains a directory entry for this child directory

	/home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92

which has an inode number of 31996735 based on the btrfs check output

     [4/7] checking fs roots
     root 262 inode 31996735 errors 1, no inode item
         unresolved ref dir 132030 index 769 namelen 36 name 
02179466-b671-4313-8fa5-0eb87d716f92 filetype 2 errors 5, no dir item, 
no inode ref
         unresolved ref dir 132030 index 769 namelen 36 name 
77ef9cd4-0efe-46af-bf7f-47f582851e16 filetype 2 errors 2, no dir index

But that inode does not exist based on "find /home -inum 31996735"

usr/bin/find: 
‘/home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92’: 
No such file or directory

Therefore since the inode does not really exist nothing will allow 
removal of the directory entry for

	/home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92

> The 'btrfs check' should be able to guess what's the extent of the
> dirent/inode desynchronization and remove the entry eventually, but as
> always 'check + repair' should be used with care and when absolutely
> sure that it's not making the things worse. Some cross checks could be
> possible, e.g. look up the relevant data in the tree dump.

I have been reluctant to do btrfs --repair because of all the warnings about how it can make things worse.

I would be nice if it would prompt before doing each repair step, but I have never run it before and suspect it probably does not do that.


-- 
Regards,

Joe


