Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED62F68F8C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBHUVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjBHUVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:21:49 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50C43456
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:21:38 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h24so22401419qtr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnR2b4BCb/mawuc9cHdPaPNKLlDd7lfkZrx8hnqSmPQ=;
        b=paWM55ErSYLKMGTyjJ5tHF/g0OiLfX+yHcwnB9iubPJeJRMvf/utAhbe2JtnGTROWR
         +qGKF2JgWV6+bFKTI67ntcH7epzHXJLiA6aZ5H1RJoS3DMljBYa4Ri44+SSEO2o14Yiq
         59f52GgefnlEQ+ri0V/vueOemphww0X+5ozhwetQIgTnVMCF7Xz43rV67xZ5wHUWEQhm
         IVrUJkr8etOQ4xXQs/iEIPt0LVL95XOiNwgGemdPwtZz9Aq+5T/smTyJUwvfGaxFAldr
         JfWceETv8hGmpuzjBDlBA5aHPovG5+gJRMdgr04wlAlslLImCqwoo93bYJCirq34hEl8
         EU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnR2b4BCb/mawuc9cHdPaPNKLlDd7lfkZrx8hnqSmPQ=;
        b=hCc/Skoo2fD8ByiIBODSCdjIWfysWHKBH+P2NJ30uJuDPbMTrOopo+sG3MSZLldHS2
         cX9zEuusNDfzinRJQjCteDn+nTV8qlgnJtkbbgT0PjdK6dRwQomIPerEfNv3nnZ59E0D
         dneJ/RJLyxQN3lzL5Qp1Ukwge8y5WqXF3qtV2q/2014HBXYqY7lu5eD0szzpftcwOsOP
         1E3eBicJMooPWi2nbAQJlp7PjmFNQ4Y+YF7jFzKhgYnab3w7YvmTQujFwfD7nbRSII/U
         gNR5hVSAaEKOC+HAD2WbYXkZfuMAYLuvB5aBg69tJi/IPZYt3nD0GEEzjUqfvUqSuhwr
         i9hQ==
X-Gm-Message-State: AO0yUKXpooZlc3HcCQ9wTPmcBLkfVw1hd2iIcU6Z+fFi9RNJPQHN/n9Z
        1bQ17/ZovkFBw9UOhb3RA+p5ZBIUoaKUMuKTenk=
X-Google-Smtp-Source: AK7set9DU2YIknWjdjDI/66u051SrH8KaRIt7+wzMuh8QhqvOPkXWL6HM61zo3D/G1ykW/UoUxkLEg==
X-Received: by 2002:a05:622a:613:b0:3b8:6c5f:4ac0 with SMTP id z19-20020a05622a061300b003b86c5f4ac0mr14646536qta.46.1675887697812;
        Wed, 08 Feb 2023 12:21:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b24-20020a05620a0f9800b0071ba3799334sm12267405qkn.58.2023.02.08.12.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:21:37 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:21:35 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 12/13] btrfs: consult raid-stripe-tree when scrubbing
Message-ID: <Y+QET5PsmIlqiYYt@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <ed868bb9e41d77fab138d2cf7b18728358526b82.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed868bb9e41d77fab138d2cf7b18728358526b82.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:49AM -0800, Johannes Thumshirn wrote:
> When scrubbing a filesystem which uses the raid-stripe-tree for logical to
> physical address translation, consult the RST to perform the address
> translation instead of relying on fixed block group offsets.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
