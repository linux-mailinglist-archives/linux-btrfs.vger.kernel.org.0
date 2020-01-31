Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518D214EF26
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 16:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAaPHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 10:07:38 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43370 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgAaPHi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 10:07:38 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so5595993qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Sem1oQT3CK6ViOUN0xaEcDDbG44DVTkOCXL84q6x95E=;
        b=0sKgh/TEAYDZ1VtIHzFcwul6SP4g+l8d4vBY71/f0htZBqq2khZYZoDgEzMR32u7jy
         dA7Cr60uxMPx1RD+BuJcOUKrFkc1O34XForn7Ew3bpUm1R1rRlMS7NiLz9E5eIPMoJrc
         qPtPci9HsBswSOo2ssNs2nCsl8L259f0eH0uyR+M+RxkW2Kug5xxRd3jAE+Xo6y18er3
         4Dz7p2YXbT4In36YaIo0CcgnY8gZMqy/w2PXQp0G0HTtzZLdQQq/tqQeAMcxIkZBXLuk
         WMvwDvNLa1AtAg/FjZPs50oMdYRwKWTjFlWwbr++kciZQQ9NT58989T83pycQXfk018H
         9XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sem1oQT3CK6ViOUN0xaEcDDbG44DVTkOCXL84q6x95E=;
        b=r503vpb3ICf5+hL7p+9EuYIAMn2hAN97hRXojNhDlgO1xZxtji4sjjxg3eHi0W6GsR
         hAwpFpGhDNyaW70tV8atFE4WVmKHxZ4q+bnmrGiUomJ1HNET01blWotKsHEJNbFtSB4A
         O9CmZbGtVYBP6PkaLhHihIM6S9XUBmVcHbaneIG0pPYjEOqKIqF+hQYOnuuQKszZFaY+
         MkmeiHnSw4ZuQdNFBO1Sp9pUvNN7WbIJ11hVwX1pYBCQNOxs8XGekbibWEBns7Z3qmKL
         DUnfK0Q8kBn9QboH22Dyq+w93RoQQqFPoLQbPvA9SR+1G9adnLKTJnjIiPNRJWu/AxQD
         X+JA==
X-Gm-Message-State: APjAAAUvB91PzogDwtlvotR8LRQBpNlBXMLh+FpK3ypdcg5hObc05f/P
        gY876pvNgBtCZsQAl6PVA6cvHg==
X-Google-Smtp-Source: APXvYqysi1QrR65FvkJ9+ysPrJyG1BB6l6LsBEyLdRcYByge2zHDfR1m/ew+TipWK0Hf/dmHZo0vwg==
X-Received: by 2002:ac8:3418:: with SMTP id u24mr10937803qtb.87.1580483255837;
        Fri, 31 Jan 2020 07:07:35 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x16sm4517556qki.110.2020.01.31.07.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 07:07:34 -0800 (PST)
Subject: Re: [PATCH 01/20] btrfs: change nr to u64 in
 btrfs_start_delalloc_roots
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200129235024.24774-1-josef@toxicpanda.com>
 <20200129235024.24774-2-josef@toxicpanda.com>
 <21932aac-2499-6112-2f47-e85b7963c037@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8c464576-7d90-1a22-6666-45b10e9796c4@toxicpanda.com>
Date:   Fri, 31 Jan 2020 10:07:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <21932aac-2499-6112-2f47-e85b7963c037@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/30/20 7:06 AM, Nikolay Borisov wrote:
> 
> 
> On 30.01.20 г. 1:50 ч., Josef Bacik wrote:
>> We have btrfs_wait_ordered_roots() which takes a u64 for nr, but
>> btrfs_start_delalloc_roots() that takes an int for nr, which makes using
>> them in conjunction, especially for something like (u64)-1, annoying and
>> inconsistent.  Fix btrfs_start_delalloc_roots() to take a u64 for nr and
>> adjust start_delalloc_inodes() and it's callers appropriately.
> 
> nit: You could include one more sentence to be explicit about the fact
> that now 'nr' management is delegated to start_delalloc_inodes i.e you
> pass it as a pointer to that function which in turn will control when
> btrfs_Start_delalloc_roots breaks out of its own loop.
> 
>>
>> Part of adjusting the callers to this means changing
>> btrfs_writeback_inodes_sb_nr() to take a u64 for items.  This may be
>> confusing because it seems unrelated, but the caller of
>> btrfs_writeback_inodes_sb_nr() already passes in a u64, it's just the
>> function variable that needs to be changed.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ctree.h       |  2 +-
>>   fs/btrfs/dev-replace.c |  2 +-
>>   fs/btrfs/inode.c       | 27 +++++++++++----------------
>>   fs/btrfs/ioctl.c       |  2 +-
>>   fs/btrfs/space-info.c  |  2 +-
>>   5 files changed, 15 insertions(+), 20 deletions(-)
>>
> 
> <snip>
> 
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -9619,7 +9619,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
>>    * some fairly slow code that needs optimization. This walks the list
>>    * of all the inodes with pending delalloc and forces them to disk.
>>    */
>> -static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
>> +static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr,
>> +				 bool snapshot)
>>   {
>>   	struct btrfs_inode *binode;
>>   	struct inode *inode;
>> @@ -9659,9 +9660,11 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
>>   		list_add_tail(&work->list, &works);
>>   		btrfs_queue_work(root->fs_info->flush_workers,
>>   				 &work->work);
>> -		ret++;
>> -		if (nr != -1 && ret >= nr)
>> -			goto out;
>> +		if (*nr != U64_MAX) {
>> +			(*nr)--;
>> +			if (*nr == 0)
>> +				goto out;
>> +		}
>>   		cond_resched();
>>   		spin_lock(&root->delalloc_lock);
>>   	}
>> @@ -9686,18 +9689,15 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
>>   int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
>>   {
>>   	struct btrfs_fs_info *fs_info = root->fs_info;
>> -	int ret;
>> +	u64 nr = U64_MAX;
> 
> This var is never used past start_delalloc_snapshot so you can remove it
> and simply pass U64_MAX to start_delalloc_inodes.

Except start_delalloc_inodes() is now taking a pointer, not the value itself. 
Thanks,

Josef
