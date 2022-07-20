Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5F57B8B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiGTOqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiGTOqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:46:39 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB44E606
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:46:38 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c3so8041446qko.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8opKbpIZ2U/IoLqoNVaRHt09NKTwtSGHaOUefMUdjfc=;
        b=SCeSy5wP9B+jCBg0bHPUq8GzEvG3hcvHOS1VW8bWU6xrSR/XqtlOA5q46E+bHpbRIv
         6ZjzjqbNFO7jQIJeV32l0GLo4CfSmDgTfyfSN+pm2Aslmc++LYayYB85XRs28SeMiTxc
         6gYY6SBsj/AfqxnetcbHw2H/MfgbWuBy4cnqqO9EBbiOwL2gxfoQHZNGWvWeZSTBvvXG
         8rv4GBWl2BCUFHw9WXpIOEvygATHzBlmnBbO7BESE01mkuPjmkl9k3du/9jlT7XRZsRX
         MV8EH05hAjz/4IrL03mH5aPw+X7AMje77pSUH2NSTTIt5kRe8J6iX29V1wU7Ml7UbS9G
         b79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8opKbpIZ2U/IoLqoNVaRHt09NKTwtSGHaOUefMUdjfc=;
        b=wWWU0YNuZVLnj1v1CfomdrzRnG4+20AOMI03m7d5vSs2nXP/OATpY4V7em1D1CVmcd
         tIpYMAWgJvQl184YQow/fR2WS3hhtnRZqN+UcC8nnAPPkr9yqXdQqIWP+7mhreWHifd1
         Yen03QUvsZe3HYuhklMVhCB8p9Czgpc9WuhYiDzOANKpAYK4rQmxFSGZ1DsO0FWnN9M6
         T4lSbI4It8cuHWBph8aEj4qz79nDMPzMU5NdwkdHmmfhfsD7ejPC39bgN41ZUl9cl98L
         BNIDD/R3zdXYqnVCQWv0oH0+MutXOApNJVKYLWUth4R2/nqM+yXoI89mFx7dX/2F5Xmo
         FzXA==
X-Gm-Message-State: AJIora+n7h6mfTGunmAyIdt/pA1zuTFVpZR/pnbvreUZnbZssZlB4QOu
        9q4T7ZMK/R5sn/a0bd34zqjus0QjPGGojQ==
X-Google-Smtp-Source: AGRyM1ssyh6T8Q1T9Wxv/Mh8dnwKoN5p2gw5mojM1GlbmDz8MESDBFRowhWALqfB0Pr8EOR7rxOJsQ==
X-Received: by 2002:a05:620a:1926:b0:6af:2a69:8b79 with SMTP id bj38-20020a05620a192600b006af2a698b79mr24800799qkb.47.1658328398317;
        Wed, 20 Jul 2022 07:46:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a0c4c00b006a6ebde4799sm17848180qki.90.2022.07.20.07.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:46:37 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:46:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/5] btrfs: Add a lockdep model for the num_extwriters
 wait event
Message-ID: <YtgVTdAB8KzBlBtY@localhost.localdomain>
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-3-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719040954.3964407-3-iangelak@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 09:09:54PM -0700, Ioannis Angelakopoulos wrote:
> Similarly to the num_writers wait event in fs/btrfs/transaction.c add a
> lockdep annotation for the num_extwriters wait event.
> 
> Use a read/write lockdep map for the annotation. A thread starting/joining
> the transaction acquires the map as a reader when it increments
> cur_trans->num_writers and it acquires the map as a writer before it
> blocks on the wait event.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
