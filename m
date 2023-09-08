Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4718F7989B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbjIHPPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjIHPPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:15:53 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D88C1FC4
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:15:49 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64a5bc53646so12188526d6.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694186149; x=1694790949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VP23bkWiBilaDugSrY725i01rv/atoaCv9s48YZB2Hw=;
        b=G5MNPGDbnNinOB+1GHvLfwcMw39JORIDLUmcHCctbG7BBJ4vXk/kwLaVFInjkS3aUO
         OZHo/CHP4Q6XhuxFhyNx3zsJ6o4LomqCC0X7mqs/fw7Hx7Ui5loLnXe1oXYpBSyGO3+u
         xjgM2ftmjkLE2acNQdq5Qm3XwPChf4qJbweIfgI5k+FhGY5HU9hqj7RJmEWSZqzjLurB
         ddMDKQk5Wrqjlp/x6RKEloc9NeciLNnng2VCbIK/y25r0d32kuz3XIW34VSPTPwYybnB
         q7MD//HnrSMs7WcIHwKTlEqM/xtrwcWrLR1Kl+ejwpKViJlFdDeExaI5cqafeRYYOdfB
         K9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186149; x=1694790949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP23bkWiBilaDugSrY725i01rv/atoaCv9s48YZB2Hw=;
        b=NG4ofXFhdEiyo3vTNsZ/oPyGgOqcRnms2w+OCP/8lkgd5IF4AEHmFXdhTgtDx3Wd+x
         gh/cg4WbiMPFfYOZQbOF/JzvNo/iojKTtr1BvYXSANN7jpObrLwopwNU7jAYLc/cvZu5
         eIbtRLGSidM1iLzsqQ/KkAz/wCEXWvDTwCIl+tnmkpZRorqV8ZGa7qZdcMMd5/dwOSns
         RdAyG7uRzUIpvcT6GvLRw+4NevH6O4qfyI1Bp7GfSjki2WX0JTG7w8CX3FLWruJF2atu
         Q01zSx7c9jZUspKbOyqsUfDRfEPwTcEEgP2EviaPJz1MuMeykMKooX2fUfxmfYSIbFhF
         nTAQ==
X-Gm-Message-State: AOJu0YwTyt7CW4k972jEu/paTVJMopgVcWxGiVILbQgUYZuVlBJqVAyY
        8ciDBSX08LPc9Ozhbm/vRR6xnJLHPLDEjmilebpTMA==
X-Google-Smtp-Source: AGHT+IFa8Pd9m4Iusce81WfJoe9Hu7PLT9PjSwVTov82ou6jBepCcaX2CTX194eMEzXyHcoCHaDiCQ==
X-Received: by 2002:a0c:ca06:0:b0:63f:7d58:669c with SMTP id c6-20020a0cca06000000b0063f7d58669cmr2531888qvk.61.1694186148756;
        Fri, 08 Sep 2023 08:15:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s17-20020a0ca611000000b006431027ac44sm775305qva.83.2023.09.08.08.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:15:48 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:15:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 17/21] btrfs: allow to run delayed refs by bytes to be
 released instead of count
Message-ID: <20230908151547.GR1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <5df582d8f2fadb2eb0baab70fe977fc2d3934ddc.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df582d8f2fadb2eb0baab70fe977fc2d3934ddc.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:19PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running delayed references, through btrfs_run_delayed_refs(), we can
> specify how many to run, run all existing delayed references and keep
> running delayed references while we can find any. This is controlled with
> the value of the 'count' argument, where a value of 0 means to run all
> delayed references that exist by the time btrfs_run_delayed_refs() is
> called, (unsigned long)-1 means to keep running delayed references while
> we are able find any, and any other value to run that exact number of
> delayed references.
> 
> Typically a specific value other than 0 or -1 is used when flushing space
> to try to release a certain amount of bytes for a ticket. In this case
> we just simply calculate how many delayed reference heads correspond to a
> specific amount of bytes, with calc_delayed_refs_nr(). However that only
> takes into account the space reserved for the reference heads themselves,
> and does not account for the space reserved for deleting checksums from
> the csum tree (see add_delayed_ref_head() and update_existing_head_ref())
> in case we are going to delete a data extent. This means we may end up
> running more delayed references than necessary in case we process delayed
> references for deleting a data extent.
> 
> So change the logic of btrfs_run_delayed_refs() to take a bytes argument
> to specify how many bytes of delayed references to run/release, using the
> special values of 0 to mean all existing delayed references and U64_MAX
> (or (u64)-1) to keep running delayed references while we can find any.
> 
> This prevents running more delayed references than necessary, when we have
> delayed references for deleting data extents, but also makes the upcoming
> changes/patches simpler and it's preparatory work for them.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
