Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E45B1E53
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiIHNPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiIHNO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 09:14:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2AF36DED
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 06:14:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f4so12805285qkl.7
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6rZ+9vbPBRuVTOwvwgSEG/BRr+O1vT8zmUO6KgsWa28=;
        b=M02Cgjn3qXxjDYuZ0C34rsY0i+s+8J0nTE8bgANCszBPxBdJ6KiNMQtX/khFAXkLFU
         L30tcEWSd3oiYoT60BEmZW9uOiZi0++TPWHKbs2OVEN6SiVK8YjdIEivGO0AzoQMbg3U
         1oaYx43sjz9otnzwM9ku7j4Mot+Gl2WG6T3Wj/WzF9PtMWfwWMBNC8iZz08h2O+eUosT
         e5J8Vjt4XdztV5LWrL8e6O7PDtiq4/EET1Z6XsX2c4BWo0OQC0Z+39evFa33eQ0k26pr
         AakKWgeooa7XT0rZJd6yk8GT+wRirz8/qjK3flmDJDlIWwK7a25QQ/90BCDDsC3YaULk
         B4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6rZ+9vbPBRuVTOwvwgSEG/BRr+O1vT8zmUO6KgsWa28=;
        b=YZjIWF1bcOuGL6eLBSrWlvIHyqltz+r+6kwqVTVGvAOz+TY5Q10/yTnyC8hWNim1+U
         AgOgnl85YWe+XNnK7ApkMWT2Q+ZIQIB0JOUOECqmQqdjVT/aRrWhERYMsM22zZDAIZpi
         RCXUUPl+NAB74scS8s33xQpGYjj+VyWsmQ26VqXCi1eYSlC+55xfrUFSmP8NLJKxlFHv
         82fS3O/Qexv4KjYFADP9cQUyiztNCrfzcpz64xR3DQmMUNHtNbxsmmGa6EYEx9YSatNb
         q58splceXTlKq5kdgpliO1BOETSUiG9w+AXMr5gT5eAvN1iTHjttRSRzO7E74uef0cPI
         c/xQ==
X-Gm-Message-State: ACgBeo38GzJ0p/68p2ONwhnh3qhNlJX+fhbF/S6o9Y+wEEy0DLN3gdw6
        wAs6VFdeWwX3/9laqXV6GoTklL7Ork/IYw==
X-Google-Smtp-Source: AA6agR6iqfJNTDLuFn0n54F9PEC90VpJOW+cwZyIrQOjWUQFSkGSuxrxcyifr/PR1c1AXnDUs3yTbg==
X-Received: by 2002:a05:620a:1788:b0:6bb:75c3:ba06 with SMTP id ay8-20020a05620a178800b006bb75c3ba06mr5928089qkb.686.1662642889349;
        Thu, 08 Sep 2022 06:14:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fu27-20020a05622a5d9b00b003434d3b5938sm15301074qtb.2.2022.09.08.06.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:14:48 -0700 (PDT)
Date:   Thu, 8 Sep 2022 09:14:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a couple of hangs during unmount caused
 by races
Message-ID: <Yxnqx5YQxmKOGuDo@localhost.localdomain>
References: <cover.1662636489.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662636489.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 08, 2022 at 12:31:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Due to some races or bad timmings, we can hang during unmount when trying
> to stop the block group reclaim task or one of the space reclaim tasks.
> The second case if often triggered by generic/562 for a while, but the
> underlying problem has been there for a long time, despite seeming to be
> more frequent recently. More details in the changelogs.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the entire series, thanks,

Josef
