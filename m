Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C3E6B8F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfGQJLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 05:11:03 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:61347 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQJLD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 05:11:03 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 1A1FD8B02
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 11:11:01 +0200 (MEST)
Date:   Wed, 17 Jul 2019 11:11:00 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: how do I know a subvolume is a snapshot?
Message-ID: <20190717091100.GC3462@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <eff513b1-a77c-cd5f-5af7-87eae73cff6a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff513b1-a77c-cd5f-5af7-87eae73cff6a@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2019-07-17 (11:24), Nikolay Borisov wrote:
> 
> 
> On 17.07.19 3. 2:24 G., Ulli Horlacher wrote:
> 
> > I thought, I can recognize a snapshot when it has a Parent UUID, but this
> > is not true for snapshots of toplevel subvolumes: 
> 
> As you have asked this before - in my testing this is not true.

It is true on all my SUSE and Ubuntu systems, for all versions.


> Alternatively you have to parse the root tree - the ROOT_ITEM's offset
> member should be 0 for well-known trees/ordinary subvolume or the
> transaction id when the snapshot was created.

Where can I find this ROOT_ITEM offset member? Which command?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<eff513b1-a77c-cd5f-5af7-87eae73cff6a@suse.com>
