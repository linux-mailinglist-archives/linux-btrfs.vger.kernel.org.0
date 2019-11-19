Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19975102A63
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfKSRCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 12:02:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:43144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbfKSRCR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 12:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18982B464;
        Tue, 19 Nov 2019 17:02:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 579EADA783; Tue, 19 Nov 2019 18:02:17 +0100 (CET)
Date:   Tue, 19 Nov 2019 18:02:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20191119170217.GX3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
 <20191115155816.GX3001@twin.jikos.cz>
 <dc018b50-def0-1a21-695b-e8ed068ee82a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc018b50-def0-1a21-695b-e8ed068ee82a@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 01:07:05PM +0800, Anand Jain wrote:
> On 11/15/19 11:58 PM, David Sterba wrote:
> > On Mon, Nov 04, 2019 at 02:33:02PM +0800, Anand Jain wrote:
> >> +		case 'v':
> >> +			bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;
> > 
> > This code gets repeated and it's not IMO simple enough to be copy-pasted
> > around. Eg. bconf_be_verbose() and eventually bconf_be_quiet().
> 
>   I was just concerned- it will make life of other developers difficult,
>   IMO too much abstraction in the code is almost like learning a new
>   programming language for the new person looking at the code.
>   For example fstests. To write patch for fstests you need to
>   learn about a lot of helpers, defines and functions and filters
>   specific to fstests but you wouldn't have had this problem if the
>   fstests abstractions were limited and if it embraced open-code style.
>   Just my 1c.

Yes it takes time to learn the abstractions but then it makes a lot of
things easier and allows to think about what to do and not necessarily
how. In a clean codebase there are enough examples to follow or copy &
adapt, I don't think it's a big deal and that it's normal and expected
when one works on various code bases.
