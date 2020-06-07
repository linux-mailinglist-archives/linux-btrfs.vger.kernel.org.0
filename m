Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C151F0ADC
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFGLKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 07:10:25 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:49669 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgFGLKZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 07:10:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49ftvz3mFpz2d;
        Sun,  7 Jun 2020 13:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591528223; bh=bPGOCg5NO/k5r6GPcmB8tRxoRgKxNVWyvhPDFFIHdZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgQJB95NTnvKYty/ijtWoHaUvnDeGgZks7r+Lf4xAQbQbidzKKOxWl7QsbOie1HnI
         dKCKAZaZtKDpFFdNz+pJsUzs99o+/U7ZI4HDQdmn5L1VBX334Wd1/tiqrauHUgLSr/
         eRD2mSLVFXVwSRo0S6CF765FFk/3DxyiblWYuA8yBL8+hUL1svNkftcpuqcUoZum9H
         qW1zllHq2TeEd0HINo6fvuxECLq5KfF/rkdSdx+Val3iHRVualeKkoKzE9sdUuBXng
         GUX4ZcYjOsjXm9KKNTdWCAvGgqCiJTFEx8jdKZugegATZ0jIZ2YQaiwwzWEjiwA2pN
         SHHeq2qws+Icw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 13:10:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: balance + ENOFS -> readonly filesystem
Message-ID: <20200607111021.GB2249@qmqm.qmqm.pl>
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
 <20200607100017.GB9208@qmqm.qmqm.pl>
 <dd988b8e-2252-f391-4d45-ef754d644417@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd988b8e-2252-f391-4d45-ef754d644417@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 06:28:44PM +0800, Qu Wenruo wrote:
> On 2020/6/7 下午6:00, Michał Mirosław wrote:
> > On Sun, Jun 07, 2020 at 10:34:52AM +0200, Michał Mirosław wrote:
> >> On Sun, Jun 07, 2020 at 03:35:36PM +0800, Qu Wenruo wrote:
> >>> On 2020/6/7 下午1:12, Michał Mirosław wrote:
> >>>> Dear btrfs developers,
> >>>>
> >>>> I just added a new disk to already almost full filesystem and tried to
> >>>> enable raid1 for metadata (transcript below).
> >>> May I ask for your per-disk usage?
> >>>
> >>> There is a known bug (but rare to hit) that completely unbalance disk
> >>> usage can lead to unexpected ENOSPC (-28) error at certain critical code
> >>> and cause the transaction abort you're hitting.
> >>>
> >>> If you have added a new disk to an almost full one, then I guess that
> >>> would be the case...
[...]
> >>> If your disk layout fits my assumption, then the following patchset is
> >>> worth trying:
> >>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=297005
> >> I'll give it a try.
> > 
> > The series doesn't apply on 5.6.x nor 5.7.x. :(
> 
> It's based on current David's misc-next branch:
> https://github.com/kdave/btrfs-devel/tree/misc-next

Thanks for the pointer. I'll try to backport this if I hit the problem
again.

Best Regards,
Michał Mirosław
