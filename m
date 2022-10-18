Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1D602E53
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJROXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJROXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:23:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A299AFA1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:22:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a24so9685973qto.10
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwwphJVgIkPIDgtJpwu2k0icdC6aULPK5YV4w8vVSwA=;
        b=uA9/rTC07EDmpj4qWjVHC38F5hpfD6pMDqoOo6e0wNErumJtjROfsg+qxtxttpunHQ
         l1XptR2K50yC6qMROdp+fCuaMSwubDoMuXMZCVeethSHKm2jKuz5iT2cQZESvKuzX9n1
         utsUSoZmsR1oElSVhn3RvxEP9RlsbXg+QK4D5NPTL1pCC54ypdeqYe5X9w0rLvz9NvHl
         ZmixMizqTqta7vu8lcgNn7SA2goG6gotr/GEBr8cyUklpbCrlHmSQhTTPAOYhHBPOuHs
         V7d5bEE6KHTGmk4LigQmExpS0foyH2ov5bi4+snasq9ztWzb1115SURE0aNEBst18J00
         C8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwwphJVgIkPIDgtJpwu2k0icdC6aULPK5YV4w8vVSwA=;
        b=pFBurKjmajRIb37P/LGwPVOaEgHBlC0SrBTjP9mIX9VLzHIVuADgvg2NN+dkVt7uGT
         OhSt1PdwKyFJWHQyc/H8SM3JLY2moGtz2mrrQOBEkTyZD60XELpgygw583wTV+xTqv9a
         GJnk7vhjpFeEqgi/lT3iFVmNWsldQA0kAIxeesjL5Ms1Ftt4MjLLpmC3BXJXKKk/tMyI
         +fQP4hADSlf+6BauI9YBOj7WdK5dLkhO5gCp/GgxrL9yTQbOpKLPIMtS1PJuK7Au+/Wh
         y4ads1UfMuTJt7OrJ4R1PbmARHBXFd1UnDZ2T5R+jU/WkvDf/ad/TWvDPVeKJGs0aZh9
         eaKA==
X-Gm-Message-State: ACrzQf3A9sEYRalpeF04c70DDnfbwsvg22cSwTXvTtKyyhlA6oCYzR6O
        OuXkBE0Hw4u6k9pKCu4G09W6uTeozMNGaQ==
X-Google-Smtp-Source: AMsMyM4FFDSo5m5lYcJxmwVQKkcASWyBn669UWgQXwOAWv5QBU29DwCswtjujGpiHnTK8843MZpDBA==
X-Received: by 2002:ac8:5c41:0:b0:39c:d768:128c with SMTP id j1-20020ac85c41000000b0039cd768128cmr2285125qtj.269.1666102974164;
        Tue, 18 Oct 2022 07:22:54 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u24-20020a37ab18000000b006bb83c2be40sm2487248qke.59.2022.10.18.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:22:53 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:22:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify generation check in btrfs_get_dentry
Message-ID: <Y062vBZTbfkQ4c0N@localhost.localdomain>
References: <20221018140638.4164-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018140638.4164-1-dsterba@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 18, 2022 at 04:06:38PM +0200, David Sterba wrote:
> Callers that pass non-zero generation always want to perform the
> generation check, we can simply encode that in one parameter and drop
> check_generation. Add function documentation.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
