Return-Path: <linux-btrfs+bounces-8041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AAE979993
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 01:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BF41C21DFC
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2A82D91;
	Sun, 15 Sep 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FnOQAN5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CF17BA7
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726443537; cv=none; b=d8wSTU0PKx8FVFYZcJBl5FGMVzUzmM6gHY58geDZwNduR4dTFDlR5FpnMY1oKsmwXgresq1IX31WwVI3rrkFPSOduI8uD2GmTknUGU+GSLFsYuH0PsBlNrsUpWjYonSj4iMHJ2zaqzlrriAb9jBfSovIpzgviaJ1OcwGHSNgKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726443537; c=relaxed/simple;
	bh=Q05MzAQUjoyTIReqVFjapvvv46qdHiXcWFqJ72KXy7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNeGm0K00aK9clFIBobFpDVKZrnr+lvFE7dYEV20O3nvE4biUNW2w29L8N0oiCHS3Qf7MAgkWYG51Taxlzck5mVvYgv5Q/r44EDEKtsw3bsFNAEnLlpjaghGEOis1uckL52zb48jNqvGT5RMDPVoZzno0fToYM1DS7sXaPIFrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FnOQAN5k; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374ca65cafdso1731383f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726443533; x=1727048333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3eSEgcq9tRW8ltV03/cwCcdOKi3LwklnRUc9FwD15uM=;
        b=FnOQAN5koDDuZt6juOpEqoxwy/V1S24FwA1+hrvaoQ5lctHf9EoZcuZa6EJKG5pO5c
         jvwhhlrG+wft0ea4EWz4ZUWRhwVGdF5Q7AmG3qLBhe84V5DAEbiW7RIVqhyzXBgHy8oD
         Yds/r9HgbHahiz7yamZOa4144xe5xtzaN4WxojyjDhmMyvB0gSnt0w40U7CVOwnknoEQ
         gxX7UCsw2xcq4VlkP3SrWbB8/BWEdqEhCPEEs3it5WXyXeygp1uksEYx8+3vXXLU9apI
         J8NygJJXgzk6hcxyZrBz+agH4CPVj9UMKp3vhDPjXtIeF9NFxpEXl12l4kGXzk2/20JK
         gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726443533; x=1727048333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eSEgcq9tRW8ltV03/cwCcdOKi3LwklnRUc9FwD15uM=;
        b=rsMFLkM++r1Vcdr9WDDYQXo8kvzZrijvy2UtQMImlVf1bj8+1tW+sp8JEdVVFmyDDD
         axprNYu+zMhZ4e2AtelcMhlUDd3cNUSCHtj5FxAq97uOInRM0hfZI3rkl/LwBr/MNEus
         JJVrM3zLDLAor1nv14mqlPPULA4fg+ZBykE/6HFmgzWniHUy2vn/vN10qCAsGNh7fnM2
         puXFz+lOLfaSoDTVXsFKfHIYTpdH7lit5vk+v4qcSwXV6L01xAyBrW14V6uDTyZD1SQZ
         T5OYH864sx5Wyj62lUvXRtLlQqwUxz/JOBSbd9soZ61JnI5VLVhgW272zTyX3vUQa7Td
         kz/w==
X-Gm-Message-State: AOJu0YwzHvedcGVHTA3TksLk0cUO7nHmY3KK+u5zgUGG85RdonFTnahB
	QjoiTyJaRjKG1xM7igwJSO/ZQmes5xzvZEj1b2wlgfS9pqkD26pCuHlQ/RiHnnM=
X-Google-Smtp-Source: AGHT+IGwDz4KqJelqM3MyoQ8Oo2fcT+8h7k5mKajDDivralLCdds5hese1BMPS070ynYi3OaSfn8ZQ==
X-Received: by 2002:adf:facb:0:b0:374:babf:ac4d with SMTP id ffacd0b85a97d-378d625360bmr4517413f8f.58.1726443532538;
        Sun, 15 Sep 2024 16:38:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7e5bbsm2721066b3a.124.2024.09.15.16.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 16:38:51 -0700 (PDT)
Message-ID: <70cf7c18-feaa-461f-9f96-f83bdea5f4c2@suse.com>
Date: Mon, 16 Sep 2024 09:08:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs keeps getting corrupted
To: Roman Mamedov <rm@romanrm.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <20240916004527.0464200f@nvm>
 <05487866-261a-46da-8b1b-fa8e0092be81@gmx.com> <20240916033159.670efe45@nvm>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240916033159.670efe45@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/16 08:01, Roman Mamedov 写道:
> On Mon, 16 Sep 2024 06:59:54 +0930
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
>>> Such a high disparity in transid mismatch, flush is not working somewhere? But
>>> I specifically do "sync" even multiple times now, before unmounting and after.
>>
>> Manually sync still relies on FLUSH, and FLUSH is not working on the
>> lower storage stack (from LUKS to your SSD/HDD firmware), sync won't
>> save you.
> 
> I always kept in mind that 'sync' was the key to ensure all data has been
> moved from RAM to the HDD. But I now realize that I missed that there's also a
> buffer in the HDD, which also needs to be flushed to disk. It could be that I
> power-off the device before it manages to do that. Also it is an SMR HDD, so
> it might need to do housekeeping with the data on-disk as well.

The point of FLUSH command is, for any correctly behaving firmware, the 
device should only report that command is done, AFTER all data is 
written into non-volatile storage (can be the spinning disk of a HDD, 
NAND or even battery powered RAM).

So if the device is reporting FLUSH done, but in fact it's not, then 
it's a big problem for the device firmware or anything between, 
including the firmware of the disk, USB to ATA converter, the device-map 
layer (remember, each dm device will also need to handle the FLUSH 
command) etc.

Although just cheating the FLUSH behavior is not that a big deal, I'm 
using that behavior all day for all my testing VMs, and AFAIK VMware and 
VBox are also doing such cheating by default

The problem can only happen if a power loss/crash happens, thus dropping 
the cache (and break the required write sequence), and corrupt the btrfs 
filesystem, since btrfs strongly relies on the correct FLUSH behavior to 
implement CoW to protect its metadata.
(I still remember a lot users reporting btrfs corruption with Vmware/Vbox)

> 
> One idea I got is sending drive to sleep (hdparm -Y) before calling power-off
> now. Hopefully that makes it flush before sleep.
> 
>>> How can I figure out what is to blame here, is it the enclosure, is it USB,
>>> LUKS, Btrfs, or some fundamental bug involving a combination of these?
>>
>> In that case, you may want to provide your kernel version first (to rule
>> out known bugs or too old kernels), then reduce the depth of the storage
>> stack, aka, running btrfs directly on that device as a test.
> 
> The kernel is 6.6 series, cannot say exact, but was at most 5-10 point
> releases older than latest, both of the times the issue occured.
> 

Then I do not think it's the dm layer.

Thanks,
Qu

