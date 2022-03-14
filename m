Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47274D8C8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiCNTk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiCNTk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:40:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8EA3C726
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 12:39:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9689821111;
        Mon, 14 Mar 2022 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647286786;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0N/Dju5azot5U5EP+MK81dz5+babOSp6QeCoWQEXSQ=;
        b=pZzWshOoW3/OyPhbKNYRJdyET0JMJpOSYj0w1fXVkih1O/IbksU1oQGTGtreE44QTT1TpR
        l1oP+f4/dn6EvJaHwiKL+rAa5x6X/yXkCUDqK6DLSx8NE+OmmGzqkJQC/HCSKfXeUC1g8h
        R8fqi+qf1TqS/CaMISpEk+jpZwHJG7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647286786;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0N/Dju5azot5U5EP+MK81dz5+babOSp6QeCoWQEXSQ=;
        b=JISGotyCcFMGBi8k5m0nP4YiAfd5hZJBgln75BZZuPUBL+TNRNLoaZPUbXDH6niuJB1Aqw
        AyoomoILqEHF96AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8E201A3B81;
        Mon, 14 Mar 2022 19:39:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4CE38DA7E1; Mon, 14 Mar 2022 20:35:48 +0100 (CET)
Date:   Mon, 14 Mar 2022 20:35:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v4 0/14] btrfs: Introduce macro to iterate over slots
Message-ID: <20220314193548.GQ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220309135051.5738-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309135051.5738-1-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 09, 2022 at 02:50:37PM +0100, Gabriel Niebler wrote:
> There is a common pattern when searching for a key in btrfs:
> 
> * Call btrfs_search_slot to find the slot for the key
> * Enter an endless loop:
> 	* If the found slot is larger than the no. of items in the current leaf,
> 	  check the next leaf
> 	* If it's still not found in the next leaf, terminate the loop
> 	* Otherwise do something with the found key
> 	* Increment the current slot and continue
> 
> To reduce code duplication, we can replace this code pattern with an iterator
> macro, similar to the existing for_each_X macros found elsewhere in the kernel.
> This also makes the code easier to understand for newcomers by putting a name
> to the encapsulated functionality.
> 
> This patchset survived a complete fstest run.
> 
> Changes from v3:
>  * Surround arguments with (…) in iterator macro definition (David)
>  * Fix btrfs_unlink_all_paths after key/found_key confusion broke btrfs/168
>    (Josef)
>  * Various stylistic improvements (David)

Added to misc-next with some fixups, thanks.
