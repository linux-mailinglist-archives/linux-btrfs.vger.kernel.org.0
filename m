Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA05B0EED
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 23:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIGVLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 17:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIGVLB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 17:11:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB062BC115
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 14:11:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id q21so1992096qtp.7
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=J7ZNDsL/fsOdXO3axPdwbfh8xzrAZGaSPpAVqTFfsaQ=;
        b=fKwRvP3vo/oIenMFepr5QwpkMYH5ek8JtiH66PVjpi7oYqlJJ1C34iXmSLxbMIA9d0
         W0T8Riw/T08zn46Wtc9sb9Mb4PR1Y9a0h++4yUmQkmtFmqoaSEC4U5DHMHY5eWZhra9L
         5GzZO8e5kSUfR6d6NSn24KIqA5Z9t3gbMy8QLffmAzviB9yUUQwDha51seBO9glEGHi7
         GDAJOIigT+9mzxymK8NkmQ6CMNg16DR92yXMxBA8qJHvMWa/VXrPaRJc3wLws3zHu/XJ
         mgpsjmJUZCJMuRBxt+ws7yDJROtdhruvN4GRRnDoFDB52I6YiKE4sj1VZUB4shnJ9CAy
         /xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=J7ZNDsL/fsOdXO3axPdwbfh8xzrAZGaSPpAVqTFfsaQ=;
        b=yEBU8G0aojmBorsDuEbYFyRZGdPJM7pJ+iTAcxJGm5L6T4Rlvh6PEsLUiKqGE+xYWe
         +bSNhjn6Jf6y8vGCNe5FV70KxnlLKPX2dp48hidr7+wEEE8ksqPG8g1edmI0+DBhBWeD
         7dsMBQ5k5DaYkJwAwXhyF5FyaL0Y5uzh+x8fEqJ/AxZdCVD0Ay0sXb84yVIlU6v98gYp
         gqgTaBmqtJywu/ScHdg+rFcA7IC/UrTmT/EGS18S18jtyuNEniyZaYFO/EbbQc4Ld8OO
         uDu4FleZK+PaC2anUqiWWlTXJYwB1nJR8C1vPWM8TVXuMSirnR2JrdO9gbVXr8tE2w/M
         RE8A==
X-Gm-Message-State: ACgBeo0oFCxbCr4MhM7+3YidKAh2Gwg+JrLIbtpkOd/Y9WDHcYy0qaIY
        osd2K6eWXmmFOP+3z44jlW8BQRPUynYaTGUv
X-Google-Smtp-Source: AA6agR7xqfxFFH4FE+peLcbErbACfNp+tiut661Q7cRm1f5cfUnFKEszeAg661S5BKN/Me09emt7Xg==
X-Received: by 2002:a05:622a:48:b0:344:625e:6c46 with SMTP id y8-20020a05622a004800b00344625e6c46mr5077614qtw.28.1662585059868;
        Wed, 07 Sep 2022 14:10:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m8-20020ac866c8000000b003445d06a622sm13109856qtp.86.2022.09.07.14.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:10:59 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:10:57 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/17] btrfs: remove struct btrfs_io_geometry
Message-ID: <YxkI4ZprAux9YkdO@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-13-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:11AM +0300, Christoph Hellwig wrote:
> Now that btrfs_get_io_geometry has a single caller, we can massage it
> into a form that is more suitable for that caller and remove the
> marshalling into and out of struct btrfs_io_geometry.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
