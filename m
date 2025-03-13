Return-Path: <linux-btrfs+bounces-12266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D281EA5F94F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9363BBA9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E562686AE;
	Thu, 13 Mar 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiFT2Kuf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939A22612
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878785; cv=none; b=LozeqRPBQcqiXCU2BNwYIjU+ml+lP+wzrSD6XQ9qhDaKv0oKMPervhJLWFy011vCfYxNoMbs2UFLDxw5njszR3PZJg4rXBlRAThp1dVVTrivP8Nzm6hnhlS+qynVI6xdlsjRFCngFbpvNK97JZi77rrvK0Gxi9oY3udzOribNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878785; c=relaxed/simple;
	bh=GAmFLiMxeemEoTyyXjCBqaYhEPX69NJktrvBspXoLLM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JpR4SMWaxde/f00+uRS79YtBZpz4O1lEREekMZ50dW11ZAmnyKao/iWLj8GRkxqilAWEL+Le7VrTXOuCTBlxjf063G2Pltw3iatCQdROx46XHjX5+V/J7STZ2OvNqnQ/7yIsidB4h3M/+6wNsWBeNUBo2CqLbv3KKO8kYAkdUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiFT2Kuf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2241053582dso28088665ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741878783; x=1742483583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yP/uljw5n/tInpzPGlrCHqW6VfgeloOJzAwiAENlw40=;
        b=hiFT2Kuf5XvZH+GHTuMZbmpOYzGSmF4oAqYicgkzo+ktezPDJsuqHvYv3KJTTP71DA
         t7byUYmS3aLtnigz8wjaUCQTlC/+fJWPgVpS+2jzdF8oSyi7nO42RlnIqzNgzPG7SLtD
         48iGqVDoeTTgnRynkSyrUy0bicQ0O83ZZ+DjGdM5ecf5fVvsyVd9832WxPBROOxIugf7
         /S+LySAIQwERqt8ybaOJMKF3+Rd1+zfWaO+771hCOjgzNhkGGgTxyjb5F2pjS0/Ffvkw
         Nx8DmQlw2gUkx+05vcRpHUuSF4YK5h8TiDSpRDe+zernQsHiMEjhESxOU3SwPcyqfnHY
         oRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878783; x=1742483583;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yP/uljw5n/tInpzPGlrCHqW6VfgeloOJzAwiAENlw40=;
        b=t975jSnla6TrqG0XIYXnx68vlgmeBAOmnK1zwSzuKzLh4eyAr2uTY4bDpsoImz7U5G
         xoCDA0xscUM0RMwq6jwhLLNBnb1c1uxwypiICJ7Okaxbc9aYO+l+tzgVPWtRCIzWamld
         qsgcnDSqKWuPoEzZnlg8YJsVRKA8e6eeoZZpRx+P3D1ntz3WBKeEE7bK9BXz1cqlSTjL
         Q6EsG0KZ3gZy45NkBBtfYNHhbc96fRvFxbA6HXMQrwKv0YUXg1RKnpp7CdEM0zE5OACA
         B84qJS4/bkg9Wp+2h9X2etlR+43f6K5R1mPlychNx8fuKrt7mz5EUJywnU+13uoJgElV
         hkcA==
X-Gm-Message-State: AOJu0Yy2+tVK2uHMUXFjWMayETjyXKsUfnZ3jHhCgOz7xJYOy7Acu0hC
	Me4vKs3LQll30wSMeHN/mKhPhZkzlYyscmJ0J7BRLwOhiN8JPYwP
X-Gm-Gg: ASbGnct4pVUbLj/8ImrbH2Qkvhs698NWVz/StCfLaemonk+Y2R+vf1YR9GjMwfi+RUY
	bJcTDfvMJAb+JDIbyu3ST+tkgAyKPjhPUB0iSyaJdrSKowI/FLqGC0+fDYXYrRhiKlKLySQFbIU
	fVLu5sl8VHqOCq4RMZ/X7zRXFoHaHK5oF3Bj2ARRfK8eLlYeMOg8eGl/opIhd0MzRSdxOm55hsP
	4vWnOgbyNbPnpeFeTXMHmEG9E+2klAAwh4tI5u5JgGIdEGRlQxaoataKfpFZRdIwatLfMOMpQaS
	5xJF/NU0KVJRAiHYFEPLSsEBDN7Rk5EmB+o3oiVaRvzD0uk=
X-Google-Smtp-Source: AGHT+IE8+9hyC96JomprVHSlJcBaeuahajCnQQLytBjvtQsgc5vyuLLjO73hlf1OsK38n7eSQ2HsHQ==
X-Received: by 2002:a17:902:e80f:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-2242887b595mr337473435ad.8.1741878782962;
        Thu, 13 Mar 2025 08:13:02 -0700 (PDT)
Received: from [0.0.0.0] ([144.24.8.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115293f6sm1488646b3a.14.2025.03.13.08.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:13:02 -0700 (PDT)
Message-ID: <cf28bffc-0a2d-481b-bb2c-17a66f113b39@gmail.com>
Date: Thu, 13 Mar 2025 23:12:55 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: =?UTF-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
References: <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
 <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
 <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
 <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com>
 <76e81f2c-17fb-4c11-b1c4-0b4c18b080b5@wdc.com>
 <CAB_b4sBkBOMCpbsf4hmC+wnL9FiH3vk70mq+QrZEAbb8Jfw=jw@mail.gmail.com>
 <4b15f181-8e28-4c8c-b86a-780315d5cc7a@wdc.com>
 <4463e487-b260-47f4-a7b7-285ebf987967@wdc.com>
Content-Language: en-US
In-Reply-To: <4463e487-b260-47f4-a7b7-285ebf987967@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/3/13 21:18, Johannes Thumshirn 写道:
> Good news, I could recreate the bug by manually moving the WPs of a
> null_blk device between adding it to the FS and balancing.
Manually adjusting the WPs of a null_blk device between adding it to the 
filesystem and balancing does seem to simulate the scenario where power 
loss causes Btrfs' assumed WPs to differ from the actual values stored 
on disk.

If data has already been written to the zones and the WPs are updated 
accordingly, but metadata changes related to block groups are lost due 
to power loss, then the behavior in btrfs_load_block_group_zone_info 
seems reasonable. Marking the entire zone as full and treating the space 
as unusable allows the balance/reclaim process to handle the inconsistency.

The next question is how to fix this issue. A potential solution might 
be to simply reorder the function calls, ensuring that 
|btrfs_find_space_info| is always executed before 
|btrfs_add_new_free_space| (and this should always be the case because 
|btrfs_add_new_free_space calls __btrfs_add_free_space_zoned that 
potentially uses the |block_group->space_info). This might be enough to 
prevent the nullptr deref.

Best,
Qiyu
>
> For the record, here's the reproducer that works for me:
>
> #!/bin/sh
>
> set -e
>
> CFS=$(findmnt -t configfs -f | awk '/^\// { print $1 }')
>
> # Create 2 zoned null_block devices
> pushd $CFS/nullb/
> for dev in nullb1 nullb2; do
>           mkdir $dev
>           pushd $dev
>           echo 128 > zone_capacity
>           echo 128 > zone_size
>           echo 1 > memory_backed
>           echo 1 > zoned
>           echo 10240 > size
>           echo 1 > power
>           popd
> done
> popd
>
> DEV1=/dev/nullb1
> DEV2=/dev/nullb2
>
> # Create a FS on nullb1 and mount it
> mkfs -t btrfs $DEV1
> mount $DEV1 /mnt
>
> # Write data to it
> dd if=/dev/zero of=/mnt/test bs=128k count=1024 status=progress
>
> # Add device two to the FS
> btrfs device add $DEV2 /mnt
>
> # Move write pointers of all empty zones by 4k to simulate write pointer
> # mismatch.
> # 'blkzone report' reports the zone numbers in sectors so we need to convert
> # it to bytes first. Afterwards we need to convert it to 4k blocks for dd.
> for zone in $(blkzone report $DEV2 | awk '/em/ { print $2 }' | sed 's/,//');
> do
>           zone=$(($zone / 8))
>           dd if=/dev/zero of=$DEV2 seek=$zone bs=4k status=progress \
>                   oflag=direct count=1
> done
>
> btrfs balance start -mconvert=raid1 /mnt
>


