Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACD5A99B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiIAOHh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiIAOHg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:07:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8EDBC0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:07:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q8so13496515qvr.9
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ORUtFkggG7I/9hHjseizvj+hcYhzU3gU9tm/dXelo1M=;
        b=BdlnjlEVA5x97H9veiSWjWXAhB+fLeyLqPObgp9m3lxoZqykHJoxA+akfaVxzpzIY3
         BiXwONAvq2mdSNXzQfCL1FRuWuQk64t6RAwT9H1jxyMV6HLj5wwA/dIFB6kl7koZdotk
         RDE7Lgnnx6HM1qpO8q+w0whKlJPuHka7h9N/jC1TJZ8c/0lWPKBoDo1Dkh1MNf2tN/zX
         ExqHPqIu4EHMnUUyLcr/ZZN32VjbPHC9w0mqbOcHBlA6o882kgS2voVpqAPkYsf12Ch4
         96cseJzIVa5p3ie/4UQOx56gxWMQ7FEh5m1lJCTCCsg7nBV3mSw4kr38/3o0NokvpNmE
         Qe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ORUtFkggG7I/9hHjseizvj+hcYhzU3gU9tm/dXelo1M=;
        b=fOixXxGilIHTWUA+7zsHAZe4MXRH6us92bnilP0qfg6dF4E7oypkuIS2hzK1U7EmhJ
         5FTRXyJP8yPZhBnnOuopLamz8WX5vdP9pN6HznfSv+GQlsO1HkTekxHpQ1JKO7ykH/py
         k4J6G0P8KlxgkhQtkO6iMJ/OXh6cOHa4KuLjyZ01zqKAINvaibqP9t6k1KH9Y074hZiS
         LcmhUsIm94gBEJrwGD8LhK4vBXudlArl0q0KSk5go8xaDHN8MRURHODrsYPm5pNTjL3S
         ZKOvzmuqyvYNWxwdX4TrS13k9178rHuc3Wg7CzcI1ree+uPrHU2bFndbwOvOWyofnBqF
         7ytQ==
X-Gm-Message-State: ACgBeo2lss84H5vNziS6DnG9TfawBASl0WjSFsp+3MvAkmMrDSSxBGkg
        dnx3oi6ovlmap5ssLBrqxtQPq/dOA1bYSw==
X-Google-Smtp-Source: AA6agR5ydot+IF5z/OSwTKlCDILdz9W2Xnl/es92jmxtT6zNn8etxmKdKNcv0FrJ2zWMG7NorcVYhA==
X-Received: by 2002:a05:6214:da6:b0:499:449:38da with SMTP id h6-20020a0562140da600b00499044938damr16886479qvh.130.1662041254642;
        Thu, 01 Sep 2022 07:07:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b006bc0c544d01sm12321049qkp.131.2022.09.01.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:07:34 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:07:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: allow fiemap to be interruptible
Message-ID: <YxC8pLJ4MkmmkdRS@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <5bf31c02f5117ece6a1f4709af1c8b938f149d3e.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf31c02f5117ece6a1f4709af1c8b938f149d3e.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Doing fiemap on a file with a very large number of extents can take a very
> long time, and we have reports of it being too slow (two recent examples
> in the Link tags below), so make it interruptible.
> 
> Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
