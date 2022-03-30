Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A34ECB64
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349743AbiC3SKI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349796AbiC3SKC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 14:10:02 -0400
X-Greylist: delayed 165218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 11:08:13 PDT
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570003EB83;
        Wed, 30 Mar 2022 11:08:13 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 27F5B806CF;
        Wed, 30 Mar 2022 14:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648663692; bh=cjEfYWlojMvy1ZwZHuEvFkA9bbP79DZeoHgKCxE+3aI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=HJrpt646NW3nHWfP7VAom7E119dueb/vT3T1pXCwb0iwiL8P3hu44JCSViNjepqPJ
         6dfFRwufTwzyo4uK3TXn6CP5gCh0sGl4ZjW0vkmeIICbec4YIB9UJX5/eFGitq/p4m
         RGFMjRmd5i8L8afpQvlprAwqmNIKoF+X5tEbuGJ8YnoCaduLu78NZM+plWHjVIxxJ0
         wK5qNOB569sq+wPwrER2xBGYswW+p60hlwrTCw7poSTgCeI5fD87znksQwoDBaxEt9
         tMNfRhqA5TBxA4vyafQPwEmdu1Gunxfw0q+gyAtBCYqxJ00KmAwgwEObif+p2Rkgso
         BFA6VWJzc2dOw==
Message-ID: <b9a6ee3d-0744-1a28-65f1-22c1402e2d48@dorminy.me>
Date:   Wed, 30 Mar 2022 14:08:11 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] btrfs: allocate page arrays more efficiently
Content-Language: en-US
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1648658235.git.sweettea-kernel@dorminy.me>
 <20220330165837.GH2237@twin.jikos.cz>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220330165837.GH2237@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/30/22 12:58, David Sterba wrote:
> On Wed, Mar 30, 2022 at 12:44:05PM -0400, Sweet Tea Dorminy wrote:
>> In several places, btrfs allocates an array of pages, one at a time.  In
>> addition to duplicating code, the mm subsystem provides a helper to
>> allocate multiple pages at once into an array which is suited for our
>> usecase. In the fast path, the batching can result in better allocation
>> decisions and less locking. This changeset first adjusts the users to
>> call a common array-of-pages allocation function, then adjusts that
>> common function to use the batch page allocator.
>>
>> v2: moved new helper to extent_io.[ch]. Fixed title format.
> 
> It does not address comments from
> https://lore.kernel.org/linux-btrfs/20220328230909.GW2237@twin.jikos.cz
I apologize, I completely missed the inline comments even though I 
thought something was missing and reread it a couple times... v3 soon.
