Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FACDE5156
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633066AbfJYQfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 12:35:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbfJYQfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 12:35:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00533ADD9;
        Fri, 25 Oct 2019 16:35:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66EF7DA785; Fri, 25 Oct 2019 18:35:55 +0200 (CEST)
Date:   Fri, 25 Oct 2019 18:35:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
Message-ID: <20191025163555.GP3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
 <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
 <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 09:56:14AM +0800, Anand Jain wrote:
> On 25/10/19 7:51 AM, Anand Jain wrote:
> > 
> > 
> > On 24/10/19 11:41 PM, David Sterba wrote:
> >> On Thu, Oct 24, 2019 at 02:28:22PM +0800, Anand Jain wrote:
> >>> When both the options (--quiet and --verbose) in btrfs send and receive
> >>> is specified, we need at least one of it to overrule the other, 
> >>> irrespective
> >>> of the chronological order of options.
> >>
> >> I think the common behaviour is to respect the order of appearance on
> >> the commandline.
> > 
> >    I am fine with this. Will fix it as this.
> 
>   Question: command -v -q -v should be equal to command -v, right?

No, that would be equivalent to the default level:

verbose starts with 1			()
verbose++				(-v)
verbose = 0				(-q)
verbose++ is now 1, which is not -v	()
