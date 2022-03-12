Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6CE4D6B74
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 01:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiCLAao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 19:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCLAan (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 19:30:43 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04F251B8C
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:29:39 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s42so9285875pfg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W0lxvmNOw1wZxyhIeWdqpgMcNgT/MaRwQJ/2EHsuXdA=;
        b=JE/LeDKXYCv1LUwpSe9A3Jd8otRelKpd+3onXlF23GBjiL4zPTXMwxM0uo8af7/DXQ
         BZuekYu1AThStEZs9CmnAYfPlr40uPRvXOTHZOyUbKfdX/2idJLd04d/oY9e5jo/SVbH
         jMy7sNzU2e9PxX4qBAyz5e+NAuIEs0+JqgBy0P34sZ4J61rSCMnF/ISsKgxm52mQTMln
         /T69vcd0+AsBFK7XMXPhiFghIO8J409pUbq2YsageCDqcufU+R8z+KRnqQ3LETTxAbtB
         zjyYbw1VUTKVnTgNqET9mjZKlZXrslOwRKy3U8IWu6rd4od18uEC2x7ceTHGAjkj0bsT
         N5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W0lxvmNOw1wZxyhIeWdqpgMcNgT/MaRwQJ/2EHsuXdA=;
        b=Yv8sZHRA+8zvTj9ofKPS4KnWGb5/ATA7KRDGy3b6L8r/IV2uh7SbkGQdwCoXXSyLxL
         6+3DlB/ezPqWVq+g005fqv/joCeznYBsC98VLXrpf8/dkOVfyGJDvsHgaFQYKucpH1Xi
         fOf0WjLro78+VDjYoLAWk7uRnKrCLqfl1HayeXN0NPWlJEiS1iJSB0s0k+XPFAEUZcG1
         Mjsds+FsJCQPSIfQaaF/YewQd3z7eexqBC2mz8YcjwOFC4DfoO6OlJ6eu8HImHoUoyji
         3muNEi0vW23Qw5Sso6Ksxbqekp6RtHQjLdvP8Ml6uLNXpY2vO32dm28+UXJtWlc0Y500
         HLlA==
X-Gm-Message-State: AOAM533DOLmEGlgH3/XgaVWJn2k5YgZq2DjcmPIiBbRxsMXGx8t/ERTF
        xXLmOUTsFRfAKNb6MOJv+IdjVaEQyq0qUw==
X-Google-Smtp-Source: ABdhPJw0UMauBtQXL4QvKaVu5D8a3Ixgpt5jlAt/Abm6d24vyPwbpq9JwudfRI+qBZITSPDX4tN/7A==
X-Received: by 2002:a05:6a00:814:b0:4f7:4c6:1227 with SMTP id m20-20020a056a00081400b004f704c61227mr12964972pfk.54.1647044978907;
        Fri, 11 Mar 2022 16:29:38 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9b1])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm12829631pfl.70.2022.03.11.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:29:38 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:29:37 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 03/16] btrfs: fix anon_dev leak in create_subvol()
Message-ID: <YivpceXk9xnkBikj@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <ee5528d299d357f225a228c394830d88e6eda17c.1646875648.git.osandov@fb.com>
 <1f55ff0e-c89d-0216-2c2f-0e1d7aa2a089@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f55ff0e-c89d-0216-2c2f-0e1d7aa2a089@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 10:42:14AM -0500, Sweet Tea Dorminy wrote:
> 
> > +out_anon_dev:
> >   	if (anon_dev)
> >   		free_anon_bdev(anon_dev);
> 
> It looks to me as though the finer-grained cleanup means free_anon_bdev()
> can always be called with no conditional; if the code reaches this point in
> cleanup, anon_dev was populated by get_anon_bdev() (which must have returned
> zero, indicating successfully populating anon_dev).

The conditional is required because halfway through the function, we
assign the anon_dev to a struct btrfs_root, which means that the
anon_dev will be freed when the root is freed:

	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
	if (IS_ERR(new_root)) {
		ret = PTR_ERR(new_root);
		btrfs_abort_transaction(trans, ret);
		goto out;
	}
	/* anon_dev is owned by new_root now. */
	anon_dev = 0;

> Otherwise,
> 
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> and thanks.

Thanks!
