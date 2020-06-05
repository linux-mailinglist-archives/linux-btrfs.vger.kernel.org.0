Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3E1EF3FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgFEJYS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 05:24:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgFEJYS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jun 2020 05:24:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4E04AD25;
        Fri,  5 Jun 2020 09:24:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42895DA811; Fri,  5 Jun 2020 11:24:13 +0200 (CEST)
Date:   Fri, 5 Jun 2020 11:24:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
Message-ID: <20200605092413.GA27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
 <8a2bac99-5c07-2aa9-fe3b-e09f2ad16213@oracle.com>
 <20200114114047.GC3929@suse.cz>
 <d38e842d-e2a7-5d27-3157-72532c3526b4@oracle.com>
 <b3981267-d64c-ebbf-233c-ea821cb7257f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3981267-d64c-ebbf-233c-ea821cb7257f@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 06:01:28PM +0800, Anand Jain wrote:
>    A ping on this series.

So I want to merge the series but I think it's unfinished. There are
mostly --verbose options added, while --quiet is only for send and
receive. My first test was 'btrfs -q subvolume create' and 'delete' and
that -q did not work is surprising. The -v/-q options need to come in
the same release.

Also, many options that have their own --verbose option should update
the help text to note that it's an alias of the global.

I'm going to take another look today, the scope of the change might be
too big to do in one go so some incremental steps might be needed.
