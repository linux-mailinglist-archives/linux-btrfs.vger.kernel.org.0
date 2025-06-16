Return-Path: <linux-btrfs+bounces-14688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEEADBD03
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8644E1893248
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5E621882B;
	Mon, 16 Jun 2025 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V2ltwSXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE54A0C
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113433; cv=none; b=KVhOzRq8UDI/jdF1seVJwvjezlgh3J+Ht7SyJ5bBV/48WozbFn/cghuMRYF0fT4WKsCf6E72ltNhJtpQwazM+Yexmvguoj4IwCEEQfa9AEV4f0aQ2O1EBkktUM7VoezYXvNeRf01/PAsPrJx+kVtN1QsOdRzrI1xmbe1DECyFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113433; c=relaxed/simple;
	bh=VJ00qr6kcwaesTuoKeqlnoQt4Vr+hWUl0nKIocdVYQo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lq9ghLURH7l9WaJoIFb57N5t5/Cu8DHv++krl5YliRu/Y+WWg6BiD249KlbRU87udXvg3DOZ6lRSt3GqC3CuGhEvI+Zzik9Nv8rTTvt5M+knIuC42zjXW7+DcED6Vk+m5GR7mCEnRKqzszSd342NdG/IwyotaZndP74r7mzodyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V2ltwSXX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a365a6804eso3654651f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750113429; x=1750718229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwdg+a3wc2KFy2xM9PUMj5Or0r02XkMiCymJK5/YRmI=;
        b=V2ltwSXXFtdg8kN1INnyG5wdPr92cHXBov7YL5AAIu8z9+SSUSXjxtYWdJGgltfjqV
         Q52G+gS8NOadhwejkagYlLOn3yBmEI4bae/EMjlGMd0ByS4U8nVAH1QAIiYIboxAmukl
         mjTQTpAk+lSspTXwgGyypZ+vVtvxcTp7EV+XfyCVGk8OJgo3XJrw14rigssmEfejQ1Hx
         fclPgxDN2dOf1EkqFhPeykUD8hp57ldHn9gBKrSiRmr6S9NBdSFI/Iy0mqNiE3nKOXuQ
         Gm5vUF2SMLlmDPoqxoe0E7oYxu4GovmQMpQtEKmR6cVM4AfrwbdM9ww3soiRyhJXrZhU
         ezXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113429; x=1750718229;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fwdg+a3wc2KFy2xM9PUMj5Or0r02XkMiCymJK5/YRmI=;
        b=U9ct83YP5jWbIV3Hq086sU4jkRFq0axD1VaJB72CZPfVoeOhYP+MlW6nf2rxA+rkZV
         WO7RjkFV2F34QPdwClgyiRALs2cpdzE7yH0t50qTmxAI3F1Kwtl0tIxBpCozA9MyX2OF
         MJRNr/1tensDWO2HGBbH4ZnMhWRZ5tfsmcdAD8J/+oDF2hDUFU+tR6Tj/ioOwOOmAUZ2
         efK4xfND28Sry6Yp7t4YtTtx8z3pVMKVlvQLeK4UPMg5YnaYT8Pm1o6xdhJ3m1IPg0UJ
         opd7ZcIWZ8A+ZLtIkpgaCjkUy3bpEZOI/caj8qsIEMkJdPLS2coXrAb2fWB/YR70prZB
         DDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVekOl96ceMHRytkeK3LPBQmAsU8mTmx/w6KrrawvpNbgBTsvumSB65m7oIQEjHjhn3WFbPLP5rlZt5jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVjveCHuQjTiFW6zIA0Ljap2IpO7tfDp97t0Qbc57T1GgyKUy
	xZ5ElDBDY731QXegKHdOM0QS0bwIFGfng7Tcf5YFpAu8aMWqB1qdT4Jk7lUgQlGglck=
X-Gm-Gg: ASbGncsStSmWlVelsZ6bGglyWqcBsY89EPCBIQlPC/PGvQZ2JeRn8XEhyKTSuagb17M
	uTEYptLfTw0D2pVfUKmHiULY538U6ZSD1NOGhhYb7NWjVEpQNj3HmUGvLYOWiJhlht7CWNXxle0
	SUinNEvDKo8CiqEESsmAy22svyhFT8pAGB8nXF6Y2kKS6vumpsU78e0kE3ACj1SHuRBcklnOAGE
	Jam0yblRNWrWXkjRxaxqJjFqWQ05CCZGap4H6tOPMMcoEd7gaD1Q2r7bkgS+U/bysTmX5e7L757
	oTYJ/vQXYdf9xt70y6Ym/5JqPjeStJJD+084hV55HM0tRvLIYfaen92zItuvT1gnE5JfhI7g/jM
	9o29gHRoWBYcsoA==
X-Google-Smtp-Source: AGHT+IHGfMwhkeI4MBv9thIKnaDMxxN7VcDB52e8XsIJEUk0kw6GjYKVOjR1EX1vTIkxSpU1RugAhQ==
X-Received: by 2002:a5d:64ee:0:b0:3a5:2ec5:35ba with SMTP id ffacd0b85a97d-3a5723a3fb2mr8173190f8f.30.1750113429000;
        Mon, 16 Jun 2025 15:37:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9e8sm7706819b3a.11.2025.06.16.15.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 15:37:08 -0700 (PDT)
Message-ID: <c34b2c63-66f9-422f-bba4-997bc530c673@suse.com>
Date: Tue, 17 Jun 2025 08:07:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] btrfs: split btrfs_fs_devices.opened
From: Qu Wenruo <wqu@suse.com>
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, Christoph Hellwig <hch@lst.de>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <20250611100303.110311-4-jth@kernel.org>
 <f1088e76-896c-4b83-8477-b7bdad7e8efd@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <f1088e76-896c-4b83-8477-b7bdad7e8efd@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/16 19:56, Qu Wenruo 写道:
> 
> 
> 在 2025/6/11 19:33, Johannes Thumshirn 写道:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> The btrfs_fs_devices.opened member mixes an in use counter for the
>> fs_devices structure that prevents it from being garbage collected with
>> a flag if the underlying devices were actually opened.  This not only
>> makes the code hard to follow, but also prevents btrfs from switching
>> to opening the block device only after super block creation.  Split it
>> into an in_use counter and an is_open boolean flag instead.
> 
> I'm hitting problems with this patch applied (previous patch 1 and 2 
> also applied and tested), that it causes problem setting up other dm 
> devices.
> Thus failing future tests that requires SCRATCH_DEV for dm setup.
> 
> Furthermore at btrfs unload time, the warnings at free_fs_devices() got 
> triggered.
> 
> But without this one (only patch 1 & 2), I have not hit anything like 
> that at all.
> 
> So this means, even without extra in_use without opening cases, this is 
> already causing problems.
> 
> 
> Furthermore the in-use-but-not-opened state for the next patch (delayed 
> devices opening), may not be that important anymore.
> 
> With extra comments added into btrfs_get_tree_super(), we can explain 
> the cleanup properly.
> And even if there are races between devices open (protected by 
> uuid_mutex) and sget_fc(), and different threads win the two races, it 
> doesn't really matter.
> 
> As long as the final btrfs_fill_super() get all its devices opened, and 
> the opened ref count is working, there is nothing to worry.
> 
> So I'm afraid both patch 3 and 4 may be dropped.

But we still need the delay of btrfs_open_devices() after sget_fc() to 
use the super block as blk holder.

So my current version is to expand the critical section of uuid_mutex to 
cover sget_fc(), then call btrfs_open_devices(), and finally unlock 
uuid_mutex.

Still running the tests but so far so good.

Thanks,
Qu

> 
> Thanks,
> Qu
> 
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   fs/btrfs/volumes.c | 53 ++++++++++++++++++++++++++--------------------
>>   fs/btrfs/volumes.h |  6 ++++--
>>   2 files changed, 34 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 1ebfc69012a2..00b64f98e3bd 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -413,7 +413,8 @@ static void free_fs_devices(struct 
>> btrfs_fs_devices *fs_devices)
>>   {
>>       struct btrfs_device *device;
>> -    WARN_ON(fs_devices->opened);
>> +    WARN_ON_ONCE(fs_devices->in_use);
>> +    WARN_ON_ONCE(fs_devices->is_open);
>>       while (!list_empty(&fs_devices->devices)) {
>>           device = list_first_entry(&fs_devices->devices,
>>                         struct btrfs_device, dev_list);
>> @@ -541,7 +542,7 @@ static int btrfs_free_stale_devices(dev_t devt, 
>> struct btrfs_device *skip_device
>>                   continue;
>>               if (devt && devt != device->devt)
>>                   continue;
>> -            if (fs_devices->opened) {
>> +            if (fs_devices->in_use) {
>>                   if (devt)
>>                       ret = -EBUSY;
>>                   break;
>> @@ -613,7 +614,7 @@ static struct btrfs_fs_devices *find_fsid_by_device(
>>       if (found_by_devt) {
>>           /* Existing device. */
>>           if (fsid_fs_devices == NULL) {
>> -            if (devt_fs_devices->opened == 0) {
>> +            if (devt_fs_devices->in_use == 0) {
>>                   /* Stale device. */
>>                   return NULL;
>>               } else {
>> @@ -848,7 +849,7 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>       if (!device) {
>>           unsigned int nofs_flag;
>> -        if (fs_devices->opened) {
>> +        if (fs_devices->in_use) {
>>               btrfs_err(NULL,
>>   "device %s (%d:%d) belongs to fsid %pU, and the fs is already 
>> mounted, scanned by %s (%d)",
>>                     path, MAJOR(path_devt), MINOR(path_devt),
>> @@ -916,7 +917,7 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>            * tracking a problem where systems fail mount by subvolume id
>>            * when we reject replacement on a mounted FS.
>>            */
>> -        if (!fs_devices->opened && found_transid < device->generation) {
>> +        if (!fs_devices->in_use && found_transid < device->generation) {
>>               /*
>>                * That is if the FS is _not_ mounted and if you
>>                * are here, that means there is more than one
>> @@ -977,7 +978,7 @@ static noinline struct btrfs_device 
>> *device_list_add(const char *path,
>>        * it back. We need it to pick the disk with largest generation
>>        * (as above).
>>        */
>> -    if (!fs_devices->opened) {
>> +    if (!fs_devices->in_use) {
>>           device->generation = found_transid;
>>           fs_devices->latest_generation = max_t(u64, found_transid,
>>                           fs_devices->latest_generation);
>> @@ -1177,15 +1178,19 @@ static void close_fs_devices(struct 
>> btrfs_fs_devices *fs_devices)
>>       lockdep_assert_held(&uuid_mutex);
>> -    if (--fs_devices->opened > 0)
>> +    if (--fs_devices->in_use > 0)
>>           return;
>> +    if (!fs_devices->is_open)
>> +        goto done;
>> +
>>       list_for_each_entry_safe(device, tmp, &fs_devices->devices, 
>> dev_list)
>>           btrfs_close_one_device(device);
>>       WARN_ON(fs_devices->open_devices);
>>       WARN_ON(fs_devices->rw_devices);
>> -    fs_devices->opened = 0;
>> +    fs_devices->is_open = false;
>> +done:
>>       fs_devices->seeding = false;
>>       fs_devices->fs_info = NULL;
>>   }
>> @@ -1197,7 +1202,7 @@ void btrfs_close_devices(struct btrfs_fs_devices 
>> *fs_devices)
>>       mutex_lock(&uuid_mutex);
>>       close_fs_devices(fs_devices);
>> -    if (!fs_devices->opened) {
>> +    if (!fs_devices->in_use) {
>>           list_splice_init(&fs_devices->seed_list, &list);
>>           /*
>> @@ -1253,7 +1258,7 @@ static int open_fs_devices(struct 
>> btrfs_fs_devices *fs_devices,
>>           return -EINVAL;
>>       }
>> -    fs_devices->opened = 1;
>> +    fs_devices->is_open = true;
>>       fs_devices->latest_dev = latest_dev;
>>       fs_devices->total_rw_bytes = 0;
>>       fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>> @@ -1306,16 +1311,14 @@ int btrfs_open_devices(struct btrfs_fs_devices 
>> *fs_devices,
>>        * We also don't need the lock here as this is called during 
>> mount and
>>        * exclusion is provided by uuid_mutex
>>        */
>> -
>> -    if (fs_devices->opened) {
>> -        fs_devices->opened++;
>> -        ret = 0;
>> -    } else {
>> +    if (!fs_devices->is_open) {
>>           list_sort(NULL, &fs_devices->devices, devid_cmp);
>>           ret = open_fs_devices(fs_devices, flags, holder);
>> +        if (ret)
>> +            return ret;
>>       }
>> -
>> -    return ret;
>> +    fs_devices->in_use++;
>> +    return 0;
>>   }
>>   void btrfs_release_disk_super(struct btrfs_super_block *super)
>> @@ -1407,7 +1410,7 @@ static bool btrfs_skip_registration(struct 
>> btrfs_super_block *disk_super,
>>           mutex_lock(&fs_devices->device_list_mutex);
>> -        if (!fs_devices->opened) {
>> +        if (!fs_devices->is_open) {
>>               mutex_unlock(&fs_devices->device_list_mutex);
>>               continue;
>>           }
>> @@ -2314,13 +2317,14 @@ int btrfs_rm_device(struct btrfs_fs_info 
>> *fs_info,
>>        * This can happen if cur_devices is the private seed devices 
>> list.  We
>>        * cannot call close_fs_devices() here because it expects the 
>> uuid_mutex
>>        * to be held, but in fact we don't need that for the private
>> -     * seed_devices, we can simply decrement cur_devices->opened and 
>> then
>> +     * seed_devices, we can simply decrement cur_devices->in_use and 
>> then
>>        * remove it from our list and free the fs_devices.
>>        */
>>       if (cur_devices->num_devices == 0) {
>>           list_del_init(&cur_devices->seed_list);
>> -        ASSERT(cur_devices->opened == 1, "opened=%d", cur_devices- 
>> >opened);
>> -        cur_devices->opened--;
>> +        ASSERT(cur_devices->in_use == 1, "opened=%d", cur_devices- 
>> >in_use);
>> +        cur_devices->in_use--;
>> +        cur_devices->is_open = false;
>>           free_fs_devices(cur_devices);
>>       }
>> @@ -2549,7 +2553,8 @@ static struct btrfs_fs_devices 
>> *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
>>       list_add(&old_devices->fs_list, &fs_uuids);
>>       memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
>> -    seed_devices->opened = 1;
>> +    seed_devices->in_use = 1;
>> +    seed_devices->is_open = true;
>>       INIT_LIST_HEAD(&seed_devices->devices);
>>       INIT_LIST_HEAD(&seed_devices->alloc_list);
>>       mutex_init(&seed_devices->device_list_mutex);
>> @@ -7162,7 +7167,8 @@ static struct btrfs_fs_devices 
>> *open_seed_devices(struct btrfs_fs_info *fs_info,
>>               return fs_devices;
>>           fs_devices->seeding = true;
>> -        fs_devices->opened = 1;
>> +        fs_devices->in_use = 1;
>> +        fs_devices->is_open = true;
>>           return fs_devices;
>>       }
>> @@ -7179,6 +7185,7 @@ static struct btrfs_fs_devices 
>> *open_seed_devices(struct btrfs_fs_info *fs_info,
>>           free_fs_devices(fs_devices);
>>           return ERR_PTR(ret);
>>       }
>> +    fs_devices->in_use = 1;
>>       if (!fs_devices->seeding) {
>>           close_fs_devices(fs_devices);
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index afa71d315c46..06cf8c99befe 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -419,8 +419,10 @@ struct btrfs_fs_devices {
>>       struct list_head seed_list;
>> -    /* Count fs-devices opened. */
>> -    int opened;
>> +    /* Count if fs_device is in used. */
>> +    unsigned int in_use;
>> +    /* True if the devices were opened. */
>> +    bool is_open;
>>       /* Set when we find or add a device that doesn't have the nonrot 
>> flag set. */
>>       bool rotating;
> 
> 



