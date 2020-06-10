Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0F1F56FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 16:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgFJOrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 10:47:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgFJOrv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 10:47:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 64691ACED;
        Wed, 10 Jun 2020 14:47:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9315CDA6FD; Wed, 10 Jun 2020 16:47:44 +0200 (CEST)
Date:   Wed, 10 Jun 2020 16:47:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 1/2] btrfs: Introduce "rescue=" mount option
Message-ID: <20200610144744.GJ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-2-wqu@suse.com>
 <3659322f-0687-d179-ff89-f3a303fe2379@oracle.com>
 <20200605113638.GB27795@twin.jikos.cz>
 <006ff0d7-517f-e505-e8cd-529029e1e203@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006ff0d7-517f-e505-e8cd-529029e1e203@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 08, 2020 at 04:11:57PM +0800, Anand Jain wrote:
> On 5/6/20 7:36 pm, David Sterba wrote:
> > On Fri, Jun 05, 2020 at 06:04:01PM +0800, Anand Jain wrote:
> >> On 4/6/20 3:18 pm, Qu Wenruo wrote:
> >>> This patch introduces a new "rescue=" mount option group for all those
> >>> mount options for data recovery.
> >>>
> >>> Different rescue sub options are seperated by ':'. E.g
> >>> "ro,rescue=nologreplay:usebackuproot".
> >>> (The original plan is to use ';', but ';' needs to be escaped/quoted,
> >>> or it will be interpreted by bash)
> >>
> >>    I fell ':' isn't suitable here.
> > 
> > What do you suggest then?
> 
> There isn't any other choice, right? Probably that's the reason for
> -o device it is -o device=dev1,device=dev2 still remains separated?
> IMO if there isn't a choice it is ok to leave them separate.

I don't think -o device is a good example to follow, we'd hardly find
any good separator of the filenames, because device path can contain
everything. /dev/disk/by-id eg. contains ":", so we'd need escaping.

> But as I commented in the other thread instead of
> -o rescue=skipbg:another1:another2 why not just -o rescue
> and mount thread shall skip the checks that fail and mount the
> fs in RO if possible. The dmesg -k must show the checks that
> were failed and had to skip to make the RO mount successful.
> So, that becomes clear about the errors which lead to the current RO 
> mount, instead of going through the logs to figure out. This is a more 
> user-friendly approach as there is one rescue option. But I am not
> sure if it is possible?

That could be a mode of rescue= that would try hard to get the
filesystem mounted but by default it's better to separate the actions,
so eg. usebackuproot is not done while skipbg would be the one to make
the mount possible.
