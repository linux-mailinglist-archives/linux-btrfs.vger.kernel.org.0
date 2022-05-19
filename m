Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2152DFF4
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiESW3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiESW27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 18:28:59 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1A66AF5
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 15:28:57 -0700 (PDT)
Received: from wsip-24-120-54-100.lv.lv.cox.net ([24.120.54.100]:28748 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nrodb-0002wV-P4 by authid <merlins.org> with srv_auth_plain; Thu, 19 May 2022 15:28:55 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nrodb-009rVa-4K; Thu, 19 May 2022 15:28:55 -0700
Date:   Thu, 19 May 2022 15:28:55 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220519222855.GL13006@merlins.org>
References: <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org>
 <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org>
 <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org>
 <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org>
 <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.120.54.100
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 03:17:55PM -0400, Josef Bacik wrote:
> Yes sorry I meant to say that.  Because we have these dangling block
> groups we'll suddenly have a bunch of files that no longer are
> mappable and we'll need to delete them.  Looks to be about 7gib of
> block groups so you're going to lose that stuff, it's going to be a
> while but it's expected.  Thanks,
> 
So, it's definitely deleting a lot

I think I'm at 81%

searching 159785 for bad extents
processed 78446592 of 95879168 possible bytes, 81%
Found an extent we don't have a block group for in the file
Performances/Magic/Diversion 08022019.mkv
Deleting [70879, 108, 10708312064] root 6781246029824 path top 6781246029824 top slot 19 leaf 10678930079744 slot 34

gargamel:~# grep -c Deleting /mnt/btrfs_space/ri1
 149583

Ok, that's a lot of files, but let's see if it finishes

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
