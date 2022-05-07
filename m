Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7951E83E
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 May 2022 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385739AbiEGPnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 May 2022 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385709AbiEGPnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 May 2022 11:43:10 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1227B2C
        for <linux-btrfs@vger.kernel.org>; Sat,  7 May 2022 08:39:23 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58452 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nnMWf-0001Kh-KL by authid <merlins.org> with srv_auth_plain; Sat, 07 May 2022 08:39:21 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nnMWf-00A8Hq-E4; Sat, 07 May 2022 08:39:21 -0700
Date:   Sat, 7 May 2022 08:39:21 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220507153921.GG1020265@merlins.org>
References: <20220503040250.GW12542@merlins.org>
 <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org>
 <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org>
 <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org>
 <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 06, 2022 at 09:15:58PM -0400, Josef Bacik wrote:
> > > The delete block bit should be automated somehow, it's quite slow and painful to do by hand (hours again here)
> >
> > Agreed, I'm going to wire something up now.  Thanks,
> >
> 
> Ok I pushed something, hopefully it works and you don't have to touch
> it anymore?  Thanks,

Thanks. That seems to almost work and I like the progress percentage,
thanks :)

But now it seems to loop on the same one? I got over 50 of those

searching 11223 for bad extents
prIgnoring transid failure35549184 possible bytes, 99%
processed 1620017152 of 1635549184 possible bytes, 99%
Found an extent we don't have a block group for in the file
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0422_2020.1_0602_1208.xz
Deleting

searching 11223 for bad extents
prIgnoring transid failure35549184 possible bytes, 99%
processed 1620017152 of 1635549184 possible bytes, 99%
Found an extent we don't have a block group for in the file
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0422_2020.1_0602_1208.xz
Deleting

searching 11223 for bad extents
prIgnoring transid failure35549184 possible bytes, 99%
processed 1620017152 of 1635549184 possible bytes, 99%
Found an extent we don't have a block group for in the file
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0422_2020.1_0602_1208.xz
Deleting

searching 11223 for bad extents
prIgnoring transid failure35549184 possible bytes, 99%
processed 1620017152 of 1635549184 possible bytes, 99%
Found an extent we don't have a block group for in the file
inode ref info failed???
elem_cnt 1 elem_missed 0 ret 0
Xilinx_Unified_2020.1_0602_1208/payload/rdi_0422_2020.1_0602_1208.xz
Deleting


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
