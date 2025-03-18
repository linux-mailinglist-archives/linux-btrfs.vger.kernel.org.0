Return-Path: <linux-btrfs+bounces-12380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E37A674C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C2418976C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B820C476;
	Tue, 18 Mar 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m6vZrlgW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D420ADD1
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303904; cv=none; b=bxowmx6JA2WBOs7gfWEa/XLqHLJSiN232bJd9UkYF8X8p+ofPjfaYij00GTp+UFlFLalXouODBChjHtj8QVFV5zFl7oOpD1TJ1T4jUMVg9WV+ZHAIFhJmqEzQhTPIdZx0BTQZTotQgKjsZVH5S1HS4Em1WMGEZ+4T5Vk/cNWPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303904; c=relaxed/simple;
	bh=pSS9b4KjyeRX3m+Vcu1trQJvwn2ZHZfbAHkYS+dr/is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3ueTQvQFKbCBXq/4/Q/N40CO9PWLFY6ukkoELpswTpfpCpy7tTxTM9uCSCHk8YoS3dCR0focJMeqzrcxZ5Fjl0NWR5L9rad4kKxnhlRz50F2AXB+CUj3FfH30N0MNFZ0kJavY8GHvogi6EdMmS0VlYnoaUP1fTfUsnNew9eb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m6vZrlgW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225df540edcso76322905ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742303897; x=1742908697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PvgZOP/grQ6MrsvtBZqJIB/hr36wNKPADFDTJgs3uI=;
        b=m6vZrlgWoFrMu3x5pa4XIRk4GS8Q33fYmTqqKdoRCpEWsecHpydCDqcfGohchS4/ge
         rApLBHVpq3JXu/rtmSHQVUeDxelCN1ATsWeP1hl4Y96qURbzofJIgzrOS4J5htVTOmZe
         sHnv0gpNA57jINZ/6MOIbG8DW7+oXQLx9exFyDzsvVmFXcYWXI6+f6v0TdV8+jlDNY5x
         NU5DbUYItA5Sfo1FNb8yABcSFPV01nMsmLHTwLLlKLyDfkbPt0qvEUDNawn0bgyVqm9j
         8qBD8cn4WNHqa3Dwtq3bnXlGKsb2La8E3uVQpnqgYwtm/iDh1gBoO2Tn9hCETjZTdprl
         TieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303897; x=1742908697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PvgZOP/grQ6MrsvtBZqJIB/hr36wNKPADFDTJgs3uI=;
        b=PLzHJSSoqZF3WLPJbJJheJw2a0VhwGu1N1S23p60JplGzmKmQ26EZGQOKvIBceJhuw
         LrWxznmQNVbWC0d1zKs05TkKMRyaEE9MtHcoQHcToUMb+mP+ug91Fk093Lyfk4kW+FAm
         xmdENdUAPMBTTHDOTalaju22hmLC8Ao39Gfd9Bej1jfrw1Od6M5996Vv8YKL+iLLMm2I
         sHY1mabPUMIU2jmP7W/S4P3GeIC3NTLnPnlq4wME50OzdpCAkpJDwCWebXoiPMpLDH8I
         zPL8aOGP73wWPuO9QSDsexZtIu4mti0Wvvm2uJ7xzP8clOaWdSZ7wfyKX2hxGRaHIKIo
         3Y+w==
X-Forwarded-Encrypted: i=1; AJvYcCW3NwYjOCjkeQIS9YWPmkSeWrevpLaMKIFZkrwQ+MvfRBYeQQn6wVmkxUip8ggQXv9RKkdN20OsocyHjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzpa5MxTXDiYWWuPHO7a6coj1NEWJIJeVEzUrNiPvyJX7pxR1
	l0R2xhlKI2Wm9hRQKMZtMPY7OZsA3ibSJRE80xOYT5mlRUakAQvYYaUKS32p2Qk=
X-Gm-Gg: ASbGncu1k8nw4gaHS7vW15PBYEEW05BU+7wzyIoJfn8bS4o7CYaMd0CrSfo+jAuoHJC
	Mwgg8Rn+QpnmJh5TblaOvsIDRqilKPtuZLhGyfq9nYAieWb7qpNWQ8O76MAD2AiMYZNegAmq8Fu
	JUgrTjwqwcWXKNwU03sfYNGP7V0AXmPNQV7JXVRtZ59M2jNEyW8kPm8lkjw4PpkaerptkoAxL8q
	CQwUyNLzIODTbiigKAnIjYeYYxDOncwuQ8/bbxKHMpL9OGH/cu0OlSesp297flNMBeDkII5jz/a
	4vkPkaIqijOIOuqauN5CufMaZdgZkb3kUpRvuA3Kf47MUUP0WSNy
X-Google-Smtp-Source: AGHT+IE6Kvikqae/QIhUUltUVzZbzSr6m/bq+X2/1Wo+d+2XzyqBFo8+FN+U7vDveLY2PY01G/wguw==
X-Received: by 2002:a05:6a21:3288:b0:1f3:323e:3743 with SMTP id adf61e73a8af0-1fa5002d58cmr4560532637.12.1742303897279;
        Tue, 18 Mar 2025 06:18:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea05961sm8895763a12.46.2025.03.18.06.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 06:18:16 -0700 (PDT)
Message-ID: <43dcef61-c574-46a9-9a94-06316d086181@kernel.dk>
Date: Tue, 18 Mar 2025 07:18:15 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-5-sidong.yang@furiosa.ai>
 <3a883e1e-d822-4c89-a7b0-f8802b8cc261@kernel.dk>
 <Z9jTYWAvcWJNyaIN@sidongui-MacBookPro.local>
 <566c700c-d3d5-4899-8de1-87092e76310c@gmail.com>
 <Z9km_8ai2zq86JKI@sidongui-MacBookPro.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9km_8ai2zq86JKI@sidongui-MacBookPro.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 1:55 AM, Sidong Yang wrote:
> On Tue, Mar 18, 2025 at 07:25:51AM +0000, Pavel Begunkov wrote:
>> On 3/18/25 01:58, Sidong Yang wrote:
>>> On Mon, Mar 17, 2025 at 09:40:05AM -0600, Jens Axboe wrote:
>>>> On 3/17/25 7:57 AM, Sidong Yang wrote:
>>>>> This patch introduces btrfs_uring_import_iovec(). In encoded read/write
>>>>> with uring cmd, it uses import_iovec without supporting fixed buffer.
>>>>> btrfs_using_import_iovec() could use fixed buffer if cmd flags has
>>>>> IORING_URING_CMD_FIXED.
>>>>>
>>>>> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
>>>>> ---
>>>>>   fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
>>>>>   1 file changed, 24 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index 6c18bad53cd3..a7b52fd99059 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
>>>>>   	struct iov_iter iter;
>>>>>   };
>>>>> +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
>>>>> +				    unsigned int issue_flags, int rw)
>>>>> +{
>>>>> +	struct btrfs_uring_encoded_data *data =
>>>>> +		io_uring_cmd_get_async_data(cmd)->op_data;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
>>>>> +		data->iov = NULL;
>>>>> +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
>>>>> +						    data->args.iovcnt,
>>>>> +						    ITER_DEST, issue_flags,
>>>>> +						    &data->iter);
>>>>> +	} else {
>>>>> +		data->iov = data->iovstack;
>>>>> +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
>>>>> +				   ARRAY_SIZE(data->iovstack), &data->iov,
>>>>> +				   &data->iter);
>>>>> +	}
>>>>> +	return ret;
>>>>> +}
>>>>
>>>> How can 'cmd' be NULL here?
>>>
>>> It seems that there is no checkes for 'cmd' before and it works same as before.
>>> But I think it's better to add a check in function start for safety.
>>
>> The check goes two lines after you already dereferenced it, and it
>> seems to be called from io_uring cmd specific code. The null check
>> only adds to confusion.
> 
> You mean 'cmd' already dereferenced for async_data. Is it okay to just
> delete code checking 'cmd' like below?
> 
> if (cmd->flags & IORING_URING_CMD_FIXED) {

Either 'cmd' may be NULL and it's valid (and the current code is fine),
or it'd be invalid, in which case that should return an error. But we
don't add random pointer == NULL checks as defensive programming. And
this one should never ever see cmd == NULL, hence the code needs to go
away. It's just confusing otherwise. Consider you reading some code
trying to understand what it does, and it has a check for cmd == NULL in
there. That would make you wonder "hmm what cases pass in a NULL for cmd
here?". When the answer is "this should never happen", don't have the
check. It just obfuscates the code.

-- 
Jens Axboe

