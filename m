Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8661E4D6BB8
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 02:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiCLBos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 20:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLBor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 20:44:47 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05E18C0CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 17:43:39 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1925480671;
        Fri, 11 Mar 2022 20:43:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647049419; bh=+LQnnQJg9Fr0iwygfkSzJeF93ptWIh0yk9Eou1H8BwI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PIwh14itWrxxPmDjZvNGLWUbSUhbt4VA6NLXxlt1fWgnQ52WitDj9v8gn+W+0/YX1
         eDiowYHTQb/GuvnUZQ2pOBuFREExe6HGUQSCI1mvWVmvOsBA4JsCIy3qKXAh1MWZQk
         Ol0PnnzxdNtJlzEGwEX7UawTGmqDGbPw0f3zLyQwj2YjGp71ZhMm+NUZHtAEW4OnrF
         Q5PtWhRNMRb8edhSlzkQWMQQ42wx0YnxOanDwBiOsyxFWwpCH4RH7kg6HQEA4VS4Xg
         I6E3I3B6jJ7rN2O19J99VszAy5VhyD8HPQwQX/RRBFAScm2Ua6YKrNYVG1bP4ljV6W
         zDrmLWomgJtxw==
Message-ID: <aac3e4b3-2e59-f243-d0e3-02c68d797642@dorminy.me>
Date:   Fri, 11 Mar 2022 20:43:38 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/16] btrfs: fix anon_dev leak in create_subvol()
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <ee5528d299d357f225a228c394830d88e6eda17c.1646875648.git.osandov@fb.com>
 <1f55ff0e-c89d-0216-2c2f-0e1d7aa2a089@dorminy.me>
 <YivpceXk9xnkBikj@relinquished.localdomain>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <YivpceXk9xnkBikj@relinquished.localdomain>
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


On 3/11/22 19:29, Omar Sandoval wrote:
> On Fri, Mar 11, 2022 at 10:42:14AM -0500, Sweet Tea Dorminy wrote:
>>> +out_anon_dev:
>>>    	if (anon_dev)
>>>    		free_anon_bdev(anon_dev);
>> It looks to me as though the finer-grained cleanup means free_anon_bdev()
>> can always be called with no conditional; if the code reaches this point in
>> cleanup, anon_dev was populated by get_anon_bdev() (which must have returned
>> zero, indicating successfully populating anon_dev).
> The conditional is required because halfway through the function, we
> assign the anon_dev to a struct btrfs_root, which means that the
> anon_dev will be freed when the root is freed:
>
> 	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
> 	if (IS_ERR(new_root)) {
> 		ret = PTR_ERR(new_root);
> 		btrfs_abort_transaction(trans, ret);
> 		goto out;
> 	}
> 	/* anon_dev is owned by new_root now. */
> 	anon_dev = 0;

Makes sense, thanks for pointing that out!

