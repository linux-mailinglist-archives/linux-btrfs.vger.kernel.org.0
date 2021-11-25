Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312C845D6DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349238AbhKYJMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:12:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349785AbhKYJKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:10:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E5EA21B36;
        Thu, 25 Nov 2021 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwL3lSmsQ3KWiBTmr82nyZz6oq/AAQGWKYmtsux+dqQ=;
        b=Ity22wSTjRkuULz21SNzw4+XOHY18l1r8180MnKns1EcHFk1ukxJAJYizjDjQ+S0dHjguY
        bk2pXPKBK+dG4OyWDsR/QXH9mkBYWsYrxOMzJF1WLCse1mwGp8AvI+bFSjq9/r2kub5X2J
        KxuKcH36/qwsXjwYyN6GFvwmjQPX0ro=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 274B413F54;
        Thu, 25 Nov 2021 09:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pml4BlVSn2E6FAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:07:33 +0000
Subject: Re: [PATCH v2 2/3] btrfs: check the root node for uptodate before
 returning it
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1637781110.git.josef@toxicpanda.com>
 <1d95650cf7f6c184b112c41801620b5faf43a520.1637781110.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <531caaa9-2a09-c360-1374-d5b432d099fa@suse.com>
Date:   Thu, 25 Nov 2021 11:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1d95650cf7f6c184b112c41801620b5faf43a520.1637781110.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.11.21 г. 21:14, Josef Bacik wrote:
> Now that we clear the extent buffer uptodate if we fail to write it out
> we need to check to see if our root node is uptodate before we search
> down it.  Otherwise we could return stale data (or potentially corrupt
> data that was caught by the write verification step) and think that the
> path is OK to search down.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
