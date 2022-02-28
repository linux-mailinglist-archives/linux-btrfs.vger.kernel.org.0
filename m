Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9864C721F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 18:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiB1RFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 12:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiB1RFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 12:05:11 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02457B0D
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 09:04:31 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 8so13593103qvf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JTr9v381/JugnJhGb2YDO+osfIPKA6ncZ51TUx4pU4w=;
        b=f+pujlqoSNfV6sfkwX1uBml4xOdbcoPHi+RzeV3XjqFKSWUkLkOoclr0D0encXh/cB
         Jdnppzy1fFUHalAu+9e6cU77iJgMymIzm6NFsEh9W90DQWv8GvDDMRilgkbuwmx53Kxr
         Peqk8G8r5l5TbzbwimxB6iB9urABGaVW3euH+ptEH9J9y0nBTvAfy35latBlpGVa/05z
         hTyN231s0kOnC/b7cZ8unOSg24/OHA1NTQ4F0AdIdzO1j4jsU+abKN7Buch7BH6qPP8S
         2fNA4Kzbmx+WIcqreufC2OBqXi4AEtWnjzvWM9DXdCFezHlJsopSIlH0jc1WxbVbg2ds
         uNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JTr9v381/JugnJhGb2YDO+osfIPKA6ncZ51TUx4pU4w=;
        b=7L55RWBYOtL5QtYU0daXq5x0sUxko7wOWcsTOH5xv9OLoWuYltR+K7iXyloWxkZ3Zg
         MAUNVUSEMqHT6XF5dREoJ5hEJOagHNomcabix+/LUdy0/xN/as+csRpliobh6HDjhA+r
         AqEO+ReTcOnzR6dbtiqbWxAwo3MbtDY6H8Uzcooy2+qaeWuOIYk0quQfaLd1cfgAbFn+
         icyIvrY1cWVAdccKGn5Bl4NaAPPIEBu+bTSnGiq6UgSSA8Zb8mwRMQOiEFi6n/SO+zFr
         Gv989y+xR/Hr9FkZ85dWzyGIsc2EkBbhNPVTDG21jTWUxZBurCANPge1X4gp6hGG1u/7
         lncw==
X-Gm-Message-State: AOAM531ovRHliWM4GpqaUNvCY0ubSgOplAIk3LyTue29ejJAuhErJtzX
        E2R+PzXfP7W3b9BGAQKKXfSbanAY9XAZBzeE
X-Google-Smtp-Source: ABdhPJzyqGNtxI6QPBiNEm4KiThB+LvaJawtXSZ4s7/V8V/WOVn7zgOEdV5P8bhAR+PcIA/xuulRIQ==
X-Received: by 2002:ac8:4e4d:0:b0:2de:7a32:a02a with SMTP id e13-20020ac84e4d000000b002de7a32a02amr17134961qtw.509.1646067869960;
        Mon, 28 Feb 2022 09:04:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n13-20020ac85b4d000000b002de6fe91d2fsm7312805qtw.68.2022.02.28.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:04:29 -0800 (PST)
Date:   Mon, 28 Feb 2022 12:04:28 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <Yh0AnKF1jFKVfa/I@localhost.localdomain>
References: <cover.1643228177.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Hi all,
> 
> This patches set was born after some discussion between me, Zygo and Josef.
> Some details can be found in https://github.com/btrfs/btrfs-todo/issues/19.
> 
> Some further information about a real use case can be found in
> https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/
> 
> Recently Shafeeq told me that he is interested too, due to the performance gain.
> 
> In V8, revision I switched away from an ioctl API in favor of a sysfs API (
> see patch #2 and #3).
> 
> In V9, I renamed the sysfs interface from devinfo/type to devinfo/allocation_hint.
> Moreover I renamed dev_info->type to dev_info->flags.
> 
> In V10, I renamed the tag 'PREFERRED' from PREFERRED_X to X_PREFERRED; I added
> another devinfo property, called major_minor. For now it is unused;
> the plan is to use this in btrfs-progs to go from the block device to the filesystem.
> First client will be "btrfs prop get/set allocation_hint", but I see others possible
> clients.
> Finally I made some cleanup, and remove the mount option 'allocation_hint'
> 
> In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
> to help the detection of the allocation_hint feature.
> 

Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
down and done so we can get it merged.  The code overall looks good, I just have
two things I want changed

1. The sysfs file should use a string, not a magic number.  Think how
   /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
   allocation_hint, you cat allocation_hint and it says "none" or
   "metadata_only".  If you want to be fancy you can do exactly like
   queue/scheduler and show the list of options with [] around the selected
   option.

2. I hate the major_minor thing, can you do similar to what we do for devices/
   and symlink the correct device sysfs directory under devid?

Other than that the code is perfect.  I think these two changes make it solid
enough to merge.  Thanks,

Josef
