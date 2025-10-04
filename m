Return-Path: <linux-btrfs+bounces-17436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0683BB9279
	for <lists+linux-btrfs@lfdr.de>; Sun, 05 Oct 2025 00:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7DB63456D4
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E9243954;
	Sat,  4 Oct 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVgbWkTc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3EF9C1
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759617413; cv=none; b=MDKpebNEeI27kIZvf4ig61Zw1qUZgNXc5YPLu87vhjIfcYtGrBTkAEq/xmrvuv8uqMFuwmJj2TCsadVrCuKshZKwLexq+PiYOOIXWz1hGFgLQhrNnzx1KAr5gpQEBuQ/OUOgTBANUtCYTRjUhYpVFKw81hLmD0gSdKGmNuwQCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759617413; c=relaxed/simple;
	bh=bEHIlB5sWmkPEurbpVnyxf9ufpujbLpYVVms7+umXCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m/5G6JPvwYChcDuX9KyOdjox0zkOBdBhAzZ/KQ3rYbnuqA36gLNttnD6YEvc544OnTuUaGDcIdb/+w4ObtVpVCmLgCwp8Eso7a7RSYjb0OQ72Y1WKvRU0s+qOACmO6E2A5ioCOJpGAVVcv4ksdSb+4tEISauaLyccoW7o37B9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVgbWkTc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso1849619e87.3
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759617408; x=1760222208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpqGdNluKcirjzlo6jT5o2HmOe6+AfkRicV43hnGfYo=;
        b=CVgbWkTcsLdgCRrlS9/4rbpnC8j1FdwPrkZ6uR1f6ZjQoPK9VK5nndC5yAS6wDS989
         J/wLuuYIl8mHOOdvl8cAMnLaabi+hgxDIKVGDSnUW1zA33AGVARFQK7Nh+embasze+rH
         3Ykf9UOO46/Gkzprhqan2BT4LT6QYXt57q/d1cBedfwnoJzbLAh1nrVhEm88qAvqR9j4
         uyC9rRfVbTat5u/mVhvVcr26Lc7l3u+O0hLDAHEzMn9pBubXIE4IzBcO4HryTC4d8snu
         LDaifuvGDpCM7o3fGsTg2uy1sw8lfgP+G2US97RgopaoexpION8MP0APUraWp5tEG5Rd
         CsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759617408; x=1760222208;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpqGdNluKcirjzlo6jT5o2HmOe6+AfkRicV43hnGfYo=;
        b=dlHHK+GMRpLAcM1pE0Hd3cG+xCHH8AmVItNzxADplOwFNOnd1wk6Qek7Kv2ESbtGEE
         WBBxQi0Jc2ES5EuWYnCggvNjEFI/t8RdJ+62YeFioQCo+fFTXNZ82r7GZjC9Ap4u9XLu
         y+f/HBdhAyrdKqcfeaswxf6Z5L7vmPE3kIJGOrwzLqK2bI7wVVw96R6k8ZxWRV1siqKX
         xC4HulAJVjgGKakiyODb7RuLta8nZUNN9IdqA1NHxyVgp4I4c5honzd+9QDRykJDsxbK
         Uqwaf4E2iu5syUcgQ7qPwPTylAvvDBfX+L7/8I2Od629aRSNAjZn81Ok9xS2nm+sQtlw
         HYyw==
X-Forwarded-Encrypted: i=1; AJvYcCV05OTvtp8zUXrjd47fwzaJGZQhOon2V0MkZ9UPRDCpO4PxJNchXrjLx6j0RGfVZh9gs7N5tgbJmyoIEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8XlfSDAB2essPMIGOGyIJk2aJmdXodhyeHdosrywUx437BDo
	jgVB1AwDVE85mrcIOwi7GgmpIWxHsKMq+XPx8KB1zeIj3g0NhCAlckInmAZfC3u2
X-Gm-Gg: ASbGncsrTdQmjPKucrZFpna8wIUz+0z1FDsXNtW65kTtLN7aP20GqVnix9kHJHP/aBG
	EFGhNPYd0fm/91imbpR3kYcxs83PQLzyBfJBY0bTstckKQRbA/bsH7wC07orZUI4oG0fzcbTmwZ
	MWa+Ckd3EyfvZCKoRull648dHDUeFeJLFLcc8hJ1aUUHQmzyASel43Pz6WtRBy8VjjZzzLdzq5f
	Xzl8rtnWpd5Lfza6VgLOR//txNeI9TEYcYvXdZJyfhrSVM7yP2Lo3wdARk9KYtrO9gRyA6fT3Ca
	gyo6vwUGMAmr8DUhgt+M15tz9Ii1mVVaQxbNXeOepJ9o6D/XopcBpShvgX8jyhM8bNOvusTPrcR
	ahiG9yWeb1bY6IeQ5dNB1xEpUx1+rP78xiip23OFNyHAGxY0j/QrqVzyGdRBIiqry8z8GujjIFf
	KV19Nxm2r0fUhEQCBNXaU0h5wU/v0D24toe8RPjJo1zO9InpW+
X-Google-Smtp-Source: AGHT+IHGxHNBve05oUYjpV9TMdkGTWffNWO8ovTW5Ihb2akb5ry+YxChzXZaRtazvbn9pfji5rCaZg==
X-Received: by 2002:a05:6512:3c87:b0:57d:b8a1:832b with SMTP id 2adb3069b0e04-58cb9d1ace5mr2932595e87.24.1759617407592;
        Sat, 04 Oct 2025 15:36:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:499:7600::192? (2001-14ba-499-7600--192.rev.dnainternet.fi. [2001:14ba:499:7600::192])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b0118d6f3sm3307679e87.77.2025.10.04.15.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 15:36:46 -0700 (PDT)
Message-ID: <09f5019c-650f-4839-8fea-a3c9eb6a9889@gmail.com>
Date: Sun, 5 Oct 2025 01:36:46 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
 <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
 <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
 <afea5a6c-96a6-4928-aa63-275a6c8f8030@gmail.com>
 <4cda86a1-6012-4200-91a0-9087eb9472da@suse.com>
From: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>
Content-Language: en-US
In-Reply-To: <4cda86a1-6012-4200-91a0-9087eb9472da@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the command.

I tried reading through the data but I could not determine if there was 
any information related to scrub or balance status.

Here's the full output I got:

> btrfs-progs v6.16.1
> root tree
> leaf 227587769614336 items 61 free space 3547 generation 2035509 owner 
> ROOT_TREE
> leaf 227587769614336 flags 0x1(WRITTEN) backref revision 1
> fs uuid 2b4ad16d-e456-4adf-960b-dca43560b98b
> chunk uuid 0e317678-73cc-4485-ab6b-987285e19681
>     item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
>         generation 2035509 root_dirid 0 bytenr 227587769630720 
> byte_limit 0 bytes_used 3319316480
>         last_snapshot 0 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2035509
>         uuid 00000000-0000-0000-0000-000000000000
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 0 otransid 0 stransid 0 rtransid 0
>         ctime 0.0 (1970-01-01 02:00:00)
>         otime 0.0 (1970-01-01 02:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
>         generation 2025974 root_dirid 0 bytenr 227594196631552 
> byte_limit 0 bytes_used 21889024
>         last_snapshot 0 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 2 generation_v2 2025974
>         uuid 00000000-0000-0000-0000-000000000000
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 0 otransid 0 stransid 0 rtransid 0
>         ctime 0.0 (1970-01-01 02:00:00)
>         otime 0.0 (1970-01-01 02:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
>         index 0 namelen 7 name: default
>     item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
>         generation 2025975 root_dirid 256 bytenr 227573939142656 
> byte_limit 0 bytes_used 6603997184
>         last_snapshot 2025951 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025975
>         uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025953 otransid 0 stransid 0 rtransid 0
>         ctime 1759258850.523837328 (2025-09-30 22:00:50)
>         otime 1679586168.0 (2023-03-23 17:42:48)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 4 key (FS_TREE ROOT_REF 256) itemoff 14921 itemsize 28
>         root ref key dirid 256 sequence 6 name .snapshots
>     item 5 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14761 itemsize 160
>         generation 3 transid 0 size 0 nbytes 16384
>         block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>         sequence 0 flags 0x0(none)
>         atime 1679586169.0 (2023-03-23 17:42:49)
>         ctime 1679586169.0 (2023-03-23 17:42:49)
>         mtime 1679586169.0 (2023-03-23 17:42:49)
>         otime 1679586169.0 (2023-03-23 17:42:49)
>     item 6 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14749 itemsize 12
>         index 0 namelen 2 name: ..
>     item 7 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14712 
> itemsize 37
>         location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
>         transid 0 data_len 0 name_len 7
>         name: default
>     item 8 key (CSUM_TREE ROOT_ITEM 0) itemoff 14273 itemsize 439
>         generation 2025954 root_dirid 0 bytenr 227588044062720 
> byte_limit 0 bytes_used 49791238144
>         last_snapshot 0 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025954
>         uuid 00000000-0000-0000-0000-000000000000
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 0 otransid 0 stransid 0 rtransid 0
>         ctime 0.0 (1970-01-01 02:00:00)
>         otime 0.0 (1970-01-01 02:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 9 key (UUID_TREE ROOT_ITEM 0) itemoff 13834 itemsize 439
>         generation 2025954 root_dirid 0 bytenr 227587802447872 
> byte_limit 0 bytes_used 16384
>         last_snapshot 0 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 0 generation_v2 2025954
>         uuid 00000000-0000-0000-0000-000000000000
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 0 otransid 0 stransid 0 rtransid 0
>         ctime 0.0 (1970-01-01 02:00:00)
>         otime 0.0 (1970-01-01 02:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 10 key (256 ROOT_ITEM 0) itemoff 13395 itemsize 439
>         generation 2025954 root_dirid 256 bytenr 227587802316800 
> byte_limit 0 bytes_used 49152
>         last_snapshot 2015386 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 1 generation_v2 2025954
>         uuid 56f85f76-1eb8-1245-a35b-8a9307d5c68f
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025954 otransid 31 stransid 0 rtransid 0
>         ctime 1759260258.238143629 (2025-09-30 22:24:18)
>         otime 1679588253.995834574 (2023-03-23 18:17:33)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 11 key (256 ROOT_BACKREF 5) itemoff 13367 itemsize 28
>         root backref key dirid 256 sequence 6 name .snapshots
>     item 12 key (256 ROOT_REF 14428) itemoff 13341 itemsize 26
>         root ref key dirid 28589 sequence 2 name snapshot
>     item 13 key (256 ROOT_REF 14451) itemoff 13315 itemsize 26
>         root ref key dirid 28635 sequence 2 name snapshot
>     item 14 key (256 ROOT_REF 14475) itemoff 13289 itemsize 26
>         root ref key dirid 28683 sequence 2 name snapshot
>     item 15 key (256 ROOT_REF 14499) itemoff 13263 itemsize 26
>         root ref key dirid 28731 sequence 2 name snapshot
>     item 16 key (256 ROOT_REF 14523) itemoff 13237 itemsize 26
>         root ref key dirid 28779 sequence 2 name snapshot
>     item 17 key (256 ROOT_REF 14547) itemoff 13211 itemsize 26
>         root ref key dirid 28827 sequence 2 name snapshot
>     item 18 key (256 ROOT_REF 14559) itemoff 13185 itemsize 26
>         root ref key dirid 28851 sequence 2 name snapshot
>     item 19 key (256 ROOT_REF 14583) itemoff 13159 itemsize 26
>         root ref key dirid 28899 sequence 2 name snapshot
>     item 20 key (256 ROOT_REF 14607) itemoff 13133 itemsize 26
>         root ref key dirid 28947 sequence 2 name snapshot
>     item 21 key (256 ROOT_REF 14631) itemoff 13107 itemsize 26
>         root ref key dirid 28995 sequence 2 name snapshot
>     item 22 key (256 ROOT_REF 14640) itemoff 13081 itemsize 26
>         root ref key dirid 29013 sequence 2 name snapshot
>     item 23 key (256 ROOT_REF 14641) itemoff 13055 itemsize 26
>         root ref key dirid 29015 sequence 2 name snapshot
>     item 24 key (256 ROOT_REF 14642) itemoff 13029 itemsize 26
>         root ref key dirid 29017 sequence 2 name snapshot
>     item 25 key (256 ROOT_REF 14643) itemoff 13003 itemsize 26
>         root ref key dirid 29019 sequence 2 name snapshot
>     item 26 key (256 ROOT_REF 14644) itemoff 12977 itemsize 26
>         root ref key dirid 29021 sequence 2 name snapshot
>     item 27 key (256 ROOT_REF 14645) itemoff 12951 itemsize 26
>         root ref key dirid 29023 sequence 2 name snapshot
>     item 28 key (14428 ROOT_ITEM 1849346) itemoff 12512 itemsize 439
>         generation 2025978 root_dirid 256 bytenr 71398781173760 
> byte_limit 0 bytes_used 8815476736
>         last_snapshot 2018745 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025978
>         uuid 97cd122d-c519-8746-bdfe-13479bfefb9d
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 1849346 otransid 1849346 stransid 0 rtransid 0
>         ctime 1758406304.841464812 (2025-09-21 01:11:44)
>         otime 1758406304.840394467 (2025-09-21 01:11:44)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 29 key (14428 ROOT_BACKREF 256) itemoff 12486 itemsize 26
>         root backref key dirid 28589 sequence 2 name snapshot
>     item 30 key (14451 ROOT_ITEM 1899154) itemoff 12047 itemsize 439
>         generation 2025981 root_dirid 256 bytenr 71398809468928 
> byte_limit 0 bytes_used 6747799552
>         last_snapshot 2018745 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025981
>         uuid c5e2ba38-c982-8a4f-99e5-bb9ff8c5f7cd
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 1897416 otransid 1899154 stransid 0 rtransid 0
>         ctime 1758484800.817458724 (2025-09-21 23:00:00)
>         otime 1758488400.101635440 (2025-09-22 00:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 31 key (14451 ROOT_BACKREF 256) itemoff 12021 itemsize 26
>         root backref key dirid 28635 sequence 2 name snapshot
>     item 32 key (14475 ROOT_ITEM 1942246) itemoff 11582 itemsize 439
>         generation 2025984 root_dirid 256 bytenr 71398831259648 
> byte_limit 0 bytes_used 6755549184
>         last_snapshot 2018745 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025984
>         uuid 38b9ea09-54ef-5140-bddc-83dc884c31b3
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 1940067 otransid 1942246 stransid 0 rtransid 0
>         ctime 1758570000.151997903 (2025-09-22 22:40:00)
>         otime 1758574800.777676964 (2025-09-23 00:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 33 key (14475 ROOT_BACKREF 256) itemoff 11556 itemsize 26
>         root backref key dirid 28683 sequence 2 name snapshot
>     item 34 key (14499 ROOT_ITEM 1977241) itemoff 11117 itemsize 439
>         generation 2025986 root_dirid 256 bytenr 71398873153536 
> byte_limit 0 bytes_used 6538182656
>         last_snapshot 2018745 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025986
>         uuid 703f0298-831b-1e4d-b1f1-fc37ff582770
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 1977241 otransid 1977241 stransid 0 rtransid 0
>         ctime 1758661201.518446292 (2025-09-24 00:00:01)
>         otime 1758661204.161207119 (2025-09-24 00:00:04)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 35 key (14499 ROOT_BACKREF 256) itemoff 11091 itemsize 26
>         root backref key dirid 28731 sequence 2 name snapshot
>     item 36 key (14523 ROOT_ITEM 2001507) itemoff 10652 itemsize 439
>         generation 2025988 root_dirid 256 bytenr 71398873497600 
> byte_limit 0 bytes_used 6561398784
>         last_snapshot 2018745 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025988
>         uuid 9672abd0-7e7b-ab4f-9e0f-7183e58bb6c4
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2001507 otransid 2001507 stransid 0 rtransid 0
>         ctime 1758747600.712874426 (2025-09-25 00:00:00)
>         otime 1758747600.840460363 (2025-09-25 00:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 37 key (14523 ROOT_BACKREF 256) itemoff 10626 itemsize 26
>         root backref key dirid 28779 sequence 2 name snapshot
>     item 38 key (14547 ROOT_ITEM 2017206) itemoff 10187 itemsize 439
>         generation 2025990 root_dirid 256 bytenr 71398872924160 
> byte_limit 0 bytes_used 6570868736
>         last_snapshot 2018745 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025990
>         uuid 671b4b4f-fd99-e140-8535-fce0a16babfb
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2017206 otransid 2017206 stransid 0 rtransid 0
>         ctime 1758834001.88320469 (2025-09-26 00:00:01)
>         otime 1758834001.271433540 (2025-09-26 00:00:01)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 39 key (14547 ROOT_BACKREF 256) itemoff 10161 itemsize 26
>         root backref key dirid 28827 sequence 2 name snapshot
>     item 40 key (14559 ROOT_ITEM 2019735) itemoff 9722 itemsize 439
>         generation 2025992 root_dirid 256 bytenr 75423231606784 
> byte_limit 0 bytes_used 6576078848
>         last_snapshot 2019735 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025992
>         uuid 3ff52125-57ee-6140-87a5-4fb848ec4638
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2019711 otransid 2019735 stransid 0 rtransid 0
>         ctime 1758919659.690576855 (2025-09-26 23:47:39)
>         otime 1758920400.700930626 (2025-09-27 00:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 41 key (14559 ROOT_BACKREF 256) itemoff 9696 itemsize 26
>         root backref key dirid 28851 sequence 2 name snapshot
>     item 42 key (14583 ROOT_ITEM 2022097) itemoff 9257 itemsize 439
>         generation 2025994 root_dirid 256 bytenr 65812067024896 
> byte_limit 0 bytes_used 6557646848
>         last_snapshot 2022097 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025994
>         uuid 860f0635-f296-a04b-9fc5-bd85d480799c
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2022097 otransid 2022097 stransid 0 rtransid 0
>         ctime 1759006819.37527411 (2025-09-28 00:00:19)
>         otime 1759006820.861182212 (2025-09-28 00:00:20)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 43 key (14583 ROOT_BACKREF 256) itemoff 9231 itemsize 26
>         root backref key dirid 28899 sequence 2 name snapshot
>     item 44 key (14607 ROOT_ITEM 2024585) itemoff 8792 itemsize 439
>         generation 2025996 root_dirid 256 bytenr 227573944696832 
> byte_limit 0 bytes_used 6583533568
>         last_snapshot 2024585 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025996
>         uuid af3524d0-8a9a-894c-b5b7-705b10114326
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2024474 otransid 2024585 stransid 0 rtransid 0
>         ctime 1759089642.387498362 (2025-09-28 23:00:42)
>         otime 1759093200.412309185 (2025-09-29 00:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 45 key (14607 ROOT_BACKREF 256) itemoff 8766 itemsize 26
>         root backref key dirid 28947 sequence 2 name snapshot
>     item 46 key (14631 ROOT_ITEM 2025813) itemoff 8327 itemsize 439
>         generation 2025998 root_dirid 256 bytenr 178141351657472 
> byte_limit 0 bytes_used 6602981376
>         last_snapshot 2025813 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2025998
>         uuid 6f085114-93b0-d146-8997-9a41ff62f8db
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025812 otransid 2025813 stransid 0 rtransid 0
>         ctime 1759177902.175859896 (2025-09-29 23:31:42)
>         otime 1759210423.120386595 (2025-09-30 08:33:43)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 47 key (14631 ROOT_BACKREF 256) itemoff 8301 itemsize 26
>         root backref key dirid 28995 sequence 2 name snapshot
>     item 48 key (14640 ROOT_ITEM 2025865) itemoff 7862 itemsize 439
>         generation 2026000 root_dirid 256 bytenr 194611771719680 
> byte_limit 0 bytes_used 6603735040
>         last_snapshot 2025865 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2026000
>         uuid a48f03d9-4847-654a-af1d-5e0eaf6ecd0c
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025863 otransid 2025865 stransid 0 rtransid 0
>         ctime 1759237252.139079795 (2025-09-30 16:00:52)
>         otime 1759240800.56609287 (2025-09-30 17:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 49 key (14640 ROOT_BACKREF 256) itemoff 7836 itemsize 26
>         root backref key dirid 29013 sequence 2 name snapshot
>     item 50 key (14641 ROOT_ITEM 2025870) itemoff 7397 itemsize 439
>         generation 2026002 root_dirid 256 bytenr 65801342844928 
> byte_limit 0 bytes_used 6603292672
>         last_snapshot 2025870 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2026002
>         uuid 56e7aa4e-e166-504d-9a55-8c8b074c0fd9
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025868 otransid 2025870 stransid 0 rtransid 0
>         ctime 1759241717.101400473 (2025-09-30 17:15:17)
>         otime 1759244400.232224532 (2025-09-30 18:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 51 key (14641 ROOT_BACKREF 256) itemoff 7371 itemsize 26
>         root backref key dirid 29015 sequence 2 name snapshot
>     item 52 key (14642 ROOT_ITEM 2025874) itemoff 6932 itemsize 439
>         generation 2026004 root_dirid 256 bytenr 187252895498240 
> byte_limit 0 bytes_used 6603341824
>         last_snapshot 2025874 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2026004
>         uuid f1761dfd-ec60-724a-9af0-dea952cc6771
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025872 otransid 2025874 stransid 0 rtransid 0
>         ctime 1759244441.841998010 (2025-09-30 18:00:41)
>         otime 1759248000.122051877 (2025-09-30 19:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 53 key (14642 ROOT_BACKREF 256) itemoff 6906 itemsize 26
>         root backref key dirid 29017 sequence 2 name snapshot
>     item 54 key (14643 ROOT_ITEM 2025904) itemoff 6467 itemsize 439
>         generation 2026006 root_dirid 256 bytenr 227587769647104 
> byte_limit 0 bytes_used 6603587584
>         last_snapshot 2025904 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2026006
>         uuid 68fd5037-6c8a-c74e-b08f-cff4cdccf752
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025904 otransid 2025904 stransid 0 rtransid 0
>         ctime 1759251597.815452999 (2025-09-30 19:59:57)
>         otime 1759251600.884521740 (2025-09-30 20:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 55 key (14643 ROOT_BACKREF 256) itemoff 6441 itemsize 26
>         root backref key dirid 29019 sequence 2 name snapshot
>     item 56 key (14644 ROOT_ITEM 2025922) itemoff 6002 itemsize 439
>         generation 2026008 root_dirid 256 bytenr 227594191208448 
> byte_limit 0 bytes_used 6603653120
>         last_snapshot 2025922 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2026008
>         uuid 07ccd2ae-f51d-2c46-82df-05e16964b2e5
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025921 otransid 2025922 stransid 0 rtransid 0
>         ctime 1759254975.20573006 (2025-09-30 20:56:15)
>         otime 1759255200.196692319 (2025-09-30 21:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 57 key (14644 ROOT_BACKREF 256) itemoff 5976 itemsize 26
>         root backref key dirid 29021 sequence 2 name snapshot
>     item 58 key (14645 ROOT_ITEM 2025951) itemoff 5537 itemsize 439
>         generation 2026010 root_dirid 256 bytenr 193309358817280 
> byte_limit 0 bytes_used 6603964416
>         last_snapshot 2025951 flags 0x1(RDONLY) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 3 generation_v2 2026010
>         uuid b46ce558-2c39-3944-91d4-b2b229f04a16
>         parent_uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 2025950 otransid 2025951 stransid 0 rtransid 0
>         ctime 1759257514.988583086 (2025-09-30 21:38:34)
>         otime 1759258800.482340435 (2025-09-30 22:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)
>     item 59 key (14645 ROOT_BACKREF 256) itemoff 5511 itemsize 26
>         root backref key dirid 29023 sequence 2 name snapshot
>     item 60 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 5072 itemsize 439
>         generation 2018764 root_dirid 256 bytenr 71399055278080 
> byte_limit 0 bytes_used 16384
>         last_snapshot 0 flags 0x0(none) refs 1
>         drop_progress key (0 UNKNOWN.0 0) drop_level 0
>         level 0 generation_v2 2018764
>         uuid 00000000-0000-0000-0000-000000000000
>         parent_uuid 00000000-0000-0000-0000-000000000000
>         received_uuid 00000000-0000-0000-0000-000000000000
>         ctransid 0 otransid 0 stransid 0 rtransid 0
>         ctime 0.0 (1970-01-01 02:00:00)
>         otime 0.0 (1970-01-01 02:00:00)
>         stime 0.0 (1970-01-01 02:00:00)
>         rtime 0.0 (1970-01-01 02:00:00)

Qu Wenruo kirjoitti 5.10.2025 klo 1.07:
>
>
> 在 2025/10/5 08:23, Henri Hyyryläinen 写道:
>>> One extra thing, at the time of the initial "btrfs check --repair", 
>>> there is no running dev-replace/balance or whatever running?
>>>
>>> Although those operations will be automatically paused by unmount,
>>> btrfs check is not going to be able to handle some of those paused 
>>> operations. 
>>
>> Is there a way for me to check that without mounting the filesystem? 
>> As far as I could find, none of the balance / scrub commands allow 
>> working on an unmounted filesystem. So I couldn't find out if I had 
>> any in canceled state.
>
> # btrfs ins dump-tree -t root <device>
>>
>> Though, I'm pretty sure I let the last scrub and balance operation I 
>> tried to fully complete before starting using the check and repair 
>> commands. But I'm not absolutely certain that I didn't try one of 
>> those a last time and didn't let it fully complete.
>>
>> I'll start that "btrfs check --readonly" command now. And I'll report 
>> back once it is done (hopefully by the morning in my timezone).
>>
>> - Henri Hyyryläinen
>>
>> Qu Wenruo kirjoitti 4.10.2025 klo 23.55:
>>>
>>>
>>> 在 2025/10/5 07:14, Qu Wenruo 写道:
>>>>
>>>>
>>>> 在 2025/10/5 04:13, Henri Hyyryläinen 写道:
>>>>> Hello again.
>>>>>
>>>>> It took over 3 days, but the btrfs check --repair has now 
>>>>> completed seemingly successfully. I mostly saw output about the 
>>>>> file being placed in lost+found and and directory size being 
>>>>> corrected. However, there were some messages about mismatch of 
>>>>> used bytes.
>>>>>
>>>>> Unfortunately it seems like the situation has gotten worse since 
>>>>> the repair, because now I cannot mount the filesystem at all. 
>>>>> Instead I get an error like this:
>>>>>
>>>>>> BTRFS error (device sdc): dev extent physical offset 
>>>>>> 19977638903808 on devid 4 doesn't have corresponding chunk
>>>>>> BTRFS error (device sdc): failed to verify dev extents against 
>>>>>> chunks: -117
>>>>>> BTRFS error (device sdc): open_ctree failed: -117
>>>>> Even if I remove that one problematic device physically from my 
>>>>> computer, the filesystem still refuses to mount with the same 
>>>>> error. Maybe the problems with the device replace are again 
>>>>> showing up with the actual size of the hard drive not being used 
>>>>> correctly? I cannot try to remove the device slack as I cannot 
>>>>> mount the filesystem.
>>>>
>>>> Nope, this is a different problem, and not related to dev replace.
>>>>
>>>> Unfortunately btrfs check has not implemented any repair for that.
>>>>
>>>> Overall if the dev extent is found but not corresponding chunk, it 
>>>> should still be fine but some space unavailable.
>>>>
>>>> But the kernel is overly cautious on chunk tree, as it's a very 
>>>> important and basic functionality.
>>>>
>>>> Please provide the full "btrfs check --readonly" output so that we 
>>>> can evaluate and add the missing repair functionality.
>>>
>>> One extra thing, at the time of the initial "btrfs check --repair", 
>>> there is no running dev-replace/balance or whatever running?
>>>
>>> Although those operations will be automatically paused by unmount,
>>> btrfs check is not going to be able to handle some of those paused 
>>> operations.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> I did try to run a repair again, and this time I got a bunch of 
>>>>> messages like:
>>>>>
>>>>>> repair deleting extent record: key [65795546775552,169,0]
>>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>>> 65811674234880 root 65811674234880
>>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>>> 0 root 14499
>>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>>> 65791012274176 root 65791012274176
>>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>>> 65806385807360 root 65806385807360
>>>>>> Repaired extent references for 65795546775552
>>>>>> ref mismatch on [65795548233728 16384] extent item 5, found 4
>>>>
>>>> That's fixing some backref mismatch, which you can ignore unless 
>>>> "btrfs check --reaonly" later reports new problems.
>>>>
>>>>> But the filesystem still refuses to mount with the exact same 
>>>>> error. I did not let the repair run entirely as it would have 
>>>>> likely taken another 3 days. What should I do? This time I'm not 
>>>>> finding any good information on what to do. For now, I've started 
>>>>> the repair again, but it doesn't exactly sound like it is even 
>>>>> fixing anything now. Still, I'll let it continue. The output so 
>>>>> far is:
>>>>>
>>>>>> [1/8] checking log skipped (none written)
>>>>>> [2/8] checking root items
>>>>>> Fixed 0 roots.
>>>>>> [3/8] checking extents
>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>>> relative chunk.
>>>>>> super bytes used 49454738989056 mismatches actual used 
>>>>>> 49454738923520
>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>>> relative chunk.
>>>>>> super bytes used 49454739005440 mismatches actual used 
>>>>>> 49454738956288
>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>>> relative chunk.
>>>>>> super bytes used 49454739021824 mismatches actual used 
>>>>>> 49454738972672
>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>>> relative chunk.
>>>>>> super bytes used 49454739005440 mismatches actual used 
>>>>>> 49454738972672
>>>>>
>>>>>
>>>>> If I was able to somehow remove that one logically corrupt devid 
>>>>> from the filesystem, or somehow correct the size, that would 
>>>>> hopefully allow me to rebuild from the raid10 data then, but I 
>>>>> can't do those with the unmountable filesystem.
>>>>>
>>>>>
>>>>> - Henri Hyyryläinen
>>>>>
>>>>> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>>>>>
>>>>>>
>>>>>> 在 2025/9/30 02:41, Henri Hyyryläinen 写道:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I hope this is the right place to ask about a filesystem 
>>>>>>> problem. Really shortly put, I have a file that both exists and 
>>>>>>> doesn't and prevents the containing directory from being 
>>>>>>> deleted. No matter what variant of rm and inode based deletion I 
>>>>>>> try I get an error about the file not existing, and I also 
>>>>>>> cannot try to read the file, but if I try to delete the 
>>>>>>> directory I get an error that it is not empty (so the file kind 
>>>>>>> of exists). Trying to ls the directory also gives a file doesn't 
>>>>>>> exist error.
>>>>>>>
>>>>>>> Here's what btrfs check found, which I hope does better in 
>>>>>>> illustrating the problem:
>>>>>>>
>>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>
>>>>>>> I've tried everything I've found suggested including a full 
>>>>>>> scrub, balance with -dusage=75 -musage=75, resetting file 
>>>>>>> attributes, deleting through the find command, and even some 
>>>>>>> repair mount flags that don't seem to exist for btrfs.
>>>>>>
>>>>>> The fs is corrupted, thus none of those will help.
>>>>>> I'm more interested in how the corruption happened.
>>>>>>
>>>>>> Did you use some tools other than btrfs kernel module and 
>>>>>> btrfs-progs?
>>>>>> Like ntfs2btrfs or winbtrfs?
>>>>>>
>>>>>> IIRC certain versions have some bugs related to extent tree, but 
>>>>>> should not cause this problem.
>>>>>>
>>>>>>
>>>>>> The other possibility is hardware memory bitflip, which is more 
>>>>>> common than you thought (almostly one report per month)
>>>>>>
>>>>>> In that case, a full memtest is always recommended, or you will 
>>>>>> hit all kinds of weird corruptions in the future anyway.
>>>>>>
>>>>>>
>>>>>> With a full memtest proving the memory hardware is fine, then 
>>>>>> "btrfs check --repair" should be able to fix it.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>
>>>>>>> What I haven't tried is a full rebalance with no filters, but I 
>>>>>>> did not try that yet as it would take quite a long time and if 
>>>>>>> it only moves data blocks around without recomputing directory 
>>>>>>> items, it doesn't seem like the right tool to fix my problem. So 
>>>>>>> I'm pretty much stuck and to me it seems like my only option is 
>>>>>>> to run btrfs check with the repair flag, but as that has big 
>>>>>>> warnings on it I thought I would try asking here first (sorry if 
>>>>>>> this is not the right experts group to ask). So is there still 
>>>>>>> something I can try or am I finally "allowed" to use the repair 
>>>>>>> command? Here's the full output I got from btrfs check:
>>>>>>>
>>>>>>>> Opening filesystem to check...
>>>>>>>> Checking filesystem on /dev/sdc
>>>>>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>>>>>> [1/8] checking log skipped (none written)
>>>>>>>> [2/8] checking root items
>>>>>>>> [3/8] checking extents
>>>>>>>> [4/8] checking free space tree
>>>>>>>> We have a space info key for a block group that doesn't exist
>>>>>>>> [5/8] checking fs roots
>>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>>>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>>> ERROR: errors found in fs roots
>>>>>>>> found 49400296812544 bytes used, error(s) found
>>>>>>>> total csum bytes: 48179330432
>>>>>>>> total tree bytes: 65067483136
>>>>>>>> total fs tree bytes: 12107431936
>>>>>>>> total extent tree bytes: 3194437632
>>>>>>>> btree space waste bytes: 4558984171
>>>>>>>> file data blocks allocated: 76487982252032
>>>>>>>>  referenced 60030799097856
>>>>>>>
>>>>>>> So hopefully if I'm reading things right, running a repair would 
>>>>>>> delete just that one file and directory (which itself is a 
>>>>>>> backup so I will not miss that file at all)?
>>>>>>>
>>>>>>> I do not have enough disk space to copy off the entire 
>>>>>>> filesystem and rebuild from scratch, without doing something 
>>>>>>> like rebalancing all data from raid10 to single and then 
>>>>>>> removing half the disks, but I assume that would take at least 4 
>>>>>>> weeks to process (as I just replaced a disk which took like a 
>>>>>>> week).
>>>>>>>
>>>>>>> As to what originally caused the corruption, I think it was 
>>>>>>> probably faulty RAM, because up to to like 3 weeks ago I had one 
>>>>>>> really bad RAM stick in my computer where a certain memory 
>>>>>>> region always had incorrectly reading bytes. I had seen 
>>>>>>> intermittent quite high csum errors in monthly scrubs pretty 
>>>>>>> randomly, which thankfully could almost always be corrected so I 
>>>>>>> didn't have any major problems even though I had like totally 
>>>>>>> broken RAM in my computer for who knows how long. So btrfs was 
>>>>>>> able to protect my data quite impressively from bad RAM.
>>>>>>>
>>>>>>> Sorry for getting a bit sidetracked there, but what should I do 
>>>>>>> in this situation?
>>>>>>>
>>>>>>> - Henri Hyyryläinen
>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>>
>>>
>

