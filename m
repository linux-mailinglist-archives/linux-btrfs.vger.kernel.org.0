Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C17C3C1FA8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhGIG4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 02:56:05 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:55422 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhGIG4F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 02:56:05 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id BBB0A8622
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 08:53:20 +0200 (MEST)
Date:   Fri, 9 Jul 2021 08:53:20 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210709065320.GC8249@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (01:05), Graham Cobb wrote:
> On 08/07/2021 23:17, Ulli Horlacher wrote:
> 
> > 
> > I have waited some time and some Ubuntu updates, but the bug is still there:
> 
> Yes: find and du get confused about seeing inode numbers reused in what
> they think is a single filesystem.

A lot of tools aren't working correctly any more, even ls:

root@tsmsrvj:~# ls -R /nfs/localhost/fex | wc 
ls: /nfs/localhost/fex/spool: not listing already-listed directory

In consequence many cronjobs and montoring tools will fail :-(


> You can eliminate the problems by exporting and mounting single
> subvolumes only 

This is not possible at our site, we use rotating snapshots created by a
cronjob.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
