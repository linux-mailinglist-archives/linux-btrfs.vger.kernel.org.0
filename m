Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72163D1349
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhGUP1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 11:27:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39620 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhGUP1C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 11:27:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0887422571;
        Wed, 21 Jul 2021 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626883658;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N58hh4d2D2FjOxp8Lyui27BELfOSa08gqeCregyry7Q=;
        b=gPWaPFt1F8KYpLk5/sWKG6Ac3g4f3PvJ4WP+XwwyJmXoM02eMU9veDtNov6fjLft4SadAR
        iHsPdC2VnZ10fbomWtiCA32QGI6Izw6LNeWYX/X/QylTTZQUuAb7jrABKFRWbsL2HC8vX0
        lRQRTTXhQcrVYF2B8iBAJlp/QA9sDbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626883658;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N58hh4d2D2FjOxp8Lyui27BELfOSa08gqeCregyry7Q=;
        b=yRZALOz3pW+H4uDAL0erjYzCkHSJP7EPHKehT/Lqp6GzdfQdRnDAbV9MgrZ9CXOTrYL8Xz
        qTcm5IxMpRPmRMDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CEC93A3B8A;
        Wed, 21 Jul 2021 16:07:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86336DA704; Wed, 21 Jul 2021 18:04:56 +0200 (CEST)
Date:   Wed, 21 Jul 2021 18:04:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 3/3] btrfs: drop unnecessary ASSERT from
 btrfs_submit_direct()
Message-ID: <20210721160455.GI19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>
References: <cover.1626871138.git.naohiro.aota@wdc.com>
 <13a38aa3e4b99f11970f96a85ce0a71498ff0737.1626871138.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a38aa3e4b99f11970f96a85ce0a71498ff0737.1626871138.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 09:43:34PM +0900, Naohiro Aota wrote:
> When on SINGLE block group, btrfs_get_io_geometry() will return "the
> size of the block group - the offset of the logical address within the
> block group" as geom.len. Since we allow up to 8 GB zone size on zoned
> btrfs, we can have up to 8 GB block group, so can have up to 8 GB
> geom.len. With this setup, we easily hit the "ASSERT(geom.len <=
> INT_MAX);".
> 
> The ASSERT looks like to guard btrfs_bio_clone_partial() and bio_trim()
> which both take "int" (now "unsigned int" with the previous patch). So to
                              ^^^^^^^^^^^^

That is now u64, fixed in the case below too.

> be precise the ASSERT should check if clone_len <= UINT_MAX. But
> actually, clone_len is already capped by bio.bi_iter.bi_size which is
> unsigned int. So the ASSERT is not necessary.
> 
> Drop the ASSERT and properly compare submit_len and geom.len in u64. Then,
> let the implicit casting to convert it to unsigned int.
                                            ^^^^^^^^^^^^

As it's fixing the 8GB zone case I'd like to put the series to -rc
queue. There are the two block layer patches, reviewed by Christoph but
I'll wait a bit for acks before sending it to Linus. Meanwhile I'll add
it to for-next for testing. Thanks.
