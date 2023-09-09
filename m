Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C6799A91
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjIIT14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjIIT1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 15:27:55 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA11AA
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 12:27:51 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Rjjg655DWz9sR3;
        Sat,  9 Sep 2023 21:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ianjohnson.dev;
        s=MBO0001; t=1694287666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KMQ7juZlR96SiTSWpFzSycl1XJ9JXtfsDnfzwWWcmI=;
        b=rfiU8rQPqD8Thf1UoB8FTSKxi1WmBQhiKu1jWL/nWX7QskBAHAHqGW38pyyiKY2S/ABjIf
        WqlbQT6xH/hJLYCIEYwe/rzJAmGIxREYckq+eH8c6aQyKMao5gbwGaC8RlzRRa+VUubtXc
        0KD5B1ICHrg/bwNybIGz01m4s93c3x7e3D/ytr0hVUHNfPD5Y4lvknMbwd3ymRphsyi3Ko
        EHZKeLlL8lWOV44GAa75VNzL4NSbDTPTD+QZxAvy4QJ5jJJA7MntFt/jaNI39Q3nquRB7d
        mun0d4I2oJsczNdS338WJHLk1hL72UHO5MUvuLDIyIWKwTxAL5qVueXfS1eBrA==
Date:   Sat, 09 Sep 2023 15:27:37 -0400
From:   Ian Johnson <ian@ianjohnson.dev>
Subject: Re: Possible readdir regression with BTRFS
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <1QGQ0S.784N7IZ653TH3@ianjohnson.dev>
In-Reply-To: <ZPxiDy1vZE5VIF93@debian0.Home>
References: <YR1P0S.NGASEG570GJ8@ianjohnson.dev>
        <ZPweR/773V2lmf0I@debian0.Home> <ZPxiDy1vZE5VIF93@debian0.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat, Sep 9 2023 at 01:16:15 PM +01:00:00, Filipe Manana 
<fdmanana@kernel.org> wrote:
> Here it is (I CC'ed you, but just to link the thread):
> 
> https://lore.kernel.org/linux-btrfs/cover.1694260751.git.fdmanana@suse.com/

Thank you! I've applied the patchset at my end and confirmed that it
works both for my sample program (prints neither 1 nor 2 if rewinddir is
not used, and prints both if it is) and for the other project I was
originally debugging.


