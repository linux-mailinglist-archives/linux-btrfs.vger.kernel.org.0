Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E64168F8BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjBHUT1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBHUTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:19:23 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B022E0E6
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:19:19 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d13so12250238qvj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIrLIVJXGILwq3HQtGglcK2qZ8dA/MOkpQQqlx9FlWw=;
        b=xBnJV9GRkxMCYn7X0NvQvNDN01/M/rMTenn5dyph9WP/3ge9e5u1SYVEgazN0S0FeK
         mJ9y0L479oHlgetRGm5fvWdTJihyW7kvUd8A67pX75zwv6veC95PVhi/ScVCE02888UB
         wAKNzCWRhmDeg7O2FMz5VQnyTvWAkTFnGeTf8ie6WbkXUPVpaAi2fq3eYACnNjFA8M6D
         GRZVgb4XJQ5xV9Va+cFMlUgUISN1L/4nAyIZ+ZdGAYxFYY1fbrnl5BU14tic8/G+nZG5
         e8wyiU0+dy5kyEKS0oDlhTR805RyZMlwF05gZc8+bRE7T8y0Q9PRz2MGbYbS7HONk8H9
         L0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIrLIVJXGILwq3HQtGglcK2qZ8dA/MOkpQQqlx9FlWw=;
        b=0w+NXOBCL6tq/Qj1QHBFwd/5amGk21BRHOm33/6bR9yS+G0u6fcvnzOf6xaa6Geosk
         1lfMdVm+8mbQpQIN3XDPCxAvbCMSXa4usLzzp3SbD7Wsvxvb+mo73ZMpKri8/sESsMsj
         eYWfmpJt7HC+owRcP49A/Ye/aIYsYPzhTpbm43PFq57O9iibeG0GkjeJL76RZkwN29K1
         vGZYPf23GRNlNtv5Ikj8z+sVplJ0eP+syNCzkypQrnULCHA90oLW1AVy1wbKlYlobE/T
         FJcTewT17QNXnOGoqFoUpu71xoMxxbpDIuVvuNO7MZRDQl8wrjuyCerE1YR5AlAvWdfQ
         ZREw==
X-Gm-Message-State: AO0yUKUiinw4gmxyWnZgzjts+u0I2oAhbggAVhrpICYBGe3t4TqNsqV0
        0BDgSpxenAGKwXdhHHtjw3qT+0RPl0oVN2DTT60=
X-Google-Smtp-Source: AK7set+sGNL+IWuNdML7yv1yLjw0b7s5fN9/Uu0GK160Fh7XdbmL7DfsNWxigmFv92hHOwWJiVMXzw==
X-Received: by 2002:a05:6214:2505:b0:56b:fb30:49c6 with SMTP id gf5-20020a056214250500b0056bfb3049c6mr16773725qvb.50.1675887558737;
        Wed, 08 Feb 2023 12:19:18 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u20-20020ae9c014000000b00720750365b9sm12114361qkk.129.2023.02.08.12.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:19:18 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:19:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 09/13] btrfs: check for leaks of ordered stripes on
 umount
Message-ID: <Y+QDxe01CVr+Aj2I@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <e39ca8369d7907b3f5714fac93dfaf342a9c2e82.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39ca8369d7907b3f5714fac93dfaf342a9c2e82.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:46AM -0800, Johannes Thumshirn wrote:
> Check if we're leaking any ordered stripes when unmounting a filesystem
> with an stripe tree.
> 
> This check is gated behind CONFIG_BTRFS_DEBUG to not affect any production
> type systems.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
