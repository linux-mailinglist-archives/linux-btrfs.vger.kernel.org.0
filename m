Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5570D57D406
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiGUTVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiGUTVd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 15:21:33 -0400
Received: from rin.romanrm.net (rin.romanrm.net [51.158.148.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA788CDB
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 12:21:30 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 7E3F15D7;
        Thu, 21 Jul 2022 19:21:25 +0000 (UTC)
Date:   Fri, 22 Jul 2022 00:21:23 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: Using async discard by default with SSDs?
Message-ID: <20220722002123.379c9ca6@nvm>
In-Reply-To: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 21 Jul 2022 14:43:16 -0400
Neal Gompa <ngompa13@gmail.com> wrote:

> potential lack of "discard=none" option to turn off discards if the
> user wanted it to. Do we already have this option?

Like on Ext4, XFS and others, the "nodiscard" mount option is available:
https://btrfs.readthedocs.io/en/latest/btrfs-man5.html

-- 
With respect,
Roman
