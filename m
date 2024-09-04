Return-Path: <linux-btrfs+bounces-7808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8172C96B086
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 07:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3098E286318
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517384A22;
	Wed,  4 Sep 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R7V5A82M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0A823C3
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428056; cv=none; b=XhImdJViMk54KoAGVShCp6PVNxyfuru8L5RItDCZVKuyoczZHUUyFjb1ezRnLkiPBzo3qY5LRT/V+9zVWDQlbU3u7g21w7QcyQKz1CUOPTXf1PPTZ8IeYw3+LRN6lCpeGc34nLpB4UZggDOue2ID29/riGpKG9ISkdxRRy6bxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428056; c=relaxed/simple;
	bh=sL6q27GUm1SogSY17KzcVFVLfzJ3atUI9/N4H7SaCr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGJynmAoabjOZs02NUJ1rRXvQEt1/XyrSRPYYt5yYiHdvC3KedPZvIV72rsquDgHGPD1C0ZYPpJk5agd8VqdUlXlL3BNVuqMBue+1bV1tuAFRdQD0uQb+SxBwQ13JEWMWjOTic3TxO0YYM2to9UelqUGH6pWg1Z96HgUbG0dlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R7V5A82M; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367990aaef3so3551471f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725428053; x=1726032853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIchMVOHLkq14Xe0Sh+YgB2rKdoiYrNx+HTZBKgp9Lk=;
        b=R7V5A82M9W6L580YAfzcA7XZfjIIMHm+Gu9AoILGNhTc+g160tTDmIABClNaQggham
         L7M/GC0Qv8AIPVpDEQHnENYxiNBl3742ivhCJpmbXfiCcETDo27PL5sIoZ8lTeWCXCsJ
         GKikSnF8eq/dkAlQNln2vLsKNH84hKeNj8dL/u8obUmr2pFA7mo1Pj5N2C10xIyLrbWP
         KQiivFta/SzUodv3m/PxY+dniFAywYiqaUySc7q8WvCfX58BVmcSDcPIzcHJlYkcTz1/
         IIpQ4ItF3dkVcg9oVMQZYJsKV6u7QUGV3sUYhxvco7bfpEOxVZSTszoALkk8VY3wnOyg
         XLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725428053; x=1726032853;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIchMVOHLkq14Xe0Sh+YgB2rKdoiYrNx+HTZBKgp9Lk=;
        b=JyvCuy0Jc1W7F9Aalwr1U4WE76xQb7fpqzKIYDMBCLAfMjRVFBaNzc/jJNP164awTL
         13KZMn10e2cJ4YjsJsuCb60We0YwNCgk0X4qF6NjP014hrOvi+KygQO92Fw7gk1tr0Nq
         mZqihdCjbfc2W1YEk9vJ45Fet233bvrT3ab2DIiOYOJVPZpM+2vuK4La5VwU0NJWFsnG
         939zXhiqShuXuhhVXbj2C5AR6LRt29OundKq4OxPHZnu8AiSkliY13QeHN3XqgAJuYPV
         ZfhfEVUp2yyMz4cmQQhEkxwOgGXNuqNiWiBiRnNTjLW/N3JTevQkArk9CD6BEsI7UDDB
         viZw==
X-Forwarded-Encrypted: i=1; AJvYcCUZFY3ELoDLiiVVAyiPznKACAnALKFemFNK4svOy0P6zVWOwbdVXBIx0yCFws0kfO+qLtXd+MKCDU9mig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAMtyYUZgMq3VIop8ciGkDp/xEZ2AH/cOlOOlHYtap1yghepH
	oq2w+z9aQItT+yQtolDTlItvou2Ru1DecZ71ZHruRTQBsOgeuIONBnepEysN724=
X-Google-Smtp-Source: AGHT+IHauGezI0A+kOZPgVQojgO9OJdAJzieMzDqu3PCUa5R+JAnsgOvzAuD8O9KXsKPzRa4M3KCfw==
X-Received: by 2002:a5d:58c8:0:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-376dea471efmr2293782f8f.48.1725428052310;
        Tue, 03 Sep 2024 22:34:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785331fbsm792009b3a.68.2024.09.03.22.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 22:34:11 -0700 (PDT)
Message-ID: <05b4be15-f285-4219-94d7-10ea1adfb45a@suse.com>
Date: Wed, 4 Sep 2024 15:04:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
 <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
 <Zta6RR1gXPi7cRH3@infradead.org>
 <e5d765e8-e294-465f-adfc-ad4787116959@gmx.com>
 <ZtfeWyP2zYawbFCZ@infradead.org>
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
In-Reply-To: <ZtfeWyP2zYawbFCZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/4 13:43, Christoph Hellwig 写道:
> On Tue, Sep 03, 2024 at 07:13:29PM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2024/9/3 16:57, Christoph Hellwig 写道:
>>> You'll also need add a EXPORT_SYMBOL_GPL for blk_alloc_discard_bio.
>>
>> Just curious, shouldn't blk_ioctl_discard() also check frozen status to
>> prevent block device trim from block suspension?
> 
> Someone needs to explain what 'block suspension' is for that first.

E.g. a long running full device trim preventing PM suspension/hibernation.

The original report shows the fstrim of btrfs is preventing the system 
entering suspension/hibernation:

  PM: suspend entry (deep)
  Filesystems sync: 0.060 seconds
  Freezing user space processes
  Freezing user space processes failed after 20.007 seconds (1 tasks 
refusing to freeze, wq_busy=0):
  task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1 
    flags:0x00004006
  Call Trace:
   <TASK>
   __schedule+0x381/0x1540
   schedule+0x24/0xb0
   schedule_timeout+0x1ea/0x2a0
   io_schedule_timeout+0x19/0x50
   wait_for_completion_io+0x78/0x140
   submit_bio_wait+0xaa/0xc0
   blkdev_issue_discard+0x65/0xb0
   btrfs_issue_discard+0xcf/0x160 [btrfs 
7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   btrfs_discard_extent+0x120/0x2a0 [btrfs 
7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   btrfs_trim_block_group+0xcb/0x130 [btrfs 
7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   btrfs_trim_fs+0x119/0x460 [btrfs 
7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 
7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   btrfs_ioctl+0x11cc/0x29f0 [btrfs 
7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
   __x64_sys_ioctl+0x92/0xd0
   do_syscall_64+0x5b/0x80
   entry_SYSCALL_64_after_hwframe+0x7c/0xe6
  RIP: 0033:0x7f5f3b529f9b
  RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
  RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
  RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
  R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
   </TASK>
  OOM killer enabled.
  Restarting tasks ... done.
  random: crng reseeded on system resumption
  PM: suspend exit
  PM: suspend entry (s2idle)
  Filesystems sync: 0.047 seconds

Considering blkdev_issue_discard() is already doing cond_sched() and 
btrfs is also doing cond_sched() for each block group, it looks like PM 
freezing needs its own freezing() checks, just like what ext4 is doing.

> 
>> And if that's the case, would it make more sense to move the signal and
>> freezing checks into blk_alloc_discard_bio()?
> 
> No.  Look at that the recent history of the dicard support.  We tried
> that and it badly breaks callers not expecting the signal handling.

OK, got it, at least for btrfs we would go the blk_alloc_discard_bio() 
and do signal and freezing checks.

Thanks,
Qu

