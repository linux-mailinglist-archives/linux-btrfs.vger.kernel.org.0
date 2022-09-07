Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061245B0BCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIGRvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIGRvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 13:51:37 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ECD74BA1
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 10:51:36 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d1so11315368qvs.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ITGHEw/7ymb4th+IGnerzxh0oAntgrwPzuWkbu2it9c=;
        b=iT1680MlJ9vpZy2yyO5XAToQ3Yz6tDTkpa3MqBL8w4OtIYy7MEGpYgQoxKjJzVQpy6
         dop58K4LGi1dN1l6Jvak7BuMUzaECUuFmbJbI01m6hxRK6tj9I4mSuc1SkibN/5Ji+rL
         tyRh3QN0zfntEHEuMDI2hJOuiuRn5nydQjCLfeU1njLXMW7MHmJRILKQq/iGGY2/QdZU
         KpDsYl3lK5xrnzHPVkGVJq0QAIYG5Zb1SWhmcz7VrJikOrII5ir2khpZVJeq7H39wUFF
         EpT6YpDHW85nqZyJaXpnEfcnPHFc8OGF4ExKde4s3dZOrz1Ex79aeETUvq3scZr8RQwB
         LJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ITGHEw/7ymb4th+IGnerzxh0oAntgrwPzuWkbu2it9c=;
        b=sfDv90+j3Pz2S624SUmexstoWky3rno369E5PZDixy9yXBb8DlxtzNOF7pRsNM4PMq
         sr4QBHQCMHqTlDYS+a5C3p/YvxnnGkOHRHcFmzVIeC+/PUqMIgaeUJf1x/MdeBdY3IH/
         EJ+5oDybI4o2t7ftQTFzMJOrJuqYb2zbItOlizO0dM7F/ZICKlrhJrCisFC/cPNaau6K
         kTwxan3IY3cjeKUDI84mNj/E/yNEJDvpKn8bqrwEKWyYUSfdgq59FXqg26vVI7h73Ks7
         QZs0NY97nc9hGVFRNUqI7YWfggIl2kE4As4cCyxA9htVMExfpJ1fnqeetZiGG2eBMa1y
         7gFQ==
X-Gm-Message-State: ACgBeo3H3asg86PCrh5umLCXs/a4Mn4HMrJVDTQLdVATyhCXAoIdnSng
        lnwC8tZuwO7Mw45NdGocSLp4pw==
X-Google-Smtp-Source: AA6agR6CoYWGm4o+0w84/9spuynpg9aAhitgRahCqiScW9rPfy0FJ/KazSprmNPB45S/CDtHbrY3dg==
X-Received: by 2002:a05:6214:62c:b0:4aa:a427:add2 with SMTP id a12-20020a056214062c00b004aaa427add2mr4175958qvx.47.1662573095310;
        Wed, 07 Sep 2022 10:51:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x2-20020a376302000000b006b905e003a4sm13742672qkb.135.2022.09.07.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:51:34 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:51:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/17] block: export bio_split_rw
Message-ID: <YxjaJQth4QkEy0HL@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-2-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:00AM +0300, Christoph Hellwig wrote:
> bio_split_rw can be used by file systems to split and incoming write
> bio into multiple bios fitting the hardware limit for use as ZONE_APPEND
> bios.  Export it for initial use in btrfs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
