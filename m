Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129021E7274
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 04:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405016AbgE2CKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 22:10:41 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:55446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404580AbgE2CKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 22:10:41 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 22:10:41 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 5133B8003FAE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 May 2020 02:03:50 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 61CF3182CED2A;
        Fri, 29 May 2020 02:03:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2899:3138:3139:3140:3141:3142:3150:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7576:8660:9040:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13095:13148:13230:13311:13357:13439:14181:14659:14721:21080:21212:21220:21433:21627:21660:21939:21990:30045:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shirt64_1016be626d5f
X-Filterd-Recvd-Size: 2475
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 May 2020 02:03:46 +0000 (UTC)
Message-ID: <5418df56f217437bd33c4cb70098db29c177d5b3.camel@perches.com>
Subject: Re: [PATCH] btrfs: Replace kmalloc with kzalloc in the error message
From:   Joe Perches <joe@perches.com>
To:     Yi Wang <wang.yi59@zte.com.cn>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Date:   Thu, 28 May 2020 19:03:45 -0700
In-Reply-To: <1590714057-15468-1-git-send-email-wang.yi59@zte.com.cn>
References: <1590714057-15468-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-05-29 at 09:00 +0800, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Use kzalloc instead of kmalloc in the error message according to
> the previous kzalloc() call.
[]
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
[]
> @@ -632,7 +632,7 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
>  
>  	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
>  	if (NULL == selected_super) {
> -		pr_info("btrfsic: error, kmalloc failed!\n");
> +		pr_info("btrfsic: error, kzalloc failed!\n");

As there is a dump_stack() done on memory allocation
failures, these messages might as well be deleted instead.

>  		return -ENOMEM;
>  	}
>  
> @@ -795,7 +795,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  	if (NULL == superblock_tmp) {
>  		superblock_tmp = btrfsic_block_alloc();
>  		if (NULL == superblock_tmp) {
> -			pr_info("btrfsic: error, kmalloc failed!\n");
> +			pr_info("btrfsic: error, kzalloc failed!\n");

If these are really desired, it'd be likely be better
to describe the function that failed instead of whatever
internal memory allocation the function used.

Another option would be to add __GFP_NOWARN to the
allocation internal to btrfsic_block_alloc and then
change this to something like

		pr_info("btrfsic: error, btrfsic_block_alloc failed!\n");						}

or move this reporting into the btrfsic_block_alloc
function and remove the messages after each failure.

etc...


