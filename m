Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE4798971
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbjIHPDP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbjIHPDP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:03:15 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4021BFA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:03:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64b3504144cso11482216d6.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185391; x=1694790191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib6/1O4NrtmAdwndQzvlpSz5mV9bB2BVpPZR69taMRw=;
        b=S/68VlOzLD0tWd3be5OReekROJcqiUVUi54MsVgylZmy/IFqlRd7ThGvQx6e5krIi1
         LVR07OjnQVq1WefVYI1bamkegYaEJjKaTMjufjL50kWoD1GJ3LV5ksOIQULT4D3YNLZY
         4vRzqAcvIiVEMLH6jG5bFWiqeA/68blT447wtv9q+LqW6oUfeHzC/Fqb1+KRG+Zpw0r2
         7IwbFzRYa+efRZpmhOzuALtT3jJvMQdvDaqJGdQqvbdE0cDEDNP67btap8e4Gm5Ss6y5
         iS4DU8PZ7YJlPm4igkO+n41YZQx3SFZ88XwOgZtL9U9CfpFf6Q8Yw5c3mTFNh7VRLQZ6
         Zk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185391; x=1694790191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib6/1O4NrtmAdwndQzvlpSz5mV9bB2BVpPZR69taMRw=;
        b=FvAUYhHyWiRDyu1nq4OVUJzj0K2mYiB3MjBXzJfjrapEkn9eETm/UkrOxdX+2mJZFX
         X3rjXoarOw89SZby6Z7PPkzm51ykFSpuBR5IOT2kJuWoscHlGJyGZVJFtyyAcUNRMCeS
         h0Mg4K1SN01gaR0s0DcaIhTOMWKE9k6xNY2Ezud8axctIrQdoo3QLr9+hybS4VD1rY2G
         uoX+4pWnK5e2e8uf66aUd+SudKliNsvht5Z31OgVfVQmmGokQTx+8Cp/PodxaBgviQfn
         xpF8NuLdVpOj1D2KeSC17nu5tnoc5+jSn7+CN3sqZ3LXQ6jTU9gmkUJpjmQclmXiaXAd
         FU1w==
X-Gm-Message-State: AOJu0YzXMLvnibBXqLSj36ltG8OWTNX4BzjUupIZDuupbCWBSjSIQQkf
        JutoF514sTK5VDZ9/QAwLumrQQ==
X-Google-Smtp-Source: AGHT+IECcshJmgxrqfzPLoj63ixgjFdcaQ2HIxWYi3UctEnpKr2xTpR3ese7agJGVWvER5Sxn7HPBA==
X-Received: by 2002:ad4:55ec:0:b0:64f:5cb1:3e93 with SMTP id bu12-20020ad455ec000000b0064f5cb13e93mr2363271qvb.41.1694185390854;
        Fri, 08 Sep 2023 08:03:10 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m13-20020ae9e00d000000b0076d6a08ac98sm632982qkk.76.2023.09.08.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:03:10 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:03:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/21] btrfs: remove refs_to_drop argument from
 __btrfs_free_extent()
Message-ID: <20230908150309.GJ1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <bb7c546282b4084cf94aa255da100d40af81b66b.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7c546282b4084cf94aa255da100d40af81b66b.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:11PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the 'refs_to_drop' argument of __btrfs_free_extent() always
> matches the value of node->ref_mod, so remove the argument and use
> node->ref_mod at __btrfs_free_extent().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
