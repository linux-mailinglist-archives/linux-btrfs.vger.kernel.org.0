Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0754E6817
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 18:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbiCXRyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 13:54:24 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A896B2473
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 10:52:51 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C8115806B3;
        Thu, 24 Mar 2022 13:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648144371; bh=YCYAivI4HJYSd56hcXnrTvs7dPVta+mgIXK4t6Ba0wg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j0KFEY1eCp4MUMdS2NxxgbB1n4R1NrXaHkfG5HUXmrif2VbCRCG23FPbPg5o5hFg7
         CCBbMAUK9Ni3bN8d39YAc+SOSKHQloaA7ZdLNx2pSime0QsPD0EJvPrHeB1GNKqsOi
         /8bEagNpTxrgjEfKr22ZcAjZHjgtykNagV1GhB8SynEVooanVRkA2xGATGANqFEc7/
         tUtdlZt/7VaMuvbK3dOcvWJOhorn+UFgoDxmVGKUq1Q6+spqjkrAHj+zexOQJCXFSh
         7hupGxKnzpwQaX/L4SqQWPU2Kmnu8BhPsQgvqn5jzvJCOM0UFy7lz8Sm15YKVeMFU8
         Xm/4hfqDj3mfQ==
Message-ID: <ac1c17b1-fc3e-8215-10b5-e283ae71787f@dorminy.me>
Date:   Thu, 24 Mar 2022 13:52:49 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v14 2/7] btrfs: send: explicitly number commands and
 attributes
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1647537027.git.osandov@fb.com>
 <ab8a0faa48aa8eea8c73ab1fc2dd0538113e4583.1647537027.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <ab8a0faa48aa8eea8c73ab1fc2dd0538113e4583.1647537027.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 3/17/22 13:25, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
s/macros/enums/?
> version plus 1, but as written this creates gaps in the number space.
> The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> 23 and 24 are valid commands.
>
> Instead, let's explicitly number all of the commands, attributes, and
> sentinel MAX constants.

If you were sending out another version, the last sentence explains what the change is doing but not why you like it as a solution to the problem.

Nit: I think it would be slightly more elegant to set the MAX values to the appropriate symbolic value instead of numerical, to emphasize the relationship a tiny bit more. Perhaps e.g.

enum btrfs_send_cmds {
	...
	BTRFS_SEND_C_UPDATE_EXTENT,
	__BTRFS_SEND_CMDS_V1_MAX = BTRFS_SEND_C_UPDATE_EXTENT,
	BTRFS_SEND_C_FALLOCATE,
	...
	BTRFS_SEND_C_ENCODED_WRITE,
	__BTRFS_SEND_CMDS_V2_MAX = BTRFS_SEND_C_ENCODED_WRITE,
	BTRFS_SEND_C_CMDS_MAX = __BTRFS_SEND_CMDS_V2_MAX,
};

(either with or without explicitly setting the numerical values of the individual commands). Or perhaps #define the MAX values instead, still in terms of the symbolic constant?

I have a mild preference for not explicitly setting things to numerical values, so it's harder to duplicate a value by accident later on; but explicit setting does help if one day some cmd needs to be dropped from the middle of the list without renumbering everything, so shrug.

Nit: If you do stick with explicit numerical values everywhere, is there a chance you could line up the = vertically, to make it easier to scan down the list of numbers and verify they are in order and without holes in the sequence? I know vertical alignment is usually unneeded, but in this case I think it does add a bunch to the readability of the table.

