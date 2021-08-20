Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B153F2B87
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhHTLut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhHTLus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:50:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE767C061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 04:50:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k19so8378368pfc.11
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a2E/F8K48S+AGXSEhFCjKkP2n2EG98ZnlM7sTYxxJgs=;
        b=IPm72sLZK3g3EQk+RzJwkYTwsZ6QokSvvWPkaZSDo0nP2E8KfJnGTxvq/6xrfUG84w
         iaQkLp6eL/rgzV+RNrraUP75iAaekXybbNmrAuBQDJ/QE3qo39ycS9xuU1GEAP3chtD0
         bG6OjMmSx4dqR7n/YfZ/upWeV03WHaYxozo4cyniFU7zUGhx1HsXRKMWY/BFmGyMU33m
         5NOP4FE9jkvT7gVHkUBcMdvL/m9PvzYc+LxWIHjPhac7dq6dFFvfcaTIJgw/kTsPOAqH
         YottK/APYsQXfMD2WXZmNmLJYjF2ME77EIzOH7hGDJzmwp5ununsDt0Kqx/bGp8Rqqv3
         DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a2E/F8K48S+AGXSEhFCjKkP2n2EG98ZnlM7sTYxxJgs=;
        b=BT1uLpDSmp3Y3Vhk1EDNU0XayKnR10yy+AutW7nokj+wKh+glhfy7XqPx+Vu7N+6de
         lFwqhuHAyISmLjRLGfnY8YcTjnVmpz2bodnUhR0dNCuc9B7FFQz5JrBgRQmyCeleeqQ+
         DdtHW5H5waxMQyv3/yqYOGHpMN2l7udHyMUvicpjV2ACQWZ2hPDdPuqJeqVCWE8oQ4TI
         BXm3p0ugr6qxguns6yD6Ci9oIetD63MKKokpUdx+VDx2/hbJ/4o/xr+2cDGLjLhpT2TF
         C+nPyHDBLXPwO/HWTyM/J0g5qDjqkGE3K0l6ee6PdIhE8XG5DfpsByfyqIaLOfVFywxx
         JcRw==
X-Gm-Message-State: AOAM532NpNFdq8ids+JKE8uczmVIJAbrMA4MM8hVXDeVS+GyGWw+hPJj
        WGu46ZtQ4+KIqH4x9oGlf4Q=
X-Google-Smtp-Source: ABdhPJzIxdepUrfP5oMUKlzw12K76wMSTqklwT4e0vzn1LNhSAfye1uvkQOSMkOAaosN9NvhODOmHA==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id n128-20020a628f860000b029032e33d7998bmr19800976pfd.64.1629460210440;
        Fri, 20 Aug 2021 04:50:10 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id u10sm7960070pgj.48.2021.08.20.04.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 04:50:10 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:50:05 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: reflink: Initialize return value in
 btrfs_extent_same()
Message-ID: <20210820115005.GB17604@realwakka>
References: <20210820004100.35823-1-realwakka@gmail.com>
 <6902f367-03d3-f732-5864-7c8b19a0f9e1@suse.com>
 <20210820111749.GO5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820111749.GO5047@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 01:17:49PM +0200, David Sterba wrote:
> On Fri, Aug 20, 2021 at 09:08:26AM +0300, Nikolay Borisov wrote:
> > 
> > 
> > On 20.08.21 г. 3:41, Sidong Yang wrote:
> > > btrfs_extent_same() cannot be called with zero length. This patch add
> > > code that initialize ret as -EINVAL to make it safe.
> > > 
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > 
> > Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > 
> > One minor nit: In this case the variable could have been initialized
> > during definition to save 1 extra line of code.
> 
> Yeah the function is short enough to have the declaration initialization
> in sight, I've changed that.

Thanks, I'll keep in mind. Any nit would be welcome.

Thanks,
Sidong
