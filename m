Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55982782FE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjHUSEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:04:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A574E2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:04:19 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59231a1ca9eso9379167b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641059; x=1693245859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7mUcRGDAxYebpvq0ZquQrwRYW7ETILFt2wTvZ8fQKs=;
        b=i3PBQCreU2uGglXB4I6XnHOFfWhyZQCJT+XksMPcB1sxiST97fHRwhMtw+9idZcigR
         ZC1/7cCLUvV3v1NQx7k0mxf7MRLk04Gc4tFX+xbz6ElRAyF2TiemKIZdKVqkPz9Ki3uB
         dS1DgOHrt1hkIBYLqVSBh4yunN6NwyB8tGoUVsnW4zL2UOqywkUqg2Nr22MDlAVxmjJ8
         mX1ksh/0rOSCD756ZDD/8TjFHhMWb+LX3r+BiTcGw/IcpsbdLBzIj4KFvASBIbcY6WL2
         TU7GFkh1zxAuXfXJtP3t8t0/vGZWz0GSf6RbI7NBscjpsXB2B4QNh/rfiOEyu2GckxsQ
         ZLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641059; x=1693245859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7mUcRGDAxYebpvq0ZquQrwRYW7ETILFt2wTvZ8fQKs=;
        b=Ncr3wT70yv6b7xroFJEI4y8whS7NGkcDkxzHkx6EhdAFxfXfGBztyWMvpQnC/ShAlW
         bH/JziCq3IipAr2f+DrIN2WJ9U42jECl/cR0UKR4C41oumONRrw5x60WZUkXvXynJUtn
         Zccra0zBbNwtxrIXlnJG+A1ihaCi3aL01wPu/WvOzeAkodcLnOSaL+Gw0LmYc617WjrR
         QAx2kBZWY4OetfQ/IiAoKSv10wKXaP8GrPYshjuz2BwE/20BVJ6y3v5mxp+JUKh0MUXI
         TcOXiyRYnSzxn6pvIVMlvZZMPQcTcgccm0N1sYgAUt8IierGfLZQmsCCSZX/sRSbAtES
         D1ZA==
X-Gm-Message-State: AOJu0YyMdwaiAZGxjNDdk7OtvYyzVIav7CMhwZ+s47iz+RNaR72Yn3E9
        uoXg6hpP1uG5UnPe2oLu14ZRjvcF2DfgOc5pNVg=
X-Google-Smtp-Source: AGHT+IHl3bnY6Ww5izUWOpqXJRwel3eJdzGGGy58TtSCj+hSXRAhJpNAvfBPuLMite4ViGycFvKdlQ==
X-Received: by 2002:a81:c211:0:b0:576:6b83:2466 with SMTP id z17-20020a81c211000000b005766b832466mr7416792ywc.25.1692641058781;
        Mon, 21 Aug 2023 11:04:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k125-20020a819383000000b0057a8de72338sm2334281ywg.68.2023.08.21.11.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:04:18 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:04:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 07/18] btrfs: function for recording simple quota
 deltas
Message-ID: <20230821180417.GE2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <85ff3dcd358a340f89e93a09eafd02e051944bcd.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ff3dcd358a340f89e93a09eafd02e051944bcd.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:54PM -0700, Boris Burkov wrote:
> Rather than re-computing shared/exclusive ownership based on backrefs
> and walking roots for implicit backrefs, simple quotas does an increment
> when creating an extent and a decrement when deleting it. Add the API
> for the extent item code to use to track those events.
> 
> Also add a helper function to make collecting parent qgroups in a ulist
> easier for functions like this.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
