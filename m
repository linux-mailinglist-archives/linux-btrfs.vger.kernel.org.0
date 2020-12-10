Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E102D6545
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 19:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgLJSkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 13:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbgLJSjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 13:39:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D8C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 10:39:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c5so2903123wrp.6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 10:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4dHq3+z+snY9xT4tOAXwPqUNyMt8qm1qGIbfohkTYs=;
        b=WyT5vz8f3RM+2ybpIMYg0qbdvrMqXdFwigLeFBRhwatSxxWyCHKVNYg4gKNhZ2RYc6
         pov/ysC0qRbJKqbqPFjkznUA6dzq0V8rWzWtUdzGvFytnq8cDChhhgIsXKmazueWwXOm
         8aeJxq0rC6VzbeLtXgKHHIvXk/iMCg4T3SNHzBpDJ7/oqFD1SSFpktBgZFBnQ8AAmfGF
         7kryI8lhpxpWghNnnLGazkVJf6tTROj7eF+aV3iYDgOHi7TYQCEbddo7Br+tBORsR9PI
         Ai7Ax9CTlJAhQdZuetPiOq7PjnC/CpzRpz/OBUVSJwUPfn+HBo2d/fjoS83sAOcGVteL
         DR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4dHq3+z+snY9xT4tOAXwPqUNyMt8qm1qGIbfohkTYs=;
        b=RgOC71lajLIGxxN4N3jkIKVgGAzJTZrxZAZ4n4KoEu/V8ZsnBKvtQxbx2wtas/4D8/
         ZsaVTbyZqA5srq0Q8EPVpAr+a/rX5me9kr4yupLLNxeBPPcUk6hU73i5ilL+atq3XCc4
         30hBVGkwQy2H1drWJ8JeNMKXz2myhUrAfgHUNOHB06LxefG7wjNSNwVe4k5c/l2V7FwO
         WcNrGuVeJmAiaOt4FQwhAkpKT7SG/EgfCnOc0n8Ks7+YDz5Vt1wMd+JUG37p22neRSXE
         tMY0N9ZxP7+h08TIKJaPNhKjrQnYQi/MY/LcqsHjRM2QdIuP0MVsRdT/fc75RFpsOZ+t
         kYWg==
X-Gm-Message-State: AOAM5316C3vqYIVUkHkFKwGq9SkDrRwjtuGoMQ044Y2+7n4ZVh8WTZWZ
        DJjNjkruhCG3xfNrbg+WtOpghNka+qDEu/zqnNxVGQ==
X-Google-Smtp-Source: ABdhPJz++u++aPYkCsCxKzWQgvQfs86w4/wqMM6QWUcznKYvOtsRiI2We1Bi2iUC3dM6fFByYD7UYHhe6BvCCnB9er0=
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr9829335wra.252.1607625553412;
 Thu, 10 Dec 2020 10:39:13 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXt9PAju7eQ3yqgtCCyGysb+sgn5kQepZ+uRqi7PVMW0pA@mail.gmail.com>
In-Reply-To: <CAMaziXt9PAju7eQ3yqgtCCyGysb+sgn5kQepZ+uRqi7PVMW0pA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 10 Dec 2020 11:38:57 -0700
Message-ID: <CAJCQCtSNs_OMmJOS-hEQzwOQBZP7HDab5U-Uj9iGfFfLwevWDw@mail.gmail.com>
Subject: Re: How do I get the physical offset of a file in BTRFS ?
To:     Sreyan Chakravarty <sreyan32@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 6:25 AM Sreyan Chakravarty <sreyan32@gmail.com> wrote:
>
> Hi,
>
> How do I calculate the physical offset of a file in BTRFS ?
>
> filefrag does not work.


Given your you post two hours before this in which you describe
btrfs_map_physical script to get the resume_offset and properly divide
by page size, this post seems anachronistic and I have no idea what
you're asking.


-- 
Chris Murphy
