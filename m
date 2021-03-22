Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864813452EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCVXUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhCVXT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 19:19:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F9C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 16:19:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cx5so9553753qvb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=gKBIEADjwH2LxNdhHjPfZp2WKJpruzkKtlxaqq52NiI=;
        b=BVVxQ6WWOiTT2feKmeyNjZP/mATnytjPRJzizgpcS0ZSuDYQCD5Zui775KZicDJ/n9
         AFqMLRgTe3mX+MKu6UDd0Bc3ZxSL9d1hQ/v+iGm1s9mjpiwWzaiG6V7PjPc21AuQg4mE
         AtuidK03jDpgslmvdVSvgs4Rs79QM4cax1qqtuv/yU2126Gto55i9Po7uY+zYsWQUzQg
         NG2bcj+pxlqq6Ow2LJLkEzKjzpeupLxmLw6vH822xXRGL9HOHmjkEdwjLhNp4W1JHZ0P
         y8B/fiXfW4XPrIWxRBw/c27xfYIp99UzwTvR/2gRAAKQ1I1DCGFulzFvCYpLlB9e3L5c
         +EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gKBIEADjwH2LxNdhHjPfZp2WKJpruzkKtlxaqq52NiI=;
        b=mKkj2g7VGfUXLo2pW9Mqw0z4qoFiiRjRudWnb1l+Ktnwf6tSAwiDgebZZ+R3VIJLKw
         2uajhaNsTdK4TWvyiYYjmjo3+Zp0qirq3Vn63syqsJSdWAr2NSf14aDdSKul7hA4HCkT
         dO9tgh9eeUIIrLmK7qpsi2Fevu6GKcwfWTkyJhuLdQoVsvxbDPX19cL1vF9W6xftibFn
         eDo+RzYWRfJ7U9bCpI4eMQtLpwJzLzn2eyrNyux9Atwy7ScCfa5S6Zq9oq87JJPg/SpC
         Ah4fTsieZno0suBxum8K3izCwWc1i0QL3lKuGTxalLd5lGs15/nUnn5T+0HSSaWoM7Ss
         uy8g==
X-Gm-Message-State: AOAM531pHwekUBVTgeYO3UJffme1kqbfQ1YHTjqIADhBssa5+GcLyGbs
        Fg8/hL0hjGHD+EpfjS3yElVgivOn4bo=
X-Google-Smtp-Source: ABdhPJwj/lxdNFhRkXOJ2Cz59sDz3pBKIar9/mb2j8+Bwmvze33UCD1KhpEeZeYS+4dtN09F8v5wyg==
X-Received: by 2002:a05:6214:268c:: with SMTP id gm12mr2162925qvb.36.1616455194816;
        Mon, 22 Mar 2021 16:19:54 -0700 (PDT)
Received: from MacbookPro.local (c-73-249-174-88.hsd1.nh.comcast.net. [73.249.174.88])
        by smtp.gmail.com with ESMTPSA id y19sm12199392qky.111.2021.03.22.16.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 16:19:54 -0700 (PDT)
Subject: Re: APFS and BTRFS
To:     "Eu, acc" <accensi@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <7ead4392-f4c2-2a5b-c104-ae8be585d49e@gmail.com>
 <20210322222257.GC7604@twin.jikos.cz>
 <CAA+gEba91br_M6qERcwL5no=DdMSw3QA7iNwf8OGwskX=9Z6_g@mail.gmail.com>
From:   Forrest Aldrich <forrie@gmail.com>
Message-ID: <8aaa32e2-c9bf-ef48-b6ac-1b04b26ab415@gmail.com>
Date:   Mon, 22 Mar 2021 19:19:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAA+gEba91br_M6qERcwL5no=DdMSw3QA7iNwf8OGwskX=9Z6_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have apfs-fuse running, but it is read-only.

I wanted to avoid the pain of replicating a large disk from USB3 to USB3 
by converting the filesystem, which I expected wouldn't be possible.  So 
now I am just replicating it, which will take days to accomplish.


Thanks.



On 3/22/21 7:13 PM, Eu, acc wrote:
> Read-only;
> - linux-apfs read-only version, linux-apfs-oot 
> https://github.com/linux-apfs/linux-apfs-oot 
> <https://github.com/linux-apfs/linux-apfs-oot>
> - apfs-fuse https://github.com/sgan81/apfs-fuse 
> <https://github.com/sgan81/apfs-fuse>
> - Linux-Reader, from DiskInternals, a Windows(!) freeware
>
> ACC

