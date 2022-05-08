Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B7C51F1EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 00:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiEHWSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 18:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiEHWSh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 18:18:37 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB9EBC14
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 15:14:44 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58466 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nnpAq-0006Wh-E0 by authid <merlins.org> with srv_auth_plain; Sun, 08 May 2022 15:14:44 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nnpAq-00Ee3c-7e; Sun, 08 May 2022 15:14:44 -0700
Date:   Sun, 8 May 2022 15:14:44 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220508221444.GS12542@merlins.org>
References: <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
 <20220507153921.GG1020265@merlins.org>
 <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org>
 <20220508194557.GP12542@merlins.org>
 <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org>
 <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
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

On Sun, May 08, 2022 at 05:49:17PM -0400, Josef Bacik wrote:
> Yeah this is the divide by 0, the error you posted earlier is likely
> because of the code refactor I did to make the delete thing work.
> I've added some more debugging to see if we're not deleting this
> problem bytenr during the search for bad extents.  Thanks,

inserting block group 15835070464000
inserting block group 15836144205824
inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
searching 4 for bad extents
processed 1032192 of 1064960 possible bytes, 96%
searching 5 for bad extents
processed 16384 of 10977280 possible bytes, 0%WTF IT DIDN'T DELETE IT!!
processed 19365888 of 49479680 possible bytes, 39%WTF IT DIDN'T DELETE IT!!
processed 25067520 of 49479680 possible bytes, 50%WTF IT DIDN'T DELETE IT!!
processed 42336256 of 49479680 possible bytes, 85%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 254902272 of 1635549184 possible bytes, 15%WTF IT DIDN'T DELETE IT!!
processed 311050240 of 1635549184 possible bytes, 19%WTF IT DIDN'T DELETE IT!!
processed 340901888 of 1635549184 possible bytes, 20%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358498304 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358514688 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358563840 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358662144 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358711296 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
processed 358727680 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358744064 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358776832 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
processed 358793216 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358842368 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358875136 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 358891520 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
processed 358907904 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
WTF IT DIDN'T DELETE IT!!
processed 359022592 of 1635549184 possible bytes, 21%WTF IT DIDN'T DELETE IT!!

many many lines from the beginning, that I wasn't getting before, so I stopped it 

Keep going?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
