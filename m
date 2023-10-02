Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9C7B5C35
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 22:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjJBUoZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjJBUoY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 16:44:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701DBF
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 13:44:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77574dec71bso17231385a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Oct 2023 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696279460; x=1696884260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oBgRG7JlCT/4JjJAVIXJMEuiIx9QBYaZcfoHRChbA0=;
        b=Q+Hzx36a+PCD29ycxazaF0odRD3kJYEZrSstzxN0h5qz1Ij8KYLSsZRIJpZnO8u7Vu
         iko39OgOmy9EU/e9mE/nGW1I9s9xc2q+zwgtfUcL4DkfK9NgDp0JV4/SvxzYoCTQyYh1
         LXH4JK/3yCwCT2gEmsKXVAxzQYnsGQChtnDj2m32+W5/HVzBGa5Q+mvJ5QZdZOE0GGmm
         LRIBjqIymr+dmkLPDvprD6o/0JYBKH4ql2PFgcQOxEIxrPLg2XKzK7sO/TtT3Z3mn9m7
         1lHvajgk3oYAM4WjsLSmUeH/UDca3UY+zPYpBA7LABgY8RUFfk/+xdHT8aj05gzlZUH2
         rXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696279460; x=1696884260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oBgRG7JlCT/4JjJAVIXJMEuiIx9QBYaZcfoHRChbA0=;
        b=qhmmS/Vl485aJKtzTa5L80RmR6yJy4HfVFez1m4sqk48QwT8qRVd6brg69YATdla0J
         0V+nqektBSnu/tgs8GrmFSLie556rSr5E9acg1xr2UlKJhuLEwfx9ZfmkLnRU+CBE9j0
         OovqlNx5Q3aws0FTTQHcUqbsLuWWmPYw7iBqFYQipJUQVLDNSXy+Pw2VCX+CZW31b34b
         /1+1U9fKeck83EVno4O3CfxUPFOrMfpPcPfgp84GhmkhFXNxGTtdGbA0CHbf3MMtxxFN
         Lg4ppxqU7Qh77dFE4Ofb8oW0lYc5bOD8DxDFeEr3Ys4FJrOoIKLMEFzaajDb+QKBUpjT
         6Kdg==
X-Gm-Message-State: AOJu0YxYfYzG4KWAlCOVpXYZDrCfS+tN4IWwTVB5yZr7x7NDv3xYdkAc
        mM9EhlH9pqHIlV33Dasmm3P0SA==
X-Google-Smtp-Source: AGHT+IEbjKXKxXK7+4torObv62+LIbkXad/HM6Dd21XZyGcPTzf9/MmMBLiSjF0fPI1Xilic4tFhkg==
X-Received: by 2002:a05:620a:1aa3:b0:773:a83f:413c with SMTP id bl35-20020a05620a1aa300b00773a83f413cmr14577926qkb.30.1696279460159;
        Mon, 02 Oct 2023 13:44:20 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w19-20020ac86b13000000b00417f330026bsm8345280qts.49.2023.10.02.13.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 13:44:19 -0700 (PDT)
Date:   Mon, 2 Oct 2023 16:44:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] btrfs: increase ->free_chunk_space in
 btrfs_grow_device
Message-ID: <20231002204418.GA852064@perftesting>
References: <cover.1695836511.git.josef@toxicpanda.com>
 <c94cdbf63118d14cfc0f95827cd67d8be1bae068.1695836511.git.josef@toxicpanda.com>
 <20230929163035.GH13697@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929163035.GH13697@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 29, 2023 at 06:30:35PM +0200, David Sterba wrote:
> On Wed, Sep 27, 2023 at 01:47:00PM -0400, Josef Bacik wrote:
> > My overcommit patch exposed a bug with btrfs/177.  The problem here is
> 
> Which patch is that?
> 

Sorry the V1 version of this series.  Thanks,

Josef
