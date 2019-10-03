Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4BC9F16
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfJCNHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 09:07:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfJCNHl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Oct 2019 09:07:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57ABDAD95;
        Thu,  3 Oct 2019 13:07:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62D41DA890; Thu,  3 Oct 2019 15:07:56 +0200 (CEST)
Date:   Thu, 3 Oct 2019 15:07:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: Properly handle backref_in_log retval
Message-ID: <20191003130756.GT2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190924170920.GB2751@twin.jikos.cz>
 <20190925110303.20466-1-nborisov@suse.com>
 <CAL3q7H6mZTNN2NuZ8dudR=F=MHVsjbyK6=3ELCOhnQJb_AFhWg@mail.gmail.com>
 <93c09683-2a67-a6e5-8853-9092912d48f7@suse.com>
 <20191003125559.GS2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003125559.GS2751@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 03, 2019 at 02:55:59PM +0200, David Sterba wrote:
> On Thu, Sep 26, 2019 at 01:39:58PM +0300, Nikolay Borisov wrote:
> > >> -       if (backref_in_log(log_root, &search_key, dirid, name, name_len))
> > >> +       ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
> > >> +       if (ret == 1)
> > >>                 return true;
> > > 
> > > This function also needs to be able to return errors and its caller
> > > check for errors.
> > 
> > Yes but this is for a follow up patch. The current patch does not make
> > the code any more broken than it currently is.
> 
> I'm going to merge the patches, please send the followup patch soon, so
> we don't forget about adding the proper error handling. Thanks.

Never mind, the patch 3/3 inlines the function and the error handling is
integrated to the caller.
