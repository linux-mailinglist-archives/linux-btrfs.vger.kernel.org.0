Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF741C2A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245326AbhI2KYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:24:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbhI2KYV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:24:21 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1CC8F22525;
        Wed, 29 Sep 2021 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632910960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Q7MC0KmyRm5mzfbCT5FicLeaLXtNuSnPtuXAsgnX7s=;
        b=I8erG7xCwDosdbjUdCUs3QXduXm1pPj0qxy9TI3+28+oiT66j411Xg47iN7xkJFNkF5it/
        jXlZw4dF5TIbswOqP1Uvymxe5MmgszPvuCU0SVF87NHjebADLRN7g5Acu96tRIBjPcEhuC
        2Sg/OwDGxJyIF7CaYcpHl/+11eQCuqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632910960;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Q7MC0KmyRm5mzfbCT5FicLeaLXtNuSnPtuXAsgnX7s=;
        b=J4k3+B72uIuOSs3KZbRGtBgHTqMp4pdUPEze7UQEIE7TRJuglSFB3xxlMIjzHLnvOhaDk1
        LneYJEXmYenjC+Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id E356E25D50;
        Wed, 29 Sep 2021 10:22:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6409DA7A9; Wed, 29 Sep 2021 12:22:23 +0200 (CEST)
Date:   Wed, 29 Sep 2021 12:22:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Message-ID: <20210929102223.GM9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927215139.GJ9286@twin.jikos.cz>
 <20210929022422.mynjvx4angtb3vfi@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929022422.mynjvx4angtb3vfi@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 02:24:22AM +0000, Naohiro Aota wrote:
> On Mon, Sep 27, 2021 at 11:51:39PM +0200, David Sterba wrote:
> > On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
> > I was doing some btrfs-convert changes and found that it crashed, rough
> > bisection points to this series. With the last patch applied, convert
> > fails with the following ASAN error:
> 
> It looks like eb->fs_info == NULL at this point. In case of
> btrfs-convert, we can assume it is non-zoned because we do not support
> the converting on a zoned device (we can't create ext*, reiserfs on a
> zoned device anyway).

That would mean that extN/reiserfs was created on a zoned device. One
can still do a image copy to a zoned device and then convert. Even if
this is possible in theory I'd rather not allow that right now because
there are probably more changes required to do full support.

I've just noticed that ZONED bit is mistakenly among the feature flag
bits allowed in convert. Added in 242c8328bcd55175 "btrfs-progs: zoned:
add new ZONED feature flag":

BTRFS_CONVERT_ALLOWED_FEATURES must not contain
BTRFS_FEATURE_INCOMPAT_ZONED.
