Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED667424ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjF2LZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjF2LZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 07:25:25 -0400
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05692703
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 04:25:21 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id C7A26400BF;
        Thu, 29 Jun 2023 11:25:18 +0000 (UTC)
Date:   Thu, 29 Jun 2023 16:25:18 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: do not enable async discard
Message-ID: <20230629162518.164ca443@nvm>
In-Reply-To: <e803b649-299b-05b6-6528-06437548e974@kernel.org>
References: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
        <e803b649-299b-05b6-6528-06437548e974@kernel.org>
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

On Thu, 29 Jun 2023 18:15:05 +0900
Damien Le Moal <dlemoal@kernel.org> wrote:

> > +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> > +		btrfs_warn(info, "zoned: disabling async discard as it is not supported");
> 
> The "not supported" mention here kind of imply that we are not finished with
> this support yet. So may be a simple: "zoned: ignoring async discard" would
> suffice ?

IMO "not supported" does not imply "not supported yet". To me the message
reads more like "not supported by definition" (of zoned), i.e. no
misunderstanding.

-- 
With respect,
Roman
