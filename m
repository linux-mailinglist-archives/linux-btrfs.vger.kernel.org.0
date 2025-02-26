Return-Path: <linux-btrfs+bounces-11835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE433A457D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BAD16BE59
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD61226D08;
	Wed, 26 Feb 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eN5Aq4eo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91EF1E1DF8;
	Wed, 26 Feb 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557496; cv=none; b=gQQwKZqBkZcBk/KDWg9OuaWXa6uejj8HSbP9sr1fBFpY87RPl04EIf3XYq0lKwXWQK2X4hEkxOewzCIAJlTN780ruVw8O33PoEQqbrHAfbnhLXHacKdHG+dBQEHazdgeVgGYNNVD//VIyhCJnwYlPsOBm6KpniG56wRtD72pAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557496; c=relaxed/simple;
	bh=awSOf5Uptv5ylK84gNxEQtXQbjceSW4sC06B5EGXwTo=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=UARJ0LvEX9I2lRuv9JPsmI0Pz0FR1j2BbDtjUsvZI+zxm3JIxy1WmYxBA7xL8TK39G5ecAxv6W8vkoD2GvKWNnhtAXmxka+Y4lhm8r43OKbLlv2G8tAUao2Xkc4kqU0HI4KCuMdWKWTEEOI7VGf+JjGC7F1jRRPnVsUvtbGh4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eN5Aq4eo; arc=none smtp.client-ip=80.12.242.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nCUZttGc7xgLFnCUctj4sa; Wed, 26 Feb 2025 09:10:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740557422;
	bh=ZqGB3dHEkHXDAW5t23ZRy/tk7CvQyYHBVX5yXFeysoI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=eN5Aq4eovmdL2fTfqQhqmyNlSDtRmJIyRo9BV90ujHdViAKnbjtHr7qbLtUGcLRlZ
	 sm6a7gFroiFb3USkdQ363fe5J2nBAhWrC7vKq9Gr98LlhArejaCxQtmS/g1lQfI49r
	 0aIAOKfoRo4tNDooG9At7xMG826jfO8nyaZlknhJmJI7Jeype1X6hRb1E9umLPEZG2
	 XbWU654Orv/crOsdG/XuK2GvaB+YBDki8U4i31RNmbRUpE2c+df/ckkinYznub6VnQ
	 yhVMeiNx7yCwm+qgQ83RKYb4GoAOEUYS84Jpg4YkW7VlX71dQkYv0MO6jlmI4MTa2U
	 +sFJCwiWciqJQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 26 Feb 2025 09:10:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
Date: Wed, 26 Feb 2025 09:10:07 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] rbd: convert timeouts to secs_to_jiffies()
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
 <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Frank.Li@nxp.com, James.Bottomley@hansenpartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, christophe.jaillet@wanadoo.fr, clm@fb.com,
 cocci@inria.fr, dick.kennedy@broadcom.com, djwong@kernel.org,
 dlemoal@kernel.org, dongsheng.yang@easystack.cn,
 dri-devel@lists.freedesktop.org, dsterba@suse.com,
 eahariha@linux.microsoft.com, festevam@gmail.com, hch@lst.de,
 hdegoede@redhat.com, hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net,
 idryomov@gmail.com, ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
To: neelx@suse.com
In-Reply-To: <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/02/2025 à 08:28, Daniel Vacek a écrit :
> On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>>
>> Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
>>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
>>>
>>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>>> the following Coccinelle rules:
>>>
>>> @depends on patch@ expression E; @@
>>>
>>> -msecs_to_jiffies(E * 1000)
>>> +secs_to_jiffies(E)
>>>
>>> @depends on patch@ expression E; @@
>>>
>>> -msecs_to_jiffies(E * MSEC_PER_SEC)
>>> +secs_to_jiffies(E)
>>>
>>> While here, remove the no-longer necessary check for range since there's
>>> no multiplication involved.
>>
>> I'm not sure this is correct.
>> Now you multiply by HZ and things can still overflow.
> 
> This does not deal with any additional multiplications. If there is an
> overflow, it was already there before to begin with, IMO.
> 
>> Hoping I got casting right:
> 
> Maybe not exactly? See below...
> 
>> #define MSEC_PER_SEC    1000L
>> #define HZ 100
>>
>>
>> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>>
>> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
>> {
>>          return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
>> }
>>
>> int main() {
>>
>>          int n = INT_MAX - 5;
>>
>>          printf("res  = %ld\n", secs_to_jiffies(n));
>>          printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));
> 
> I think the format should actually be %lu giving the below results:
> 
> res  = 18446744073709551016
> res  = 429496130
> 
> Which is still wrong nonetheless. But here, *both* results are wrong
> as the expected output should be 214748364200 which you'll get with
> the correct helper/macro.
> 
> But note another thing, the 1000 * (INT_MAX - 5) already overflows
> even before calling _msecs_to_jiffies(). See?

Agreed and intentional in my test C code.

That is the point.

The "if (result.uint_32 > INT_MAX / 1000)" in the original code was 
handling such values.

> 
> Now, you'll get that mentioned correct result with:
> 
> #define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)

Not looked in details, but I think I would second on you on this, in 
this specific example. Not sure if it would handle all possible uses of 
secs_to_jiffies().

But it is not how secs_to_jiffies() is defined up to now. See [1].

[1]: 
https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/jiffies.h#L540

> 
> Still, why unsigned? What if you wanted to convert -5 seconds to jiffies?

See commit bb2784d9ab495 which added the cast.

> 
>>          return 0;
>> }
>>
>>
>> gives :
>>
>> res  = -600
>> res  = 429496130
>>
>> with msec, the previous code would catch the overflow, now it overflows
>> silently.
> 
> What compiler options are you using? I'm not getting any warnings.

I mean, with:
	if (result.uint_32 > INT_MAX / 1000)
		goto out_of_range;
the overflow would be handled *at runtime*.

Without such a check, an unexpected value could be stored in 
opt->lock_timeout.

I think that a test is needed and with secs_to_jiffies(), I tentatively 
proposed:
	if (result.uint_32 > INT_MAX / HZ)
		goto out_of_range;

CJ

> 
>> untested, but maybe:
>>          if (result.uint_32 > INT_MAX / HZ)
>>                  goto out_of_range;
>>
>> ?
>>
>> CJ
>>

...

