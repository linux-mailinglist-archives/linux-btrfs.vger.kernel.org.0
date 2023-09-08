Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8179896A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbjIHPCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjIHPCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:02:16 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E4D1FDE
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:02:02 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64b8e1c739aso12290506d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185322; x=1694790122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9kvFV736Tf+lkMwwt4Z4QzXKs9QenK/4e0oEoRX644=;
        b=YmTMj7qtT8A6H18uM9G9SOdYD6/8fmnTaA2O5jFGF9pDRkveGjvurxpSA1agHF5/ER
         mt8Q2dyfPKId9B0mqxibxClsgc8qyXBJ2fjOsFy/0qcph9ghwHK9YpYob/oXln0mjPqE
         q0SN1dPLw38y1rHvlhT1PE7aKh+6GArWZrsKuWdPr7Gq7E6rY9kXi9tB3eQs5hahs/gZ
         vSO22IcFOcXXRU5Kpb87Y4JckYPH3HGifqZ1R4wYOyGZeGmXdoQVkai+A+saYrwWLr4U
         s4mIryld6TyojKNMcf7F4ZSBZiTX0FTex4Wz3THYnoy9Krq9ulTec151M11gN74yRoL6
         DL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185322; x=1694790122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9kvFV736Tf+lkMwwt4Z4QzXKs9QenK/4e0oEoRX644=;
        b=fJJ/hwJrAFmuJa5x4pVYL8EEfv/WMiH6HKzDu85Ouhwa1KYxZ2P2th92RoCrFEukLT
         yasu2qQnaOxYyhIE2VjsDdjz4LQe1KdJ5mG4Igk76Cgtf7J2SuIillDlBKokKchoRRr1
         jabXIzlO/aCyBS1jFzx7TFeBEfcrcSPcmXc/4GL2TO9YbiBTMJz60RZ16zux1+0Appwr
         N8gF3E1zYLER7A7sbZpYR7Hynjs+ZYxliGRSZU4AtEsx40xi2gM8FWBqCzDafWwFqyd1
         +eWW2LVJUdLXYf6aGVGz9mzKc/YC8cdC9lsHnAC8NSw663RjFUjlBeP7ok04tnFqy8Q2
         Evag==
X-Gm-Message-State: AOJu0Yz24n80g+ft/eSx9aiczzTo7Is/HG2/7dgGPBz5SVW3ASqPM741
        2k+eg4+EpwR+tUFNnYWvH4dYzg==
X-Google-Smtp-Source: AGHT+IH6nOalCAaEp4hJR8pyQXZkl0Zib+qRwiV9rMmyCXTtJQnWlaG0hhMCpkdCAUZba3V+7zJ2pQ==
X-Received: by 2002:a0c:8e41:0:b0:64f:92dc:3de2 with SMTP id w1-20020a0c8e41000000b0064f92dc3de2mr2998506qvb.53.1694185321701;
        Fri, 08 Sep 2023 08:02:01 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id pa32-20020a05620a832000b007671b599cf5sm638572qkn.40.2023.09.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:02:01 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:02:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/21] btrfs: remove redundant BUG_ON() from
 __btrfs_inc_extent_ref()
Message-ID: <20230908150200.GH1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <c547f96cd16df65de1aa5607ca06b007e65a7aff.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c547f96cd16df65de1aa5607ca06b007e65a7aff.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At __btrfs_inc_extent_ref() we are doing a BUG_ON() if we are dealing with
> a tree block reference that has a reference count that is different from 1,
> but we have already dealt with this case at run_delayed_tree_ref(), making
> it useless. So remove the BUG_ON().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
