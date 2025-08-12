Return-Path: <linux-btrfs+bounces-16007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36605B21E32
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4915A19045C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 06:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9F2E282C;
	Tue, 12 Aug 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkofZ5yy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF62DFA3B;
	Tue, 12 Aug 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979760; cv=none; b=UUMioDJac0gEERS5KfmF/PCNNgHU8buucT+peenp3+fupSmOYAWbj6pmztacmyYi9jfnv6G3KzSg6gqYWIPwinaaAueRx7uaPDj03lVlij2JX1Ee9ChjrZ4TzFFiCNrFUk+vy04j1VUYSQIU3x8TMTPCpEOK4I2aLAf/H7WdQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979760; c=relaxed/simple;
	bh=zFAGRrwuwWB5HJl+9EwiGvBXdn70IvxXPFhQq2EEYsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckJqEGnEbZAQ4J+XNgwTX9pVgHAKEFxEpzr2tzdIcqEgsCaalHn7JJSLT86zulmEN5pLmhZercuMD1ZssH4XdtKa/RtN7mQlqvisc6HL8Md4zAm1ls9D9I1q7GrA/r1lrfyFCcL28JtHRIh2067GJMKhAfrD+ih4npSrUkaGCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkofZ5yy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-242d8dff9deso25088235ad.2;
        Mon, 11 Aug 2025 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754979757; x=1755584557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG5zr+MTtgDNpu4lXKuxczvNiLElW1aH6m8gqjR8YtU=;
        b=BkofZ5yyuPd7/JZ9YMAi3UEtJJXNVGagaO6EduWYWyrIhGE3QVKoGdQPT+WdjePxsL
         8QSeZ2iyjPh/9XMqQATJecFu0ig42ZWPehs4rqedaBJBEU2e0vsfr+TfxMV455zLR5YD
         vmRsCZ7gPty3MwycoEQaR7QDXA6/fP2tJyOQsXB4NpVpqIYezkzOQ6bQCQQuZA2CGqfp
         vR586QnJOKD2wLftof3fL2+L5wCH8hpXUsoIKTDbgrXJDlNj+5pw1T2Qj+x1ZNtnIU6n
         t/ZwpIfczNa94ZxKRkbTqKqpzXPH5Cn8+FyEeJep1rmbo3ZsICWkU0keJNXhLPTrcZAh
         JzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979757; x=1755584557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG5zr+MTtgDNpu4lXKuxczvNiLElW1aH6m8gqjR8YtU=;
        b=fzfrQqLVuaiV6GFx15oayIWXIacZYHmf0AFTJeryOnGFbInAODqSVjzeppkR+eAZjj
         Q8GKSijODKqj7AoyVBZkVmzyCZ58x219bnzgwn2UXV87Xn/jUakDJNKy8zFqsmSb9TWT
         t7wtegWSTtfNRKe1VjOib9TSD5BXyjgVadfvAH0eXoS54hIilqDcBkrFOiQzLY0u8tHx
         TwS2fT63MfrdamBDJdEHFAMfBsUa3f0tQhNCFI4uBkqhhrLBMHZAwWtNqRMDCpj0bXFY
         6lshuwkVOHHnR/jQ8XVFD9Ah0MUQLd6c0XpJJ/CXpYq8pb/120ix4E0quXtVoSGCSrBY
         yRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXChWK2NLAvrMRbdJGpBzQoQBLAZk8ynPRWFroBvmumOJvAVtQyxjEZBESh5ak8govXnrYdR+P/@vger.kernel.org
X-Gm-Message-State: AOJu0YzGuxVnlkd6neM9VMghOdmVA7fipxTk8vxY2igUNGVX1oUNuHJo
	YgB0j0H/h9I3j+cT5ydr2ysYlZjj5fWJ/I0jZWxHs+Qv9c8scN4hLjVjkzInYA==
X-Gm-Gg: ASbGnctwMmJIrhMbd4/EhYoqtzAEhrSSYaYdENRMaPEMYeOTuA7g76n24hCYjlkUaph
	RZGpCoUUNiUZ+Hj+ijy7iXFPkDzEB+7LmfkQsyp9PzEkz/gFja4nsGzPxvkeuogtPimIPc+qn1E
	mfYx277NK4n54gjmcXImQOmCZAQygzA9/gULqMk9FoJ9CSdzvYOAvTdDt/5OIcpTMoXZX8nVrcR
	yBntFmts2ouCoNFu8IdLVsw35jgqoGULadc1KaTER/GXt7LjNBVcY96vd4JPk9H/K8sAHxAuteb
	z9Z3slWkwcKGL+oI7tq0ZJu8m2OfeGQqV/Wh6nxV02HmOL7pxJsRJ0RTbr712gCW6W9Y/YfVllV
	8vltTPy3sHC9lfARkCf8dFBIqB/828cms
X-Google-Smtp-Source: AGHT+IEhv/3Obwg8nbzWtzGYWth66QSTLwod1boZkrgeuclBY6e1ov7BO4kx6oGAa+tGDIF217HF/Q==
X-Received: by 2002:a17:902:f706:b0:237:f76f:ce34 with SMTP id d9443c01a7336-242fc228a6emr31561655ad.15.1754979756941;
        Mon, 11 Aug 2025 23:22:36 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm290936605ad.36.2025.08.11.23.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:22:36 -0700 (PDT)
Message-ID: <9b8a35b7-0531-480a-a833-3844d048937b@gmail.com>
Date: Tue, 12 Aug 2025 11:52:32 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
 <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/4/25 09:28, Qu Wenruo wrote:
>
>
> 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
>> For large blocksizes like 64k on powerpc with 64k pagesize
>> it failed simply because this test was written with 4k
>> block size in mind.
>> The first few lines of the error logs are as follows:
>>
>>       d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
>>
>>       File snap1/foo fiemap results in the original filesystem:
>>      -0: [0..7]: data
>>      +0: [0..127]: data
>>
>>       File snap1/bar fiemap results in the original filesystem:
>>      ...
>>
>> Fix this by making the test choose offsets based on
>> the blocksize.
>
> I'm wondering, why not just use a fixed 64K block size?

Sorry for delayed response. Yes, if you feel keeping it simple by 
keeping the values aligned to 64k, I can make the change.

>
> So that all supported btrfs block sizes can result the same file 
> contents.
>
>> Also, now that the file hashes and
>> the extent/block numbers will change depending on the
>> blocksize, calculate the hashes and the block mappings,
>> store them in temporary files and then calculate their diff
>> between the new and the original filesystem.
>> This allows us to remove all the block mapping and hashes
>> from the .out file.
>
> Although I agree we should remove the block mappings from the golden 
> output, as compression can add extra flags and pollute the golden output.
>
> But that can also be done with _require_btrfs_no_compress() helper.

Okay. In that case, I will have the above pre-condition too.

>
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/btrfs/137     | 135 +++++++++++++++++++++++++++++---------------
>>   tests/btrfs/137.out |  59 ++-----------------
>>   2 files changed, 94 insertions(+), 100 deletions(-)
>>
>> diff --git a/tests/btrfs/137 b/tests/btrfs/137
>> index 7710dc18..61e983cb 100755
>> --- a/tests/btrfs/137
>> +++ b/tests/btrfs/137
>> @@ -27,53 +27,74 @@ _require_xfs_io_command "fiemap"
>>   send_files_dir=$TEST_DIR/btrfs-test-$seq
>>     rm -fr $send_files_dir
>> -mkdir $send_files_dir
>> +mkdir $send_files_dir $tmp
>
> Just a small nitpick, it's more common to use $tmp.<suffix>, that's 
> why the default _cleanup() template goes with "rm -f $tmp.*"

Noted. Thanks.

--NR

>
> Thanks,
> Qu
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


