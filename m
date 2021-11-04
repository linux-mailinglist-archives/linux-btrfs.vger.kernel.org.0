Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73744535A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKDM4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 08:56:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDM4K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 08:56:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9BB291FD5A;
        Thu,  4 Nov 2021 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636030411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhPsFDuTT6NbUC+xzWChC5KrYEGEmfMvC8TBdjbdVLg=;
        b=Ov4WjRFMQpQSK8KP2iYwqwM+B0m+4q6Kuvm8ydRGD0Jf8rs3rbyiwfmD2WKLmpqVxrFRIq
        pOTcBgiAT6YwlID9HfIKX8+k+f0jamqNQa5lI19D25hyTxoPMP9BkSgVsuImdFUALTk57/
        vl0VEm5IYqIzXz034QDRw0hjPRRr5IM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66CB613BD4;
        Thu,  4 Nov 2021 12:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oVRxFsvXg2HOGQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 12:53:31 +0000
Subject: Re: [PATCH 2/4] btrfs: remove global rsv stealing logic for orphan
 cleanup
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1635450288.git.josef@toxicpanda.com>
 <58f93c86b8adad28df72e11b9ff660b597551bf1.1635450288.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d36a051d-4838-429d-fef9-8cafa986f680@suse.com>
Date:   Thu, 4 Nov 2021 14:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <58f93c86b8adad28df72e11b9ff660b597551bf1.1635450288.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.21 г. 22:50, Josef Bacik wrote:
> This is very old code before we were stealing from the global reserve
> during evict.  We have proper ways to steal from the global reserve
> while we're evicting, so rip out this code as it's no longer necessary.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
