Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70A179220
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgCDOPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 09:15:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:55704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCDOPC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 09:15:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD0A1AB64;
        Wed,  4 Mar 2020 14:15:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 56086DA7B4; Wed,  4 Mar 2020 15:14:38 +0100 (CET)
Date:   Wed, 4 Mar 2020 15:14:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] btrfs-progs: metadata_uuid feature fixes and
 portation
Message-ID: <20200304141438.GT2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <Damenly_Su@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
 <2974237d-ea96-bde8-bc48-2cf8bd6a375b@suse.com>
 <c6ceaa56-f5db-54ec-a2ba-130d469ec992@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6ceaa56-f5db-54ec-a2ba-130d469ec992@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 31, 2020 at 06:04:42PM +0800, Su Yue wrote:
> On 2020/1/31 4:05 PM, Nikolay Borisov wrote:
> >
> >
> > On 12.12.19 г. 13:01 ч., damenly.su@gmail.com wrote:
> >> From: Su Yue <Damenly_Su@gmx.com>
> >>
> >> The series are inspired by easy failing misc-tests/034.
> >> Those patches fix misc-tests/034 and add new test images.
> >>
> >> After portation of kernel find fs_devices code, progs is able to
> >> work on devices with FSID_CHANGING_V2 flag, not sure whether the
> >> functionality is necessary. If not, I will remove it in next version.
> >
> > For now I think it's best if this is not added. Kernel is supposed to
> > handle split-brain scenarios upon device scan which is triggered
> > automatically by udev. If the need arises in the future then we can
> > think about integrating this code in btrfs-progs.
> >
> 
> Okay, so drop patch[3-11].

So patches 1 and 2 have been applied. Thanks.
