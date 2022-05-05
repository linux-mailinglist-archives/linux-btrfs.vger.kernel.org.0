Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E1B51C377
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiEEPMD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiEEPMC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 11:12:02 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAF32ED67
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:08:23 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58422 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nmd5Z-0006Tv-KJ by authid <merlins.org> with srv_auth_plain; Thu, 05 May 2022 08:08:21 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nmd5Z-005mQn-D9; Thu, 05 May 2022 08:08:21 -0700
Date:   Thu, 5 May 2022 08:08:21 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220505150821.GB1020265@merlins.org>
References: <CAEzrpqeHSCGrOZuUs2XSXAhrHvFbUiWmAkG_hRUu49g7nQ8K8w@mail.gmail.com>
 <20220502234135.GC29107@merlins.org>
 <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org>
 <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org>
 <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org>
 <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503172425.GA12542@merlins.org>
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

On Tue, May 03, 2022 at 10:24:25AM -0700, Marc MERLIN wrote:
> doing the longer one, will report back
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair --init-extent-tree /dev/mapper/dshelf1

Still running, it would be lovely to have a percentage of completion on
this one too :)

Repaired extent references for 331055104
ref mismatch on [331071488 16384] extent item 0, found 1
tree backref 331071488 parent 353419264 not found in extent tree
backpointer mismatch on [331071488 16384]
adding new tree backref on start 331071488 len 16384 parent 353419264 root 353419264
Repaired extent references for 331071488
ref mismatch on [331087872 16384] extent item 0, found 1
tree backref 331087872 parent 353419264 not found in extent tree
backpointer mismatch on [331087872 16384]
adding new tree backref on start 331087872 len 16384 parent 353419264 root 353419264

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
