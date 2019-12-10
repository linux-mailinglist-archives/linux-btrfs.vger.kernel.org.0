Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA25118E28
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 17:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLJQvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 11:51:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:58356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfLJQvD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 11:51:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BF62AE40;
        Tue, 10 Dec 2019 16:51:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B6A5DA727; Tue, 10 Dec 2019 17:51:02 +0100 (CET)
Date:   Tue, 10 Dec 2019 17:51:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: fix warn_on for send from readonly mount
Message-ID: <20191210165101.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191202094450.1377-1-anand.jain@oracle.com>
 <20191205113907.8269-1-anand.jain@oracle.com>
 <CAL3q7H635MDHBAEA0UZZKOn6kz=Hwna2YyM7RLZ=MbYqJOcimQ@mail.gmail.com>
 <7b4f1318-eb0f-8d1d-7ea4-c2d7bce93df4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4f1318-eb0f-8d1d-7ea4-c2d7bce93df4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 07:45:10PM +0800, Anand Jain wrote:
> On 5/12/19 7:43 PM, Filipe Manana wrote:
> > On Thu, Dec 5, 2019 at 11:39 AM Anand Jain <anand.jain@oracle.com> wrote:
> >> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> >> Link: https://lore.kernel.org/linux-btrfs/21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net/
> >> Suggested-by: Filipe Manana <fdmanana@gmail.com>
> > 
> > s/gmail.com/suse.com/
> > (David can probably do that when he picks the patch)
> > 
>   Oh. Sorry I missed it. Thanks, Anand

Fixed and added to misc-next, thanks.
