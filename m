Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820234F8529
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 18:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiDGQuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245119AbiDGQuU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 12:50:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D920F4E
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 09:48:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 35AEE212C6;
        Thu,  7 Apr 2022 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649350099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tigYxSNpKyWORk7o/3icc+FJ1zT5q4+RbHtwo2OPVM=;
        b=WGAQhloWH+S7biYFCrlxuxjFxJCVYSZ956yGz1gvvMGBoucFeqEb+hbKfUZwqO+novlCvK
        wPxW26uRNpg2A8eXcCkKOpxOh8cQqD/Y0ttY/RLUvj689okXo8dWq64kcPV2wfKky//McS
        KlkjbC+ka5fjadSApsUt30tXJnJ//Lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649350099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tigYxSNpKyWORk7o/3icc+FJ1zT5q4+RbHtwo2OPVM=;
        b=yKw6dwBlD+iIvoyfnUNTj4ru83Poz8ZzBWRIJNPb2WEkZiaMUX2cT5oB54mFc1J0FFWgZq
        imWTWOR66mdknsCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2C3E9A3B87;
        Thu,  7 Apr 2022 16:48:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1111DA80E; Thu,  7 Apr 2022 18:44:15 +0200 (CEST)
Date:   Thu, 7 Apr 2022 18:44:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/6] Turn delayed_nodes_tree into XArray and adjust usages
Message-ID: <20220407164414.GO15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220407153855.21089-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407153855.21089-1-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 07, 2022 at 05:38:48PM +0200, Gabriel Niebler wrote:
> XArrays offer a somewhat nicer API than radix trees and were implemented
> specifically to replace the latter. They utilize the exact same underlying
> data structure, but their API is notionally easier to use, as it provides
> array semantics to the user of radix trees. The higher level API also
> takes care of locking, adding even more ease of use.
> 
> The btrfs code uses radix trees directly in several places, such as for the
> `delayed_nodes_radix` member of the btrfs_root struct.
> 
> This patchset converts `delayed_nodes_radix` into an XArray, renames it
> accordingly and adjusts all usages of this object to the XArray API.
> It survived a complete fstests run.

So it converts just one structure, it would be better do it in one
patch otherwise it leaves the conversion half way and it's confusing to
see xarray structure in the radix-tree API.

> Gabriel Niebler (6):
>   Turn delayed_nodes_tree into delayed_nodes_xarray in btrfs_root
>   btrfs_get_delayed_node: convert to using XArray API
>   btrfs_get_or_create_delayed_node: convert to using XArray API
>   __btrfs_release_delayed_node: convert to using XArray API
>   btrfs_kill_all_delayed_nodes: convert to using XArray API
>   __setup_root: convert to using XArray API for delayed_nodes_xarray

The subject(s) should start with "btrfs: ..."
