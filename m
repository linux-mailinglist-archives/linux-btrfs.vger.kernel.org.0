Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE647A3026
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Sep 2023 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjIPMfc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Sep 2023 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjIPMfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Sep 2023 08:35:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB1019A;
        Sat, 16 Sep 2023 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HoH40DFZbzHZqFBwd6eu9+B3epbq/sl/PaZo7hcjS0Y=; b=jEsiCiPMEErRhSMnIKtWA8KJ5M
        VJ9+8AhA/u6I76G9qIjDQLmExg9Ry0w/VX4USnilKxVM4Ru9gDAvJu1gT61MUYlXqy7oy4GdZcHCw
        mlGjI3xZ+Xep/WN6clufQut2c9f7h6uCdAI73JfrIRbpLyCgAdTHPusFHuwFWJMcdoghqOk9aqY4e
        58kVAdTgpJfYIa1dQP6Yz73+7oULOuHDc3OuqPM5VAzFRZG+mkl8druB3hduI44RHSZMN4fRjprr9
        mWW8kl3EKOTDK3qCMGXM2YAxfdU61DlFukw7MTXVaXgA1w6isFY74py8vr4KM3mBQlaWYuIO8ic80
        k4MEzjkQ==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qhUVv-0058It-HL; Sat, 16 Sep 2023 14:35:07 +0200
Message-ID: <10911f40-b4df-43c2-4843-c97dbc7af583@igalia.com>
Date:   Sat, 16 Sep 2023 09:35:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] btrfs: Add test for the temp-fsid feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, dsterba@suse.cz,
        kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20230913224545.3940971-1-gpiccoli@igalia.com>
 <0ab7fabb-a59e-df61-7a16-44457df2992a@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <0ab7fabb-a59e-df61-7a16-44457df2992a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2023 20:25, Anand Jain wrote:
> [...]
> This test case's integration will be timed alongside the kernel.
> 
> Running this test case on older kernel/progs without the feature under
> test must terminate the test case with _notrun(). I find that part is
> missing here.
>

I'm confused about the relation between _notrun() and
_require_btrfs_fs_feature(). I see that some tests (like mine) make use
of the latter, but some tests do as you suggest, using _notrun. They
intersect only on tests 125 and 192, and it seems they are aimed at
different things, based on these two.

The _require_btrfs_fs_feature() seems to be used with the same semantic
I'm using, i.e., to check if a feature is present, given that the test
requires it. Now the _notrun() thing is used like (in test 192):


# We require a 4K nodesize to ensure the test isn't too slow
if [ $(_get_page_size) -ne 4096 ]; then
        _notrun "This test doesn't support non-4K page size yet"
fi


So, there's a secondary condition here, and the test is prevented from
running if such condition is not achieved.

Do you / others think I should switch approaches and use _notrun()? Or
should I somehow use both?!


>> +_scratch_dev_pool_put 1
> 
> _scratch_dev_pool_put
> 
> takes no argument.

Thanks for noticing that! Will fix in next version =)
Cheers!
