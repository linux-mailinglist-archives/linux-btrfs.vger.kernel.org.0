Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08D51F5215
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgFJKRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 06:17:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgFJKRI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 06:17:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5DD18AAC6;
        Wed, 10 Jun 2020 10:17:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E5FADA872; Wed, 10 Jun 2020 12:17:01 +0200 (CEST)
Date:   Wed, 10 Jun 2020 12:17:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
Message-ID: <20200610101701.GH27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
 <8a2bac99-5c07-2aa9-fe3b-e09f2ad16213@oracle.com>
 <20200114114047.GC3929@suse.cz>
 <d38e842d-e2a7-5d27-3157-72532c3526b4@oracle.com>
 <b3981267-d64c-ebbf-233c-ea821cb7257f@oracle.com>
 <20200605092413.GA27795@twin.jikos.cz>
 <525dc473-b717-a274-f083-3ab280e83add@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525dc473-b717-a274-f083-3ab280e83add@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 05, 2020 at 06:12:30PM +0800, Anand Jain wrote:
> 
> > My first test was 'btrfs -q subvolume create' and 'delete' and
> > that -q did not work is surprising. The -v/-q options need to come in
> > the same release.
> 
>   Ah. I thought rest of the commands shall adopt -q option progressively.
>   So its not unfinished. Anyway I can fix them now.

From use case point of view it is unfinished, adding options for
verbosity without the corresponding quieting option just does not make
sense. The global options were my suggestion but so far I don't think
we've reached common understanding what's needed to implement that.
