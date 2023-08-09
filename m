Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D1776063
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHINQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjHINQG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 09:16:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9CA2106
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 06:16:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40648d758f1so48685381cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691586962; x=1692191762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUFD+zARLBoD9VgfQ9i6E9H3evhSNHaQhIu9d2QM1Sk=;
        b=49DGZzAi0lv9R4YUMmmyRsTaKTI24MrnipFt1c85HJH1J8TAsoBZdDM9BkmJIMRaET
         Az6MNfDAIf4iKebPZ86C5koKjZhQIkq4wDkOy56mqH1F/ztPtJuxFFZVDKCx/2DUXTFX
         5K4mQ9NnaruKl1Z5E4M0G0TGVWWclb2yrZGNBv9Tf3SqNVFYF2he1YxXXM4JaB2BT13n
         2m5VN0Kb554n/8gHrivnx7P9aXKT6tsFHvTlG1p1ckJwWeLdSC1IuLV1zUqVYcOdUeSN
         pZjul2ODl7JoaAe+ZsQgBtX8eWJDPj5R1sijKMmbYtKy+xKFG0zOMNO8NiIHnEY+bRCu
         H48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586962; x=1692191762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUFD+zARLBoD9VgfQ9i6E9H3evhSNHaQhIu9d2QM1Sk=;
        b=CQp4oKOJOGd3flVV/F/lK2DLg2UBYmBURorKPDHazI/93toYcZ+zrjiy+QOvgT7+KQ
         wWyheAJSA5MpdWQqnAmlLUkT4zoffch2E0Vp1BsdVcTAryggznBnb2UrdbVcdmHgJ4n2
         /5zGVeccNSvzFvynmZCAAF1Uh2inrHihkwRJ6hZb3Ig1Azs/cftgrbIrx4/WI8vahMop
         QvBfJkJhk0tC2MFurqofTdWdVHl8cDXiSNs4uXR476Kbo63H9la5Jab+ITAi326iWYBv
         9TV4FkK47KwHYoFaVIB399hEeK/H0D5YmgRhN2ALqU6MQSdO039EoLSJ/oh0fLduUWLt
         e27Q==
X-Gm-Message-State: AOJu0Yw13zWcpX400jcHFT2j2+7cqTUXNYIWgXtoJXK2dVb5QaTXOIE2
        ZFKnwCJmCA04eVG5fLp48CBJBS7xgW0p01rw2BsvUg==
X-Google-Smtp-Source: AGHT+IEa09oBu/MB/OEEfjZ4vZbDQ+KCNXPdyFD/E3NQZ42iO9BeMWBS6KhnCOOaufCRh2MqCYdSPQ==
X-Received: by 2002:a05:6214:390c:b0:63c:ea63:4717 with SMTP id nh12-20020a056214390c00b0063cea634717mr2509361qvb.43.1691586962165;
        Wed, 09 Aug 2023 06:16:02 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a2-20020a0c8bc2000000b0063d06946b2bsm4428701qvc.100.2023.08.09.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:16:01 -0700 (PDT)
Date:   Wed, 9 Aug 2023 09:16:00 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: fix race between balance and cancel/pause
Message-ID: <20230809131600.GB2515439@perftesting>
References: <9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com>
 <20230808024748.20530-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808024748.20530-1-xiaoshoukui@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 07, 2023 at 10:47:48PM -0400, xiaoshoukui wrote:
> I think this patch does not fully fix the issue.
> 
> This patch just fix assertion panic, but in the race situation, the ioctl pause 
> request still returns an incorrect value 0 to the user which mislead the user the
> pause request finished successfully. In fact, the balance request has not been paused.
> 
> Test results and analysis are as follows:
> https://lore.kernel.org/linux-btrfs/20230726030617.109018-1-xiaoshoukui@gmail.com/T/#me125d17fa59e9e671149cc76d410ced747f488b1

They're just two different issues.  My patch is concerned with the panic, yours
is concerned with getting the correct return value out to the user.

Rebase your patch ontop of Sterba's tree with my fix and send it along, getting
an accurate errno out to the user is a reasonable goal.  Thanks,

Josef
