Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9F7A5600
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjIRXB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIRXB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 19:01:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E40A4;
        Mon, 18 Sep 2023 16:01:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4E2C433C8;
        Mon, 18 Sep 2023 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695078111;
        bh=zSXhmBZjcS1+bDylN7SmZFG7tHyEZB1dLv1a5/mX3nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Btpz06nz9uY6r0f9cSMpBPRNwKTYLDYZmWrXKYdqXoCKUQc+NK0xI58AH8sOLxKEA
         a2SyI1Rme9gyGtUl1fcb53baa1uOGXRUJuYWXEIkdqIBOo/l0pkaNsydhbEsPnGIDp
         mpdmHbdUFVi/20fvBR/EsFUaZcxIyLypGLlb7xjJZ8pvMdB523DsV6Uo5f90GFoQSO
         YwwwhjYlv3sLLPH+lSVoI8GJD5XTKMq9wrfYgffHxyybvrWir5JJF/F6Gy703ib1nh
         CCvGi07CFU5DvLie8VoVTk/R6D4GjtUd6uDpRDljPdUqwcRLtk1EEkXD3DlPbXXBvP
         f7jN9f5cwmniQ==
Date:   Mon, 18 Sep 2023 19:01:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 2/4] btrfs: return real error when orphan
 cleanup fails due to a transaction abort
Message-ID: <ZQjW3b/Sw8VoKfT7@sashalap>
References: <20230907154400.3421858-1-sashal@kernel.org>
 <20230907154400.3421858-2-sashal@kernel.org>
 <ZPn911P6vnhfuJ3T@debian0.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZPn911P6vnhfuJ3T@debian0.Home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 05:44:07PM +0100, Filipe Manana wrote:
>On Thu, Sep 07, 2023 at 11:43:58AM -0400, Sasha Levin wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> [ Upstream commit a7f8de500e28bb227e02a7bd35988cf37b816c86 ]
>
>Please don't add this patch to any stable release.
>Besides not being that important for stable, backporting it alone would not
>be correct as it depends on:

Dropped, thanks!

-- 
Thanks,
Sasha
