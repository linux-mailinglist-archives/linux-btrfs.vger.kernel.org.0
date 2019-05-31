Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA8315EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEaULn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 16:11:43 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:43038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727316AbfEaULn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 16:11:43 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 16:11:42 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 3DF3D1804EE34
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 20:05:46 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 94FE640D7;
        Fri, 31 May 2019 20:05:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3868:3870:4321:5007:7875:10004:10400:10848:11026:11232:11658:11914:12048:12114:12296:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:14915:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: milk45_14de4368b0321
X-Filterd-Recvd-Size: 2042
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 20:05:43 +0000 (UTC)
Message-ID: <a7a2a7c70c2dcef122ddbe86eb84820fc4384c7e.camel@perches.com>
Subject: Re: [PATCH] btrfs: Fix -Wunused-but-set-variable warnings
From:   Joe Perches <joe@perches.com>
To:     Andrey Abramov <st5pub@yandex.ru>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 31 May 2019 13:05:41 -0700
In-Reply-To: <20190531195349.31129-1-st5pub@yandex.ru>
References: <20190531195349.31129-1-st5pub@yandex.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2019-05-31 at 22:53 +0300, Andrey Abramov wrote:
> Fix -Wunused-but-set-variable warnings in raid56.c and sysfs.c files

trivia:

> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index f3d0576dd327..4ab29eacfdf3 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1182,22 +1182,17 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  	int nr_data = rbio->nr_data;
>  	int stripe;
>  	int pagenr;
> -	int p_stripe = -1;
> -	int q_stripe = -1;
> +	int is_q_stripe = 0;

These uses seem boolean, so perhaps just use bool?

> +	if (rbio->real_stripes - rbio->nr_data == 2)
> +		is_q_stripe = 1;
[]
> @@ -1241,7 +1236,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
[]
> +		if (is_q_stripe) {
> @@ -2340,8 +2335,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
[]
> +	int is_q_stripe = 0;
> @@ -2351,14 +2345,10 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
> +	if (rbio->real_stripes - rbio->nr_data == 2)
> +		is_q_stripe = 1;
[]
> @@ -2380,7 +2370,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
[]
> +	if (is_q_stripe) {


