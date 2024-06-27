Return-Path: <linux-btrfs+bounces-6026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502CA91B00C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA97284B93
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981219CCEE;
	Thu, 27 Jun 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSInJADs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F661FCE;
	Thu, 27 Jun 2024 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518576; cv=none; b=Uujg/vvdphBTAB8uqqGTHBX9t4QOSGR5hYHPn2dtjCpjLeonRiFjgVKwotRI5afWRVGIaCNfuA8lfi9jJUEm+74l9KKZBwllBKZx+2TKtqpUoCt8S+3BqXFdN2Aj+793ZBeHhRTJwzKdW5XMfu1Pm9ozh/6K6s1hSWi8Giu/kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518576; c=relaxed/simple;
	bh=j0M3IUix/LfaUkv0AmWudcuUwP/LVTMJvS33d1VBWq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkIum1UWE/M2Fwc/NyEd658SAQbZwpAOW/Cj6h4LmGbQKecg7C9SmbP6J1zAAcscMyi8ak549iCoU/vsaoDshMP/rTcZC/Kv0ZRQhMTy5fG+S4mc5Q7r5wLk2xumBA00uu1Hm09EOfaFJzTcICpNldLEi+P0gL0gzY4pgcCFLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSInJADs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52caebc6137so7658831e87.0;
        Thu, 27 Jun 2024 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719518573; x=1720123373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYq8Eji0RnJ6Rd8NQrtYKMpeaEgTzQm86nRkdDm5M0E=;
        b=dSInJADsS9a+0I8+oh6T14DZLhx7toyNQ8hhRoq9SDommMX3uXsVfOi3dZhEIcx2Gm
         vuy7X+hxCf/CgaJ0fokxDlYNdai3RXlIB4MhCWLc+VemLR/XlH3i4Msq9BpbFEr/E6cI
         MSLHjvCbOJw8PHOpRMvTJq+CdQL6924BorUDSi6FXHFThInlI51Jm+CRleLABNlN8pEm
         N4TN7e1dx40GkCelPb8yN6rM7E6gKGZHbur6f0EbGZ+QkbchOAtGg5BE8JMGqogU8gC7
         R8hYObbNaVtecdZ8oWMAvR0K3i5qxAvXONlI0WEk6y2xB/vIeSPovhr5+5oAZfsMu3kH
         Kq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719518573; x=1720123373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYq8Eji0RnJ6Rd8NQrtYKMpeaEgTzQm86nRkdDm5M0E=;
        b=U719+7uZsOIic5eoKqS/Kba0ZJe8E/+Q2KdxHvW3ydLh3pWdZRMpg6vw/Rwbv+aYId
         mQ2utfI934akPZ+PhRxQJpVavnGxxkT/Nba9Yj/uLO9pzck6zQOjAGESk/aQhvCXma7y
         8HlyBzjrhCcqg7A+M0WSQyyElzN/0rvzXrdm7bC2Yh0v/RPhbmPqDq17FDIrkagOSYuO
         5MtI/myDMeUYINLYPibm4qEHfK/JJKM9rUGCXewR9Twu6fnApeZGb1vpuqXGV8XH/vFH
         hwtIJyd8GzHgfUq0YkU1WPQy4WN4Js4qTL6guYaBcrY8FUjQBbNHhqzy36kuC21vW1q8
         evzA==
X-Forwarded-Encrypted: i=1; AJvYcCXu7SyO2ldzN9f/pV82wXo/Zj7T+56rlvXIGBBpLLX/mutpaYotVd9VIFFKa9cPKW0vxGAwe3fbZLx7mOUTZf9B6oM5+qOg41Yg6G6RG2zB3aRpDzbCduzD7X/YOBUPIfPjakhsr7+XlKI=
X-Gm-Message-State: AOJu0YyRahv6h7OC8MocoMDBeN0egOovmew6xPP6B6mozOnw/AlL4Chk
	E9B99UEVUyveqgrGAzQpqlQdC3FqKyRZXTJe10jeoq6+v4Bo1cFO
X-Google-Smtp-Source: AGHT+IFSXhfeUaslCaFTDRdRpdymLfeS9k6hSr8ruhbLIJBKqC4g8+vcyz2q10ylMEBGG2siz+IU9Q==
X-Received: by 2002:ac2:4c4d:0:b0:52d:b118:5063 with SMTP id 2adb3069b0e04-52db1185114mr5569458e87.47.1719518572798;
        Thu, 27 Jun 2024 13:02:52 -0700 (PDT)
Received: from [192.168.178.20] (dh207-41-166.xnet.hr. [88.207.41.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1b574sm7397466b.21.2024.06.27.13.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 13:02:52 -0700 (PDT)
Message-ID: <2c82d850-7834-48d6-88b7-9128ae105206@gmail.com>
Date: Thu, 27 Jun 2024 22:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPROBLEM=5D_make_randconfig=3A_fs/btrfs/ref-verif?=
 =?UTF-8?B?eS5jOjUwMDoxNjogZXJyb3I6IOKAmHJldOKAmSBtYXkgYmUgdXNlZCB1bmluaXRp?=
 =?UTF-8?Q?alized_in_this_function_=5B-Werror=3Dmaybe-uninitialized=5D?=
To: Filipe Manana <fdmanana@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <76d879d2-200d-4b15-8fab-fcd382a4c3e2@gmail.com>
 <CAL3q7H7p6EYDG9k66bxDZZrfTQPaiEiZOnFFbov2C3EuRMVLZg@mail.gmail.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <CAL3q7H7p6EYDG9k66bxDZZrfTQPaiEiZOnFFbov2C3EuRMVLZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/27/24 20:11, Filipe Manana wrote:
> On Thu, Jun 27, 2024 at 7:07 PM Mirsad Todorovac <mtodorovac69@gmail.com> wrote:
>>
>> Hi all,
>>
>> After following Boris' advice in https://lore.kernel.org/lkml/20240404134142.GCZg6uFh_ZSzUFLChd@fat_crate.local/
>> on using the randconfig test, this is the second catch:
>>
>> KCONFIG_SEED=0xEE80059C
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ time nice make -j 36 bindeb-pkg |& tee ../err-6.10-rc5-05a.log; date
>>   GEN     debian
>> dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat debian/arch)
>> dpkg-buildpackage: info: source package linux-upstream
>> dpkg-buildpackage: info: source version 6.10.0-rc5-gafcd48134c58-27
>> dpkg-buildpackage: info: source distribution jammy
>> dpkg-buildpackage: info: source changed by marvin <marvin@defiant>
>> dpkg-architecture: warning: specified GNU system type i686-linux-gnu does not match CC system type x86_64-linux-gnu, try setting a correct CC environment variable
>>  dpkg-source --before-build .
>> dpkg-buildpackage: info: host architecture i386
>>  make -f debian/rules binary
>> #
>> # No change to .config
>> #
>>   CALL    scripts/checksyscalls.sh
>>   UPD     init/utsversion-tmp.h
>>   CC      init/version.o
>>   AR      init/built-in.a
>>   CHK     kernel/kheaders_data.tar.xz
>>   CC [M]  fs/btrfs/ref-verify.o
>>   AR      fs/built-in.a
>> fs/btrfs/ref-verify.c: In function ‘process_extent_item.isra’:
>> fs/btrfs/ref-verify.c:500:16: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>   500 |         return ret;
>>       |                ^~~
>> cc1: all warnings being treated as errors
>> make[7]: *** [scripts/Makefile.build:244: fs/btrfs/ref-verify.o] Error 1
>> make[6]: *** [scripts/Makefile.build:485: fs/btrfs] Error 2
>> make[5]: *** [scripts/Makefile.build:485: fs] Error 2
>> make[4]: *** [Makefile:1934: .] Error 2
>> make[3]: *** [debian/rules:74: build-arch] Error 2
>> dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
>> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
>> make[1]: *** [/home/marvin/linux/kernel/linux_torvalds/Makefile:1555: bindeb-pkg] Error 2
>> make: *** [Makefile:240: __sub-make] Error 2
>>
>> real    0m2.583s
>> user    0m9.943s
>> sys     0m5.607s
>> Thu Jun 27 19:14:55 CEST 2024
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>> This fix does nothing to the algorithm, but it silences compiler -Werror=maybe-uninitialised
> 
> You've reported this before, and there's a fix [1] for it in the
> btrfs' github repo, for-next branch. It's not yet in Linus' tree.
> 
> [1] https://lore.kernel.org/linux-btrfs/612bf950d478214e8b76bdd7c22dd6a991337b15.1719143259.git.fdmanana@suse.com/

Yes, this is correct. It is somewhat hard to follow all the possible trees ...

>> ---
>> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
>> index cf531255ab76..0b5ff30e2d81 100644
>> --- a/fs/btrfs/ref-verify.c
>> +++ b/fs/btrfs/ref-verify.c
>> @@ -459,6 +459,8 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
>>                 iref = (struct btrfs_extent_inline_ref *)(ei + 1);
>>         }
>>
>> +       ret = -EINVAL;
>> +
> 
> This is not correct.
> This would result in failure if we have an extent item without any
> inline references (only keyed references following the extent item).

I see.

> Thanks.

No big deal. Many people do not like warnings in compilation and use -Werror ...

Glad I could be of use.

Best regards,
Mirsad Todorovac

>>         ptr = (unsigned long)iref;
>>         end = (unsigned long)ei + item_size;
>>         while (ptr < end) {
>> ---
>>
>> Hope this helps.
>>
>> Best regards,
>> Mirsad Todorovac
>>

