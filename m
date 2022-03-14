Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870C4D8A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiCNROL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiCNROI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 13:14:08 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF36244
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 10:12:56 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 9F43580689;
        Mon, 14 Mar 2022 13:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647277976; bh=4TR9PdO+M7v5XVT8Ipy4tFaG+diUFe/E9C87hSWxsf0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dMK4GiYvQnaaroJSavsOn2kcAq5p0HTa89Hkh9QehBlfdNj0Gt16Ldie+VfxpQJ3w
         DvbWZz0laVkTmACiRwXY+aGBMgtQPMwqAiTc5k6HQaSR07ztV03py4PTBgN6XoDtFY
         OtE/jvGCCBZCq8AYpooLSRycZXsnu2EZuXi76jTOYXWz3dqyjrUS6h03jTcGsRTTLH
         YIF58AYnS53/OuV+aVXzPSzUt1kn+VfsmOMxLvjDM81uGMrxHlVLaIWaBU7vg3qxPg
         OtYSAxGA3jlra55utyNNJgBb9k3HCe5/6D6+2PvI+x/J0ncANMT1zdR9Co+3bfSqbj
         qoHvBcD1ppH/A==
Message-ID: <762b6b64-804a-61d9-0e13-c3ecd7fbf35f@dorminy.me>
Date:   Mon, 14 Mar 2022 13:12:54 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 00/12] btrfs: item helper prep work for snapshot_id
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1646692306.git.josef@toxicpanda.com>
 <ebaefb10-2d76-85fe-1c7b-75f885baf5b7@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <ebaefb10-2d76-85fe-1c7b-75f885baf5b7@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 3/9/22 08:57, Nikolay Borisov wrote:
>
>
> On 8.03.22 г. 0:33 ч., Josef Bacik wrote:
>> Hello,
>>
>> I sent a bunch of patches previously to rework a lot of our helpers in
>> preparation of adding the snapshot_id to the btrfs_header.  I missed 
>> a few
>> important areas with those patches, so here's the remaining work to 
>> make it
>> easier to expand the size of the btrfs_header.  These are general 
>> fixups and
>> cleanups that don't rely on the extent tree v2 work.  Thanks,
>>
>> Josef
>>
>> Josef Bacik (12):
>>    btrfs: move btrfs_node_key into ctree.h
>>    btrfs: add a btrfs_node_key_ptr helper, convert the users
>>    btrfs: introduce *_leaf_data helpers
>>    btrfs: make BTRFS_LEAF_DATA_OFFSET take an eb arg
>>    btrfs: pass eb to the node_key_ptr helpers
>>    btrfs: pass eb to the item_nr_offset helper
>>    btrfs: add snapshot_id to the btrfs_header and related defs
>>    btrfs: move the header SETGET funcs
>>    btrfs: move the super SETGET funcs
>>    btrfs: move BTRFS_LEAF related definitions below super SETGET funcs
>>    btrfs: const-ify fs_info for the compat flag handlers
>>    btrfs: use _offset helpers instead of offsetof in generic_bin_search
>>
>>   fs/btrfs/ctree.c                | 151 ++++++------
>>   fs/btrfs/ctree.h                | 411 +++++++++++++++++---------------
>>   fs/btrfs/extent_io.c            |   6 +-
>>   fs/btrfs/struct-funcs.c         |   8 -
>>   fs/btrfs/tree-checker.c         |   4 +-
>>   fs/btrfs/tree-mod-log.c         |   4 +-
>>   include/uapi/linux/btrfs_tree.h |   1 +
>>   7 files changed, 303 insertions(+), 282 deletions(-)
>>
>
> Overall LGTM:
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Also Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, for 
what it's worth.
