Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1C7779B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjHJNfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHJNfB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 09:35:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D87211D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 06:35:00 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bca3588edbso816479a34.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691674500; x=1692279300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CapgdV9irXipspK9ZW/2lTmGgTOP26Jman83pfzX098=;
        b=Yj+F++qTxaTD86fWW6UGohJyI6zntdABXWbfepWrOzGmADl65UZjhcKqqzL4r20Bbr
         C2unVLYVXuoWEmqcaDe3FqSyYUEJiGwp5DfCSobh5UGCiCs48BOs4Nisz3tMi0uC1sQt
         DbIfKR+Ph7T6su0SeYUmKiAA1D3ECYOri65m8cSBs1ovnd3/RdHkvKTKULbQi/DWo3T+
         pxfNvNb6ScFfELuAgv2ku5o0C9dEtjMTKu1joOJwwdHQ2COcaDW42iT5UApkzoNoXt7r
         Ogj8JBpPIy9f8Ui3DpsWFIBVkMsEFxAE/SFd+oBfue24RxPDUiYdeMcQMm3xpxnkWZRw
         VL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691674500; x=1692279300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CapgdV9irXipspK9ZW/2lTmGgTOP26Jman83pfzX098=;
        b=YSsQQ42zpInJaN6+LMzatWE2sGYjPHktKsl2rIlfg4p8cxgo6fxs3ARjpAcFKPg8lb
         RvcnhJZYrRWsDJRYBPx5cx3BzNfCgSFxLwnzl2RgAxkMopF32waARSW8Z3dvw1EPQkSr
         ckY9C+a7Ma+bDgJBnN6gJIdpxjRkWZ2UGK2Fy6yh0uHWJiohRVW4TKap/uOJnS6hcLcJ
         vPMmIu3zkrQ43+1UOiu5dnaAzKjpBbHViutZKbPad67Jc4WUJrv9WLeogSDijrvJUaog
         5BzSFthTpN2PPZBC9A7nAPFbModRtrHCEaFTP2rxXteKER9+e5P/HK+tAD6DleDXE0/6
         dA7g==
X-Gm-Message-State: AOJu0YxpCIg8uQnV9+HZdSTAV4+81nce5Fhxv1pNGlBN8vAftNw+HFBr
        hu24WPBcC1bdN/uTSl56JguZcg==
X-Google-Smtp-Source: AGHT+IFVsdQifTyekBrQZnpqxRi2WH94HXTIYd0/rYdC5OInWg6CkyVo3Zqsc4YxSUr4EBzvwLRLzg==
X-Received: by 2002:a05:6358:7e8c:b0:12b:e47a:8191 with SMTP id o12-20020a0563587e8c00b0012be47a8191mr1212578rwn.16.1691674500005;
        Thu, 10 Aug 2023 06:35:00 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bq22-20020a05622a1c1600b00406b11a54b8sm496813qtb.7.2023.08.10.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:34:59 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:34:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org, dsterba@suse.cz
Subject: Re: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Message-ID: <20230810133458.GB2621164@perftesting>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:30AM +0900, Naohiro Aota wrote:
> In the current implementation, block groups are activated at
> reservation time to ensure that all reserved bytes can be written to
> an active metadata block group. However, this approach has proven to
> be less efficient, as it activates block groups more frequently than
> necessary, putting pressure on the active zone resource and leading to
> potential issues such as early ENOSPC or hung_task.
> 
> Another drawback of the current method is that it hampers metadata
> over-commit, and necessitates additional flush operations and block
> group allocations, resulting in decreased overall performance.
> 
> Actually, we don't need so many active metadata block groups because
> there is only one sequential metadata write stream.
> 
> So, this series introduces a write-time activation of metadata and
> system block group. This involves reserving at least one active block
> group specifically for a metadata and system block group. When the
> write goes into a new block group, it should have allocated all the
> regions in the current active block group. So, we can wait for IOs to
> fill the space, and then switch to a new block group.
> 
> Switching to the write-time activation solves the above issue and will
> lead to better performance.
> 
> * Performance
> 
> There is a significant difference with a workload (buffered write without
> sync) because we re-enable metadata over-commit.
> 
> before the patch:  741.00 MB/sec
> after the patch:  1430.27 MB/sec (+ 93%)
> 
> * Organization
> 
> Patches 1-5 are preparation patches involves meta_write_pointer check.
> 
> Patches 6 and 7 are the main part of this series, implementing the
> write-time activation.
> 
> Patches 8-10 addresses code for reserve time activation: counting fresh
> block group as zone_unusable, activating a block group on allocation,
> and disabling metadata over-commit.
> 
> * Changes

Additionally you had these failures in the CI setup

btrfs/220 btrfs/237 btrfs/239 btrfs/273 btrfs/295 generic/551 generic/574

I've excluded them so we can catch regressions, but everything except btrfs/220
seem like legitimate failures.  btrfs/220 needs to be updated since zoned
doesn't do discard=async, but you can do that whenever, I'm less worried about
that.  The rest should be investigated at some point, though not as a
prerequisite for merging this series.  Thanks,

Josef
