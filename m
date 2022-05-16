Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF89052881B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiEPPKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbiEPPKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:10:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0A3B3FD
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:10:39 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kk28so12341407qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oaXh2R0xByZJJoHmQMADUF2jVRfHzUS7FKKSBUYT5Rk=;
        b=dwVaCM6hSwXiY02m42ayBu76ZV+Ip9+MFBYqIXTRFUsnrjaL1Vstujk+gr+Qls38JI
         BCKrk3LRaSxiFm144UKQ0/3q6YjXCP1XTIUTBMbgDCOLrN6FBNNGpGwf/Ka1+Od9EUcB
         DIdwaWX6On0KLJNFI1Z0WmHfRDJkiw3WskJyMd4twECg9WlbXbSjYCxIM1w3JAG8GAOD
         Yd48VfZ1gweftfJDpzz1ObOHLqiSckKvBQqenyaDufky0RT8MH8qEaFkUBEhUWdhmYIO
         ib4wEnI6wVuugwldj5V5DBseFopSO2uX4M9dh3qpalgBqAG27uMOiSm9S0ZvicZ1fnLp
         yQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaXh2R0xByZJJoHmQMADUF2jVRfHzUS7FKKSBUYT5Rk=;
        b=vHiImNEpfxvbdsJGr2zkVnXnXDXln6ZXWWU6JwvxS+XDs+r3QY/Z3ArzAGvrZ0ciCX
         Y7dL1FnW6LnHuembgKqtMZcgy6BLrYCx+FCi779ah/jFRycd22YOaCNdFMAEQDpQACAP
         lT5wfXbK21dzWbjWeBUW4zT4Q/NSquoyHDBLen1+tcgIl9WUAtX2f2okBC5FiqAdJVM0
         dPxoAanlNlUUvxyL+jUrICnA371/3Zw/wwIQzrfrn60XnRMScwWTLaS0KuEtC/GKUsmn
         lZUw+CaDwqz0fwOhZN18v30Rx9uTkghlvnNzMTwQPk0m/ujRVUbLr3Jjr8UffY5SsCKe
         TFiQ==
X-Gm-Message-State: AOAM532X3cM2lDbnNPzYdsw826TY1M2vb6dTY1zciv53zTYEHpm4UGXk
        kYfZLM2vbpOi8PLq2Qfs7hbEDgyVt18Xqw==
X-Google-Smtp-Source: ABdhPJxEtjAX8IXCo+mldzqClxxhU9YvKLFSPnknT03MHVmzkwkIdUrPfvacpOBdaiIWKlBAhfkQGA==
X-Received: by 2002:a0c:d6c6:0:b0:456:4e6a:b875 with SMTP id l6-20020a0cd6c6000000b004564e6ab875mr15634142qvi.34.1652713838380;
        Mon, 16 May 2022 08:10:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 16-20020a370710000000b0069fc13ce1d7sm5895168qkh.8.2022.05.16.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:10:37 -0700 (PDT)
Date:   Mon, 16 May 2022 11:10:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Message-ID: <YoJpbIKbwEwweAup@localhost.localdomain>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <YoJmpxKoIUKWyevt@localhost.localdomain>
 <PH0PR04MB74166206230DEAF4BED182B99BCF9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74166206230DEAF4BED182B99BCF9@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 03:04:35PM +0000, Johannes Thumshirn wrote:
> On 16/05/2022 16:58, Josef Bacik wrote:
> > On Mon, May 16, 2022 at 07:31:35AM -0700, Johannes Thumshirn wrote:
> >> Introduce a raid-stripe-tree to record writes in a RAID environment.
> >>
> >> In essence this adds another address translation layer between the logical
> >> and the physical addresses in btrfs and is designed to close two gaps. The
> >> first is the ominous RAID-write-hole we suffer from with RAID5/6 and the
> >> second one is the inability of doing RAID with zoned block devices due to the
> >> constraints we have with REQ_OP_ZONE_APPEND writes.
> >>
> >> Thsi is an RFC/PoC only which just shows how the code will look like for a
> >> zoned RAID1. Its sole purpose is to facilitate design reviews and is not
> >> intended to be merged yet. Or if merged to be used on an actual file-system.
> >>
> > 
> > This is hard to talk about without seeing the code to add the raid extents and
> > such.  Reading it makes sense, but I don't know how often the stripes are meant
> > to change.  Are they static once they're allocated, like dev extents?  I can't
> > quite fit in my head the relationship with the rest of the allocation system.
> > Are they coupled with the logical extent that gets allocated?  Or are they
> > coupled with the dev extent?  Are they somewhere in between?
> 
> The stripe extents have a 1:1 relationship file the file-extents, i.e:
> 
> stripe_extent_key.objectid = btrfs_file_extent_item.disk_bytenr;
> stripe_extent_type = BTRFS_RAID_STRIPE_EXTENT;
> stripe_extent_offset = btrfs_file_extent_item.disk_num_bytes;
> 
> 
> > Also I realize this is an RFC, but we're going to need some caching for reads so
> > we're not having to do a tree search on every IO with the RAID stripe tree in
> > place.
> 
> Do we really need to do caching of stripe tree entries? They're read, once the
> corresponding btrfs_file_extent_item is read from disk, which then gets cached
> in the page cache. Every override is cached in the page cache as well.
> 
> If we're flushing the cache, we need to re-read both, the file_extent_item and 
> the stripe extents.

Yup ok if we're 1:1 with the file-extents then we don't want the whole tree
striped.

Since we're 1:1 with the file-extents please make the stripe tree follow the
same convention as the global roots, at least put the load code in the same area
as the csum/fst/extent tree, if your stuff gets merged and turned on before
extnet tree v2 it'll be easier for me to adapt it.  Thanks,

Josef
