Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA131549E2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiFMT5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiFMT4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:56:36 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D5A5022
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:28:06 -0700 (PDT)
Received: from rrcs-173-197-119-179.west.biz.rr.com ([173.197.119.179]:40181 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0o4r-0006wh-6S by authid <merlins.org> with srv_auth_plain; Mon, 13 Jun 2022 11:28:04 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0onD-00CGqH-RG; Mon, 13 Jun 2022 11:28:03 -0700
Date:   Mon, 13 Jun 2022 11:28:03 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220613182803.GQ1664812@merlins.org>
References: <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613175651.GM1664812@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 173.197.119.179
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, yes and no, it mounted, but 99% of the files are missing.
There are a few in lost+found but ultimately almost everything
is gone.

The top structure is there, but then mostly empty underneath:

drwxr-xr-x 1 root   root              0 Jun 13 11:26 .beeshome/
-rw-r--r-- 1 root   root    13569961558 Jul 16  2020 DS1
drwx------ 1 root   root           5062 Jun  8 15:52 lost+found/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media/
d????????? ? ?      ?                 ?            ? media_daily.20220325_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_daily.20220326_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_daily.20220327_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_daily.20220328_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_hourly.20220328_22:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_hourly.20220328_23:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_hourly.20220329_00:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_hourly.20220329_01:01:01/
drwxr-xr-x 1 root   root             28 Jun  8 16:12 media_ro.20220227_00:24:39/
drwxr-xr-x 1 root   root             28 Jun  8 16:22 media_ro.20220306_00:24:43/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_ro.20220313_00:24:44/
drwxr-xr-x 1 root   root             28 Jun  8 16:42 media_ro.20220320_00:24:47/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_ro.20220327_00:24:32/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_weekly.20220130_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_weekly.20220206_02:03:01/
drwxr-xr-x 1 root   root             20 Jun  8 16:00 media_weekly.20220213_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 media_weekly.20220306_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other/
d????????? ? ?      ?                 ?            ? other_daily.20220325_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_daily.20220326_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_daily.20220327_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_daily.20220328_01:02:01/
d????????? ? ?      ?                 ?            ? other_hourly.20220328_21:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_hourly.20220328_22:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_hourly.20220328_23:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_hourly.20220329_00:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_hourly.20220329_01:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_ro.20220227_00:25:38/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_ro.20220306_00:25:40/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_ro.20220313_00:26:11/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_ro.20220320_00:25:35/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_ro.20220327_00:24:58/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_weekly.20220130_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_weekly.20220206_02:03:01/
drwxr-xr-x 1 root   root             28 Jun  8 16:06 other_weekly.20220213_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 other_weekly.20220306_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 SW/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 SW_ro.20220227_00:34:48/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 SW_ro.20220306_00:33:55/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 SW_ro.20220313_00:33:42/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 SW_ro.20220320_00:35:42/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 SW_ro.20220327_00:32:46/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound/
d????????? ? ?      ?                 ?            ? Sound_daily.20220325_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_daily.20220326_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_daily.20220327_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_daily.20220328_01:02:01/
d????????? ? ?      ?                 ?            ? Sound_hourly.20220328_22:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_hourly.20220328_23:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_hourly.20220329_00:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_hourly.20220329_01:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_ro.20220227_00:40:41/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_ro.20220306_00:45:46/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_ro.20220313_00:37:25/
drwxr-xr-x 1 merlin hideftp          70 Jun 25  2021 Sound_ro.20220320_00:39:38/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_ro.20220327_00:35:22/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_weekly.20220130_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_weekly.20220206_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_weekly.20220213_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Sound_weekly.20220306_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2/
d????????? ? ?      ?                 ?            ? Med2_daily.20220325_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_daily.20220326_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_daily.20220327_01:02:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_daily.20220328_01:02:01/
d????????? ? ?      ?                 ?            ? Med2_hourly.20220328_22:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_hourly.20220328_23:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_hourly.20220329_00:01:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_hourly.20220329_01:01:01/
drwxr-xr-x 1 root   root             20 Jun  8 16:15 Med2_ro.20220227_00:46:32/
drwxr-xr-x 1 root   root             20 Jun  8 16:24 Med2_ro.20220306_00:46:14/
drwxr-xr-x 1 root   root             20 Jun  8 16:42 Med2_ro.20220313_00:38:01/
drwxr-xr-x 1 merlin hideftp         102 Jun 25  2021 Med2_ro.20220320_00:40:27/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_ro.20220327_00:35:50/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_weekly.20220130_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 Med2_weekly.20220206_02:03:01/
drwxr-xr-x 1 root   root             20 Jun  8 15:54 Med2_weekly.20220213_02:03:01/
drwxr-xr-x 1 root   root             20 Jun  8 16:35 Med2_weekly.20220306_02:03:01/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 W/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 W_ro.20220227_02:10:25/
drwxr-xr-x 1 root   root           4498 Mar 28 11:01 W_ro.20220306_00:47:32/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 W_ro.20220313_00:38:28/
drwxr-xr-x 1 root   root             34 Jun  8 17:52 W_ro.20220320_01:12:38/
drwxr-xr-x 1 root   root              0 Jun 13 11:26 W_ro.20220327_00:37:15/


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
