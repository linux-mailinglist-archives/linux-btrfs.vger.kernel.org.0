Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D622D1EA687
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFAPIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:08:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgFAPIA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:08:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A6AAAC5B;
        Mon,  1 Jun 2020 15:08:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23003DA79B; Mon,  1 Jun 2020 17:07:55 +0200 (CEST)
Date:   Mon, 1 Jun 2020 17:07:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
Message-ID: <20200601150755.GX18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
 <20200515195858.GS18421@twin.jikos.cz>
 <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
 <20200522134656.GL18421@twin.jikos.cz>
 <a240b771-bec4-dfc5-bfff-e4ee820bc481@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a240b771-bec4-dfc5-bfff-e4ee820bc481@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 26, 2020 at 03:23:08PM +0800, Anand Jain wrote:
> > Yes that's the usecase and the possibility to make more targeted tests
> > is also good, but that still means the feature is half-baked and missing
> > the main part. If it was out of scope, ok fair, but I don't want to
> > merge it at that state. It would be embarassing to announce mirror
> > selection followed by "ah no it's useless for anything than this special
> > usecase".
> 
> I didn't realize the need for default policy is prioritized before this 
> patch set.

The updated default policy has been asked for for a long time so this is
what makes it important.

> Potential default read policy is interesting, looking into it.

Thanks.
