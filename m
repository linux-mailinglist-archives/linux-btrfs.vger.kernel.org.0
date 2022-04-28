Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8778E513CF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 22:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbiD1VAd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiD1VAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 17:00:32 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67939393F6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:57:17 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nkBCO-00013I-J9 by authid <merlin>; Thu, 28 Apr 2022 13:57:16 -0700
Date:   Thu, 28 Apr 2022 13:57:16 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220428205716.GU29107@merlins.org>
References: <20220428030002.GB12542@merlins.org>
 <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org>
 <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org>
 <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org>
 <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org>
 <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 04:28:53PM -0400, Josef Bacik wrote:
> "Make recovery tools more resilient" is definitely muuuuuch higher on
> the team priority list that's for fucking sure.  Try again please,
> hopefully it works this time.  Thanks,

Great to hear, and obviously not just hearing, thanks for your
persistence in this mega thread.

Here's the new one:
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d
"3700677820416,168,53248" -r 11223 /dev/mapper/dshelf1
FS_INFO IS 0x55f248b64600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55f248b64600
Error searching to node -2

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
