Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115884A931B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 05:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354164AbiBDEci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 23:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiBDEci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 23:32:38 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEBC061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 20:32:37 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z5so4117658plg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Feb 2022 20:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=j3XulYOyxjt0H6Dm+T6h4fIFDcGa8dxAZc2gSXDaSOM=;
        b=W/zivjjoKcpfM4mLFy7M2wN6INoqQnQ9+THaeoyJplASvlVzpFvhUjWzghAnSVecht
         qxS/JdI8/sw3FW0MgfZPMXid6yWcWMn/aRywFmJw0dnJWC8rHYIZv3JfmHWpK5NfRFEv
         v6puWhdFkw9N6X49ZKOvjn7X/o7ki9PhGgsrZxb50pnKaL7oTOm5w+iDQxZ+5vmxoao3
         Px8d7C+QCd0ZkWEm+Mooyur44U3OKHz92BBB0bfNHRNy5Ryi962t8qszsP2d4f+zRQqh
         1ZlwBMP9yUAgaFACrgXh+oEwUFNZejcLTPiaPum6LhM/JBkliJ08H1gViRGDikH6VDwV
         jsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=j3XulYOyxjt0H6Dm+T6h4fIFDcGa8dxAZc2gSXDaSOM=;
        b=ReDgazD22TQNV7tnlTMBBwbIVTyS20FoxE2dWABnw0x01xG+RzBijiQ4h5b3ThUX0O
         2VlQdWAZQsb46MqX7hcqokaWo4KHd7eLIGCTKnCYfl0Z4zLsJPLa5de3rWRtVB7yIDdY
         b1WYYbuhIrrV1ydQnqpD38QIFQgv4OnD5EUKd1yOEMPTIgeRvKymP2pBdScxLXS1qSDL
         26rupDTV8vs0PEeAoTML7ZAgz6SezkSx0hR5CGv2XQAgnqhC13QEY8ABLNUG4MnM82Zc
         YzqioD57UgmEny2lRVLIRFUnhL0KCZc1e+lxRbRQsvZ+00Jmft78AcyNE7DkAlGzQgMA
         JCag==
X-Gm-Message-State: AOAM533eBNaVPmGC7QVLhBvtDnB6mIY28NocwZEBjbHRl8O7+/9AoAkB
        WUD8JjTRgYRPlII6FtyHImlrh/TqFUo=
X-Google-Smtp-Source: ABdhPJzv0bt3bTJi2ggiVDWq5kNjR2SHlSVotuslt9CrIVBByDtcpDgU0QKIB5P8Ge1jNioB76aXgw==
X-Received: by 2002:a17:903:1d0:: with SMTP id e16mr1443116plh.65.1643949157210;
        Thu, 03 Feb 2022 20:32:37 -0800 (PST)
Received: from [192.168.1.223] ([47.151.162.98])
        by smtp.gmail.com with ESMTPSA id f12sm477953pgg.35.2022.02.03.20.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:32:36 -0800 (PST)
Date:   Thu, 03 Feb 2022 20:32:29 -0800
From:   Benjamin Xiao <ben.r.xiao@gmail.com>
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <5AJR6R.7DWSX2SE14RN3@gmail.com>
In-Reply-To: <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
        <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
        <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Okay, I just compiled a custom Arch kernel with your patches applied. 
Will test soon. Besides enabling autodefrag and redownloading a game 
from Steam, what other sorts of tests should I do?

Ben

On Fri, Feb 4 2022 at 09:54:19 AM +0800, Qu Wenruo 
<quwenruo.btrfs@gmx.com> wrote:
> 
> 
> On 2022/2/4 09:17, Qu Wenruo wrote:
>> 
>> 
>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>> Hello all,
>>> 
>>> Even after the defrag patches that landed in 5.16.5, I am still 
>>> seeing
>>> lots of cpu usage and disk writes to my SSD when autodefrag is 
>>> enabled.
>>> I kinda expected slightly more IO during writes compared to 5.15, 
>>> but
>>> what I am actually seeing is massive amounts of btrfs-cleaner i/o 
>>> even
>>> when no programs are actively writing to the disk.
>>> 
>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>> partition. In my case, I was downloading Strange Brigade, which is a
>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>> download, iostat will start reporting disk writes around 300 MB/s, 
>>> even
>>> though Steam itself reports disk usage of 40-45MB/s. After the 
>>> download
>>> finishes and nothing else is being written to disk, I still see 
>>> around
>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
>>> cleaner and other btrfs processes writing a lot of data.
>>> 
>>> I left it running for a while to see if it was just some maintenance
>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>> reboot, but it actually prevented me from properly rebooting. After
>>> systemd timed out, my system finally shutdown.
>>> 
>>> Here are my mount options:
>>> rw,relatime,compress-force=zstd:2,ssd,autodefrag,space_cache=v2,subvolid=5,subvol=/
>>> 
>> 
>> Compression, I guess that's the reason.
>> 
>>  From the very beginning, btrfs defrag doesn't handle compressed 
>> extent
>> well.
>> 
>> Even if a compressed extent is already at its maximum capacity, btrfs
>> will still try to defrag it.
>> 
>> I believe the behavior is masked by other problems in older kernels 
>> thus
>> not that obvious.
>> 
>> But after rework of defrag in v5.16, this behavior is more exposed.
> 
> And if possible, please try this diff on v5.15.x, and see if v5.15 is
> really doing less IO than v5.16.x.
> 
> The diff will solve a problem in the old code, where autodefrag is
> almost not working.
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index cc61813213d8..f6f2468d4883 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, 
> struct
> file *file,
>                         continue;
>                 }
> 
> -               if (!newer_than) {
> -                       cluster = (PAGE_ALIGN(defrag_end) >>
> -                                  PAGE_SHIFT) - i;
> -                       cluster = min(cluster, max_cluster);
> -               } else {
> -                       cluster = max_cluster;
> -               }
> +               cluster = (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
> +               cluster = min(cluster, max_cluster);
> 
>                 if (i + cluster > ra_index) {
>                         ra_index = max(i, ra_index);
> 
>> 
>> There are patches to address the compression related problem, but not
>> yet merged:
>> 
>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=609387
>> 
>> Mind to test them to see if that's the case?
>> 
>> Thanks,
>> Qu
>>> 
>>> 
>>> I've disabled autodefrag again for now to save my SSD, but just 
>>> wanted
>>> to say that there is still an issue. Have the defrag issues been 
>>> fully
>>> fixed or are there more patches incoming despite what Reddit and
>>> Phoronix say? XD
>>> 
>>> Thanks!
>>> Ben
>>> 
>>> 


