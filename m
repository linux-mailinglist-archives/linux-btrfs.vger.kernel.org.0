Return-Path: <linux-btrfs+bounces-545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E38023A8
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C63B20A86
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32113D26D;
	Sun,  3 Dec 2023 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHMpo7LS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F8DB
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 04:16:23 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fa37df6da8so1786568fac.2
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Dec 2023 04:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701605783; x=1702210583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvAvZ0yrj1DwrsmjmFAHAticMD3/zj2DqX4aCxgU34I=;
        b=CHMpo7LSDbCUBn8fCXylgZ5YYAqKXDTvr1QGOqgN0F6NMQxVVa6KIk/WKL1m3g87vi
         tZmSABP6AfVuJa9vCGxN+KWRlEgB5FN9h3aL5mVdvf/9lbAuwDJ9wwVFMuiq/mHZxzbh
         yiL44LPXKmxF3b7MnrpBo4Vz/AluHW+0ym+NiXfidZAC6rGU/h2F9TIKR1fpdZv8dqFn
         rwXJbck9ohylegsn4SsM1DnEg9ZH4KZxjlw+tf2RfXjCxW2I+5SrV9H2U3/NpQDsw+Mo
         WQPMcBJp6V1QQRZMNzZjs7ThzRSx7cAz4D28gU86fGq+W3aXoNm1HKO0dwE5r+ZNqU6B
         okPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701605783; x=1702210583;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvAvZ0yrj1DwrsmjmFAHAticMD3/zj2DqX4aCxgU34I=;
        b=kJj+fYZxgQjXGQ6hEQMCMLtg5EcIprUm+mS5uYiKJUvmE7A1hGk/e8tO3Tuiwg4XjR
         ISqu+mG+rjHlRPN6JOiYMXNS8m34RcylicOEkoLvaOdyNYjapR1iTt2eiG9fxN7bike4
         +48QMnvqxUaalP466MGn8HORkbesYu9n0+ktTIG2DROEYnrAGPbAuZ8RhzGZ+wXSfWW5
         bQun4osmmjWK1yBkIc46eW/XcIZoJOlnu14rYf+mmDgevXj8aWtj4Dd6C8Ov8d8Tihnu
         VqvmQrcDPDCl7Hzcqtbhw9sQEJrXZAV5WsfCMtqZ+cP7k7hSCkBWLmFpadXb0M4lnuVx
         Iong==
X-Gm-Message-State: AOJu0YyXwEdvIh90/4GWBZmT935J4OTR6e/2hRN51TI9mZaq+qrq00Oa
	EUz15sdi2EACUa+Cq34Upd6hU+of01M=
X-Google-Smtp-Source: AGHT+IHaHVw+nRjQ6NbVq5IdPCaxDMEYiWp1NW6D9MyJ5iLzknyXU8Bm2Eu4xXxXOp8EGDMLIOh3pA==
X-Received: by 2002:a05:6870:4707:b0:1fa:df52:beb4 with SMTP id b7-20020a056870470700b001fadf52beb4mr3265880oaq.32.1701605782652;
        Sun, 03 Dec 2023 04:16:22 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id lg22-20020a0568700b9600b001fa1db68eecsm96796oab.4.2023.12.03.04.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 04:16:22 -0800 (PST)
Message-ID: <e78b13ac-6fdf-48eb-b33a-82474e49003d@gmail.com>
Date: Sun, 3 Dec 2023 06:16:21 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS corruption after conversion to block group tree
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
 <e20c7d59-c460-4236-9771-9cb4a3f9dfb2@gmx.com>
 <1b32a750-d464-49f1-a288-577ee2fd473e@gmail.com>
 <bf4ee7ec-ab90-496c-9117-b13a096994a6@gmx.com>
 <3b55e499-791b-4f98-9ca3-0ff0a218c0bf@gmx.com>
 <8dac2b61-0a42-4416-9477-4cecc1b0eb06@gmail.com>
 <bae5e86b-d215-4984-95f2-4f24a8ee6bd9@gmx.com>
 <39ff2b14-9f8a-4477-aa49-b4cb19e1d7ef@gmail.com>
In-Reply-To: <39ff2b14-9f8a-4477-aa49-b4cb19e1d7ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/23 06:05, Russell Haley wrote:
> 
> 
> On 12/2/23 00:43, Qu Wenruo wrote:
>>
>> Very hard to say if it's the firmware's fault, but it can also be our
>> fault on the bg tree conversion.
>>
>> Anyway two reports are more than enough for us to enhance bg tree
>> conversion code.
>>
> 
> If the two reports you're counting are mine and Alexander's from October
> that I linked at the top of the thread, make it three:
> 
> https://www.reddit.com/r/btrfs/comments/186pw3v/fs_got_corrupted_after_running_btrfstune/

Might be 4.  A user in that thread says they had the same issue after
doing that and posted about it last week, but I tracked back to their
older thread:

https://www.reddit.com/r/btrfs/comments/17si8cb/cannot_mount/

They didn't mention block group tree conversion the first time, so they
misremembered at least once.

Thanks,

- Russell Haley

