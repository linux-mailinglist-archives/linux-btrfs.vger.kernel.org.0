Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6F18BDF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 18:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgCSR0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 13:26:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41895 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSR0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 13:26:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id s11so3908710qks.8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RDka7Gh4xTr2kWEmUvuwIQ9BeUjTqlunLmjQXspf9Wo=;
        b=UkuVE2oIU6xyzAqUsl7dIbekausBqTvm8879okTRkARCYbeGs6FPMvkbjUxhkTkms1
         qWLglvbbRlLnj0zJfcA2MkvITeD0iTHjzEdJF23Sjd+hlCmEOKM8ddbKXfBhdweRa4a7
         hYM36opBbSf8dZ2OBzFhKCikOOMVws3U4JtSQVp+aXEks4MNQcW2JgrksWoT2rfnamYs
         xS9oLcr5fvUvdHIwxbSnEwirtprcdNZD8DXtW4X0d/DFzElbbYVv4vjI2W6j3qnozQCu
         ni7j6fIUoR8yqSnebdJE0ci92bQ2gdsZE8MDfmUpAY3nvdYAEX8ef/0IvVMDq9A9A4M1
         FYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDka7Gh4xTr2kWEmUvuwIQ9BeUjTqlunLmjQXspf9Wo=;
        b=f52zn6nTgJSjU4BN+yM+AkeC6Ut/fK9niwS60dsIxGCFHiP6m3JpleUpCMQ7hpwFA5
         uj6YCBkaU+38BqG8qZXHEnUo4wrkn6FdtV31b9nYkltj+gGkqsRLBrHdIIiSb+2zZ+sF
         zesRFkCm4bsaMFkerdpIieOVfXcnjVLLzvIji2Ur2KryQ9jdmTuI6zF6OLwKrVAwsymy
         JkOwEX409G2R4ipRuRx1bCGsWZNzAJuWI4jO//9sI8Wd1qRxMnIppWx3cZ/WNUXM1o2K
         5BldfukshyjBlJkkXpLSjIEQ+ai+XE9Q71/jkOBw0uHtsqyC5dsbv0k7PtobNdlYPcZY
         ntdw==
X-Gm-Message-State: ANhLgQ3TGtveBtHbpFHUsfeM94iXAHnKzdgj301DnICcvqDAMB8CxRlx
        wlpTi+xe3CHImB6q5JSj2w7M+kdFCTY=
X-Google-Smtp-Source: ADFU+vs4Lis5e9a4hGuovuJZYoZE1bi3WE3bzSHPx4ks/m73NpGci1Rs+VKVd13lPk4N1IUlT8ZJIA==
X-Received: by 2002:ae9:f007:: with SMTP id l7mr4202362qkg.11.1584638764648;
        Thu, 19 Mar 2020 10:26:04 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 82sm1893367qko.91.2020.03.19.10.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:26:03 -0700 (PDT)
Subject: Re: [PATCH RFC 00/39] btrfs: qgroup: Use backref cache based backref
 walk for commit roots
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b3ba6a74-0d25-4cf1-03fc-a279cbb40694@toxicpanda.com>
Date:   Thu, 19 Mar 2020 13:26:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> This patchset is based on an OLD misc-next branch, please inform me
> before trying to merge, so I can rebase it to latest misc-next.
> (There will be tons of conflicts)
> 
> The branch can be fetched from github for review/testing.
> https://github.com/adam900710/linux/tree/backref_cache_all
> 
> The patchset survives all the existing qgroup tests.
> 
> 
> === BACKGROUND ===
> One of the biggest problem for qgroup is its performance impact.
> Although we have improved it in since v5.0 kernel, there is still
> something slowing down qgroup, the backref walk.
> 
> Before this patchset, we use btrfs_find_all_roots() to iterate all roots
> referring to one extent.
> That function is doing a pretty good job, but it doesn't has any cache,
> which means even we're looking up the same extent, we still need to do
> the full backref walk.
> 
> On the other hand, relocation is doing its own backref cache, and
> provides a much faster backref walk.
> 
> So the patchset is mostly trying to make qgroup backref walk (at least
> commit root backref walk) to use the same mechanism provided by
> relocation.
> 
> === BENCHMARK ===
> For the performance improvement, the last patch has a benchmark.
> The following content is completely copied from that patch:
> ------
> Here is a small script to test it:
> 
>    mkfs.btrfs -f $dev
>    mount $dev -o space_cache=v2 $mnt
> 
>    btrfs subvolume create $mnt/src
> 
>    for ((i = 0; i < 64; i++)); do
>            for (( j = 0; j < 16; j++)); do
>                    xfs_io -f -c "pwrite 0 2k" $mnt/src/file_inline_$(($i * 16 + $j)) > /dev/null
>            done
>            xfs_io -f -c "pwrite 0 1M" $mnt/src/file_reg_$i > /dev/null
>            sync
>            btrfs subvol snapshot $mnt/src $mnt/snapshot_$i
>    done
>    sync
> 
>    btrfs quota enable $mnt
>    btrfs quota rescan -w $mnt
> 
> Here is the benchmark for above small tests.
> The performance material is the total execution time of get_old_roots()
> for patched kernel (*), and find_all_roots() for original kernel.
> 
> *: With CONFIG_BTRFS_FS_CHECK_INTEGRITY disabled, as get_old_roots()
>     will call find_all_roots() to verify the result if that config is
>     enabled.
> 
> 		|  Number of calls | Total exec time |
> ------------------------------------------------------
> find_all_roots()|  732		   | 529991034ns
> get_old_roots() |  732		   | 127998312ns
> ------------------------------------------------------
> diff		|  0.00 %	   | -75.8 %
> ------
> 
> 
> Patch 01~30 are mostly refactors and code movement, which exposes no
> behavior change.
> 
> Patch 31~32 are small behavior change only for qgroup backref cache.
> Patch 33~39 are the implementation of qgroup backref cache.
> 
> 
> === REASON FOR RFC ===
> The naming is currently my biggest concern.
> 
> Since the code movement involves exporting quite a lot of functions, in
> theory they should have btrfs_ prefix.
> (For all newly exported functions in backref.h)
> 
> But some functions like alloc_backref_node(), adding "btrfs_" prefix
> doesn't make it more clear, but just making it unnecessary long.
> 
> My current plan is to rename them using "btrfs_brc_" prefix (BackRef
> Cache), and remove the "cache" in the original name.
> 
> E.g:
> alloc_backref_node => btrfs_brc_alloc_node()
> backref_cache_release => btrfs_brc_release()
> link_backref_edge => btrfs_brc_link_edge()
> 
> But the abbr "brc" is pretty confusing and makes no sense by itself, so
> I'm not sure what's the best practice here.
> 

btrfs_backref_node_alloc()
btrfs_backref_node_free()
btrfs_backref_edge_link()

etc, rename the structures to btrfs_backref_* and then make the function names 
follow suit.  Thanks,

Josef
