Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7A301B5F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 12:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbhAXLTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 06:19:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:51066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbhAXLTY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 06:19:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47B3AAD3E;
        Sun, 24 Jan 2021 11:18:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A941DA7D7; Sun, 24 Jan 2021 12:16:56 +0100 (CET)
Date:   Sun, 24 Jan 2021 12:16:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] lib/zstd: Convert constants to defines
Message-ID: <20210124111656.GD1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nick Terrell <terrelln@fb.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-14-nborisov@suse.com>
 <8849FEEB-48EC-4C63-9046-279C9AFF029D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8849FEEB-48EC-4C63-9046-279C9AFF029D@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 05:50:52PM +0000, Nick Terrell wrote:
> 
> 
> > On Jan 22, 2021, at 1:58 AM, Nikolay Borisov <nborisov@suse.com> wrote:
> > 
> > Those constants are really used internally by zstd and including
> > linux/zstd.h into users results in the following warnings:
> > 
> > In file included from fs/btrfs/zstd.c:19:
> > ./include/linux/zstd.h:798:21: warning: ‘ZSTD_skippableHeaderSize’ defined but not used [-Wunused-const-variable=]
> >  798 | static const size_t ZSTD_skippableHeaderSize = 8;
> >      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/zstd.h:796:21: warning: ‘ZSTD_frameHeaderSize_max’ defined but not used [-Wunused-const-variable=]
> >  796 | static const size_t ZSTD_frameHeaderSize_max = ZSTD_FRAMEHEADERSIZE_MAX;
> >      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/zstd.h:795:21: warning: ‘ZSTD_frameHeaderSize_min’ defined but not used [-Wunused-const-variable=]
> >  795 | static const size_t ZSTD_frameHeaderSize_min = ZSTD_FRAMEHEADERSIZE_MIN;
> >      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/zstd.h:794:21: warning: ‘ZSTD_frameHeaderSize_prefix’ defined but not used [-Wunused-const-variable=]
> >  794 | static const size_t ZSTD_frameHeaderSize_prefix = 5;
> > 
> > So fix those warnings by turning the constants into defines.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> > include/linux/zstd.h | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/zstd.h b/include/linux/zstd.h
> > index 249575e2485f..e87f78c9b19c 100644
> > --- a/include/linux/zstd.h
> > +++ b/include/linux/zstd.h
> > @@ -791,11 +791,11 @@ size_t ZSTD_DStreamOutSize(void);
> > /* for static allocation */
> > #define ZSTD_FRAMEHEADERSIZE_MAX 18
> > #define ZSTD_FRAMEHEADERSIZE_MIN  6
> > -static const size_t ZSTD_frameHeaderSize_prefix = 5;
> > -static const size_t ZSTD_frameHeaderSize_min = ZSTD_FRAMEHEADERSIZE_MIN;
> > -static const size_t ZSTD_frameHeaderSize_max = ZSTD_FRAMEHEADERSIZE_MAX;
> > +#define ZSTD_frameHeaderSize_prefix 5
> > +#define ZSTD_frameHeaderSize_min ZSTD_FRAMEHEADERSIZE_MIN
> > +#define ZSTD_frameHeaderSize_max ZSTD_FRAMEHEADERSIZE_MAX
> > /* magic number + skippable frame length */
> > -static const size_t ZSTD_skippableHeaderSize = 8;
> > +#define ZSTD_skippableHeaderSize 8
> > 
> > 
> > /*-*************************************
> This looks good to me! We removed these constants from the upstream header a
> while ago, for similar reasons.
> 
> You can add:
> 
> Reviewed-by: Nick Terrell <terrelln@fb.com>

Thank you, patch added to misc-next, the warning -Wunused-const-variable
added back to Makefile.
