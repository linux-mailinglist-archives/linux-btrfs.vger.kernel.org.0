Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB64D1A9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 15:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiCHOcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 09:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiCHOcY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 09:32:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697094C401
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 06:31:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25F441F396;
        Tue,  8 Mar 2022 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646749887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SN8tQW4fhsAZOzWJNbGXrRps3YNRF3hpOPG9if1p+oA=;
        b=K0Rbtfhmqkvne9fV+qrPynu0WabjDuUmxzhUm9TivEvI1xbXaAjYLtsvLGyYZmDhdlHaBy
        t3A/foD4RimOjvloRECgq3ItpIrFY0NTH06phj9bfTjHbuat/kJrL6GdbzL6d9bjH5JlKo
        RtwE5BNCbLhG3/Sq8ityQh0UuyyZ7+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646749887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SN8tQW4fhsAZOzWJNbGXrRps3YNRF3hpOPG9if1p+oA=;
        b=hSTtxyrdaE07WIs9MKwrrtc1zRsyiDzoPU1o7VyNZFU9jKFlt7f3pLfxZ9Ao0vCjAnptad
        YKuXfKTA1B5o/JCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1E425A3B87;
        Tue,  8 Mar 2022 14:31:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EAC33DA823; Tue,  8 Mar 2022 15:27:31 +0100 (CET)
Date:   Tue, 8 Mar 2022 15:27:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v3 0/14] btrfs: Introduce macro to iterate over slots
Message-ID: <20220308142731.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220302164829.17524-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302164829.17524-1-gniebler@suse.com>
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

On Wed, Mar 02, 2022 at 05:48:15PM +0100, Gabriel Niebler wrote:
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
> Changes from v2:
>  * Rename btrfs_valid_slot to btrfs_get_next_valid_item (Nikolay)
>  * Fix comment formatting (David)
>  * Remove redundant parentheses and indentation in loop condition (David)
>  * Remove redundant iter_ret var and reuse ret instead (Nikolay)
>  * Make termination condition more consistent in btrfs_unlink_all_paths
>    (Nikolay)
>  * Improved patch organisation by splitting into one patch per function (David)
>  * Improve doc comment for btrfs_get_next_valid_item (Gabriel)
>  * Remove `out` label and assoc. gotos from id_create_dir (Gabriel)
>  * Initialise `ret` in process_all_refs and process_all_new_xattrs (Gabriel)
>  * Remove unneeded btrfs_item_key_to_cpu call from loop body in
>    btrfs_read_chunk_tree (Gabriel)

I still see some of the style issues not addressed in your version, I'll
point them out in the first example I find but it needs to be fixed in
all of them. Otherwise it looks good. As we're near the code freeze for
5.17 I'm not sure I could put it there so it's 5.18 at the latest.
