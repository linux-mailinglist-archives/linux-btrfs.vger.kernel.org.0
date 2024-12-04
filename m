Return-Path: <linux-btrfs+bounces-10061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD39E4475
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 20:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61098165E29
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB81C3C17;
	Wed,  4 Dec 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwA5dEug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9851C3C0A
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339850; cv=none; b=a+mH9nh/Bk2Zx/HR3mlVGemJzq6d37TmwZsptv7FkDbp83UFERyIrJymk/BPMT9FeVYojsj2DCwx2zc+VPcFFWlTRSeDNN24q3eJDtBVe7xSViLWidPLaSaxgFIuXBsOMT64WKRv8nII5AlHoL5kBzmenIDhMqEzuu9bbpIF5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339850; c=relaxed/simple;
	bh=K+SaX9K/yUOCQMt0fS2xd2UPeikTdLVfgNmKeDB9xB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X9omMArPVjyqdkg11aUw210AJqyXd2zD0ile3Zu/DyK/t7IHSxsGGPknpRnwzQ3BSe+os6I7busblvwAVMb/Q9tckdsmfnAJ3ILJl5xOT+6qJK36jfsoWr9w/TDXkFPEKUpnJFmDGClgMTKV4pzdJHKv4oncSELr1fp+gyzVJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwA5dEug; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso647301fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2024 11:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733339845; x=1733944645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmywcN091E9HtokrB992xrhgLxVckajVXu8WQAOqgI4=;
        b=CwA5dEugUnfqMhxN+9q2q+i0tphC+a9Q86d7jtrsTalALCNrXP1XmquGIGcdxlD/5n
         6FT0ckUiYCP9kpyHCgiAONc5zLv7gjIZxg9y5Lg7vjMGhMUOlAcXLUOJ0JXfA+qq+RmN
         GCfgmiebINkvWoVKLs8K1f7Ft5ngL+T615IBr8AYVcsDoKI2ciTP3atTXZys98lKUUn+
         hoPdgNU0tD8XzTAP1240o8ryHJzISeOV05dyPuxC+eYAaXLrIaHPYR7vKUQgjqBHJ+hc
         aAFPp4HMrwIZtA9f746GFlEULOsZpiOy+g7eOrSpdmnGQM9eWGt7PZMsyDq+8qPt6FjX
         F0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339845; x=1733944645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmywcN091E9HtokrB992xrhgLxVckajVXu8WQAOqgI4=;
        b=QJkIz3lc7h0g3HS4sYseWGhIBJ+tbEB2LUWjqu4Qh0yHgBJ69vvCwa4jO8HtnkAZUz
         +Fm4BwRUUOYxYwlT+SsTEgV5jJXfK8+I0ULlvile+mQSMfCZhqgWEMlCtdSKjG1iyiFu
         +3/njDP5w8ILRor0W3QmYKgVlvS9FZ/xxNUjseFo1t5cUxDoY9Ci9rMW3PfPpI0gJnmc
         o0Wite1GwUBufzKHBRrmtI/KMYImQNJ5rsHrlYdEBrDkoIhCZ/GnR2RKdB9A1P2nRaBZ
         DiGK7HcjgjYe5zwnIhwb6vyhpiNv6EFREfWT627nZgAvUvfy4rEjkDz2lWsSJ4un3nYi
         scaw==
X-Forwarded-Encrypted: i=1; AJvYcCUZN5bKdy7Ju9d5MYvel1aWtKn6sjSe+yErTV1Ecl5cifVvJMD0UEjiDlTdbOyGhdAjgl58uak/xQZsrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwObk2vF7QHBKRb6piawnO+AmVpzhpgh+zoB/Euqnc3JEj5xEld
	YGkhrmAxiahCana0TVsfxFjqPJ2FddDNFLSX2hXMqif8YdVPwTiF
X-Gm-Gg: ASbGncswZt7l8BSp0SvhIbV4+0suDePhDhNVT8+ZfWu7im/xugq0N5rIsu6cTMgfOjE
	kxOSgNjCAWOy0e6KnmG1womNK+1sMEn6uBgAnxb1r7eh0MgP7IrFAy5j+fslh3eueXFAYINAfpy
	GMhkNWd58VJtZ3OzMnM4oaYWohOD6vi2HKDNB/OYO8zaIYtAfXOO1vNRMD2Xf/pCbsQbmLYOYrS
	tBgvfZd5A1MXIAKdk5m51jL7eZbGhWJR00CgoqVO5fhb0QVvCLT05sAwksOVjhH1BNxVBFUFbP+
	VIgTW35NF0tnL8PNtliQkXh3
X-Google-Smtp-Source: AGHT+IGYxKWRR2zX2C6ms48e3iXBcjiWrKleiOzQfUsGPDT8MwOH+JlfcSk7WtQvYnkWbJZJ7bfULg==
X-Received: by 2002:a2e:bd8b:0:b0:2ff:d32f:f881 with SMTP id 38308e7fff4ca-30009cabaa0mr49847081fa.38.1733339845179;
        Wed, 04 Dec 2024 11:17:25 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:4d35:5668:cbfd:6319? ([2a00:1370:8180:3d9b:4d35:5668:cbfd:6319])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbe53b7sm20554191fa.31.2024.12.04.11.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:17:24 -0800 (PST)
Message-ID: <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
Date: Wed, 4 Dec 2024 22:17:23 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <wqu@suse.com>, Scoopta <mlist@scoopta.email>,
 linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

04.12.2024 07:40, Qu Wenruo wrote:
> 
> 
> 在 2024/12/4 14:04, Scoopta 写道:
>> I'm looking to deploy btfs raid5/6 and have read some of the previous
>> posts here about doing so "successfully." I want to make sure I
>> understand the limitations correctly. I'm looking to replace an md+ext4
>> setup. The data on these drives is replaceable but obviously ideally I
>> don't want to have to replace it.
> 
> 0) Use kernel newer than 6.5 at least.
> 
> That version introduced a more comprehensive check for any RAID56 RMW,
> so that it will always verify the checksum and rebuild when necessary.
> 
> This should mostly solve the write hole problem, and we even have some
> test cases in the fstests already verifying the behavior.
> 

Write hole happens when data can *NOT* be rebuilt because data is 
inconsistent between different strips of the same stripe. How btrfs 
solves this problem?

It probably can protect against data corruption (by verifying checksum), 
but how can it recover the correct content?

