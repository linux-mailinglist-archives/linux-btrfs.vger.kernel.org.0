Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887BB5B0EC3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIGVAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 17:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGVAk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 17:00:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA059E888
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 14:00:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c9so11445314qkk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=js7gxeaMZkPigUAoxpkc/AkWfetQpEurT+me6eERS74=;
        b=HZ6dePp2uUB3a2ltuaZByOW/gWFEqqyEymKacbSD1gtidSR2TfDUbsVqQWMQhcZ3i4
         8TMJ4BtSBDpOJPvsfB40L0zDHF/CJLgItwEXSywmocSD0O94H3sewvWSqRFghJkhWCnR
         xFsd0G3oIqJY+YpR7yx7BXMdgEEcIrfPKWSEA8/BwHgXW2ix+FK7ehoVAi8oPiah89v8
         He/D3Ov1GZax2q4ZBB/FEZX+DVDUUGX4C54jrqqEn6qJpZS6mECNkOxrE58OhJJd/bm0
         PzrqEE82ILKTKJ1Xeuje+O6SU0zPM7yZ/GOQvE0lNqvZ9xcVDI8aKkIvyIOhFoVMMq7h
         JeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=js7gxeaMZkPigUAoxpkc/AkWfetQpEurT+me6eERS74=;
        b=X3vJKDJEHQSM9NLWZcPBHds95bl14YAb+2DH1OFop9/5kCOKuLowiy1g0OcfSJNXqE
         VBSRMUEEzTaYf1kStdJwfS0bCIlmStaBefzVbiN0VD2943XAwhzuxizNs/yIyl3R+Nwl
         4N45T5ZY5LhWLfOLTsYorziQ7qUEvTyrQIy2v4EWYvxZyYcNqEkyrfo6Pnw43SSlMBu5
         goDmYcdYWoiosb1knMdLEpxal8ynRGEySDrE9nIF6KxvUBhHbvxCGtKGwbGTMuG9q5Jj
         J3kywS9i7xGI9w+fmWuo98m46nbLoZgZlOzbf/mqWDTqvTSARVyBDQzHf0cMakQaxYfg
         jQUA==
X-Gm-Message-State: ACgBeo3xYVTxB7/7UglYHHC0fSa2wYjDoVzqeAqmLypqZ4th0S6dcPwr
        kLhY1TuF09P3Vu8TJ2aAI4gKvQ==
X-Google-Smtp-Source: AA6agR5aCtwbvr/ffq0h/OBDFjVNVKy6G9BY1nph9kc6vKRFCrPA2Vy0Jhcq/aq3ZRstmGtJoso6vA==
X-Received: by 2002:a05:620a:1a0c:b0:6bb:a292:bf92 with SMTP id bk12-20020a05620a1a0c00b006bba292bf92mr4281591qkb.90.1662584436756;
        Wed, 07 Sep 2022 14:00:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id hh9-20020a05622a618900b00344576bcfefsm12788112qtb.70.2022.09.07.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:00:36 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:00:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/17] btrfs: pass the iomap bio to btrfs_submit_bio
Message-ID: <YxkGco1bbiZXZbvh@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-9-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:07AM +0300, Christoph Hellwig wrote:
> Now that btrfs_submit_bio splits the bio when crossing stripe boundaries,
> there is no need for the higher level code to do that manually.
> 
> For direct I/O this is really helpful, as btrfs_submit_io can now simply
> take the bio allocated by iomap and send it on to btrfs_submit_bio
> instead of allocating clones.
> 
> For that to work, the bio embedded into struct btrfs_dio_private needs to
> become a full btrfs_bio as expected by btrfs_submit_bio.
> 
> With this change there is a single work item to offload the entire iomap
> bio so the heuristics to skip async processing for bios that were split
> isn't needed anymore either.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
