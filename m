Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51006445666
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhKDPhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 11:37:34 -0400
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:45182 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKDPhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 11:37:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.03771266|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.317786-0.00353176-0.678682;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.LnZkhEF_1636040093;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LnZkhEF_1636040093)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 04 Nov 2021 23:34:53 +0800
Date:   Thu, 04 Nov 2021 23:34:59 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
Subject: Re: [PATCH v3] btrfs: fix a check-integrity warning on write caching disabled disk
In-Reply-To: <20211104150212.GZ20319@twin.jikos.cz>
References: <20211103080721.23DC.409509F4@e16-tech.com> <20211104150212.GZ20319@twin.jikos.cz>
Message-Id: <20211104233458.1670.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Wed, Nov 03, 2021 at 08:07:22AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > On Thu, Oct 28, 2021 at 06:32:54AM +0800, Wang Yugui wrote:
> > > > When a disk has write caching disabled, we skip submission of a bio
> > > > with flush and sync requests before writing the superblock, since
> > > > it's not needed. However when the integrity checker is enabled,
> > > > this results in reports that there are metadata blocks referred
> > > > by a superblock that were not properly flushed. So don't skip the
> > > > bio submission only when the integrity checker is enabled
> > > > for the sake of simplicity, since this is a debug tool and
> > > > not meant for use in non-debug builds.
> > > > 
> > > > xfstest/btrfs/220 trigger a check-integrity warning like the following
> > > > when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.
> > > 
> > > Does this need the integrity checker to be also enabled by mount
> > > options? I don't think compile time (ie the #ifdef) is enough, the
> > > message is printed only when it's enabled based on check in
> > > __btrfsic_submit_bio "if (!btrfsic_is_initialized) return", where the
> > > rest of the function does all the verification.
> > 
> > Yes.  We need mount option 'check_int' or 'check_int_data' to  trigger
> > this check-integrity warning.
> 
> So the mount options need to be checked here as well.

We just need to add the mount option(check_int/check_int_data) to
changelog

when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y and the disk with WCE=0.
=>
when CONFIG_BTRFS_FS_CHECK_INTEGRITY=y , and mount
option(check_int/check_int_data), and the disk with WCE=0.


The check of mount option(check_int/check_int_data) is done later
inside btrfsic_submit_bio. No necessary to check mount
option(check_int/check_int_data) here, we just need to match
submit_bio(linux/bio.h).

#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
void btrfsic_submit_bio(struct bio *bio);
int btrfsic_submit_bio_wait(struct bio *bio);
#else
#define btrfsic_submit_bio submit_bio
#define btrfsic_submit_bio_wait submit_bio_wait
#endif

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/11/04


