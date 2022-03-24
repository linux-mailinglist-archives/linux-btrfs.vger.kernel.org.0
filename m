Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83704E5DE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 06:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiCXFBa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 01:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbiCXFBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 01:01:07 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F738189
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 21:59:02 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: prevent subvol with swapfile from being deleted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1648097940; bh=bQH+p5oMqU96T9wqwAy6H+Cp5tVoxCLTKyqKmPVnE78=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=d3EmGRFflPYm27Bp+m9y7a8mLcZRSTH/sO4meoygHlvY77kSRpGCXSI0OVR7T6/UO
         wGHAUKqbN8T53t6FaOLTJy1FLVq2efr+D0iQH62dew+iisDXMiO2q4Nugspth2AHzC
         tU+vsj3bV+wI1Wcx2Ety3TpY76etWPcrg0seaWFM=
To:     dsterba@suse.cz, quwenruo.btrfs@gmx.com,
        linux-btrfs@vger.kernel.org, robbieko@synology.com,
        cccheng@synology.com, seanding@synology.com, fdmanana@kernel.org
References: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
 <20220323071031.1398152-1-kevinhu@synology.com>
 <20220323214538.GF2237@twin.jikos.cz>
From:   Kaiwen Hu <kevinhu@synology.com>
Message-ID: <e1b49830-1a88-2385-4b39-cfd8697cac98@synology.com>
Date:   Thu, 24 Mar 2022 12:59:00 +0800
MIME-Version: 1.0
In-Reply-To: <20220323214538.GF2237@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 3/23/2022 9:37 PM, Filipe Manana wrote:
> Are you planning on sending in a test case for fstests as well?
> It's great to have a reproducer in a changelog, but unless it is
> turned into a test case for fstests, it doesn't prevent a regression
> in the future.

Ok, I'll work on it.


On 3/24/2022 5:45 AM, David Sterba wrote:
> I've added the subvolume id to the two messages, otherwise it's not a
> very useful for user.

Thanks,


Kaiwen Hu



