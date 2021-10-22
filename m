Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E01F437580
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhJVKd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 06:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhJVKd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 06:33:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F09C061764
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 03:31:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id r15so4093774qkp.8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t6ReXSv6zXPxlP0d6BuJ5CfHRqEI5nNVz1+KgbewN6w=;
        b=Qk9NlQVD5idpwqw8O6OCr5ewwSy3fN/PKMl3v7Kjghcwe/H6MBNpZNIj/DCbXwpP9F
         ZLv5Pug5/c6A/KzpKuourcL2HVzJvyQSISMf6D+nANyc3/Veg93PBmg/+1qTKd5xmWAk
         V3HluhbHAl7gNHNE1cr4+oQSTlZOw5XfPGbEL412JtrjRoGzV88nMWMhWo/YkOXwT3C4
         Y4uVQwChoEMZ0NFc/ztTWj4D4kaFf74vyaPrPbFXvAqpGcXmXXdOg0A6PMDoZzHqstLa
         evQAQCtUDVAq+BvH8/PAQ+lA6TLoaMSdWgzZEVqVrpkjVvFtQBaPFDW7yhavly21G4Pd
         M1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6ReXSv6zXPxlP0d6BuJ5CfHRqEI5nNVz1+KgbewN6w=;
        b=dAX2XgoXoT+sp1m/xL8uLgL5Iz9GgrMmwbR+Y0VusJCjwr+DWzd620nhXUJ6Gh6Nx4
         TJZtWLcGea8TrA8DXDCBDhCs23Cx71phVk80i64YmsK8Lv/Mj6TA8ae2x7iRQUnzNdAo
         IaCqACgsFqMS7311AdGuAGUEY/iE04kFbW21TRcR+NtiTol5/OOoq4jAsBKpzxss6VJh
         0YwGLPSUjPnSOn8a+fL7h2bgCHtk5rWGaG2e0GM2FlMBY/oOBmd/I/EMl2Slo49BZQrI
         oMUyFXXF9vXqhRnpEiBPdaKi8VpRCaHwTy/GY6xbVQO5Mfr8D1mzQgLwF7awcdUZpFsW
         joVw==
X-Gm-Message-State: AOAM533A9KQMIxRBM/0KEnYCmktGdV8xFPgB4RzqUdEQMxkI/EemgbTb
        rhNPD2NjTQMSoPvRujCmHlifdA==
X-Google-Smtp-Source: ABdhPJyGhhaHrYKl4wFSMOl4xzMvG9HzMotnFIPzGTmT+DVQkHG5haNmgUrHB3KzdApsewQkrEAuPA==
X-Received: by 2002:a05:620a:1707:: with SMTP id az7mr8951498qkb.276.1634898700426;
        Fri, 22 Oct 2021 03:31:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k8sm3906739qkk.37.2021.10.22.03.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:31:40 -0700 (PDT)
Date:   Fri, 22 Oct 2021 06:31:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: fix comment about sector sizes supported in 64K
 systems
Message-ID: <YXKTCukXtkX6UpY/@localhost.localdomain>
References: <59371eece911ff3e73517fc9e3fbafa843f9bcc3.1634860167.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59371eece911ff3e73517fc9e3fbafa843f9bcc3.1634860167.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 07:53:05AM +0800, Anand Jain wrote:
> Commit 95ea0486b20e ("btrfs: allow read-write for 4K sectorsize on 64K
> page size systems") added write support for 4K sectorsize on a 64K
> systems. Fix the now stale comments.
> 
> No functional change.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
