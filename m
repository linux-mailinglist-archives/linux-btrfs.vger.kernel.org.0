Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01964A7E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 20:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLLTFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 14:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiLLTFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 14:05:41 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984AFC7A
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 11:05:39 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3cbdd6c00adso160441567b3.11
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 11:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gde4Nsy6ltj9qRkJEfthpVdhAOD1YkpJppuIqbG9DHo=;
        b=7m0DXUj/BKhxDgB+VgYIYnKEygwn+FwOaRhNqUiovp4c1XB03DPOWh9iAKKOk4cdnj
         IymIImzteIhtpbZCftVuZGuXRx8y5MVynZLhEabLRNvCRmLWZlR6YCG5iEdGqpVCLE1W
         PL1IuwBkydZyENi5eyBiJJOWB5Y5Y7rzAgvxTgVBfjbv5PAgRi6xNnEqXMjM0Xm4DU7D
         S7bjvetLgbYCqGsCyuZ5IkEVwuQ5MbzfGH0Nz5zuD9lYFgyO/WmCMjGjjjPgU6bXqvyG
         l4H5HVjOYZGK7FnAfZZQ74LRI5O6fN2esu0W13e26VgNQzD3eZP/8558S0u/eLyT3pw0
         9BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gde4Nsy6ltj9qRkJEfthpVdhAOD1YkpJppuIqbG9DHo=;
        b=Xk75d1MSL1M/PoKpFyTG4NsCwXmsvjubbnjTELKYeQSNPhvepgNIsKs2JRcnLVbPHa
         4/ljQijzEKY3DmDYiibIYpmSJu3A3ELYpRKKf5F4eWVpnTrmBeJpWMJo/hep870z81cO
         zYIPJdUyqYvZ5WflToHrURBweNeSZM7lIg41Mvw18khSffjk4sXovqRYqgeQ4Hy2Pjh/
         xGQZeNfoL9KaXNE6ZJAqCs54DE4gjngTMopW1ZxaxdAAYYsnzOtwdmmU6v62zl8bzv0L
         ucZh711pF6QRjmunCjQokUHTc5pv0n5jvTqo208Mdssij+a23Adl3G4TzE7p6i607gG5
         wuCA==
X-Gm-Message-State: ANoB5plvo2R79QecXfDRjabZ+aLsYplvPkuznFemV1l7Pp/YrhRCcVOD
        hf8rvNvsDkIqozFihsByquTycBxlQpGqUMi1WCI=
X-Google-Smtp-Source: AA0mqf6hM3LZ2AndzcY5CaW6v6r5AHcvri0Bw6n5V7d/I8I90eseDk5y44CIGQWoEKYOSPw2971fhA==
X-Received: by 2002:a05:7500:4589:b0:ea:3ca2:13c3 with SMTP id gh9-20020a057500458900b000ea3ca213c3mr2080489gab.72.1670871938186;
        Mon, 12 Dec 2022 11:05:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u2-20020a37ab02000000b006b615cd8c13sm6124618qke.106.2022.12.12.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 11:05:37 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:05:36 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: delayed_ref parameter cleanup
Message-ID: <Y5d7gKMAAnQ11kO5@localhost.localdomain>
References: <cover.1670835448.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1670835448.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 01:02:45AM -0800, Johannes Thumshirn wrote:
> While looking at the delayed_ref code for the RST series I've discovered, that
> drop_delayed_ref is using a btrfs_trans_handle without even using it. After
> having it removed I've identified more uses of the trans in the callchain that
> are unused after drop_delayed_ref got rid of it.
>

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
