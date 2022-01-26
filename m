Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58949CF0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 16:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiAZP67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 10:58:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiAZP66 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 10:58:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6E0B1F3B0;
        Wed, 26 Jan 2022 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643212737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsxdYmsMi9SV+BO4UZFzZZxA25PXLcSKtG7Ub4Imuqs=;
        b=rXk7pIoLHLt4X4zbcp/ASyI9nv1ENJzVVxt3A75OfvYjXfE6lXm9Bba6M2It60T8u+JFqb
        hRxr5SSrPD3kghBgU5ZazXk3tSXbGfM1x0reA/o5ioCaAhlNMgjzwdtbOJRGDEW/aVOMFg
        sIYlfPykkxUAVxQLHS216a5vPnj9VAk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 770D713E1A;
        Wed, 26 Jan 2022 15:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 83TAGMFv8WFfMgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 26 Jan 2022 15:58:57 +0000
Message-ID: <45fbafab-c7bb-9096-2fb5-c0f85c2927c1@suse.com>
Date:   Wed, 26 Jan 2022 17:58:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 10/11] btrfs: add code to support the block group root
Content-Language: en-US
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
 <6989c644d619aa6c829310bb9f508e12a36ea8af.1639600719.git.josef@toxicpanda.com>
 <37128edf-7bdd-0d36-3103-8e12805ed761@suse.com>
 <20220126153432.GY14046@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220126153432.GY14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.01.22 г. 17:34 ч., David Sterba wrote:
> You mean that extent tree v2 is mainly for speeding up mount? AFAIK it's
> only one of the improvements it brings. I'm not sure what you'd like to
> see in the commit message but could update it eventually.

No, I mean the block group root is speeding up the mount, extent v2 has 
a lot more features like the gc, changed metadata blocks management etc.

My point is that the block group root is not strictly required by extent 
v2 just that it's convenient time to be added. I meant this could have 
been made more explicit in the changelog.
