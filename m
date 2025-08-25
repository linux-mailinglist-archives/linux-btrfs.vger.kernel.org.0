Return-Path: <linux-btrfs+bounces-16326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C1B33630
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E843A7887
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF933277818;
	Mon, 25 Aug 2025 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN+M5Kw5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2B28F4;
	Mon, 25 Aug 2025 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102102; cv=none; b=gypRTr7U0i8IKGW0ctWpN635gDmM5dsH3TivOozpEstFdtlgzzYT0m+Fyj06KU6xNiWj6yHc/I5mXHdg2G8xv2gQ6vfJUwEsIySuN3Xs8gQHtzTce0nOYYfulzXKrOOLbQ602IO+Hy4tDIsVcQ4yXeJhYwSJ7CFWIRudHc4A/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102102; c=relaxed/simple;
	bh=EeeyZslswpMte1A5IBx83vaVXUM8WyJ/4AL5hdo26AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sj/0ZFvpgLgRwz9HWISMNmMy8uxhXk7lrw9wTKU3eklel7IXociCKKdleV5n65BGape3LuTbG75kfico5np9sX6hF+Ls4PcsoBurIK2qBp6Eqv4e0ve3PZNv8IBbzSOfYYmSvK0dc5k0DhLBtnfFV/mqoFKmZQ09Q2TVYvOrgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN+M5Kw5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b471aaa085aso2350776a12.0;
        Sun, 24 Aug 2025 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756102100; x=1756706900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePcq55QlaIQhD6W6i3BzpekEYbGHQ7MqRNHPHEJ8CoE=;
        b=FN+M5Kw5K93B7F/P6V4na9/pAcduS5nXb7VcirWbS3RG+WSGt+zUWgMLeB3wrRTAEC
         5l3lp4YM5xdZGOpygxnj4nN8YdchRhkn0P9K3boiF5iDUE67tPgfSb2dnAX2y8Ed/0Wc
         40N6jAG1VdFkGFoWbqw7QCZSt4QO1ZzwNgHkOQaZv9iaq7XYXUITYzs0KYLLe1fZlyyd
         7XScSGdLm4XhxkXQKCYAE3aL7o8TJiPfb26tmfxcCSOB78ChJ1WCfqxJk35yO/O/IUDh
         9JPuddZxPXofWyShgn/II1ten7YbtzOI7JREY91vgyEzIWh45qOKnreDIJqg0WhT0HHf
         +QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756102100; x=1756706900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePcq55QlaIQhD6W6i3BzpekEYbGHQ7MqRNHPHEJ8CoE=;
        b=cPE0UG8k515yYWYx+uGHUC6yyj1u7X+rLWqkVhEcpQ2Lnh0bt9fvzGddlPoz7tev0M
         WuEe5f5T67VFqeui8fExYNtK+Esg6tlyBIOjE8h3LvfEWaxWDHRr1IOOzbEE5wpAVnHt
         CSzA8Ls3ZZi1P26UR2hvORJqZx907PlfVvpsucmu106U2vQovndjMjySHk64nLST4MZ5
         wpXV1QL75nu4W/X+xW2n5jqv6DRAsafdbahEK9aTFequTQejnQJzK8zfrsruVNtiRFg3
         jzlwg0JlfsxxdN9R1hIpB7+chuV/yt4FDtRzvEBKZnK7hTCfMURb/htl2h4Y1K4CywZ/
         vHZA==
X-Forwarded-Encrypted: i=1; AJvYcCWAUmhMcSmU5lK6zJnha29HrgSi3u2PQVbpUaGLQHaNOYayGwfDAzoL3S4kyXn18tDA/+tgqfX+8Hh8HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjupVIijxJIHbkrCZhXtTTrCaVnvoBMLVvUpAYJBrFr2G351uZ
	13BF7I4OTF5/PKUArfkXUQp0iGjAI5go1X0DlPCMBAQ/4wY4kd5gxdmS
X-Gm-Gg: ASbGncvcFCBLUvM6PxV0lj9XKYLW0h7P4TzhONxuqnGAYTuxIKrbzeKE2FcjI5fK0yi
	YmD3pE7dAXmm1RvdztkACM1pULabnN359fUDhWgRvrp+YAfq0/cC7RFaZhS3MEekkH86bzbGo3P
	qnXyKbEdKr9UW5kdqJGry4rWSkQ6WoaeT1x4vbPmIojt0Tw2eknXcQ78DLiMFoC9EkGtshXhPug
	pHTpRoXtkNu/kgxBcAyO9gRSos5cHsHE4blgJ258/MM34ztyWAYNoWOwC2EFP2XToxcvFNNpAwH
	srvp8wrKoeW1ZwrZX7XQ6NO3uWk/Vq52UyzaMHVn1oTHrxDczc0wkYLiTe2oeVZSwCJxPIZ3EsL
	leDX+7jIMwXyuDpk/12/oA7Rae+7WSrjJ6MQlx1EuijE=
X-Google-Smtp-Source: AGHT+IGxv6Tlv+N6IlipVyBKb3VB4RiY+Sv2RfWybVGHv3N0fWrjfz6akoDlTTO+PK9tV2vac9bDqg==
X-Received: by 2002:a17:903:234f:b0:246:9644:3924 with SMTP id d9443c01a7336-24696443cd1mr57007735ad.20.1756102100146;
        Sun, 24 Aug 2025 23:08:20 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889c61bsm57840855ad.143.2025.08.24.23.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 23:08:19 -0700 (PDT)
Message-ID: <0ab6b334-a0ba-4797-9aed-c941f9a0b614@gmail.com>
Date: Mon, 25 Aug 2025 11:38:15 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] btrfs: Misc test fixes for large block/node sizes
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ritesh.list@gmail.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <aKv6tra6TKzX3x2l@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aKv6tra6TKzX3x2l@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/25 11:25, Ojaswin Mujoo wrote:
> On Wed, Aug 20, 2025 at 08:15:03AM +0000, Nirjhar Roy (IBM) wrote:
>> Some of the btrfs and generic tests are written with 4k block/node size in mind.
>> This patch fixes some of those tests to be compatible with other block/node sizes too.
>> We caught these bugs while running the auto group tests on btrfs with large
>> block/node sizes.
>>
>> [v2] -> v3
>> 1. Added RBs by Qu Wenruo in btrfs/{301, 137}
>> 2. Updated the commit message of generic/563 with a more detailed explanation
>>     by Qu Wenrou.
>> 3. Reverted by block size from 64k to 4k while filling the filesystem with dd
>>     for test generic/274.
> Hi Nirjhar,
>
> The changes look good. With the commit message typo fixed for
> generic/563, feel free to add
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks. Added the RBs, fixed some typos and sent the final [v4].


[v4] 
https://lore.kernel.org/all/cover.1756101620.git.nirjhar.roy.lists@gmail.com/

--NR

>
> Regards,
> ojaswin
>
>> [v1] -> [v2]:
>> 1. Removed the patch for btrfs/200 of [v1] - need more analysis on this.
>> 2. Removed the first 2 patches of [v1] which introduced 2 new helper functions
>> 3. btrfs/{137,301} and generic/274 - Instead of scaling the test dynamically
>>     based on the underlying disk block size, I have hardcoded the pwrite blocksizes
>>     and offsets to 64k which is aligned to all underlying fs block sizes <= 64.
>> 4. For generic/563 - Doubled the iosize instead of btrfs specific hack to cover
>>     for btrfs write ranges.
>> 5. Updated the commit messages
>>
>> [v1] - https://lore.kernel.org/all/cover.1753769382.git.nirjhar.roy.lists@gmail.com/
>> [v2] - https://lore.kernel.org/all/cover.1755604735.git.nirjhar.roy.lists@gmail.com/
>>
>> Nirjhar Roy (IBM) (4):
>>    btrfs/301: Make the test compatible with all the supported block sizes
>>    generic/274: Make the pwrite block sizes and offsets to 64k
>>    btrfs/137: Make this test compatible with all supported block sizes
>>    generic/563: Increase the iosize to to cover for btrfs
>>
>>   tests/btrfs/137     | 11 ++++----
>>   tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
>>   tests/btrfs/301     |  2 +-
>>   tests/generic/274   |  8 +++---
>>   tests/generic/563   |  2 +-
>>   5 files changed, 45 insertions(+), 44 deletions(-)
>>
>> --
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


