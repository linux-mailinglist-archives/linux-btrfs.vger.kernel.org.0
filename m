Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D259C5353CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbiEZTPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiEZTPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 15:15:14 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBB9CF52
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 12:15:12 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nuIwy-0001Ub-1g by authid <merlin>; Thu, 26 May 2022 12:15:12 -0700
Date:   Thu, 26 May 2022 12:15:12 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220526191512.GE28329@merlins.org>
References: <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org>
 <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org>
 <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org>
 <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org>
 <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 02:54:47PM -0400, Josef Bacik wrote:
> > Do I do
> > ./btrfs rescue tree-recover --init-extent-tree /dev/mapper/dshelf1
> > or
> > ./btrfs rescue tree-recover /dev/mapper/dshelf1
> 
> Tree-recover first, lord I'm tired of our tools randomly not updating
> root pointers.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1 
ERROR: cannot read chunk root
WTF???
ERROR: open ctree failed
Tree recover failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
