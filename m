Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD3215CB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgGFRKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgGFRKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 13:10:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834CC061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 10:10:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so12645170pfi.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JrfaYyazSb7kWxVYSMV2VYHC+l6Y2+vcmWB3sVhZagA=;
        b=Z6oIRUIzkjqQOsnw1gu5k+643AGkAtgaZBTk9VuFKBhhHCSLr2EkzXgNFnaAGmBQ0w
         a/CUi270UPtNhV5a8/gO4NVHrT3E7MrqacUe+r6l2al7RDn4npSfsZHEfjREn6LAcVfk
         Hfr/rkw++fMYvkW8nnL/JD5/fKopsIp4pbrYgZ69ouvtqM7pZ4b31xmySVKkTbTKOjnq
         AWbDsBBV1SS5bfKyVPVSM6qfOKzdG7i2ro1zpNZV7gG36F4UXAoYwOSIouZ+iRWH4MnI
         lRv94Th4NTDzDi1DVqGGGtNyOUUM6wSsvOGt+zG6TvcqjO7NoP80Iq89Fo+/Qrqwuwlt
         4wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JrfaYyazSb7kWxVYSMV2VYHC+l6Y2+vcmWB3sVhZagA=;
        b=aUDnp0ZSzxKo0zeRAUh3FyVOjA0Sj7bxUi3XKZzsA7bya02pNjZZ0+mqg7XuchOywl
         rW4K1YuU8REa5K8nOtxjMwVVU9a85O4Dyjg/IF4WKvdyNooHOqMNMbW+m0KmWMhAFAKa
         bV1cEUT+gAjvkBlHlmnZi1JCB5lim6FUXeUACQ5KgWSiT4nnIuykXTOihLwJW3GHj48V
         DlCFDnrtBE5y0S04ZzJttsSQwUeSkBMveARS+tc+2OSX6mGX1AB3DGYco8UhNUvYq7j5
         CB+aZlvIRG2xhMsdoqeuGbvBTu8jwhbbkvJXrxkWq4zwl1nC7ncuAyjRcLw6iLyx2ApY
         Lajw==
X-Gm-Message-State: AOAM531Ix+GH7a7AFVl3qr0E8sQyFNxkvvVgp9hW9R0ZQnwERa2npU+Z
        Jv6QhLj25ADUqk3QtE8H9sFz+FZkBNI=
X-Google-Smtp-Source: ABdhPJxJB002gzSoVMwUCFF3YgsDphKSu7WbZWcRKHgbOk3FLFybvgwRKZouRRyS3LYEwH9jaSF7gA==
X-Received: by 2002:a63:c60f:: with SMTP id w15mr22121255pgg.113.1594055429835;
        Mon, 06 Jul 2020 10:10:29 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::6fa7])
        by smtp.gmail.com with ESMTPSA id 198sm20871797pfb.27.2020.07.06.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:10:28 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:10:28 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
Message-ID: <20200706171028.GA16070@vader>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
 <1d41a247-a4f7-124a-4842-f7d886e9aa70@gmx.com>
 <c3b2c46ca5314285a79536cb3c233e1b@rs.bosch.com>
 <a18bcf27-4c65-6033-0ea7-45da2b521864@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a18bcf27-4c65-6033-0ea7-45da2b521864@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 07:21:42PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/2 下午7:08, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote:
> > Hi Qu,
> > 
> > I'm using this structure to get the address of file extent:
> > 
> > struct fiemap_extent {
> > 	__u64	fe_logical;  /* logical offset in bytes for the start of
> > 			      * the extent */
> > 	__u64	fe_physical; /* physical offset in bytes for the start
> > 			      * of the extent */
> 
> fe_physical in btrfs is btrfs logical address.
> 
> > 	__u64	fe_length;   /* length in bytes for the extent */
> > 	__u64	fe_reserved64[2];
> > 	__u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> > 	__u32	fe_reserved[3];
> > };
> > 
> > And using fe_physical field I verified that it really reflects the offset in filesystem image - I can see that file content begins at this offset.
> > The problem is that I run into some specific case where file content doesn't begin at fe_physical, I rather have something else at this offset.
> 
> As said, there is no guarantee that btrfs logical address is mapped 1:1
> on disk.
> It's possible, but never guaranteed.
> 
> You need to pass that fe_physical number to btrfs-map-logical to find
> the real on-disk offset.
> 
> Thanks,
> Qu

FYI, I have a utility that does this mapping for all extents in a file:
https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_map_physical.c

$ sudo ./btrfs_map_physical archlinux-2020.07.01-x86_64.iso | column -ts $'\t'        
FILE OFFSET  FILE SIZE  EXTENT OFFSET  EXTENT TYPE  LOGICAL SIZE  LOGICAL OFFSET  PHYSICAL SIZE  DEVID  PHYSICAL OFFSET
0            6811648    0              regular      6815744       304680529920    6815744        1      89898610688
6811648      4096       0              regular      4096          304594616320    4096           1      89812697088
6815744      70250496   0              regular      70254592      419517255680    70254592       1      168228114432
77066240     4096       0              regular      4096          419587510272    4096           1      168298369024
77070336     127647744  0              regular      127647744     443648155648    127647744      1      209538883584
204718080    552960     0              regular      557056        304605401088    557056         1      89823481856
205271040    134217728  0              regular      134217728     491017764864    134217728      1      238654881792
339488768    43814912   0              regular      43814912      419587514368    43814912       1      168298373120
383303680    241664     0              regular      245760        304605958144    245760         1      89824038912
383545344    4096       0              regular      4096          304594620416    4096           1      89812701184
383549440    134217728  0              regular      134217728     517290700800    134217728      1      255264141312
517767168    78376960   0              regular      78381056      451287601152    78381056       1      213957103616
596144128    82284544   0              regular      82284544      517424918528    82284544       1      255398359040
