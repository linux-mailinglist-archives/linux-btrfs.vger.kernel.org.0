Return-Path: <linux-btrfs+bounces-7981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A069F97784C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2231C24D81
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 05:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32D17A5AA;
	Fri, 13 Sep 2024 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="vSONBOMC";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="NUZHDXix"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F91448ED
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205155; cv=none; b=iRH3dNaofVdT56gs8mdt9WMNtjVaU3jWqsGenkemMnHKknxkY0lCLxhHRf0oH8BwgBelQHab5+BHbp5IN82SJvPT63b8zJrvrKNSe0ePhrAYTGHX7DmT4rYFSjS+/LEKmlf+GXKp7GhbCOMds6yl09Fw+op1c6doNpFJ/PsOp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205155; c=relaxed/simple;
	bh=k/8bxqVjSV1Yab8fiaIn7nhxoU5s3j6uizbiwHrhmyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H1KOwazAruE/T8jtSJ7ykx0cNe7mZlcaJ5Zwg0VrBzQOVQ4hsfbzMglGQC5FBHZWHGCE/4OwytgoKQ9RKM6mO6XxTNvhXMAQruTW8kd2jysGQQfnk9gLv6d2wfRf+UQkQ/QGKcYX7s5jujhU2JlSX6zwjcvwFuyw7cMC1U6J3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=vSONBOMC; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=NUZHDXix; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <c275d2c9-20d9-46ce-82ab-3f86c091a5d3@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726205143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdcmefc0hK9z/Udz4aMmKjHAgTI2YwkksVKgVlZqvkQ=;
	b=vSONBOMCcc+omLEwcnsrdvmkI5K6j9o3mQ5vYW6KTVN6NSd9X4tB1GcL4UZSs1Kh8f00Jw
	im0nBqvsUFnzwpdV0kvsD+UocHRoI2JdP4CJf0MfVx3mGL7w+lCgP7hQ/iSnuFqUZhHN9U
	EKC/kjyllfuHxn0skSJxJ5hqbOwYSqO8D0FfYDa/mXY02y2KbQVS9LWmzaimMvRXnUUOOA
	6wcgmkGovWufWrxAAPVh07fQynZ4dzFxKZtWubcgHpNthjjIkjISysAMPmY+9JP8+eyrO9
	PeJBCm0LvD6AqNc88SiAJ76hMantReCnyw/IJCR2+C4lDSRqjCN7LjsTCUTYYaX12GZXFv
	D3VtSxo0aAlx8/xtSmrViEPKypFuk7LzYBQ+45ZPQthOaHVgfkRTgYbL5PAivhwsnW02eW
	qPIv3onFccgAPDQntVQaIDvKearWONUmHfkD1/1BZPJMoU+vW2VaVuFBKPd3gYX6mZMpCx
	Db5sIOXPC3CSeni9AooI7uYHp+SJ9RcBHoJSNDWA88i4YOocc89I0W9725ZhI48mhSXHYQ
	FdhlNTH+QL/vn55jH6W0tqTShUTk6D9sIfub7u+nsj+4Arj3wfrVIQgb5LNcnH5pOmRYhr
	Yp9yf+2AS7477tLKwPu62Q+kOYn9y8xuHpE3Qnbor2jzbgKtixXns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726205143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdcmefc0hK9z/Udz4aMmKjHAgTI2YwkksVKgVlZqvkQ=;
	b=NUZHDXixPTqJnX38V7EPwlbYSgItzt776eJzbFgitQod1dvAMa+JrWZbUiX9QDQbiJ8nSl
	+Qj7d7jp9/QS3FBQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Fri, 13 Sep 2024 09:25:36 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Critical error from Tree-checker
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
 <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
 <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
 <1ee66f34-b855-4a96-bf75-a3d14b9ce392@suse.com>
Content-Language: fr-FR, en-GB-large
From: Archange <archange@archlinux.org>
In-Reply-To: <1ee66f34-b855-4a96-bf75-a3d14b9ce392@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 13/09/2024 à 01:42, Qu Wenruo a écrit :
>
>
> 在 2024/9/12 21:43, Archange 写道:
>> Le 12/09/2024 à 14:23, Qu Wenruo a écrit :
>>> 在 2024/9/12 19:34, Archange 写道:
>>>> Le 12/09/2024 à 14:01, Qu Wenruo a écrit :
>>>>> 在 2024/9/12 19:27, Archange 写道:
>>>>>> […]
>>>>>>
>>>>>> [3/7] checking free space tree
>>>>>> there is no free space entry for 0-65536
>>>>>> cache appears valid but isn't 0
>>>>>
>>>>> Then it's totally fine.
>>>>>
>>>>> For the 0-65536 problem, mind to provide the following dump?
>>>>>
>>>>> # btrfs ins dump-tree -t fst <device>
>>>>>
>>>>> I'm afraid since the fs is somewhat old, there may be some corner 
>>>>> case
>>>>> btrfs-check is not handling properly.
>>>>
>>>> ERROR: unexpected tree id suffix of 'fst': t
>>>
>>> My bad, it should be "btrfs ins dump-tree -t free-space <device>".
>>
>> The output is too big for an email, so uploaded here:
>>
>> https://paste.xinu.at/XtR8/
>>
>>> And if possible, also "btrfs ins dump-tree -t extent <device>" just 
>>> in case.
>>
>> Same thing (even bigger), also output on the terminal and while 
>> redirecting to a file was quite different (but maybe that’s more 
>> because something changed between the two calls), so here are:
>>
>> – the cli run : https://paste.xinu.at/9vs/
>>
>> – the file run: https://paste.xinu.at/XpzhbZ/
>
> Thanks a lot.
>
> This indeed shows a very old filesystem, and for a long long time, we 
> no longer create any block group at logical bytenr 0, thus it shows an 
> corner case that older fs layout doesn't exclude the first 1MiB.

IIRC this file system was created in 2016.

> And it's indeed a false alert.
>
> In that case, as long as you still have unallocated space, you can 
> just relocate the system chunks:
>
> # btrfs balacne start -s <mnt>
>
> Which should move the system chunks to new locations and will not 
> utilize the first 1MiB reserved space.

# btrfs balance start -s /
ERROR: Refusing to explicitly operate on system chunks.
Pass --force if you really want to do that.

According to https://btrfs.readthedocs.io/en/latest/btrfs-balance.html, 
-s requires -f, so I guess I should continue with that?

Regards,
Archange


