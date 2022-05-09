Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A751F24D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 03:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiEIBaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 21:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiEIAu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 20:50:29 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544F65CA
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 17:46:36 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58478 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nnrXn-0002e9-Ui by authid <merlins.org> with srv_auth_plain; Sun, 08 May 2022 17:46:35 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nnrXn-00EvE1-Ly; Sun, 08 May 2022 17:46:35 -0700
Date:   Sun, 8 May 2022 17:46:35 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220509004635.GT12542@merlins.org>
References: <20220507153921.GG1020265@merlins.org>
 <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org>
 <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org>
 <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org>
 <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
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

On Sun, May 08, 2022 at 08:22:19PM -0400, Josef Bacik wrote:
> On Sun, May 8, 2022 at 6:14 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, May 08, 2022 at 05:49:17PM -0400, Josef Bacik wrote:
> > > Yeah this is the divide by 0, the error you posted earlier is likely
> > > because of the code refactor I did to make the delete thing work.
> > > I've added some more debugging to see if we're not deleting this
> > > problem bytenr during the search for bad extents.  Thanks,
> >
> 
> Ooooh right this is the other problem, overlapping extents.  This is
> going to be trickier to work out, I'll start writing it up, but I want
> to make it automatic as well, so probably won't have anything until
> the morning.  Thanks,

Thanks for the heads up

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
