Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E334092B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 16:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCRPti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 11:49:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCRPtc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 11:49:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29116AB8C;
        Thu, 18 Mar 2021 15:49:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A753DA6E2; Thu, 18 Mar 2021 16:47:28 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:47:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa@fedoraproject.org>, linux-btrfs@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
Message-ID: <20210318154728.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Neal Gompa <ngompa@fedoraproject.org>, linux-btrfs@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20210317200144.1067314-1-ngompa@fedoraproject.org>
 <012ab078-c026-6894-80e0-ba5bbe697dc6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <012ab078-c026-6894-80e0-ba5bbe697dc6@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 08:32:30AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/18 上午4:01, Neal Gompa wrote:
> > This is a patch requesting all substantial copyright owners to sign off
> > on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> > to resolve various concerns around the mixture of code in btrfs-progs
> > with libbtrfsutil.
> >
> > Each significant (i.e. non-trivial) commit author has been CC'd to
> > request their sign-off on this. Please reply to this to acknowledge
> > whether or not this is acceptable for your code.
> 
> I'm a little surprised that I got CCed, as I can't remember any
> contribution from me to libbtrfstuil.

$ git log --oneline --author=wqu libbtrfsutil
f01d2b85581e libbtrfsutil: Convert to designated initialization for SubvolumeIterator_type
425c950cc6fe libbtrfsutil: Convert to designated initialization for QgroupInherit_type
a528cbeead1c libbtrfsutil: Convert to designated initialization for BtrfsUtilError_type
