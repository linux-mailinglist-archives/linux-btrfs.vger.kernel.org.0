Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C990148C6ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354484AbiALPQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 10:16:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34776 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354485AbiALPQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 10:16:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 181411F39B;
        Wed, 12 Jan 2022 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642000590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nf/8t+rxFp9TaMoHmrPY4MoFZZ+TSvaiZHXqtMv7uMQ=;
        b=I5nuBr3wnBg9AZPlD1nB3VaWaxhSOAkkqYhzz4eM2qWNHRKa4f80D+buozfY2Kzp9oxdrY
        k6808Jn9iq8ClqEalcvumeX9QkYXRlqqcgKLkIMJYyS8x8w+dOlZezuz0Kzx9mYEunW/wq
        vdK7IHBuciIfaRS3dCWHNWrvcWjC1Ug=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D208213B70;
        Wed, 12 Jan 2022 15:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NRciMM3w3mEtHAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 12 Jan 2022 15:16:29 +0000
Subject: Re: [PATCH v2 10/11] btrfs: add code to support the block group root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1639600719.git.josef@toxicpanda.com>
 <6989c644d619aa6c829310bb9f508e12a36ea8af.1639600719.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <37128edf-7bdd-0d36-3103-8e12805ed761@suse.com>
Date:   Wed, 12 Jan 2022 17:16:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6989c644d619aa6c829310bb9f508e12a36ea8af.1639600719.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 22:40, Josef Bacik wrote:
> This code adds the on disk structures for the block group root, which
> will hold the block group items for extent tree v2.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Ok, this is formally not needed for the extent v2 but the major rework
for extent v2 is used to introduce this change and it's idea is to speed
up fs mount right? If so I'd like this to be stated more explicitly in
the changelog of the patch. I guess this can be done by David as well.

<snip>
