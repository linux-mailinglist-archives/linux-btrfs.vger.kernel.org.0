Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA10777A53
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjHJOTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHJOTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 10:19:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1E26BB
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 07:19:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC46D218A8;
        Thu, 10 Aug 2023 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691677153;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sigEkuWUCfA40a46Hta4Ano87M4/1VdFpBuX/Z78yE=;
        b=f4LGVBMiKWZcx2CUFDy68g/lvv2+nm9lm7yZeb0CHZG58glEpZ0Pt6PXtwTyVigRX1hnb3
        73mhMiDswcyiy1UqnQQoy9a77G+lzQzBd74e7nNbAOwuZhqcooadMQOd8hN/c28FtNCloM
        431TW0dmdw5tHqECbDjYL4YHrS/CpGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691677153;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sigEkuWUCfA40a46Hta4Ano87M4/1VdFpBuX/Z78yE=;
        b=ggWerTHu0vqIgKsuHWCJ9iNm4tHmPpsCgKTuJzqrkmnE3i/rf/B7HLQL+iMdnWmqBzsYp7
        nxwwTPNzujqBJYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94E78138E0;
        Thu, 10 Aug 2023 14:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WIloI+Hx1GTHAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 14:19:13 +0000
Date:   Thu, 10 Aug 2023 16:12:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH -next v2] btrfs: Use LIST_HEAD() to initialize the
 list_head
Message-ID: <20230810141248.GB2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230810030022.780950-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810030022.780950-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 11:00:22AM +0800, Ruan Jinjie wrote:
> Use LIST_HEAD() to initialize the list_head instead of open-coding it.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

> ---
> v2:
> - Add the remainig LIST_HEAD() conversions.
> - Update the commit message.

Added to misc-next, thanks.
