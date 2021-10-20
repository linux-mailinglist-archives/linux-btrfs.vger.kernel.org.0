Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF164352E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhJTSsE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhJTSsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 14:48:03 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15759C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 11:45:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j12so4061497qkk.5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sbJmHDQTK+9eV6VZ6ElyTBMAkrkt3WyBRIUgWQKP3Ic=;
        b=QUrOIWp5ymfFPnAvyK0ouUou6z6ifgXQWTuPEhzgtOhnXVWvXRgHE60LtmQO+latJK
         Hj/3vyI1P7bJbrA67zfYeDxj4V0CzL611wWQB2VzeqDo4/dLLxjHC1jhayjhQdfB2mk8
         ovT6mA9ohcVjFahYSLrqMPYzkqQ2JWXDJdaHlxYf8IBVilIM2HOnoROTIF88fwdOJSIu
         1kwLOGtvGEvE+/XoYDfyFrskg3pbHrJ3UGKaoBCOhKEVhSEIclHlUyBsBok9jH2/siF/
         Xi9CPp/XT/EhEey/VQ8E/OT5MYh521Z5NrTLWlu4XBQr7DbdqYX30zeeI+E60InxBZfc
         v9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbJmHDQTK+9eV6VZ6ElyTBMAkrkt3WyBRIUgWQKP3Ic=;
        b=W2S//czLm0IfXrh6EbjtrVJpgbLqnYFfygHpRbpZ/e1Vno78nUXBBTAP+9YsTnwyke
         TupWOyJBVtWyfip9VRLKGd1s9rgsaRgLAvlpqDZKEFO0mfbNHqk/0qMqPZ1thBxr7/6H
         OtNIyIzXNaqN87RrRj2jMjsib45p40XFto7WS6G6S3jfGr/6VFdeBPPVp48SeAaPA+Bn
         AMcVaUUhx181kte50SCip53COJY8cdfBIahGum5J502NiSsQsu14lZMBYWDtqnuUvdsf
         Xsr3ClgfAu6aGhWlgX5iGs7bs3aOl9lGdaXIC8mdcuuxbnSKpHxyrSuxm4EZUxtK67Qf
         q4Iw==
X-Gm-Message-State: AOAM530JsoH2Kmt9HDqXaNTgePXVeDROahobv8u62IRjIW0gxgNQv2FE
        vaSgtYbng61kuRWSgHVbDfwALncwebucqw==
X-Google-Smtp-Source: ABdhPJwh+woVPoPlQfFpwvyT4y5LTeFpjEzF9IzibcHe8hCEdiY4arWiH4xCOiOsbwZ5Cb6dsD+8hg==
X-Received: by 2002:ae9:d8c6:: with SMTP id u189mr674845qkf.391.1634755548157;
        Wed, 20 Oct 2021 11:45:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6sm1311219qti.38.2021.10.20.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:45:47 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:45:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] fstests: btrfs validate sysfs fsid and usage
Message-ID: <YXBj2qJ0NlZuFuh7@localhost.localdomain>
References: <cover.1634713680.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634713680.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 03:16:41PM +0800, Anand Jain wrote:
> Patch 1 adds a helper to check if the kernel is latest enough to provide
> the fsid from the sysfs.
> Patch 2 validates the sysfs fsid against the fsid from the sb
> Patch 3 is a test case to make sure if the btrfs filesystem usage is
> successful on a sprout filesystem with a seed device missing.
> 
> Anand Jain (3):
>   common/btrfs: add _require_btrfs_sysfs_fsid helper
>   btrfs/248: validate sysfs fsid
>   btrfs/249: test btrfs filesystem usage command on missing seed device
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
