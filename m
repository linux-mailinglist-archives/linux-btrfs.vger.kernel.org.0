Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2534DA3E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 21:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiCOUUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiCOUUt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 16:20:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527C61A80B
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 13:19:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F0F421123;
        Tue, 15 Mar 2022 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647375574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kiP+RB1xDW1wqFJBHraRQqOypjpqL0YCTfN8DT1JQro=;
        b=zfXUXqMnHS7CvPVc9DsgogjFIb4l3FrmfjpwCWGV27S7yJWzVHfp5iufusjUtN+mgypb2x
        O39V5e4XeW03sRPr6l9jxYDZT9lgBfFFPpY5bRZSPhbmGi8zQ22xdPKLfpm7FfZVdaQfLD
        1Dbi07HvgTnK387CwguEF3GF/9JqUVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647375574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kiP+RB1xDW1wqFJBHraRQqOypjpqL0YCTfN8DT1JQro=;
        b=PH3ryVFktLcb5xaxBRxtJrbHOAkigsy+R2i56hgS1U3kWCVBofw1Mi/uncuF0FBzRL9Z7e
        EP1LVgJg38mEgjAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 01100A3B81;
        Tue, 15 Mar 2022 20:19:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C8CCDA7E1; Tue, 15 Mar 2022 21:15:35 +0100 (CET)
Date:   Tue, 15 Mar 2022 21:15:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] btrfs: don't trust sub_stripes from disk
Message-ID: <20220315201534.GY12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <d5fb898de7b87629a08f51bf1ca50a2b8f48b95b.1647329345.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fb898de7b87629a08f51bf1ca50a2b8f48b95b.1647329345.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 03:32:59PM +0800, Qu Wenruo wrote:
> [BUG]
> LKP reported a divide error testing my scrub entrance tests:
> 
>  BTRFS info (device sdb2): dev_replace from /dev/sdb3 (devid 2) to /dev/sdb6 started
>  divide error: 0000 [#1] SMP KASAN PTI
>  CPU: 3 PID: 3293 Comm: btrfs Not tainted 5.17.0-rc5-00101-g3626a285f87d #1
>  Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
>  RIP: 0010:scrub_stripe (kbuild/src/consumer/fs/btrfs/scrub.c:3448 kbuild/src/consumer/fs/btrfs/scrub.c:3486 kbuild/src/consumer/fs/btrfs/scrub.c:3644) btrfs
>  Code: 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 0c 11 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 27 09 00 00 41 8b 5d 1c 99 <f7> fb 48 8b 54 24 30 48 c1 ea 03 48 63 e8 48 b8 00 00 00 00 00 fc
>    0:	00 00                	add    %al,(%rax)
>    2:	fc                   	cld
>    3:	ff                   	(bad)
>    4:	df 48 89             	fisttps -0x77(%rax)
>    7:	f9                   	stc
>    8:	48 c1 e9 03          	shr    $0x3,%rcx
>    c:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
>   10:	48 89 fa             	mov    %rdi,%rdx
>   13:	83 e2 07             	and    $0x7,%edx
>   16:	83 c2 03             	add    $0x3,%edx
>   19:	38 ca                	cmp    %cl,%dl
>   1b:	7c 08                	jl     0x25
>   1d:	84 c9                	test   %cl,%cl
>   1f:	0f 85 27 09 00 00    	jne    0x94c
>   25:	41 8b 5d 1c          	mov    0x1c(%r13),%ebx
>   29:	99                   	cltd
>   2a:*	f7 fb                	idiv   %ebx		<-- trapping instruction
>   2c:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
>   31:	48 c1 ea 03          	shr    $0x3,%rdx
>   35:	48 63 e8             	movslq %eax,%rbp
>   38:	48                   	rex.W
>   39:	b8 00 00 00 00       	mov    $0x0,%eax
>   3e:	00 fc                	add    %bh,%ah
> 
> [CAUSE]
> The offending function is simple_stripe_full_stripe_len(), which handles
> both RAID0 and RAID10.
> 
> In that function we will divide by map->sub_stripes.
> 
> So this means map->sub_stripes is 0.
> 
> For RAID10 it's impossible as btrfs_check_chunk_valid() will ensure
> RAID10 chunk has sub_stripes set to 2.
> 
> But it doesn't check RAID0 (nor any other profiles).
> 
> With more help from Oliver, it shows that under their environment,
> SINGLE/DUP profiles also have 0 as their sub_stripes.
> 
> So it looks like a bug in btrfs-progs, but I can not reproduce nor pin down
> the exact commit.
> 
> [FIX]
> >From btrfs_raid_array[], all profiles have either sub_stripes as 1 or 2
> (only for RAID10).
> 
> Thus there is no need to trust the sub_stripe value from disk at all.
> 
> I'm not yet confident to put such sub_stripes check for all profiles, as
> there is no concrete evidence to indicate it's a bug in mkfs.btrfs, nor
> how many users are affected by it.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> I don't have direct evidence to indicate it's a bug in mkfs.btrfs.
> 
> But both code review and extra debug patches show Oliver's environment
> has chunk items with 0 as sub_stripes (for DUP at least).
> 
> However using the same progs version, I can not reproduce the same
> behavior at all (still 1 sub_stripes for SINGLE/RAID0/DUP/...)
> 
> So this is just a preventive method.

This is obviously safer as the values in the table are fixed, but it
would be also good to find the cause. I think that if it was a bug we'd
have seen it already but it could also depend on the setup.

Have you noticed any other strange looking values during the analysis?
One weird value would mean it's a bug but if there's like a missing
whole update in some data structure that would get fixed after first
write it could be eg. a missing fsync somewhere or a bug on the lower
layer.
