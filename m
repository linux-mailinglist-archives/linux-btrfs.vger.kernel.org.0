Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687F4F1FDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 01:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiDDXKD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbiDDXJ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 19:09:56 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5233370
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 15:45:05 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbVRX-0006vJ-Js by authid <merlin>; Mon, 04 Apr 2022 15:45:03 -0700
Date:   Mon, 4 Apr 2022 15:45:03 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220404224503.GA11442@merlins.org>
References: <20220404181055.GW1314726@merlins.org>
 <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org>
 <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org>
 <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
 <20220404212951.GG14158@merlins.org>
 <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
 <20220404220935.GH14158@merlins.org>
 <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 06:34:39PM -0400, Josef Bacik wrote:
> Alright, lets see how fucked this thing is
> 
> ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal
dump-tree -t ROOT /dev/mapper/dshelf1a
btrfs-progs v5.16.2 
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Couldn't read chunk tree
ERROR: unable to open /dev/mapper/dshelf1a

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
