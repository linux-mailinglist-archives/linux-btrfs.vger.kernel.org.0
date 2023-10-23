Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3B7D3A65
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjJWPLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPLV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 11:11:21 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0A5DD
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 08:11:19 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7af45084eso32325957b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698073878; x=1698678678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zj6gkC1XO3M3yDyQTpk+K5u2VTOVgCKSWJ/fE8jDVgk=;
        b=0ioNSk8CqP2V9zphWYhOgrCPSDC9/GgdxkjCrdOJlHRL8mS0zklQc6rrijEnzeqieo
         OD9lwXHu+30CTmwsycbtn9gow3y9Y69rLZwwxW6i+2esJhF0NrglgtzFsgzLeoiVdjNl
         aEgj0U/4aATytNVyef8u/VXKBNLhR3z3qtX6UBugFlK2xuxCeyUvkK+YM6GgkHLDDTlg
         U/AO+2v96fTLYkYZ/tkR4UgbdmQ3/i4l3n1lHW9p+NfXm0wKMtTlq79AKD/CUolidIZY
         miPP/EecuQeAT3RgSo8qWmeHaqHuEs9t991Ik3ilvRdYOHpGcfDTZcMOZStaeKj33nP3
         P0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073878; x=1698678678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj6gkC1XO3M3yDyQTpk+K5u2VTOVgCKSWJ/fE8jDVgk=;
        b=oSweOsMXMrKXeqX7TXyoDqHX5cEkTOZGFCDkfasBmQfCEES64l0QydVddZRr+wNtc3
         VGdiGqHodxnglFlEfqYjGdh8bYRwcKvX9h5620fRsvurDeKIQSRHnTt0XeVk4GbUk81I
         7yfh14wNBRsp1ahSyMiY44fO3EPlZfWADV8u2UolvSXokgdzJ8xouGtub4zM0QTB6HNk
         +loKc25Yd5FZY/liA+hIWCY6pR5U/nm2rfKUWNM9o0byMdROfuVuTCsUXd7bH2sctcge
         WQ2a7XxJIvsW7CIfankFWfGKXEkT7xO7J+davLZCaqGv2tTQco6uiAK5eCUUkd+j7cbo
         eEAg==
X-Gm-Message-State: AOJu0YxquvNJEAdbCnbytwPmhCCZzgLly++3cMsmcwBKIRadnPd2Cs/D
        xaBDzTORTekQkeiriu65joDW2knBEXs7xL11iYUm0g==
X-Google-Smtp-Source: AGHT+IFHxzD8k7SR3+mQi/UOyYlAiGXIFxd9V5f9bdnblZS1lrMpHUDTqDoGCoa9xwoIzgqUSLaccA==
X-Received: by 2002:a0d:e481:0:b0:5a8:2744:1565 with SMTP id n123-20020a0de481000000b005a827441565mr8033765ywe.4.1698073878195;
        Mon, 23 Oct 2023 08:11:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j126-20020a0df984000000b0058038e6609csm3206038ywf.74.2023.10.23.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:11:17 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:11:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a corruption after snapshoting a new
 subvolume
Message-ID: <20231023151117.GB2798160@perftesting>
References: <cover.1697716427.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697716427.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 01:19:27PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with kernel 6.5, we no longer commit the transaction used to
> create a subvolume when we finish creating the subvolume. This behaviour
> was introduced for performance reasons and done with commit 1b53e51a4a8f
> ("btrfs: don't commit transaction for every subvol create"). However this
> allows for a corruption if we snapshot a subvolume created in the current
> transaction, where basically we get a snapshot root that points to an
> extent buffer that was not written. This makes attempt to read the extent
> buffer later to fail, either with the infamous "parent transid verify
> failed ..." error or with checksum failures.
> 
> More details on the changelog of the first patch, and the remaining patches
> are just cleanups.
> 
> Filipe Manana (3):
>   btrfs: fix unwritten extent buffer after snapshoting a new subvolume
>   btrfs: use bool for return type of btrfs_block_can_be_shared()
>   btrfs: make the logic from btrfs_block_can_be_shared() easier to read
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
