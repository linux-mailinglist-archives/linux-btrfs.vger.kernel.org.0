Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FD2DB54F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 21:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgLOUk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 15:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgLOUkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 15:40:45 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E2C0617A7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 12:40:05 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z9so15693916qtn.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 12:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HshYfG2KMrE9kn42haCeoby2VEyH8mOhh50GEaEr1A=;
        b=mhOaE3z6azxTmFH32YvuOJafvDEnDudEnB0mknrJsir8PEHyQmusq9acLo+pw0CSqQ
         Vp/S722NtvJS/Uk4+UXpa9sxxpwMwfuHXzn7pNDKY8u8dMhKdnfQLq/b/V2gBnYeblx8
         Cc7UaxOo2ZDAXWH7DkF0Ivbs/KHM2h4d5/MIY49ZujptYSTw5c9tyZODkM/deQFgfjJ6
         rYqDLfFIet7Yy+cUl8HAS0mrtsfOUffMIVfx2tZNf2dhdr27tHg6Bh7V2JEj4ida/0ZL
         q1qEdRTxmhlMoz977gMt1/JguMTt3HUg3vZbuChAqal2tRr+MtkjzhmVF6n11z8Dn5L3
         AkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HshYfG2KMrE9kn42haCeoby2VEyH8mOhh50GEaEr1A=;
        b=CTZg1Z1tsVhZ3fgf/DYEj12GClbvoz0sRdhY7uhJ3iFT+f0kogIpA6ef0/hA7YZ4yQ
         i7RAPVa6NqcBqgNWe48BKLk/vFJrlLP4VrzuleVTXhBbsWaIU5ayXp0UjXYeaNwrKquC
         XfXxH5mvGp/TI6j9rDZg4F3lyvlcKrlwna3OxffULZHyQJK+cbQzlFekEG80HwIw4836
         jydtx9l1Hn2FlDlNcgOTs9jsEqCSltumr7xi2nN1ikM1JITFPMebGZkcAdbjkMreMNLE
         EumXTWl+02cCRMBCcDMgpCt9PZu81uJgNeANuzLqpYd6IhHdQnZc0grfebuVR7JUbxfJ
         ytKA==
X-Gm-Message-State: AOAM5308uFCbKAzv7+7ifoABXhC+0E5HLQWeZYuywkpRwCXOPvM/dfjn
        iNtUAoOqnnuq1ifH16wHu8tW4g==
X-Google-Smtp-Source: ABdhPJxiugaG/jmzL48Kxc3TEvuVl/AjNbFQJRvqnPnSTZnHYEOgwU9u9y8h7QTjT/Z0avSiURBZbA==
X-Received: by 2002:ac8:5509:: with SMTP id j9mr37712777qtq.284.1608064804528;
        Tue, 15 Dec 2020 12:40:04 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm49077qtu.23.2020.12.15.12.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 12:40:03 -0800 (PST)
Subject: Re: [PATCH 3/4] btrfs: exclude mmaps while doing remap
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1607969636.git.josef@toxicpanda.com>
 <d4234012acb7ecbdaa4aec9a9a6057ec596c6415.1607969636.git.josef@toxicpanda.com>
 <20201215202315.GA6905@magnolia>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6bc7fdb7-7c8f-92ec-e320-d1878b0b4584@toxicpanda.com>
Date:   Tue, 15 Dec 2020 15:40:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215202315.GA6905@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/15/20 3:23 PM, Darrick J. Wong wrote:
> On Mon, Dec 14, 2020 at 01:19:40PM -0500, Josef Bacik wrote:
>> Darrick reported a potential issue to me where we could allow mmap
>> writes after validating a page range matched in the case of dedupe.
>> Generally we rely on lock page -> lock extent with the ordered flush to
>> protect us, but this is done after we check the pages because we use the
>> generic helpers, so we could modify the page in between doing the check
>> and locking the range.
> 
> FWIW I only found that via code inspection because Matthew Wilcox asked
> me about whether or not filesystems did the right thing.  I wrote the
> attached fstest to try to demonstrate the problem on btrfs but it
> actually passes on xfs and btrfs.  This means either that (a) btrfs is
> doing it right through some other means because I don't understand its
> locking or (b) the test is wrong.
> 
> The test /does/ explode as expected on ocfs2 because mmap io lol there.
> 

The problem exists, it's just the window is super narrow.  If you put a 
schedule_timeout(HZ) right after btrfs_remap_file_range_prep() you'd hit the 
problem every time.  We basically have to mkwrite right between doing the 
vfs_dedupe_file_range_compare() and calling btrfs_extent_same(), which is going 
to be hard to do.  You aren't missing something, it's just hard to hit.  Thanks,

Josef
