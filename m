Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242CC1318B0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 20:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAFT0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 14:26:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35067 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgAFT0r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 14:26:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so43385929qto.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2ZOlOdKrDgSsydgVjUB8mXkG3doGd8t6/btleIvGEh4=;
        b=jz00Tna6KVR1a/xdBDBYHGFTKFS3yvKsTISBIfXpusp77ee/8mUTJfEwFFSNHY3Ic6
         jX27rsEZzZrmmKM/v2v+e/AYDmbPRBIaA0Hqe2xG0ZQalz0cqQJ6bJkWS2AzyD7wje+9
         YvM9Gr+7EGZ6cabbdkFh6DXjkG0jYqij9gIeu+/mKX2I4W90LRr3Y9efRJdwtPodtNVM
         dvjevx+XwJhV/n9zvCCbnq67bvUXCaQXAwjYznq5FZdbCSbo0sw9tpjM/RkTxFoUaxj2
         GFpmVgzEuV7vhdOvE5hIdY00TIjvuwJZK9JHrM4G++I0d4BCVi33/SjXfPHpPLJt9aOQ
         0ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ZOlOdKrDgSsydgVjUB8mXkG3doGd8t6/btleIvGEh4=;
        b=jf+Z5+679hkJ0aVZEPZm2aas2pG1Sm8X8BRkuwVKcvJjZrIeRvKm2BYBpTmN07o0Jh
         1IIw5XkURXeVF1qh8wfCLZ7hed3I8aV7VPSn5pDrX8a4BZ69fHEiFCp5iYFrtQQsapj6
         0siUHFbW50KTOE+ZuFopVXUcvPbPllRkumjeIpT4WH3Vi8TeArm+UzQv1Zpe0/fOQk3S
         RmFuUmu2NH95cYFD8yrP9FAMq5AEy8wptpvhaTMNsuZRMDh/k8S9ZXIcNUTpP6dscK/8
         +5Td2EFoU1wGXwq+7x+A9YSJm0kWnjhS2DUER5m60ULVkFCZVVJcnao6g/PjdndMX9Re
         5TUQ==
X-Gm-Message-State: APjAAAXdAgf8RgqdfGnEOBtcIFt7Z/xjl0gcStjWfO2omIpZpKGf8Oij
        N9vKOqJDrDXE4czVHBDU/h3LQg==
X-Google-Smtp-Source: APXvYqympW7SH/KbgcAS1MTXudlnggsJho6oaNShHM35y2t5rUECrLf7oSIdsfHkmcdP/Jy9iYbb1Q==
X-Received: by 2002:ac8:7097:: with SMTP id y23mr77367560qto.114.1578338805874;
        Mon, 06 Jan 2020 11:26:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id d8sm23434582qtr.53.2020.01.06.11.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 11:26:45 -0800 (PST)
Subject: Re: r
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
 <b58caea4-476b-bf83-292d-ea71052bbea7@toxicpanda.com>
 <20200106180413.GQ3929@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2d2d563f-6fa4-e307-1486-d249c2390570@toxicpanda.com>
Date:   Mon, 6 Jan 2020 14:26:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106180413.GQ3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/6/20 1:04 PM, David Sterba wrote:
> On Mon, Jan 06, 2020 at 11:33:51AM -0500, Josef Bacik wrote:
>> This took me a minute to figure out, but from what I can tell you are doing the
>> mb's around the BTRFS_ROOT_DEAD_RELOC_TREE flag so that in clean_dirty_subvols()
>> where we clear the bit and then set root->reloc_root = NULL we are sure to
>> either see the bit or that reloc_root == NULL.
>>
>> That's fine, but man all these random memory barriers around the bit messing
>> make 0 sense and confuse the issue, what we really want is the
>> smp_mb__after_atomic() in clean_dirty_subvols() and the smp_mb__before_atomic()
>> in have_reloc_root().
> 
> The barriers around test_bit are required, test_bit could be reordered
> as it's not a RMW operation. I suggest reding docs/atomic_t.rst on that
> topic.
> 
>> But instead since we really want to know the right answer for root->reloc_root,
>> and we clear that _before_ we clear the BTRFS_ROOT_DEAD_RELOC_TREE let's just do
>> READ_ONCE/WRITE_ONCE everywhere we access the reloc_root.  In fact you could just do
> 
> But READ/WRITE_ONCE don't guarantee CPU-ordering, only that compiler
> will not reload the variable in case it's used more than once.
> 
>> static struct btrfs_root get_reloc_root(struct btrfs_root *root)
>> {
>> 	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>> 		return NULL;
>> 	return READ_ONCE(root->reloc_root);
> 
> Use of READ_ONCE has no effect here and produces the same buggy code as
> we have now.
> 

Hmm didn't follow smp_read_barrier_depends() all the way down, I assumed it at 
least protected from re-ordering.  Looks like it only does something on alpha.

> I sent the code to Qu in the previous discussion as work in progress,
> with uncommented barriers, expecting that they will be documented in the
> final version. So don't blame him, I should have not let barriers
> reasoning left only on him. I'll comment under the patch.
> 

There's still just too many of them, like I said before we're only worried about 
either BTRFS_ROOT_DEAD_RELOC_TREE or !root->reloc_root.  So I guess instead do 
something like

static struct btrfs_root *get_reloc_root(struct btrfs_root *root)
{
	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
		return NULL;
	smp_mb__after_atomic();
	return root->reloc_root;
}

And then in clean_dirty_subvols() do the smp_mb__before_atomic() before the 
clear_bit.  There's no reason for the random mb's around the other test_bit's. 
Thanks,

Josef
