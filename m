Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077425B27E5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIHUuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIHUug (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 16:50:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC9B2CCB
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 13:50:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1A371F461;
        Thu,  8 Sep 2022 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662670232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlztSxcl4VoGdN6aZHnYLj8tenJTciy1GRJq2KjlMeg=;
        b=tVdBwpiz9+bqRxTfaMkRA1DLsEFiqNRZ0dl6K3VfvawR5XAo36tKhHF/UOKxZhcg8Z2KJb
        990ALjjDEuxs0NfIQzhTwn56p5W9OqtedscQtl4AtnBzZAv30VsqugCr0koqBLEhCEOAKO
        oVEntJjL5edgnRK2WKKQRjfaqUy1pZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662670232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlztSxcl4VoGdN6aZHnYLj8tenJTciy1GRJq2KjlMeg=;
        b=+1RljxW7SF27h8VzNEMBNOhyXfT5RBlsP9BnLBTjLsjmzgIc0GXlCAY6gyzdFUyBqb6aIG
        JYalOv/vKN1EUkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C442F13A6D;
        Thu,  8 Sep 2022 20:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2xf+LphVGmPxZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Sep 2022 20:50:32 +0000
Date:   Thu, 8 Sep 2022 22:45:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/5] btrfs: qgroup: address the performance penalty
 for subvolume dropping
Message-ID: <20220908204508.GQ32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1661302005.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661302005.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 24, 2022 at 09:14:04AM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v4:
> - Fix a kmalloc() usage, which can lead to kobject warnings
>   Since kobject_init_and_add() relies on certain values of a member,
>   kmalloc() can leave kobj->state_initialized to be true, and cause
>   crash at qgroups_kobj initialization time.
> 
> - Add a script in the cover letter to verify the behavior
>   Will later be submitted as a test case.

I've fixed some issues, eg. scnprintf in the sysfs callbacks, we now
have the sysfs_emit, dropped the BUILD_BUG_ON. Further cleanups can be
done, I'd like to get it in before rc5.
