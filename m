Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A315072A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiDSQI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354462AbiDSQIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 12:08:46 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB23B018
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 09:05:57 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id F236F7CF;
        Tue, 19 Apr 2022 16:05:52 +0000 (UTC)
Date:   Tue, 19 Apr 2022 21:05:51 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220419210551.65db356b@nvm>
In-Reply-To: <20220419155721.6702-1-gniebler@suse.com>
References: <20220419155721.6702-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 19 Apr 2022 17:57:21 +0200
Gabriel Niebler <gniebler@suse.com> wrote:

> -	btrfs_init_delayed_node(node, root, ino);
> +        do {

The "do" line appears one character off to the right for me, and upon
examination that's because it uses spaces for indentation instead of TABs like
all other lines. Did not check if this is the only place.

There is "checkpatch.pl" which would catch issues like this:
https://www.kernel.org/doc/html/latest/dev-tools/checkpatch.html

-- 
With respect,
Roman
