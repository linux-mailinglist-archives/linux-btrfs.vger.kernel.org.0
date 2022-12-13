Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E264BBC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiLMSPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiLMSOy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:14:54 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162524BE2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:14:12 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fz10so537517qtb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oySAg/w74fhi6ZJb3Gz6lwpwzF08cKGqbcOSE9xcTTk=;
        b=dqeXz1ruF6iVmCUyLCCE6E2zAS/uzS5Is9lX/UR6FXBxGlx1bXLY2JOkSyebbEzrhc
         g1mkDO6WkmwIuCTwwslXS7lBaaQo+t0wC3oT2lMrFdUAvQnINa+a+J7oKKGc8N8gRWJZ
         NEoS1/lmdkyhEWGuZY1SpQHWukrs3kdA/u8IbuBxoiZUA/mZLSzxXgRLz1IzPZ4ruNC4
         0/JoxPjrRWWBb7LZCZr6CQAP1rGC2rsoi/usqecMmYEBJMs6E+2LHgPsy0R6CNuSqW1M
         nHGEY4WliZ4KntGIy4JWcL90CqEV9Z+Se7QvTe63tw5+xKJB//yG9AJUFBRPAt3RyqnH
         ploQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oySAg/w74fhi6ZJb3Gz6lwpwzF08cKGqbcOSE9xcTTk=;
        b=q1tpX7RFGBEGZhbxBL3DMdj67B5LDlIwp4V9mzxtuIGuD+S0lJWjNkAoM25O6oDWhD
         Kya7Gp3gPO0FW/JC+y6ux/aGIv3tlHt+bgmcSv/aOtOsp9oiLLZnb/au7Y0ACDPMxRpi
         0ToqkWlIhuL8wz5ufIcmG0Xn2yEw3e7IB0Bzy3eI+u36V/RgKf+fg7NfgAQU56sbF7FG
         e1H0Wn1aaZbkr/CMdFUUFo1KXpvCbN5nIfLTk4R+zG6Q15/qEqH+e0169Yy+84ZGELr0
         gNVKnSflgAqISs+POxs0c6QdijFBWnXxzdcenFlCbMwbVFkbQAjz+thHZrq6B/D+TIi7
         MNdQ==
X-Gm-Message-State: ANoB5pkI4+0Mbe6rHQ0W8f9Ywvf615sgXeVIwmTVjr0r0hdzENBWFEqH
        N4y2KeBYq5zJjo14cJefXey7dQ/sBypUO1GZwUg=
X-Google-Smtp-Source: AA0mqf5LaYxIyG045r0RaEh20dy92R+ePJ2dyMme0/3+ckT0iBxU0fnYD/QW/TqZSLNCgAnfHkoesg==
X-Received: by 2002:a05:622a:1995:b0:3a7:242:4f3 with SMTP id u21-20020a05622a199500b003a7024204f3mr34789943qtc.66.1670955251506;
        Tue, 13 Dec 2022 10:14:11 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id z12-20020ac875cc000000b0039cba52974fsm235654qtq.94.2022.12.13.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:14:11 -0800 (PST)
Date:   Tue, 13 Dec 2022 13:14:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/16] btrfs: wait ordered range before locking during
 truncate
Message-ID: <Y5jA8S5ocOwWTOdN@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07644d32ba3e517e26199b4b78f81636655a7702.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07644d32ba3e517e26199b4b78f81636655a7702.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:21PM -0600, Goldwyn Rodrigues wrote:
> Check if truncate needs to wait for ordered range before calling
> btrfs_truncate(). Instead of performing it in btrfs_truncate(), perform
> the wait before the call.
> 
> Remove the no longer needed variable to perform writeback in
> btrfs_truncate().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
