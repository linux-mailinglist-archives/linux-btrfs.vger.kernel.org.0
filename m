Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0884776069
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjHINRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjHINRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 09:17:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1B2108
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 06:17:17 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7672303c831so524304185a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691587037; x=1692191837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DjePaA/d+8npZVGECfKbPntZQ4Qw4yDL7ir0DX5WTQ=;
        b=cIgkdMmLWU5b8crsOBBAogxI4DhNZX7aj8J3nCZ77D72Ehifr5lEyLwxWud+dg9X5F
         CKADYB5MkPBjBED/Vog3yMejwLOsVxHVlbWfUHwwdHYjpxUXQJ3z6VdMWLxgC7cm0vef
         aLWuWTLi8UO0BZmLm1ZCMqieEzZEBoN1/s27Q9wu9253sKXd6NzfD6u7Lm2jOlvwtZy6
         DDpJ1UmqSWK9Mc+UQICl8gz02yrYxmxIfyZqEv+fPnfQvT2VEsTjRj3Shs1nXeWtkJRE
         ZHHXDxBn9rZE1SaRI69N7na/Slrbvx/W1i3X2bqwJq4ftK7bJjT/AugzIoCvkVTF06t/
         EKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587037; x=1692191837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DjePaA/d+8npZVGECfKbPntZQ4Qw4yDL7ir0DX5WTQ=;
        b=JGwp6ftbT/fkdn0gi1wXNjNEf/yEbedUwTpbrPJ5gcZR/88nyCHSLfR9GXiEeIg18b
         dQjFvhJglZfAXSwXVIA/wh267mys3f+PlTVaGzm2/ZBJVLSnFa+PV98cfpEHSHxuMFGO
         iae110C7xoFecpE1LotMMZw80iyA6oELtQFKliCvEUq+UK2d2p7RAaDZmfnjfpOhMB/Z
         MtHKwhFPyNRNEWG3pH7p2D7oxB0itBQ96j94k+DltZsxsuA3IbI5TMQ2MSLx5YieblQO
         fU9hlDEnl//xUJLS0oXzdf7XI1TBKE7ZYGNlsTL5SuS6SOHHBiiVRjoCg3WFsiDrF1qT
         X+jQ==
X-Gm-Message-State: AOJu0YylF4Szqw9QXjPJNHBOBCjdxyMGR60YLpSe/EQ6NpmCxUSPXYzH
        ZB8WgiuV1qYbAXZve6RMYkToCg==
X-Google-Smtp-Source: AGHT+IFlkktiY7wc1crxupa09uDEm8wzAnmow4wM1uqNS5zrrAIHt3QZ18iGN4llAqFs3uFjXDoZ6Q==
X-Received: by 2002:a37:8687:0:b0:76c:d6eb:df89 with SMTP id i129-20020a378687000000b0076cd6ebdf89mr2839842qkd.28.1691587036842;
        Wed, 09 Aug 2023 06:17:16 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a119c00b0076825e43d98sm3974227qkk.125.2023.08.09.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:17:16 -0700 (PDT)
Date:   Wed, 9 Aug 2023 09:17:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/mkfs/005: use udevadm settle to avoid
 false alerts
Message-ID: <20230809131715.GC2515439@perftesting>
References: <688da51813559124605fca0f67c178095baca8d2.1691473890.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688da51813559124605fca0f67c178095baca8d2.1691473890.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:52:06PM +0800, Qu Wenruo wrote:
> [BUG]
> During my test runs of mkfs-tests, 005-long-device-name-for-ssd failed
> with the following error messages:
> 
>   ====== RUN CHECK dmsetup remove btrfs-test-with-very-long-name-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQPGc
>   device-mapper: remove ioctl on btrfs-test-with-very-long-name-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQPGc  failed: Device or resource busy
>   Command failed.
>   failed: dmsetup remove btrfs-test-with-very-long-name-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQPGc
>   test failed for case 005-long-device-name-for-ssd
> 
> [CAUSE]
> There seems to be a race between "btrfs inspect dump-super" and the
> dmsetup removal.
> 
> [FIX]
> Add a "udevadm settle" before removing the dm devices.
> 
> Also since we're here, use the same "udevadm settle" instead of the
> manual sleep to wait for the new dm device to showup.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
