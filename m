Return-Path: <linux-btrfs+bounces-15831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D888EB19C54
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B314E178049
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B832367CD;
	Mon,  4 Aug 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwQ3JrUI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14299161302;
	Mon,  4 Aug 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291929; cv=none; b=V5RgeW/01khp5CTx7qU5LVPnja493ImljRNc4Q8Yzajji0h12DGXkxzXvaj8IHPqRnioa2+njADBxCm3bUmZewZcaTNxX79kJ0SSd2N/M/SDt/41GJMqqKvR5f2w9FZ/ghkKq0EzcRXr6/ClJn+FAWgPRgRlVRiQwhKksqFqXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291929; c=relaxed/simple;
	bh=cCcVYlhEyiFtN9xqaK+NKSArW0CPYla6XknaWvXHrKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJjhyiLdZQzXb2zNRBrjYnkLHKwwyjA7XEIY4eL1NDXVX2X8IkfpkClsbYACaH/S+7O7y6kJ1csKEDfZkro3wKeI7A9eLFjoEXvD60/B35DVZOsAAvSHHlPNxtOtTCJ+5Yc6Ao0DZ+iKk8GmH+g4flXxV9+LK9Mouel4D8MThn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwQ3JrUI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bfd457607so626387b3a.0;
        Mon, 04 Aug 2025 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291927; x=1754896727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnUgT/SqpDX8BkCm+Xal8FgIpR1Xl4VjR2ewgqoEXXE=;
        b=CwQ3JrUIuGn52vXqSTdgir0Z9IpAaiTElblr4dSQOlBsnumVyumJ+3qZ/+4lQr8izM
         43T1Enitvplc9tA5ujVGKX2NFiqvGW4pR1vsQEG/0HwSiwai07QAUjl5ilYbyNqRQHB/
         8O5O5oRLk4ntQ2cmPNGo1Mujdt448oumXdiTi8DOM/qMjt5E2iO5jlcrejFr/YiUjC33
         s6AJcHvzrYKO/wzvb03XJKTICw8AJ/jygJq4w4vAxssJ0j9/K1Ulc1QZyKShb3eG7aN0
         2ZBmSyI7m/zNJ0mTbHZc5q9ukA8rD+c4hyxYwXkpYz4BTeCPDc2x4U2oJccVee7+Yat/
         aZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291927; x=1754896727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnUgT/SqpDX8BkCm+Xal8FgIpR1Xl4VjR2ewgqoEXXE=;
        b=gM4eyMCsGgDeMP2nymNWorfC9De+XWwzLx9FXYojP1v8YGVQjtuy/VT1PXBVDwk4ud
         p0LK2k0S33QdivSWQzkVavnnBZLHdlDwSy5jjue859SyU8hk+ZZYep0f5S3uNS+iLevN
         awxWAgtrrnwySOYFe23LCqhGFIjX/H/GN2RwNNZkK5tK07D13cjVNPKg5pscov62qErp
         007ibRslCdF+oSBd+8+Xvy6ts0xX5vdNUjzhV1Q1V9wcdrUpGdzV52FnHAHRy70kY6sd
         rbXkYFCUAnyrmt7LFbcYd3Gdb1ybfn0cfxC6nkXYAK290U8WgHKbaWcqPO3bDZnkJD/+
         T2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVqObBXNe6z5/SHqYQJbJMpmnGN1SSFBtYr3BIERs83aRsJ4XkdybsuBFr9xAiBmQq3tLjgBF9zwCN/IA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SNia+KOTpvQnVG1teE7RzjPIhbufJKGRU1oc97eN50t+Nvlz
	PGkAhykNWSiZIECoNRbGSjtPLXTiajTdgmLS3qDF05qtUcbhjmhejEko
X-Gm-Gg: ASbGncvvRZOxJ19hau2UjHqrPNAnu9YcggYw5vevzMQfZiUv9FyK/wR3uCxkZYgovdB
	dg5nddWrwtM60oecOLHjaH63tryufTe36Af8y7JAs1cn6xbZ9wAMZHkd0Ms/n5sDLuq8TWPmHkr
	eS4nReeiyEtYiVmkuss8yRu/Yk2O25Q4TEfSgkFMOFgS6pn7NO1OKfgoimzGLem6yghFalpOQjn
	ZzN+5l9OvmtEyoZ3jFtuDGYgaI512kqMTPWzacVUKTbPjUYbd0xVqzS7IiIiBKCsAPahB817+X1
	T+a6ujOqZswQgr2TEOjgGE8I1ypn/sHjlb0KV2EWnSzAf7KBcb9INfro/OxKnx7/BIQSyQK71Iu
	26WokghiFV5/tPb4GI8YHieexCl3xPr9x
X-Google-Smtp-Source: AGHT+IG5Wc7orosDUJCSsLH8IHDk6LrnZl67jJUUiPDyzRbKdvIX4WZ7eAQkdMQprH3/k1zVjQFWcA==
X-Received: by 2002:a05:6a00:114b:b0:75f:914e:1972 with SMTP id d2e1a72fcca58-76bec4b7d16mr9262127b3a.17.1754291927122;
        Mon, 04 Aug 2025 00:18:47 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd4893sm9714870b3a.107.2025.08.04.00.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:18:46 -0700 (PDT)
Message-ID: <896c6f9d-81e0-41ba-81c1-11bc64741614@gmail.com>
Date: Mon, 4 Aug 2025 12:48:42 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for
 larger nodesize
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
 <CAL3q7H65RB6+91qxJsNfsUKeig0hqNEUTSx9ZuquFnri5RSh2Q@mail.gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <CAL3q7H65RB6+91qxJsNfsUKeig0hqNEUTSx9ZuquFnri5RSh2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/30/25 20:36, Filipe Manana wrote:
> On Tue, Jul 29, 2025 at 7:24 AM Nirjhar Roy (IBM)
> <nirjhar.roy.lists@gmail.com> wrote:
>> When tested with blocksize/nodesize 64K on powerpc
>> with 64k  pagesize on btrfs, then the test fails
>> with the folllowing error:
>>       QA output created by 563
>>       read/write
>>       read is in range
>>      -write is in range
>>      +write has value of 8855552
>>      +write is NOT in range 7969177.6 .. 8808038.4
>>       write -> read/write
>>      ...
>> The slight increase in the amount of bytes that
>> are written is because of the increase in the
>> the nodesize(metadata) and hence it exceeds the tolerance limit slightly.
>> Fix this by increasing the write tolerance limit from 5% from 6%
>> for 64k blocksize btrfs.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/generic/563 | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/563 b/tests/generic/563
>> index 89a71aa4..efcac1ec 100755
>> --- a/tests/generic/563
>> +++ b/tests/generic/563
>> @@ -119,7 +119,22 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" -c fsync \
>>          $SCRATCH_MNT/file >> $seqres.full 2>&1
>>   switch_cg $cgdir
>>   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
>> -check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +blksz=`_get_block_size $SCRATCH_MNT`
> Here the block size is captured, but then it's not used anywhere in the test...

Yeah. I will remove this. Thanks.

--NR

>
> Thanks.
>
>> +
>> +# On higher node sizes on btrfs, we observed slightly more
>> +# writes, due to increased metadata sizes.
>> +# Hence have a higher write tolerance for btrfs and when
>> +# node size is greater than 4k.
>> +if [[ "$FSTYP" == "btrfs" ]]; then
>> +       nodesz=$(_get_btrfs_node_size "$SCRATCH_DEV")
>> +       if [[ "$nodesz" -gt 4096 ]]; then
>> +               check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
>> +       else
>> +               check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +       fi
>> +else
>> +       check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +fi
>>
>>   # Write from one cgroup then read and write from a second. Writes are charged to
>>   # the first group and nothing to the second.
>> --
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


