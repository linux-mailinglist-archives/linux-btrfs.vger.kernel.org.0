Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB617351F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 11:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgB1KRh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 Feb 2020 05:17:37 -0500
Received: from len.romanrm.net ([91.121.86.59]:50236 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgB1KRg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 05:17:36 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id CBB6140321;
        Fri, 28 Feb 2020 10:17:34 +0000 (UTC)
Date:   Fri, 28 Feb 2020 15:17:34 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which
 won't mount
Message-ID: <20200228151734.34512da4@natsu>
In-Reply-To: <291710b7-9218-da54-dbb5-391f6e106984@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
        <291710b7-9218-da54-dbb5-391f6e106984@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 28 Feb 2020 10:13:41 +0200
Nikolay Borisov <nborisov@suse.com> wrote:

> 
> 
> On 28.02.20 г. 10:03 ч., Anand Jain wrote:
> > On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
> > but it won't mount because we don't yet support subpage blocksize/
> > sectorsize.
> > 
> >  BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536
> > 
> > So in this case during convert provide a warning and a 10s delay to
> > terminate the command.
> > 
> > For example:
> > 
> > WARNING: Blocksize 4096 is not equal to the pagesize 65536,
> >          converted filesystem won't mount on this system.
> >          The operation will start in 10 seconds. Use Ctrl-c to stop it.
> > 10 9 8 7 6 5 4^C
> 
> What's the point of the delay? Just refuse to start the operation and quit.

IMO there should be a way to proceed with convert, if the user knows what they
are doing; maybe refuse the operation, but provide an "-f" "--force" option to
proceed anyway?

As for these 10 second delays, they always seemed a bit odd and unusual among
Linux filesystem tools or Unix CLI software in general.

-- 
With respect,
Roman
