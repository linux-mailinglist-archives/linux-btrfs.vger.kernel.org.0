Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C6A31635
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 22:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEaUi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 16:38:27 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:58745 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727576AbfEaUi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 16:38:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 764EC3D05;
        Fri, 31 May 2019 20:38:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:421:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:10004:10400:10848:11232:11473:11658:11914:12048:12114:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14915:21080:21627:30012:30054:30064:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: price00_f062e7ab5c2e
X-Filterd-Recvd-Size: 1735
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 20:38:23 +0000 (UTC)
Message-ID: <c7dd57c50690048c16722005bba1c47bcb3af750.camel@perches.com>
Subject: Re: [PATCH] btrfs: Fix -Wunused-but-set-variable warnings
From:   Joe Perches <joe@perches.com>
To:     Andrey Abramov <st5pub@yandex.ru>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 31 May 2019 13:38:22 -0700
In-Reply-To: <14843931559334698@myt6-add70abb4f02.qloud-c.yandex.net>
References: <20190531195349.31129-1-st5pub@yandex.ru>
         <a7a2a7c70c2dcef122ddbe86eb84820fc4384c7e.camel@perches.com>
         <14843931559334698@myt6-add70abb4f02.qloud-c.yandex.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2019-05-31 at 23:31 +0300, Andrey Abramov wrote:
> 31.05.2019, 23:05, "Joe Perches" <joe@perches.com>:
> > On Fri, 2019-05-31 at 22:53 +0300, Andrey Abramov wrote:
> > >  Fix -Wunused-but-set-variable warnings in raid56.c and sysfs.c files
> > These uses seem boolean, so perhaps just use bool?
> I used int because you use ints (as bools) everywhere (for example
> there is only one bool (as a function argument) in the entire raid56.c
> file with 3000 lines of code), so with int code looks more consistent.
> Are you sure that I should use bool?

That's up to you and the btrfs maintainers.


