Return-Path: <linux-btrfs+bounces-5565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE61900F51
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 05:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5897F1F2208F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B3DDC5;
	Sat,  8 Jun 2024 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MBBx8bTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D631BE6C
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717816845; cv=none; b=MQMFJ3nErxcgaXfBiGlHWI/XgyXdCowi66i0GnRVOjmZoWxaMSjpeQLsqO6MjLcahWUg2YwFQL0uqIqSljSMAZCLZ/owZLnrST7SaNJSzRI6eBf35fa8eeY0n/ITWaL0P6Cr7O58ZYOlvWp4iIDclx0I+Y5jOdwnd8JHfol7wXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717816845; c=relaxed/simple;
	bh=PK6bZ/sgGkm+j9vsWMEbSGAmyilWrOIyThcBlrC+d0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/eczJBBDcNO+aLFD14jtjbtWdq5qANu6dB8YSExDOznYue8SN4vQtsquxmjbRrlShej8CV2bImbJKq8kNRY1E4qzmrK5ztKYWKNaf1MlGG/S+ch8pEJ6NrfbKkWZDtM/Wxfg1CL0iHBTJEFTNTBbwMV7TM/4AWhgSNa+xvmlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MBBx8bTn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35e573c0334so2287991f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 20:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717816840; x=1718421640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yKvPH/K6K1BfyjL5LKevu0fc/cXRPuRX007pu5asWOU=;
        b=MBBx8bTnHvtW9gaETlIsRvBu6RWHPsm6TLTSzU9Iaq4uoiEVH/+EyepEB+B7TBGsdj
         fG1xfYBufE8zqAf3aDnKougDbibd5lpv6hODhcfHeC2c1HAB6Szr1DxaViJlUeVz3SFB
         rReIVTYI/4uy5yeSbG+HOJQ/0zP+wOiDFaTlSbMFdmMIzh/sRUS74TEUZuazm6U8uA0c
         Nxif7vMrvYvQU57etRhAl3krQ/3cOB/kD0cLAtzSo+5NaBt/oHRZ0DxDQR5/C9GY9Ehh
         6kMzqg8Z7f/T9RY2WXigABbS5ZHnu6gK/VL1mBBceCVHLAwrS8/olqeU5MkmmZ2s1Amo
         GOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717816840; x=1718421640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKvPH/K6K1BfyjL5LKevu0fc/cXRPuRX007pu5asWOU=;
        b=BF89RTdgSGtRvIC0+VJnUBeZwRylewF8uf9DAdrr9FQaRRbvfWtHjohxn+XZ+9utvF
         IwbAVuX/s2Bhjbm5xDkdxsS7KA6m7HPhRQBrawJkAZfhRRMV78Jlm7Zsja4fvEjduvkr
         OnZY4UiJwlEbKLio98npROM9Ta2+5P4mgN7Rgwq/r7eV7egZORIFiIe4Nn7mPxhgPOIM
         ZUs2rKAKg8k4J/1v+IJRab3UBaeBmeOYe3s4X8Bx0dl91+N/HmTq2J3PODkZjdWCRqXv
         d3jER1HbXDxe5phBAe9exRpXLkO5H92Fjqa1UiCuSeWa4Bgz6sK6wBUDMsurKhQMIbHS
         Qwjg==
X-Gm-Message-State: AOJu0Yxdiy7HcF647rD7LqlP5FQ0WH45kyiIXCzeO69AkNT9cgDz4hFg
	ZvGQk4R7Aw3SbdycnRVNxfjTpwEXiwUOY5/mZ5YXLGzXAwefsM0lsgwaTwjL6d9s1LmoNMQ9Kpe
	c
X-Google-Smtp-Source: AGHT+IGYI5nWbydc80ZXpJNxf4Acc1ZAQPLKrnZ3TlfxRPF61n1E++avyctBL32U9uTpzp+feG2jAA==
X-Received: by 2002:a5d:46cc:0:b0:354:f4a9:b88a with SMTP id ffacd0b85a97d-35ef0d84474mr7168879f8f.21.1717816840359;
        Fri, 07 Jun 2024 20:20:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041a31d3b9sm1240012b3a.139.2024.06.07.20.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 20:20:39 -0700 (PDT)
Message-ID: <5a8c1fbf-3065-4cea-9cf9-48e49806707d@suse.com>
Date: Sat, 8 Jun 2024 12:50:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: raid5 silent data loss in 6.2 and later, after "7a3150723061
 btrfs: raid56: do data csum verification during RMW cycle"
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <ZlqUe+U9hJ87jJiq@hungrycats.org>
 <a9d16fd4-2fec-40c7-94cc-c53aa208c9b9@gmx.com>
 <ZmO6IPV0aEirG5Vk@hungrycats.org>
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
In-Reply-To: <ZmO6IPV0aEirG5Vk@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/8 11:25, Zygo Blaxell 写道:
> On Sat, Jun 01, 2024 at 05:22:46PM +0930, Qu Wenruo wrote:
[...]
>>
>> Nope, rmw_rbio() would call bitmap_clear() on the error_bitmap before
>> doing any RMW.
> 
> This is true, but the code looks like this:
> 
>                  ret = rmw_read_wait_recover(rbio);
>                  if (ret < 0)
>                          goto out;
>          }
> 
> [some other stuff]
> 
>          bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
> 
> The problem happens before the bitmap_clear, at `goto out`.  Actually it
> happens in rmw_read_wait_recover() (formerly rmw_read_and_wait()),
> because that function now changes 'ret' if the repair fails:
> 
> @@ -2136,6 +2215,12 @@ static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
> 
>          submit_read_bios(rbio, &bio_list);
>          wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
> +
> +       /*
> +        * We may or may not have any corrupted sectors (including missing dev
> +        * and csum mismatch), just let recover_sectors() to handle them all.
> +        */
> +       ret = recover_sectors(rbio);
>          return ret;
>   out:
>          while ((bio = bio_list_pop(&bio_list)))
> 
> Before this change, if all the blocks in the stripe were readable, we
> would recompute parity based on the data that was read, and proceed
> to finish the rbio.  As long as the writes were also successful,
> the new blocks that were written would be updated and recoverable.
> (The old unrecoverable blocks would still be unrecoverable, but there's
> no fixing those.)

I still do not believe the old behavior is correct.

If the data is corrupted, re-generate the P/Q using the bad one is only 
killing all the remaining (if any) chance of recovery.

> 
> After this change, we now end up in an infinite loop:
> 
> 1.  Allocator picks a stripe with some unrecoverable csum blocks
> and some free blocks
> 
> 2.  Writeback tries to put data in the stripe
> 
> 3.  rmw_rbio aborts after it can't repair the existing blocks
> 
> 4.  Writeback deletes the extent, often silently (the application
> has to use fsync to detect it)
> 
> 5.  Go to step 1, where the allocator picks the same blocks again
> 
> The effect is pretty dramatic--even a single unrecoverable sector in
> one stripe will bring an application server to its knees, constantly
> discarding an application's data whenever it tries to write.  Once the
> allocator reaches the point where the "next" block is in a bad rmw stripe,
> it keeps allocating that same block over and over again.

I'm afraid the error path (no way to inform the caller) is an existing 
problem. Buffered write can always success (as long as no ENOMEM/ENOSPC 
etc), but the real writeback is not ensured to success.
It doesn't even need RAID56 to trigger.

But "discarding" the dirty pages doesn't sound correct.
If a writeback failed, the dirty pages should still stay dirty, not 
discarded.

It may be a new bug in the error handling path.

> 
> So there are some different cases to handle at this point:
> 
> 1.  We can read all the blocks and they have good csums:  proceed
> to write data and update parity.  This is the normal good case.
> 
> 2.  We can read all the blocks, there are csums failures, but they
> can be repaired:  proceed to write data and update parity.  This is
> the case fixed in the patch.
> 
> 3.  We can read all the blocks, there are csums failures, but they
> can't be repaired:  proceed to write data and update parity.

Nope, we should not continue, it's only "spreading" the corruption.

>  This case
> is broken in the patch.  The data in the unrecoverable blocks is lost
> already, but we can still write the new data in the stripe and update
> the parity to recover the new blocks if we go into degraded mode in
> the future.

We should only continue if our write range covers the bad sector, but 
that's impossible as that breaks DATACOW.

I can do extra handling, like if the write range covers a bad sector, we 
do not try to recover that one.

But I strongly doubt if that would have any meaning, since that means 
we're writing into a sector which already has csum.

> 
> 4.  We can read enough of the blocks to attempt repair, and the
> repair succeeds:  proceed to write data and update parity.  This is
> the degraded good case.

Degraded is not treated any different, it's just the same as failing the 
read.

> 
> 5.  We can read enough of the blocks to attempt repair, and the
> repair fails:  proceed to write data and update parity.  The lost
> data block is gone, but we can still write the new data blocks and
> compute a usable parity block.  This is another case broken by the
> patch, the degraded-mode version of case 3.

The degraded case is only making things more complex.
But I get your point.

> 
> 6.  We can't read enough of the blocks to attempt repair:  we can't
> compute parity any more, because we don't know what data is in the
> missing blocks.  We can't assume it's some constant value (e.g. zero)
> because then the new parity would be wrong if some but not all of the
> failing drives came back.
> 
> For case 1-5, we can ignore the return value of verify_one_sector()
> (or at least not pass it up to the caller of recover_vertical()).

Nope, that falls back to the old behavior, a corrupted section would 
only spread to P/Q.

We should not touch such corrupted full stripe. IIRC we already have 
such test cases in fstests.

I believe we should let the users know there is something wrong, telling 
then which sector is problematic (and which file), hoping they can 
delete the file or whatever.

We can not do the data loss decision for the end users.

> Either we restored the sector we didn't, but either outcome doesn't
> affect whether a new parity block can be computed to enable recovery of
> the new data blocks and the remaining recoverable data blocks.  The other
> error cases in recover_vertical() are either fatal problems like ENOMEM,
> or there's too many read failures and we're actually in case 6.
> 
> For case 6, the options are:
> 
> A.  abort the rbio and drop the write
> 
> B.  force the filesystem read-only
> 
> I like B for this case, but AIUI the other btrfs raid profiles currently
> do A if all the data block mirror writes fail.

The current solution for RAID56 is just do not touch it.
We do not continue nor ignore.

I believe B is the much safer solution, but I'm not sure if other 
profiles really go A.

IIRC for RAID1* we just continue as long as we have at least one good 
mirror written.

[...]
>>
>> Can you try to do it with newly created fs instead?
> 
> Already did (I needed to do that many times to run bisect...).

Any shorter reproducer?

If I understand you correct, the problem only happens when we have all 
the following conditions met:

- the sector has csum
   Or we won't very the content anyway

- both the original and repaired contents mismatch csum

This already means there are errors beyond the RAID5 tolerance.

> 
>>> 	while true; do
>>> 		# Any big file will do, usually faster than /dev/random
>>> 		# Skipping the first 1M leaves the superblock intact
>>> 		while cat vmlinux; do :; done | dd of=/dev/vdd bs=1024k seek=1
>>> 		# This should fix all the corruption as long as there are no
>>> 		# reads or writes anywhere on the filesystem
>>> 		btrfs scrub start -Bd /dev/vdd
>>> 	done
>>
>> [IMPROVE THE TEST]
>> If you want to cause interleaved free space, just create a ton of 4K
>> files, and delete them interleavely.
>>
>> And instead of vmlinux or whatever file, you can always go with
>> randomly/pattern filled file, and saves its md5sum to do verification.
> 
>> [MY CURRENT GUESS]
>> My current guess is some race with dd corruption and RMW.
>> AFAIK the last time I am working on RAID56, I always do a offline
>> corruption (aka, with fs unmounted) and it always works like a charm.
>>
>> So the running corruption may be a point of concern.
> 
> Generally, we expect the hardware to introduce corruption at any time.
> Ideally, a btrfs raid[156] should be able to work when one of its devices
> returns 4K blocks from /dev/random on every read, and if it can't,
> that's always a bug.

But so far your description is for two sectors corruption, beyond 
RAID5's tolerance.

> 
>> Another thing is, if a full stripe is determined to have unrepairable
>> data, no RMW can be done on that full stripe forever (unless one
>> manually fixed the problem).
> 
> Yeah, that's the serious new problem introduced in this patch for 6.2.
> 6.1 didn't do that in two cases where 6.2 and later do.

Unfortunately, I do not think this is the root problem.
The change is towards the correct direction, from ignoring the problem 
to at least not making it worse.

> 
>> So if by somehow you corrupted the full stripe by just corrupting one
>> device (maybe some existing csum mismatch etc?), then the full stripe
>> would never be written back, thus causing the data not to be written back.
> 
> My reproducer wasn't sufficient to trigger the bug--it would only generate
> csum errors on one device, but there need to be csum errors on two devices
> (for raid5) to get into the data-loss loop.  Apparently 6.2 still has
> a bug somewhere that introduces extra errors (it crashes a lot, that
> might be related), because when I tested on 6.2 I was observing the
> two-csum-failure case not the intended one-csum-failure case.
> 
> 6.6 and 6.9 don't have any of those problems--no crashes, no cross-device
> corruption. I've been running the reproducer on 6.6 and 6.9 for a week
> now, and there are no csum failures on any device other than the one
> being intentionally corrupted, and there are no data losses because the
> code never hits the "goto out" line in rmw_rbio (confirmed with both
> a kgdb breakpoint on the test kernel and some printk's).  So on 6.6
> and 6.9 btrfs fixes everything my reproducer throws at it.

That's my expectation. Thankfully it finally matches reality.

So that's something else in v6.2 causing beyond-raid5-tolerance.
And the data drop problem is definitely a big problem but I do not think 
it's really RAID56 specific.

My guess is some later RAID56 fixes are not yet backported to v6.2?
One quick possible fix is:

486c737f7fdc ("btrfs: raid56: always verify the P/Q contents for scrub")


> 
> It was a bad reproducer.  Sorry about that!
> 
>> Finally for the lack of any dmesg, it's indeed a problem, that there is
>> *NO* error message at all if we failed to recover a full stripe.
>> Just check recover_sectors() call and its callers.
> 
> The trouble with dmesg errors is that there are so many of them when
> there's a failure of a wide RAID5 stripe, and they can end up ratelimited,
> so admins can't see all of them.  But they're also better than nothing
> for case 6, so I approve adding a new one here.
> 
> For case 6, it might be reasonable to throw the entire filesystem
> read-only; otherwise, there's silent data loss, and not having silent
> data loss is a critical feature of btrfs.  It would still be possible
> to scrub, find the affected files, and remove them, without triggering a
> rmw cycle.  Maybe some future btrfs enhancement could handle it better,
> but for now a dead stop is better than any amount of silent loss.
> 
> One possible such enhancement is to keep the blocks from being
> allocated again, e.g. put them on an in-memory list to break the
> allocate-write-fail-free-allocate loop above.

The retry for failed full stripe is intentional, for the following two 
points:

- There may be a chance the error may be temporary
   So the next retry may get a good contents and do the repair correctly

- There is no need to cache something we know it's unreliable

[...]
> 
> On 6.6, all the automation was broken by the regression: when we replaced
> a broken file or added a new one, the new file was almost always silently
> corrupted,

A quick search through the data writeback path indeed shows we do 
nothing extra when hitting a writeback error.

This means, the dirty pages would be considered uptodate, thus later can 
be dropped.
I think we should change the behavior of clearing dirty flags, so that 
the dirty page flag only got cleared if the writeback is successful.
So I believe this is the root cause.

This change is going to be huge, and I have to check other fses to be 
extra safe.

But even with that fixed, the do-not-touch-bad-full-stripe policy is not 
doing anything helpful, unless the corrupted sector get full deleted, 
which can be very hard detect.

Maybe you can try a different recovery behavior?

E.g. always read the file, and the read failed, delete and then copy a 
new one from the backup server.

Then it may solve the problem as the bad sectors would be deleted (along 
with its csum)

Thanks,
Qu
> and we had no IO error signal to trigger replacement of the
> data from another server, so corrupted files became visible to users.
> git-based tools for deployment were fully unusable on 6.6:  any commit
> would break the local repo, while deleting and recloning the repo simply
> hit the same broken stripe rmw bug and broke the replacement repo.
> 
> At the end of recovery we did a full verification of SHA hashes and
> found only a few errors, all in files that were created or modified
> while running 6.6.
> 
>> So a more normalized test would help us both.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Loop 2 runs `sync -f` to detect sync errors and drops caches:
>>>
>>> 	while true; do
>>> 		# Sometimes throws EIO
>>> 		sync -f /testfs
>>> 		sysctl vm.drop_caches=3
>>> 		sleep 9
>>> 	done
>>>
>>> Loop 3 does some random git activity on a clone of the 'btrfs-progs'
>>> repo to detect lost writes at the application level:
>>>
>>> 	while true; do
>>> 		cd /testfs/btrfs-progs
>>> 		# Sometimes fails complaining about various files being corrupted
>>> 		find * -type f -print | unsort -r | while read -r x; do
>>> 			date >> "$x"
>>> 			git commit -am"Modifying $x"
>>> 		done
>>> 		git repack -a
>>> 	done
>>>
>>> The errors occur on the sync -f and various git commands, e.g.:
>>>
>>> 	sync: error syncing '/media/testfs/': Input/output error
>>> 	vm.drop_caches = 3
>>>
>>> 	error: object file .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5 is empty
>>> 	fatal: loose object 39c876ad9b9af9f5410246d9a3d6bbc331677ee5 (stored in .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5) is corrupt
>>>
> 

