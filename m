Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC77B2759CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIWOVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:21:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:55706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIWOVE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:21:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5EF0B29D;
        Wed, 23 Sep 2020 14:21:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B41FDA6E3; Wed, 23 Sep 2020 16:19:47 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:19:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/7] btrfs: Remove struct extent_io_ops
Message-ID: <20200923141947.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-8-nborisov@suse.com>
 <20200921203808.GW6756@twin.jikos.cz>
 <94e97e0e-7b91-a877-aad1-446e231b27d5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e97e0e-7b91-a877-aad1-446e231b27d5@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 09:25:50AM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.09.20 г. 23:38 ч., David Sterba wrote:
> > On Fri, Sep 18, 2020 at 04:34:39PM +0300, Nikolay Borisov wrote:
> > 
> > You should really write changelogs for patches that not obviously
> > trivial.
> > 
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > 
> 
> 
> I thought this patch was rather self-explanatory - just removing no
> longer used struct and related functions but I guess that's just me
> given I have written the previous 6 patches, so will add a changelog in
> the next iteration. Thanks.

The subject says "remove some struct", but when somebody reads it it's
missing the "..., because ..." part. It becomes clear after reading the
patch that is' not used anymore, but there should be some clue in the
changelog from the beginning.
