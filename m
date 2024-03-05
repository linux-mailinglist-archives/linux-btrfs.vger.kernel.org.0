Return-Path: <linux-btrfs+bounces-3009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B38718B9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6187B2143E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9B4F613;
	Tue,  5 Mar 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NDm2r5st"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC438DD1
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629061; cv=none; b=BtXOLmX5T3PFcqd5NMP3qaf+hqiCCYel8E4wSgZndkuoSx9Fd1xbp5tfQqjQ0GHyz59T8iSdvhwPclzQqx3S1RGX0C000gZObW6himl1erJIhEt4uguN4Ayk5PUkgD7j/SgBj1PbbItE9YwVMjIQCGIRktae6fuui0jVqTm19eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629061; c=relaxed/simple;
	bh=loUuHG6Rl5ZahVypUQt1mcaUcLn65SSDNsljM58YBSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPnJmU/jpgv1x2WSmnyQ/IzPdChiZHAegqLUKc9a37FL9rTtLrD413i7+h/ufVFa6oUPnEP33K4ukSr/9fqH/biBUsoXb4MyIc8satyhLxg81xph/T4rHDalfN2JS5r/3MQZZzBlJminZYcqiiZsL3GKCgqK98UCPF7AsgH7AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NDm2r5st; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so5336471fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 00:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709629056; x=1710233856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0X83xOzgweJaKyIm8x1h65Q1GPFlkWhbvFgIWbJbDGs=;
        b=NDm2r5staqa63+QO+ZwQ2L4e6AWNwvzY6l9A2SOyaoO0EOFnQ/xcQww93Vu5TzmBpN
         XkbjdZQrR50++YwjrwSLrLWqwsgDpf4oU0E3RMajIBH9riwgEAnxBynd/VWAqlDVFulx
         m1ZZfVXWEAKetSOmrRr4PQq+Sb/MTGHLME/x6UiPJgKql16ASEvkLrZnFZ92hmuhPhUm
         LcgnGNTf4bioi/sP1GcejcB0l1uNLqsNBCfk/bb6Q+LXJtLpIyscUB8QhjTbtrZOvp8R
         sElwAW3NeebfAGyt18PJethQq33+m2p0+VQfZATr2csPqiPXUsS4EGYddFeg/JmfWpg8
         wUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629056; x=1710233856;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X83xOzgweJaKyIm8x1h65Q1GPFlkWhbvFgIWbJbDGs=;
        b=lcmDttwoxheBD8JrmB5jFLBVk37uJHULi37l/udK/X2LT/Km8rmIIzmL4I4NiKIMFs
         2XA3K1OrndBpBDl2xqUDRYR/JLfiJoS1osd2xw/TMhupdfCkC3nRtUJLO9HDIgQLxeP9
         zPXGo1YpM296/KHViNv8EU8G/MGF6Y97uYeyYV0HooEE19vnAtWxp5UMERsoCBlNxDaF
         z/kfbOq0gZ/eLt+clpVw9ECAKVd+a3Topo6bWBOfPxg6zOx3dwQduFY8GDSCtuTgdi+h
         Fro66nGK/X0RjE829T12TJqvXMhKdDmQEP7rJpkjRGexoRLAw4Tk1hxHFMLa2DvJKukM
         wiMA==
X-Gm-Message-State: AOJu0YxXwvfpq45u4aLWH9uDqbihfyBME6tyB734eD17ZRCEmLob52aj
	DRMlZGWxpK936RyHjfa1ZOj4GkCBMHwZlzwl10DLRlKR8lSF1kvuk60a8WIpnYI=
X-Google-Smtp-Source: AGHT+IG5mmFqoe7q6aetUnV1FKqk9OSnknpzFWETfXp2zUhvB5xYeDfsxZk+4vh/2rF+zCMMw7apeg==
X-Received: by 2002:a2e:908b:0:b0:2d2:ed31:9fa6 with SMTP id l11-20020a2e908b000000b002d2ed319fa6mr877212ljg.49.1709629056276;
        Tue, 05 Mar 2024 00:57:36 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b001dba739d15bsm9994536plg.76.2024.03.05.00.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:57:35 -0800 (PST)
Message-ID: <f995abc3-27c4-418e-b595-88c79b793deb@suse.com>
Date: Tue, 5 Mar 2024 19:27:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: fix false alerts on zoned device scrubing
Content-Language: en-US
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 WA AM <waautomata@gmail.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <91a3647a1f2657b89bd63c12fa466c6c70965d22.1709606883.git.wqu@suse.com>
 <lxmzcflltgts5hesryp5duiufj3mtsiqotn7bjwiowzz5ljge4@ifshxhdddgo7>
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
In-Reply-To: <lxmzcflltgts5hesryp5duiufj3mtsiqotn7bjwiowzz5ljge4@ifshxhdddgo7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/5 19:18, Naohiro Aota 写道:
> On Tue, Mar 05, 2024 at 01:18:22PM +1030, Qu Wenruo wrote:
>> [BUG]
>> When using zoned devices (zbc), scrub would always report super block
>> errors like the following:
>>
>>    # btrfs scrub start -fB /mnt/btrfs/
>>    Starting scrub on devid 1
>>    scrub done for b7b5c759-1baa-4561-a0ca-b8d0babcde56
>>    Scrub started:    Tue Mar  5 12:49:14 2024
>>    Status:           finished
>>    Duration:         0:00:00
>>    Total to scrub:   288.00KiB
>>    Rate:             288.00KiB/s
>>    Error summary:    super=2
>>      Corrected:      0
>>      Uncorrectable:  0
>>      Unverified:     0
>>
>> [CAUSE]
>> Since the very beginning of scrub, we always go with btrfs_sb_offset()
>> to grab the super blocks.
>> This is fine for regular btrfs filesystems, but for zoned btrfs, super
>> blocks are stored in dedicated zones with a ring buffer like structure.
>>
>> This means the old btrfs_sb_offset() is not able to give the correct
>> bytenr for us to grabbing the super blocks, thus except the primary
>> super block, the rest would be garbage and cause the above false alerts.
>>
>> [FIX]
>> Instead of btrfs_sb_offset(), go with btrfs_sb_log_location() which is
>> zoned friendly, to grab the correct super block location.
>>
>> This would introduce new error patterns, as btrfs_sb_log_location() can
>> fail with extra errors.
>>
>> Here for -ENOENT we just end the scrub as there are no more super
>> blocks.
>> For other errors, we record it as a super block error and exit.
>>
>> Reported-by: WA AM <waautomata@gmail.com>
>> Link: https://lore.kernel.org/all/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com/
>> CC: stable@vger.kernel.org # 5.15+
>> Signed-off-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index c4bd0e60db59..e1b67baa4072 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -2788,7 +2788,6 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>   					   struct btrfs_device *scrub_dev)
>>   {
>>   	int	i;
>> -	u64	bytenr;
>>   	u64	gen;
>>   	int ret = 0;
>>   	struct page *page;
>> @@ -2812,7 +2811,17 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>   		gen = btrfs_get_last_trans_committed(fs_info);
>>   
>>   	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
>> -		bytenr = btrfs_sb_offset(i);
>> +		u64 bytenr;
>> +
>> +		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
>> +		if (ret == -ENOENT)
>> +			break;
>> +		if (ret < 0) {
>> +			spin_lock(&sctx->stat_lock);
>> +			sctx->stat.super_errors++;
>> +			spin_unlock(&sctx->stat_lock);
>> +			break;
> 
> Since an error from scrub_one_super can continue, this can be "continue"
> also? > E.g, if btrfs_sb_log_location() returns -EUCLEAN on the 2nd SB, it
> fails to detect the 3rd SB's corruption.

You're right, I originally though it can return error from 
blkdev_zone_mgmt() and if that failed we can no longer continue.

But that can only happen in write case, meanwhile we're in the READ path.
And in that case, sb_write_pointer() can return -ECULEAN and we can 
still continue.

Would allow continue for non-ENOENT errors.

Thanks,
Qu
> 
> Other than that, looks good.
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
>> +		}
>>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>>   		    scrub_dev->commit_total_bytes)
>>   			break;
>> -- 
>> 2.44.0

