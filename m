Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDBB482EBE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 08:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiACHlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 02:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACHlm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 02:41:42 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37401C061761
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 23:41:42 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 139so65292747ybd.3
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Jan 2022 23:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRWpPzclZTjjn6rrnlVnX3D+69Y7cGa4t4VaoK848YQ=;
        b=hba3yLscMbP/+YcyBH6vOr5PZO7uMbQ3l9kxdOUc87MTBbKaG6fGzNkaAkLV+oblyU
         4TdwcIx7Gdt7PwHoQHs4h/tUhyniBU1raVjaQns4gl2/6PBzDQOVMlNT+mrKZpgDRqIi
         gfbkt0OBUpHnj21TfHvObD+HCipGOsN3dCBn9pA8TzI2UoYtXdVJtQszTZp208KtUD/f
         ySHcQOBcy4Ru0eQalhiozYCMaywaWp4IzYbxj2WI2/PYDa988rgdgIf7NdGyktewk1lm
         Guj0VUIyfZ4uVFBDQ1WEPUnWhsQjCi0jwOuauA2vSPJQ9HJfWGHWshOaCLMBrMHTqBMy
         jKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRWpPzclZTjjn6rrnlVnX3D+69Y7cGa4t4VaoK848YQ=;
        b=oP7U/PBX03kYY6JY+0swJr+qAoe0T6CexCFAe9pWSw5vLgvgEk9CXTsLwLRScNfiBM
         fQ6AWoCrGKRUlMN7yxe4BpCeydaF2TJZTis0Vp1Rmqe1Ck1xZtP98usGuPXTVEtlYX1z
         m2nseSCNcxxIGxkPYRIBDExPljA9RIcv/QRcu9i+JVyHPUMnRKOBa5JDEhS4Q4R5rhwd
         wJ45ENgJWwHH8vTTs3y80pCKsNWhk4eeOj+z9AL6d7SoPHWmT+bJqgYrePuPR5zBiZhm
         Y9NBHeLRIjTmT1tvMJZhQug18TXkmOEvbm93Q7L11bMPNAvSKkCyE7H8vIkNCxkicuam
         JDuA==
X-Gm-Message-State: AOAM530NGTduz9s31cNtF44jppiTlnA9xe5dnrw3jIUXmZ3TjdA565RV
        V8I+4sBkU7UbWziHxbfiLiKvslIk1tzB4aCQzcrnHHWP6EoOCg==
X-Google-Smtp-Source: ABdhPJzx2Pk3nzpv3zCQRq9+cfKP0XwAMYLlIOnYQ1ODNWARU63HY3pImtRrVH3qvDpwkRWqNHlaajnRkpopfkrKZxA=
X-Received: by 2002:a25:1505:: with SMTP id 5mr42590966ybv.695.1641195701269;
 Sun, 02 Jan 2022 23:41:41 -0800 (PST)
MIME-Version: 1.0
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org> <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
 <YdDAGLU7M5mx7rL8@hungrycats.org> <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
 <YdDurReZpZQeo+7/@hungrycats.org> <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
 <YdEbsxw7Nk0GKKzN@hungrycats.org> <b6f84999f9506ca2e72673d8e94e72a0f29cea11.camel@ericlevy.name>
In-Reply-To: <b6f84999f9506ca2e72673d8e94e72a0f29cea11.camel@ericlevy.name>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 3 Jan 2022 00:41:25 -0700
Message-ID: <CAJCQCtQB=9B20+wbxWrNda4G-ses2Rxd8BdHuKGPCWvKR5dF9g@mail.gmail.com>
Subject: Re: parent transid verify failed
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 1, 2022 at 9:03 PM Eric Levy <contact@ericlevy.name> wrote:
>
> On Sat, 2022-01-01 at 22:27 -0500, Zygo Blaxell wrote:

> > Since you're transitioning from one disk to multiple disks, you
> > should
> > convert metadata to raid1, and ensure there's sufficient unallocated
> > space on the first drive to hold metadata as it grows.  This can be
> > done
>
> I thought it was the default for disk pools, fully duplicated metadata,
> and JBOD-style for payload data.

raid1 is the default profile for metadata at mkfs time for multiple
device file systems.

However, dup is the default profile for metadata at mkfs time for
single device file systems, and it's not automatically converted to
raid1 when you add additional devices.


-- 
Chris Murphy
