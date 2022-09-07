Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645405B0EE3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIGVIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIGVIL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 17:08:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CAB8F15
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 14:08:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cr9so11429321qtb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Sep 2022 14:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4ERbyTXHv2lNc1OengqdU9yPwIrFd5BCgzt43DOXgbY=;
        b=mttEMBLSxaMSVF0EY/TViBdNqlFKy1EgBz5Xqsb3PMuybnAtoFTahj27y2FZuJqltL
         5vHIvJOUjazNrLllbFdjPA8kicDMh2O9P4DTwkBtROGhmcP7vrBAKesbGuSg4IBYBWHB
         0yqo/cTXuHKX91QYi8bRo+L8pWJiQ8PsN0oKAHiKl/ytO7E+UIxPSWUem904U6g6DuwO
         gX2lzH7hfmW2Sre/4vZMIbAF1r1mtDzzJ2IFEBnQQNJKjqgPVWNK5e6Wre6BrFbj8YNQ
         ecKSrxHuhVUiLmZBgyfkODE3YPYjnX7u/z7Yt3bOlLFo/eS5qsaBYF8OotFBvoQ0Bh1Y
         pq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4ERbyTXHv2lNc1OengqdU9yPwIrFd5BCgzt43DOXgbY=;
        b=BT+igB/Y5w5NY3wFNC+8+74CNPmVD6moOjdzOFBuIEaO3wVn9US22FJvljsSL5Im1l
         IPOxecyeurQSu5Qxr57ucIqeCihFflZFE8RnDe+2llnZm31W0iniFA8cGB+5aRpDgJJv
         JlhiyWC/qARH7tcKD18ijwfObvdeUL/RYrU9NjFyMMfViIEH87L5+b/mcxTwtvhUvdRm
         Gz3kBWF6d5HDVg8oIShxEc85XAbCkIygP1BVYJP39WLEoU3P+LZmUVg1V27D3Gem4Ein
         r3IkZJL7bZLBVXpDD+7MYt8nfQLtedufW4yLXV4V6cvvlBQ7gmYPr9pioE0fkXM4fLc2
         CtoA==
X-Gm-Message-State: ACgBeo0Y+NdoLUu4YNf2kZLLj0QYOay459EkHGVETOXNn+CGuZQuTd3s
        pVj3PQ9mV46jdGkwSZCj0xK81g==
X-Google-Smtp-Source: AA6agR6R9Ma4fBS5M0YMOexWJqKtOp++nxoZDcJuRj8U2CzvivXJR8/9/fGFcY7cndh6ByDpsAlNXQ==
X-Received: by 2002:ac8:5cd6:0:b0:343:669b:7266 with SMTP id s22-20020ac85cd6000000b00343669b7266mr5132698qta.549.1662584889528;
        Wed, 07 Sep 2022 14:08:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b006bbb07ebd83sm15329310qkn.108.2022.09.07.14.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:08:09 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:08:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/17] btrfs: remove stripe boundary calculation for
 encoded I/O
Message-ID: <YxkIOFcSN4tMv6Ur@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-12-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:10AM +0300, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Stop looking at the stripe boundary in
> btrfs_encoded_read_regular_fill_pages() now that that btrfs_submit_bio
> can split bios.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
